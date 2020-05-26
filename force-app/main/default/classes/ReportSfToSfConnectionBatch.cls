global class ReportSfToSfConnectionBatch implements Database.Batchable<SObject>, Database.Stateful {

    private SalesforceToSalesforceConnection__c s2s;
    private Id connectionId;
    private String emailAddress;
    private DateTime lastSyncDate;
    private List<PartnerNetworkRecordConnection> sharedRecords;
    private List<PartnerNetworkRecordConnection> publishedRecords;
    private List<PartnerNetworkRecordConnection> notPublishedRecords;

    public ReportSfToSfConnectionBatch() {
        this.publishedRecords = new List<PartnerNetworkRecordConnection>();
        this.notPublishedRecords = new List<PartnerNetworkRecordConnection>();
        this.s2s = SalesforceToSalesforceConnection__c.getInstance();
        this.connectionId = (Id)s2s.get('connectionId__c');
        this.emailAddress = (String)s2s.get('emailAddressNotification__c');
        this.lastSyncDate = System.DateTime.now();
        this.sharedRecords = [
            select localRecordId
            from PartnerNetworkRecordConnection
            where connectionId = this.connectionId;
        ];
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        // TODO Create PNRC Selector that returns Database.QueryLocator
        // return Database.getQueryLocator([
        //     select localRecordId
        //     from PartnerNetworkRecordConnection
        //     where connectionId = :connectionId
        //     and startDate != null and startDate > :(DateTime)s2s.get('lastSyncDate__c')
        // ]);
        return Database.getQueryLocator([
            select id
            from Tank__c
            where createdDate > :(DateTime)s2s.get('lastSyncDate__c')
        ])
    }

    global void execute(Database.BatchableContext bc, List<Tank__c> tanks) {
        for (Tank__c tank : tanks) {

        }
    }

    global void finish(Database.BatchableContext bc) {
        s2s.put('lastSyncDate__c', lastSyncDate);
        upsert s2s;

        AsyncApexJob a = [
            select id, Status, NumberOfErrors, extendedStatus
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
            if (!String.isBlank(a.extendedStatus)) {
                message.plainTextBody += 'Following error occured during Batch processing:\n';
                message.plainTextBody += a.extendedStatus + '\n';
            }
            message.plainTextBody += 'Published records:\n';
            if (publishedRecords.size() > 0){
                for (PartnerNetworkRecordConnection pnrc : publishedRecords) {
                    message.plainTextBody += pnrc.localRecordId + '\n';
                }
            }
            message.plainTextBody += 'Not published records:\n';
            message.plainTextBody += 'Last Sync Date:\n';
            message.plainTextBody += s2s.get('lastSyncDate__c');

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
