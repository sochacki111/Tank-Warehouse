trigger GunTrigger on Gun__c ( after delete, after insert, after undelete, after update,
                                 before delete, before insert, before update) {

    if(TriggerExceptionHelper.isTriggerEnabled('GunTrigger__c')) {
        if(Trigger.operationType == System.TriggerOperation.BEFORE_INSERT) {
            GunTriggerHandler.onBeforeInsert(Trigger.new);
        }

        else if(Trigger.operationType == System.TriggerOperation.AFTER_INSERT) {
            GunTriggerHandler.onAfterInsert(Trigger.new, Trigger.newMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.BEFORE_UPDATE) {
            GunTriggerHandler.onBeforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.AFTER_UPDATE) {
            GunTriggerHandler.onAfterUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.BEFORE_DELETE) {
            GunTriggerHandler.onBeforeDelete(Trigger.old, Trigger.oldMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.AFTER_DELETE) {
            GunTriggerHandler.onAfterDelete(Trigger.old, Trigger.oldMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.BEFORE_INSERT) {
            GunTriggerHandler.onBeforeUndelete(Trigger.new, Trigger.newMap);
        }
    }
}