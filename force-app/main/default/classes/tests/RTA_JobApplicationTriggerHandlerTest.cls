@isTest
private class RTA_JobApplicationTriggerHandlerTest {
    @TestSetup
    static void makeData() {
        List<Job_Application__c> jobApplications = new List<Job_Application__c>();
        Position__c position = new Position__c(Name='Test position', Status__c='Open');
        Candidate__c candidate = new Candidate__c(Name='John Smith', Email__c='john@example.com');
        
        insert position;
        insert candidate;

        for (Integer i = 0; i < 100; i++) {
            Job_Application__c jobApplication = new Job_Application__c();

            jobApplication.Position__c = position.Id;
            jobApplication.Candidate__c = candidate.Id;
            jobApplication.Current_Status__c = 'New';
            jobApplication.Link_to_Application__c = 'test-link';
            
            jobApplications.add(jobApplication);
        }
        insert jobApplications;
    }

    @isTest
    static void checkIfPositionIsClosedIfJobApplicationStatusIsHired() {
        List<Job_Application__c> jobApplications = [
            SELECT Id, Position__c FROM Job_Application__c WHERE Current_Status__c='New'
        ];
        Position__c position = [SELECT Id, Status__c FROM Position__c WHERE Id = :jobApplications[0].Position__c];
        System.assertEquals('Open', position.Status__c, 'Position should be Open for hiring.');

        for (Job_Application__c jobApplication : jobApplications) {
            jobApplication.Current_Status__c = 'Last stage - Hired';
        }
        
        Test.startTest();
        update jobApplications;
        Test.stopTest();
        
        position = [SELECT Id, Status__c FROM Position__c WHERE Id = :jobApplications[0].Position__c];
        System.assertEquals('Closed_Filled', position.Status__c, 
                            'When job application status is Last stage - Hired, related position should close.');
    }
    
    @isTest
    static void checkIfPositionIsOpenIfJobApplicationStatusIsNotHired() {
        List<Job_Application__c> jobApplications = [
            SELECT Id, Position__c FROM Job_Application__c WHERE Current_Status__c='New'
        ];
        Position__c position = [SELECT Id, Status__c FROM Position__c WHERE Id = :jobApplications[0].Position__c];
        System.assertEquals('Open', position.Status__c, 'Position should be Open for hiring.');

        for (Job_Application__c jobApplication : jobApplications) {
            jobApplication.Current_Status__c = 'CV checked and invite to interview';
        }
        
        Test.startTest();
        update jobApplications;
        Test.stopTest();
        
        position = [SELECT Id, Status__c FROM Position__c WHERE Id = :jobApplications[0].Position__c];
        System.assertEquals('Open', position.Status__c, 
                            'Position must stay Open, if there are no Hired job applications.');
    }
}