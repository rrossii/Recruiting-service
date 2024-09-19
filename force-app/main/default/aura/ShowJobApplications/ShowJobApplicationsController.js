({
    init: function (component, event, helper) {
        var action = component.get("c.getRelatedJobApplicationsInfo");

        action.setParams({
            candidateId: component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.jobApplications", data.getReturnValue());
        });
        $A.enqueueAction(action);

        component.set('v.columns', [
            {label: 'Application name', fieldName: 'Name', type: 'text'},
            {label: 'Status', fieldName: 'Current_Status__c', type: 'text'},
            {label: 'Applied date', fieldName: 'Application_Date__c', type: 'date'}
        ]);
    }
});

