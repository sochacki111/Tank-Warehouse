public class TankTriggerHandler {

	public static void onBeforeInsert(List<Tank__c> newTanks){
		System.debug('-- TankTriggerHandler.onBeforeInsert --');
        TankService.isDuplicate(newTanks);
	}

	public static void onAfterInsert(List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onAfterInsert --');
        TankService.saveChangeHistory(newTanks);
	}

	public static void onBeforeUpdate(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap, List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
		System.debug('-- TankTriggerHandler.onBeforeUpdate --');
	}

	public static void onAfterUpdate(List<Tank__c> oldTanks, Map<Id,Tank__c> oldTankMap, List<Tank__c> newTanks, Map<Id,Tank__c> newTankMap){
        System.debug('-- TankTriggerHandler.onAfterUpdate --');
        TankService.saveChangeHistory(newTanks);
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