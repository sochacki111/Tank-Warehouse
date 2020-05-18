public class TurretControllerExtension {
    public Turret__c turret { get; set; }

    public TurretControllerExtension(ApexPages.StandardController stdController) {
        this.turret = (Turret__c)stdController.getRecord();
    }

    public PageReference updateTurret() {
        try {
            update turret;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Turret has been updated');
            ApexPages.addMessage(myMsg);
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        return null;
    }
}
