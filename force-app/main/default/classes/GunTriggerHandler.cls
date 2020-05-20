public class GunTriggerHandler {

    public static void onBeforeInsert(List<Gun__c> newGuns){
        System.debug('-- GunTriggerHandler.onBeforeInsert --');
    }

    public static void onAfterInsert(List<Gun__c> newGuns, Map<Id,Gun__c> newGunMap){
        System.debug('-- GunTriggerHandler.onAfterInsert --');
        GunService.saveChangeHistory(newGuns);
    }

    public static void onBeforeUpdate(List<Gun__c> oldGuns, Map<Id,Gun__c> oldGunMap, List<Gun__c> newGuns, Map<Id,Gun__c> newGunMap){
        System.debug('-- GunTriggerHandler.onBeforeUpdate --');
        GunService.saveChangeHistory(oldGunMap, newGuns);
    }

    public static void onAfterUpdate(List<Gun__c> oldGuns, Map<Id,Gun__c> oldGunMap, List<Gun__c> newGuns, Map<Id,Gun__c> newGunMap){
        System.debug('-- GunTriggerHandler.onAfterUpdate --');
    }

    public static void onBeforeDelete(List<Gun__c> oldGuns, Map<Id,Gun__c> oldGunMap){
        System.debug('-- GunTriggerHandler.onBeforeDelete --');
        GunService.saveChangeHistory(oldGuns);
    }

    public static void onAfterDelete(List<Gun__c> oldGuns, Map<Id,Gun__c> oldGunMap){
        System.debug('-- GunTriggerHandler.onAfterDelete --');
    }

    public static void onBeforeUndelete(List<Gun__c> newGuns, Map<Id,Gun__c> newGunMap){
        System.debug('-- GunTriggerHandler.onBeforeUndelete --');
    }
}