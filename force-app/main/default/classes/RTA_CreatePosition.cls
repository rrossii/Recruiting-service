public with sharing class RTA_CreatePosition {
    
    @InvocableMethod(label='Create position')
    public static void createPosition(List<PositionRequest> requests) {
        List<Position__c> positionsToInsert = new List<Position__c>();
        
        for (PositionRequest request : requests) {
            Position__c position = new Position__c(
                Status__c='Open',
                Name=request.name, 
                Description__c=request.description,
                Min_Salary__c=request.minSalary,
                Max_Salary__c=request.maxSalary);
            
            positionsToInsert.add(position);
            
        }
        
        
        try {
            if (!positionsToInsert.isEmpty()) {
                insert positionsToInsert;
            	System.debug('Positions created successfully.');
            }
        } catch (DmlException e) {
            System.debug('Position creation failed. ' + e.getMessage());
        }
    }
    
    public class PositionRequest {
        @InvocableVariable
        public String name;
        
        @InvocableVariable
        public String description;
        
        @InvocableVariable
        public Integer minSalary;
        
        @InvocableVariable
        public Integer maxSalary;
    }

}