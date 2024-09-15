public with sharing class RTA_JobApplicationTriggerHandler {
    public static void handleAfterUpdateHired(List<Job_Application__c> jobApplications) {
        
        List<Position__c> positionsToClose = 
            [SELECT Id FROM Position__c 
            WHERE Id IN (SELECT Position__c FROM Job_Application__c 
                        WHERE Id IN :Trigger.new 
                        AND
                        Current_Status__c = 'Last stage - Hired')
            ];

        for (Position__c position : positionsToClose) {
            position.Status__c = 'Closed_Filled';
        }

        try {
            update positionsToClose;
            System.debug('Closed position successfully.');
        } catch (DmlException e) {
            System.debug('Cannot close the position. ' + e.getMessage());
        }
    }
}