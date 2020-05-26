public class TankTriggerHandler {

    public static void onBeforeInsert(List<Tank__c> newTanks){
        System.debug('-- TankTriggerHandler.onBeforeInsert --');
        TankService.isDuplicate(newTanks);
    }
    
    public static void onAfterInsert(List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onAfterInsert --');
        TankService.saveChangeHistory(newTanks);
         // TODO Is it a good practice to pass all newTanks into Queueable and to check there from which local record create pnrc?  
        System.enqueuejob(new CreateTankPartnerNetworkRecordConnection(newTankMap));
    }

    public static void onBeforeUpdate(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap, List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onBeforeUpdate --');
        TankService.saveChangeHistory(oldTankMap, newTanks);
    }

    public static void onAfterUpdate(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap, List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onAfterUpdate --');
    }

    public static void onBeforeDelete(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap){
        System.debug('-- TankTriggerHandler.onBeforeDelete --');
        TankService.saveChangeHistory(oldTanks);
    }

    public static void onAfterDelete(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap){
        System.debug('-- TankTriggerHandler.onAfterDelete --');
    }

    public static void onBeforeUndelete(List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onBeforeUndelete --');
    }
}