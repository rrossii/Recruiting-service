public without sharing class RTA_CandidateController {
    @AuraEnabled(cacheable=true)
    public static List<Position__c> getRelatedPositionInfo(Id candidateId) {
        List<Position__c> position = [
            SELECT Id, Name, Description__c, Required_Skills__c, Location__c FROM Position__c
            WHERE Id IN (SELECT Position__c FROM Job_Application__c WHERE Candidate__c = :candidateId)
        ];

        try {
            return position;
        } catch (Exception e) {
            throw new AuraHandledException('Error in getRelatedPositionInfo(): ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static Candidate__c getCandidateById(Id candidateId) {
        try {
            return [SELECT Id, Name, Email__c, Location__c FROM Candidate__c WHERE Id = :candidateId];
        } catch (Exception e) {
            throw new AuraHandledException('Error in getCandidateById(): ' + e.getMessage());
        }
    }
}