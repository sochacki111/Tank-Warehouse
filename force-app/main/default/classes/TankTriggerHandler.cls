public class TankTriggerHandler {

    public static void onBeforeInsert(List<Tank__c> newTanks){
        System.debug('-- TankTriggerHandler.onBeforeInsert --');
    }

    public static void onAfterInsert(List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onAfterInsert --');
    }

    public static void onBeforeUpdate(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap, List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onBeforeUpdate --');
    }

    public static void onAfterUpdate(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap, List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onAfterUpdate --');
    }

    public static void onBeforeDelete(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap){
        System.debug('-- TankTriggerHandler.onBeforeDelete --');
    }

    public static void onAfterDelete(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap){
        System.debug('-- TankTriggerHandler.onAfterDelete --');
    }

    public static void onBeforeUndelete(List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onBeforeUndelete --');
    }
}