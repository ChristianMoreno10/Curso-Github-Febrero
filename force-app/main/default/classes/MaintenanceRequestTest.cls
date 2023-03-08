@isTest
public with sharing class MaintenanceRequestTest {
    @TestSetup
    static void makeData(){
        Vehicle__c vehicle = new Vehicle__c(Name = 'Vehicle');
        insert vehicle;
        Vehicle__c vehicle2 = new Vehicle__c(Name = 'Vehicle2');
        insert vehicle2;

        List<Case> cases = new List<Case>();
        Case case1 = new Case(Status = 'Working', Origin = 'Email', Type = 'Repair', Vehicle__c = vehicle.Id);
        Case case2 = new Case(Status = 'Working', Origin = 'Email', Type = 'Routine Maintenance', Vehicle__c = vehicle2.Id);
        cases.add(case1);
        cases.add(case2);
        insert cases;
        
    }

    @isTest
    static void CreateANewCaseRelatedToVehicleWhenTypeisRepairAndUpdateStatusToClosed(){
        Case cas = [SELECT Id FROM Case WHERE Type = 'Repair'];
        cas.Status = 'Closed';
        Vehicle__c vehicle = [SELECT Id FROM Vehicle__c WHERE Name = 'Vehicle'];
        
        Test.startTest();
        update cas;
        Test.stopTest();

        System.assertEquals(1, [select count() from Case where Status = 'New' and Vehicle__c =: vehicle.Id and Type = 'Routine Maintenance']);
    }
    
    @isTest
    static void CreateANewCaseRelatedToVehicleWhenTypeIsRoutineMaintenanceAndUpdateStatusToClosed(){
        Case cas = [SELECT Id FROM Case WHERE Type = 'Routine Maintenance'];
        cas.Status = 'Closed';
        Vehicle__c vehicle = [SELECT Id FROM Vehicle__c WHERE Name = 'Vehicle2'];
        
        Test.startTest();
        update cas;
        Test.stopTest();

        System.assertEquals(1, [select count() from Case where Status = 'New' and Vehicle__c =: vehicle.Id and Type = 'Routine Maintenance']);
    }
}