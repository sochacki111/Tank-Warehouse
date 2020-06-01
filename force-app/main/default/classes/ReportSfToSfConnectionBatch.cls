global class ReportSfToSfConnectionBatch implements Database.Batchable<SObject>, Database.Stateful {

    private SalesforceToSalesforceConnection__c s2s;
    private Id connectionId;
    private String emailAddress;
    private DateTime lastSyncDate;
    private List<PartnerNetworkRecordConnection> sharedRecords;
    private List<PartnerNetworkRecordConnection> publishedRecords;
    private Set<Id> notSharedTankIds;

    public ReportSfToSfConnectionBatch() {
        this.s2s = SalesforceToSalesforceConnection__c.getInstance();
        this.connectionId = (Id)s2s.get('connectionId__c');
        this.emailAddress = (String)s2s.get('emailAddressNotification__c');
        this.lastSyncDate = System.DateTime.now();
        this.sharedRecords = [
            select localRecordId
            from PartnerNetworkRecordConnection
            where startDate != null and startDate > :(DateTime)s2s.get('lastSyncDate__c')
        ];
        this.publishedRecords = [
            select localRecordId
            from PartnerNetworkRecordConnection
            where connectionId = :this.connectionId
            and startDate != null and startDate > :(DateTime)s2s.get('lastSyncDate__c')
        ];
        this.notSharedTankIds = new Set<Id>();
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            select id
            from Tank__c
            where createdDate > :(DateTime)s2s.get('lastSyncDate__c')
        ]);
    }

    global void execute(Database.BatchableContext bc, List<Tank__c> tanks) {
        Set<Id> notSharedTankIds = (new Map<Id,Tank__c>(tanks)).keySet();

            for (PartnerNetworkRecordConnection sharedRecord : sharedRecords) {
                notSharedTankIds.remove(sharedRecord.localRecordId);
            }
    }

    global void finish(Database.BatchableContext bc) {
        s2s.put('lastSyncDate__c', lastSyncDate);
        upsert s2s;

        AsyncApexJob thisApexBatch = [
            select id, status, numberOfErrors, extendedStatus
            from AsyncApexJob
            where Id = :bc.getJobId()
            limit 1
        ];

        try {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses = new String[] { 
                emailAddress
            };
            message.subject = 'ReportSfToSfConnectionBatch finished';

            message.plainTextBody = 'ReportSfToSfConnectionBatch finished:\n';
            if (!String.isBlank(thisApexBatch.extendedStatus)) {
                message.plainTextBody += 'Following error occured during Batch processing:\n' +
                    thisApexBatch.extendedStatus + '\n' +
                    'Total number of errors:\n' +
                    thisApexBatch.numberOfErrors + '\n';
            } else {
                message.plainTextBody += 'No error occured!\n';
            }
            message.plainTextBody += 'Published records:\n';
            if (publishedRecords.size() > 0){
                for (PartnerNetworkRecordConnection pnrc : publishedRecords) {
                    message.plainTextBody += pnrc.localRecordId + '\n';
                }
            } else {
                message.plainTextBody += 'No new shared records!\n';
            }
            if (notSharedTankIds.size() > 0) {
                message.plainTextBody += 'Not shared records:\n';
                for (Id tankId : notSharedTankIds) {
                    message.plainTextBody += tankId + '\n';
                }
            } else {
                message.plainTextBody += 'All records are shared!\n';
            }
            message.plainTextBody += 'Last Sync Date:\n' +
                s2s.get('lastSyncDate__c');

            List<Messaging.SendEmailResult> results = Messaging.sendEmail(
                new List<Messaging.SingleEmailMessage> {
                    message
                }
            );
        } catch (EmailException e) {
            System.debug(e);
        }
    }
}
