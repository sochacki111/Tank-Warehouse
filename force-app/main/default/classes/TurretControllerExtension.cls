public class TurretControllerExtension {
    public Turret__c turret {get; set;}

    public TurretControllerExtension(ApexPages.StandardController stdController) {
        this.turret = (Turret__c)stdController.getRecord();
    }

    public PageReference updateTurret() {
        try {
            update turret;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Turret has been updated');
            ApexPages.addMessage(myMsg);
        } catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong');
            ApexPages.addMessage(errorMsg);
        }
        return null;
    }

    public List<TurretHistory__c> getTurretRecordHistory() {
        List<TurretHistory__c> turretHistories = [
            select id,
            action__c,
            date__c,
            createdBy.name
            from TurretHistory__c
            where Turret__c = :turret.id
            order by date__c desc
            ];
            
        return turretHistories; 
    }
}