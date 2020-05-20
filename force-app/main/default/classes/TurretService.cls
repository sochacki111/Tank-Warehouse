public class TurretService {
	public static void saveChangeHistory(Map<Id,Turret__c> oldTurretMap, List<Turret__c> newTurrets) {
		List<TurretHistory__c> histories = new List<TurretHistory__c>();
		Map<String, Schema.SobjectField> turretFields = Schema.SObjectType.Turret__c.fields.getMap();
		String oldValue;
		String newValue;
		String fieldLabel;
		String actionHistory = '';
		Turret__c oldTurret = (Turret__c)trigger.old[0];

		for (Turret__c turret : newTurrets) {
			for (String fieldName : turretFields.keySet()) {
				if ( turret.get(fieldName) != oldTurretMap.get(turret.id).get(fieldName)) {
					oldValue = String.valueOf(oldTurret.get(fieldName));
					newValue = String.valueOf(turret.get(fieldName));
					fieldLabel = turretFields.get(fieldName).getDescribe().getLabel();
					actionHistory += 'Changed ' + 
					'<strong>' + fieldLabel + '</strong>' + 
					' from ' + 
					oldValue + 
					' to ' + 
					'<strong>' + newValue + '</strong>' +
					'<br/>';
				}  
			}
		}
		if (String.isBlank(actionHistory)) {
			actionHistory = 'Empty Update';
		}

        for (Turret__c turret : newTurrets) {
            TurretHistory__c history = new TurretHistory__c(
                turret__c = turret.id,
                action__c = actionHistory,
                date__c = System.now()
			);
			histories.add(history);
        }

		try {
			insert histories;
		} catch (DMLException e) {
			System.debug(e);
		}
	}

	public static void saveChangeHistory(List<Turret__c> changedTurrets) {
		List<TurretHistory__c> histories = new List<TurretHistory__c>();
        String actionHistory;

		if (Trigger.isInsert) {
			actionHistory = 'Created';
		} else {
			actionHistory = 'Deleted';
		}
        
        for (Turret__c turret : changedTurrets) {
            TurretHistory__c history = new TurretHistory__c(
                turret__c = turret.id,
                action__c = actionHistory,
                date__c = System.now()
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
