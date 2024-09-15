public with sharing class RTA_Interview {
    public static void createInterviews(ID jobApplicationID) {
        String jobApplicationName = [SELECT Name FROM Job_Application__c WHERE Id = :jobApplicationID].Name;
        
        List<Interview__c> interviews = new List<Interview__c> {
            new Interview__c(Job_Application__c=jobApplicationID, Name=jobApplicationName + ' - first stage',
                                                    Type__c='CV review', Status__c='Scheduled'),
            new Interview__c(Job_Application__c=jobApplicationID, Name=jobApplicationName + ' - second stage',
                                                    Type__c='Personal Interview', Status__c='Scheduled'),
            new Interview__c(Job_Application__c=jobApplicationID, Name=jobApplicationName + ' - last stage',
                                                    Type__c='Test task review', Status__c='Scheduled')
        };
            
        try {
            insert interviews;
            System.debug('All interviews for job application ' + jobApplicationID + ' created successfully');
        } catch (DmlException e) {
            System.debug('Interviews creation failed. ' + e.getMessage());
        }
    }
    
    public static void deleteInterviews(ID jobApplicationID) {
        try {
            List<Interview__c> relatedInterviews = [SELECT Id FROM Interview__c WHERE Job_Application__c =: jobApplicationID];
        	delete relatedInterviews;
            
            System.debug('Interviews deleted successfully.');
        } catch (DmlException e) {
            System.debug('Cannot delete interviews: ' + e.getMessage());
        }
       
    }
}