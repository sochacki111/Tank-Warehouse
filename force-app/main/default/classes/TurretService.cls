public class TurretService {    
	public static void saveChangeHistory(List<Turret__c> changedTurrets) {
		List<TurretHistory__c> histories = new List<TurretHistory__c>();
        String historyType = 'unknown';

		if (Trigger.isInsert) {
			historyType = 'Create';
		} else if (Trigger.isUpdate) {
            historyType = 'Edit';
		} else {
			historyType = 'Delete';
		}
        
        for (Turret__c turret : changedTurrets) {
            TurretHistory__c history = new TurretHistory__c(
                turret__c = turret.id,
                type__c = historyType,
                modifyDate__c = System.now()
			);
			histories.add(history);
        }
        
		try {
			insert histories;
		} catch (DMLException e) {
			System.debug(e);
		}
	}
}
