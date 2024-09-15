trigger RTA_JobApplicationTrigger on Job_Application__c (after update, after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            List<Job_Application__c> jobApplications = Trigger.new;
            RTA_JobApplicationTriggerHandler.handleAfterUpdateHired(jobApplications);
        }
        
    }
}