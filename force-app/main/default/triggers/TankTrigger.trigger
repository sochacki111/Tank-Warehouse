trigger TankTrigger on Tank__c ( after delete, after insert, after undelete, after update,
                                 before delete, before insert, before update) {

    if(TriggerExceptionHelper.isTriggerEnabled('TankTrigger__c')) {
        if(Trigger.operationType == System.TriggerOperation.BEFORE_INSERT) {
            TankTriggerHandler.onBeforeInsert(Trigger.new);
        }

        else if(Trigger.operationType == System.TriggerOperation.AFTER_INSERT) {
            TankTriggerHandler.onAfterInsert(Trigger.new, Trigger.newMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.BEFORE_UPDATE) {
            TankTriggerHandler.onBeforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.AFTER_UPDATE) {
            TankTriggerHandler.onAfterUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.BEFORE_DELETE) {
            TankTriggerHandler.onBeforeDelete(Trigger.old, Trigger.oldMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.AFTER_DELETE) {
            TankTriggerHandler.onAfterDelete(Trigger.old, Trigger.oldMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.BEFORE_INSERT) {
            TankTriggerHandler.onBeforeUndelete(Trigger.new, Trigger.newMap);
        }
    }
}