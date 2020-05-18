public class TankControllerExtension {
    public Tank__c tank { get; set; }

    public TankControllerExtension(ApexPages.StandardController stdController) {
        this.tank = (Tank__c)stdController.getRecord();
    }

    public PageReference createTank() {
        try {
            insert tank.clone(false, false, false, false);
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Tank has been created');
            ApexPages.addMessage(myMsg);
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        return null;
    }

    public PageReference updateTank() {
        try {
            update tank;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Tank has been updated');
            ApexPages.addMessage(myMsg);
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        return null;
    }

    public PageReference deleteTank() {
        PageReference pr = Page.Tanks;
        pr.setRedirect(true);
        pr.getParameters().put('message', 'Hello, World!');
        try {
            delete tank;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Tank has been removed');
            ApexPages.addMessage(myMsg);
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        return pr;
    }
}
