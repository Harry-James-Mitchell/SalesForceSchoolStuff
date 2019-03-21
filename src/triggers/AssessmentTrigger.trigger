trigger AssessmentTrigger on Assessment__c (after insert) {

    if(trigger.isAfter && trigger.isInsert){
        CreateGrades.createGradeForAllStudentsInAssessment(trigger.new);
    }
}