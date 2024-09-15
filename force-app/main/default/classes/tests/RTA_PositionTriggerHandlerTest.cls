@isTest
public class RTA_PositionTriggerHandlerTest {
    @TestSetup
    static void makeData() {
        List<Position__c> positions = new List<Position__c>();

        for (Integer i = 0; i < 100; i++) {
            Position__c position = new Position__c();
            position.Name = 'Test position '+ i;
            position.Status__c = 'Open';
            position.Min_Salary__c = 500;
            position.Max_Salary__c = 1000;

            positions.add(position);
        }

        insert positions;
    }

    @isTest
    static void checkClosedDateIsCurrentDate() {
        List<Position__c> positions = [SELECT Id FROM Position__c WHERE Status__c = 'Open'];

        Test.startTest();
        for (Position__c position : positions) {
            position.Status__c = 'Closed_Filled';
        }
        update positions;
        Test.stopTest();

        List<Position__c> closedFilledPositions = [SELECT Id, Closed_Date__c FROM Position__c WHERE Status__c = 'Closed_Filled'];

        for (Position__c position : closedFilledPositions) {
            System.assertEquals(System.today(), position.Closed_Date__c);
        }

    }
}