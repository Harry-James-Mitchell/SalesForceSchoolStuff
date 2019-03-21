@isTest(SeeAllData=true)
public class RunAsTest {

    @isTest static void viewClasses(){
        User u = [SELECT Id FROM User WHERE Id = '0051U000003ygerQAA'];
        
        List<Class__c> classes = [SELECT Id, Name FROM Class__c];
        System.debug('Classes: ' + classes);
        
        System.runAs(u){
            classes = [SELECT Id, Name FROM Class__c];
       		System.debug('Classes: ' + classes);
        }
    }
}