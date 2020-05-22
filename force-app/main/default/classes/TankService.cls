public class TankService {
    public static void isDuplicate(List<Tank__c> changedTanks) {
        List<Tank__c> tanks = TanksSelector.findAll();

        for (Tank__c newTank : changedTanks) {
            for (Tank__c tank : tanks) {
                if (newTank.name == tank.name && newTank.country__c == tank.country__c) {
                    newTank.addError('Based on entered data possible duplicate was detected. Record not saved');
                }
            }
        }
    }

    public static void saveChangeHistory(Map<Id,Tank__c> oldTankMap, List<Tank__c> newTanks) {
        List<TankHistory__c> histories = new List<TankHistory__c>();
        Map<String, Schema.SobjectField> tankFields = Schema.SObjectType.Tank__c.fields.getMap();
        String oldValue;
        String newValue;
        String fieldLabel;
        String actionHistory = '';
        Tank__c oldTank = (Tank__c)trigger.old[0];

        for (Tank__c tank : newTanks) {
            for (String fieldName : tankFields.keySet()) {
                if ( tank.get(fieldName) != oldTankMap.get(tank.id).get(fieldName)) {
                    oldValue = String.valueOf(oldTank.get(fieldName));
                    newValue = String.valueOf(tank.get(fieldName));
                    fieldLabel = tankFields.get(fieldName).getDescribe().getLabel();
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

        for (Tank__c tank : newTanks) {
            TankHistory__c history = new TankHistory__c(
                tank__c = tank.id,
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

    public static void saveChangeHistory(List<Tank__c> changedTanks) {
        List<TankHistory__c> histories = new List<TankHistory__c>();
        String actionHistory;

        if (Trigger.isInsert) {
            actionHistory = 'Created';
        } else {
            actionHistory = 'Deleted';
        }
        
        for (Tank__c tank : changedTanks) {
            TankHistory__c history = new TankHistory__c(
                tank__c = tank.id,
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
