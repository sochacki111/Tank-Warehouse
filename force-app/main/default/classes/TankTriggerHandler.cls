public class TankTriggerHandler {

    public static void onBeforeInsert(List<Tank__c> newAccs){
        System.debug('-- TankTriggerHandler.onBeforeInsert --');
    }

    public static void onAfterInsert(List<Tank__c> newAccs, Map<Id,Tank__c> newAccMap){
        System.debug('-- TankTriggerHandler.onAfterInsert --');
    }

    public static void onBeforeUpdate(List<Tank__c> oldAccs, Map<Id,Tank__c> oldAccMap, List<Tank__c> newAccs, Map<Id,Tank__c> newAccMap){
        System.debug('-- TankTriggerHandler.onBeforeUpdate --');
    }

    public static void onAfterUpdate(List<Tank__c> oldAccs, Map<Id,Tank__c> oldAccMap, List<Tank__c> newAccs, Map<Id,Tank__c> newAccMap){
        System.debug('-- TankTriggerHandler.onAfterUpdate --');
    }

    public static void onBeforeDelete(List<Tank__c> oldAccs, Map<Id,Tank__c> oldAccMap){
        System.debug('-- TankTriggerHandler.onBeforeDelete --');
    }

    public static void onAfterDelete(List<Tank__c> oldAccs, Map<Id,Tank__c> oldAccMap){
        System.debug('-- TankTriggerHandler.onAfterDelete --');
    }

    public static void onBeforeUndelete(List<Tank__c> newAccs, Map<Id,Tank__c> newAccMap){
        System.debug('-- TankTriggerHandler.onBeforeUndelete --');
    }
}