trigger ClassEnrollmentTrigger on ClassEnrollment__c (before insert) {

    if(Trigger.isBefore && Trigger.isInsert){
        //System.debug('we got in here');
        CreateGrades.createGradesForEnrollment(trigger.new);
    } 
}