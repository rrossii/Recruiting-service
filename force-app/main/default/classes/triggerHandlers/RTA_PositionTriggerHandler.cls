public with sharing class RTA_PositionTriggerHandler {
    public static void handleBeforeUpdate(List<Position__c> positions) {
        for (Position__c position : positions) {
            if (position.Closed_Date__c == null && (position.Status__c == 'Closed_Filled' || position.Status__c == 'Closed_Canceled')) {
                position.Closed_Date__c = Date.today();
            }
        }
    }
}