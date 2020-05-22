public class CreateTankPartnerNetworkRecordConnection implements Queueable {
    
    private List<Tank__c> tanks;
    private List<PartnerNetworkRecordConnection> pnrcsToInsert;
    private SalesforceToSalesforceConnection__c s2s;
    private Id connectionId;
    private String emailAddress;

    public CreateTankPartnerNetworkRecordConnection(List<Tank__c> tanks) {
        this.tanks = tanks;
        this.s2s = SalesforceToSalesforceConnection__c.getInstance();
        this.connectionId = (Id)s2s.get('connectionId__c');
        this.emailAddress = (String)s2s.get('emailAddressNotification__c');
    }

    public void execute(QueueableContext context) {
        for (Tank__c tank : tanks) { 
            // TODO Check whether record is subscribed from other Salesforce instance. If it's not then create pnrc from that record 
            PartnerNetworkRecordConnection pnrc = new PartnerNetworkRecordConnection(
                ConnectionId = connectionId,
                LocalRecordId = tank.Id
            );

            pnrcsToInsert.add(pnrc);
        }
        
        // TODO Send error report to emailAddress 

        insert pnrcsToInsert;
    }
}
