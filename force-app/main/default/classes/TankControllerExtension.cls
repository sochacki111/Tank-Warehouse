public class TankControllerExtension {
    public Tank__c tank { get; set; }

    public TankControllerExtension(ApexPages.StandardController stdController) {
        this.tank = (Tank__c)stdController.getRecord();
    }

    public PageReference createTank() {
        try {
            insert tank;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Tank has been created');
            ApexPages.addMessage(myMsg);
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }

        return null;
    }

}
