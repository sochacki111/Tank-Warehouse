public class TankControllerExtension {
    public Tank__c tank {get; set;}

    public TankControllerExtension(ApexPages.StandardController stdController) {
        this.tank = (Tank__c)stdController.getRecord();
    }

    public List<Tank__c> getAllTanks() {
        return [
            select id,
            name
            from Tank__c
            order by name asc
        ];
    }

    public PageReference createTank() {
        PageReference pr = Page.Tanks;
        pr.setRedirect(true);

        try {
            upsert tank;
        } catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong');
            ApexPages.addMessage(errorMsg);

            return null;
        }
        return pr;
    }

    public PageReference updateTank() {
        try {
            update tank;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Tank has been updated');
            ApexPages.addMessage(myMsg);
        } catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong');
            ApexPages.addMessage(errorMsg);
        }
        return null;
    }

    public PageReference deleteTank() {
        PageReference pr = Page.Tanks;
        pr.setRedirect(true);

        try {
            delete tank;
        } catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong');
            ApexPages.addMessage(errorMsg);

            return null;
        }
        return pr;
    }

    public List<TankHistory__c> getTankRecordHistory() {
        List<TankHistory__c> tankHistories = [
            select id,
            action__c,
            date__c,
            createdBy.name
            from TankHistory__c
            where Tank__c = :tank.id
            order by date__c desc
            ];
            
        return tankHistories; 
    }
}
