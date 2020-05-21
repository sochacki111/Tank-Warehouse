public class GunService {
    public static void saveChangeHistory(Map<Id,Gun__c> oldGunMap, List<Gun__c> newGuns) {
        List<GunHistory__c> histories = new List<GunHistory__c>();
        Map<String, Schema.SobjectField> gunFields = Schema.SObjectType.Gun__c.fields.getMap();
        String oldValue;
        String newValue;
        String fieldLabel;
        String actionHistory = '';
        Gun__c oldGun = (Gun__c)trigger.old[0];

        for (Gun__c gun : newGuns) {
            for (String fieldName : gunFields.keySet()) {
                if ( gun.get(fieldName) != oldGunMap.get(gun.id).get(fieldName)) {
                    oldValue = String.valueOf(oldGun.get(fieldName));
                    newValue = String.valueOf(gun.get(fieldName));
                    fieldLabel = gunFields.get(fieldName).getDescribe().getLabel();
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

        for (Gun__c gun : newGuns) {
            GunHistory__c history = new GunHistory__c(
                gun__c = gun.id,
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

    public static void saveChangeHistory(List<Gun__c> changedGuns) {
        List<GunHistory__c> histories = new List<GunHistory__c>();
        String actionHistory;

        if (Trigger.isInsert) {
            actionHistory = 'Created';
        } else {
            actionHistory = 'Deleted';
        }
        
        for (Gun__c gun : changedGuns) {
            GunHistory__c history = new GunHistory__c(
                gun__c = gun.id,
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
