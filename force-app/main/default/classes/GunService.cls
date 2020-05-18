public class GunService {    
	public static void saveChangeHistory(List<Gun__c> changedGuns) {
		List<GunHistory__c> histories = new List<GunHistory__c>();
        String historyType = 'unknown';

		if (Trigger.isInsert) {
			historyType = 'Create';
		} else if (Trigger.isUpdate) {
            historyType = 'Edit';
		} else {
			historyType = 'Delete';
		}
        
        for (Gun__c gun : changedGuns) {
            GunHistory__c history = new GunHistory__c(
                gun__c = gun.id,
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
