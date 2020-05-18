public class TankService {
	public static void isDuplicate(List<Tank__c> changedTanks) {
		List<Tank__c> tanks = [
			select id,
			name,
			country__c
			from Tank__c
		];
		for (Tank__c newTank : changedTanks) {
			for (Tank__c tank : tanks) {
				if (newTank.name == tank.name && newTank.country__c == tank.country__c) {
					newTank.addError('Based on entered data possible duplicate was detected. Record not saved');
				}
			}
		}
	}
    
	public static void saveChangeHistory(List<Tank__c> changedTanks) {
		List<TankHistory__c> histories = new List<TankHistory__c>();
        String historyType = 'unknown';

		if (Trigger.isInsert) {
			historyType = 'Create';
		} else if (Trigger.isUpdate) {
            historyType = 'Edit';
		} else {
			historyType = 'Delete';
		}
        
        for (Tank__c tank : changedTanks) {
            TankHistory__c history = new TankHistory__c(
                tank__c = tank.id,
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
