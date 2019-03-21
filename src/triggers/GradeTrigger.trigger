trigger GradeTrigger on Grade__c (before insert) {

    if(trigger.isBefore && trigger.isInsert){
        CreateGrades.preventDuplicates(trigger.new);
    }
}