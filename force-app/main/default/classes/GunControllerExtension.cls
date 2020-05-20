public class GunControllerExtension {
    public Gun__c gun {get; set;}

    public GunControllerExtension(ApexPages.StandardController stdController) {
        this.gun = (Gun__c)stdController.getRecord();
    }

    public PageReference updateGun() {
        try {
            update gun;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Gun has been updated');
            ApexPages.addMessage(myMsg);
        } catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong');
            ApexPages.addMessage(errorMsg);
        }
        return null;
    }

    public List<GunHistory__c> getGunRecordHistory() {
        List<GunHistory__c> gunHistories = [
            select id,
            action__c,
            date__c,
            createdBy.name
            from GunHistory__c
            where Gun__c = :gun.id
            order by date__c desc
            ];
            
        return gunHistories; 
    }
}