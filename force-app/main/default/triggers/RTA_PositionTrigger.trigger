trigger RTA_PositionTrigger on Position__c (before update) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        List<Position__c> positions = Trigger.new;
        RTA_PositionTriggerHandler.handleBeforeUpdate(positions);
    }
}