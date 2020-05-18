public class GunControllerExtension {
    public Gun__c gun { get; set; }

    public GunControllerExtension(ApexPages.StandardController stdController) {
        this.gun = (Gun__c)stdController.getRecord();
    }

    public PageReference updateGun() {
        try {
            update gun;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Gun has been updated');
            ApexPages.addMessage(myMsg);
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        return null;
    }
}
