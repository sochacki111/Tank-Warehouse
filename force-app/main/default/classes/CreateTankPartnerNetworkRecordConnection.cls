public class CreateTankPartnerNetworkRecordConnection implements Queueable {
    
    private Map<Id,Tank__c> newTankMap;
    private List<PartnerNetworkRecordConnection> pnrcsToInsert;
    private SalesforceToSalesforceConnection__c s2s;
    private Id connectionId;


    public CreateTankPartnerNetworkRecordConnection(Map<Id,Tank__c> newTankMap) {
        this.pnrcsToInsert = new List<PartnerNetworkRecordConnection>();
        this.newTankMap = newTankMap;
        this.s2s = SalesforceToSalesforceConnection__c.getInstance();
        this.connectionId = (Id)s2s.get('connectionId__c');
    }

    public void execute(QueueableContext context) {
        Set<id> sharedRecordIds = PartnerNetworkRecordConnectionsSelector.findAllLocalRecordIds();
        for (Id tankId : newTankMap.keySet()) { 
            // TODO get tank ids from newTankMap that are not shared in more elegant way than looping over every id
            //select id from Tank__c where id not in :sharedRecordIds
            if (!sharedRecordIds.contains(tankId)) {
                PartnerNetworkRecordConnection pnrc = new PartnerNetworkRecordConnection(
                    connectionId = connectionId,
                    localRecordId = tankId
                );
                pnrcsToInsert.add(pnrc);
            }
        }

        insert pnrcsToInsert;
    }
}
