public with sharing class RTA_UpdatePosition {
    public static void updateOpenedDevPositions() {
        List<Position__c> openedDevPositions = [FIND 'dev*' IN ALL FIELDS RETURNING Position__c(Description__c, Min_Salary__c, Max_Salary__c, Status__c)][0];
        
        List<Position__c> openedDevPositionsToUpdate = new List<Position__c>();
        for (Position__c position : openedDevPositions) {
            if (position.Status__c == 'Open') {
                position.Min_Salary__c += position.Min_Salary__c * 0.1;
                position.Max_Salary__c += position.Max_Salary__c * 0.1;
                
                openedDevPositionsToUpdate.add(position);
            }
        }
        
        try {
            update openedDevPositionsToUpdate;
            System.debug('Opened dev position updated successfully.');
        } catch (DmlException e) {
            System.debug('Cannot update opened dev position: ' + e.getMessage());
        }
        
        
    }
}