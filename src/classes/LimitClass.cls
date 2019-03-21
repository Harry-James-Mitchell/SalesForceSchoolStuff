@isTest(SeeAllData=true)
public class LimitClass {
	
    @isTest static void methodOne(){
        List<Account> accList = new List<Account>();
        for(Integer i=0; i<5; i++){
			Account a = new Account(Name = 'test' + i);
            accList.add(a);
        }
        insert accList;
        System.debug('Number of DML statements in methodOne: ' + Limits.getDmlStatements());
        System.debug('Number of DML statements allowed: ' + Limits.getLimitDmlStatements());
        System.debug('Amout of heap size used: ' + Limits.getHeapSize());
        System.debug('total amount of heap allowed: ' + Limits.getLimitHeapSize());
    }
    
    //Why you should never do this - uses five times as much stuff
    @isTest static void methodTwo(){
        //List<Account> accList = new List<Account>();
        for(Integer i=0; i<5; i++){
			Account a = new Account(Name = 'test' + i);
            //accList.add(a);
            insert a;
        }
        //insert accList;
        System.debug('Number of DML statements in methodTwo: ' + Limits.getDmlStatements());
        System.debug('Number of DML statements allowed: ' + Limits.getLimitDmlStatements());
        System.debug('Amout of heap size used: ' + Limits.getHeapSize());
        System.debug('total amount of heap allowed: ' + Limits.getLimitHeapSize());
    }
}