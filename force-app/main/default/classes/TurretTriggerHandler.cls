public class TurretTriggerHandler {

	public static void onBeforeInsert(List<Turret__c> newTurrets){
		System.debug('-- TurretTriggerHandler.onBeforeInsert --');
	}

	public static void onAfterInsert(List<Turret__c> newTurrets, Map<Id,Turret__c> newTurretMap){
        System.debug('-- TurretTriggerHandler.onAfterInsert --');
        TurretService.saveChangeHistory(newTurrets);
	}

	public static void onBeforeUpdate(List<Turret__c> oldTurrets, Map<Id,Turret__c> oldTurretMap, List<Turret__c> newTurrets, Map<Id,Turret__c> newTurretMap){
		System.debug('-- TurretTriggerHandler.onBeforeUpdate --');
	}

	public static void onAfterUpdate(List<Turret__c> oldTurrets, Map<Id,Turret__c> oldTurretMap, List<Turret__c> newTurrets, Map<Id,Turret__c> newTurretMap){
        System.debug('-- TurretTriggerHandler.onAfterUpdate --');
        TurretService.saveChangeHistory(newTurrets);
	}

	public static void onBeforeDelete(List<Turret__c> oldTurrets, Map<Id,Turret__c> oldTurretMap){
		System.debug('-- TurretTriggerHandler.onBeforeDelete --');
		TurretService.saveChangeHistory(oldTurrets);
	}

	public static void onAfterDelete(List<Turret__c> oldTurrets, Map<Id,Turret__c> oldTurretMap){
		System.debug('-- TurretTriggerHandler.onAfterDelete --');
	}

	public static void onBeforeUndelete(List<Turret__c> newTurrets, Map<Id,Turret__c> newTurretMap){
		System.debug('-- TurretTriggerHandler.onBeforeUndelete --');
	}
}