trigger TurretTrigger on Turret__c ( after delete, after insert, after undelete, after update,
                                 before delete, before insert, before update) {

    if(TriggerExceptionHelper.isTriggerEnabled('TurretTrigger__c')) {
        if(Trigger.operationType == System.TriggerOperation.BEFORE_INSERT) {
            TurretTriggerHandler.onBeforeInsert(Trigger.new);
        }

        else if(Trigger.operationType == System.TriggerOperation.AFTER_INSERT) {
            TurretTriggerHandler.onAfterInsert(Trigger.new, Trigger.newMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.BEFORE_UPDATE) {
            TurretTriggerHandler.onBeforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.AFTER_UPDATE) {
            TurretTriggerHandler.onAfterUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.BEFORE_DELETE) {
            TurretTriggerHandler.onBeforeDelete(Trigger.old, Trigger.oldMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.AFTER_DELETE) {
            TurretTriggerHandler.onAfterDelete(Trigger.old, Trigger.oldMap);
        }

        else if(Trigger.operationType == System.TriggerOperation.BEFORE_INSERT) {
            TurretTriggerHandler.onBeforeUndelete(Trigger.new, Trigger.newMap);
        }
    }
}