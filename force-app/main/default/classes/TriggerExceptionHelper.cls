public with sharing class TriggerExceptionHelper {
    public static Boolean isTriggerEnabled(String triggerName) {
        try {
            TriggerException__c triggerExc = TriggerException__c.getInstance();
            Boolean result = (Boolean)triggerExc.get(triggerName);
            System.debug('Trigger ' + triggerName + ' = ' + result);
            return result;
        } catch(Exception exc){
            System.debug(exc.getMessage());
            return false;
        }
    }
}