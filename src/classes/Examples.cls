public class Examples {
    
    public Examples(){
        
        List<Integer> myGrades = new List<Integer>();
        myGrades.add(75);
        myGrades.add(85);
        myGrades.add(90);
        myGrades.add(60);
        myGrades.add(70);
        
        System.debug('myGrades: ' + myGrades);
        System.debug('myGrades: ' + myGrades[0]);
        
        for (Integer i=0; i<myGrades.size(); i++){
            System.debug('Grade ' + i+1 + ' : ' + myGrades[i]);
        }
        
        List<String> associates = new List<String>{'Harry', 'Matt', 'Matthew', 'Gabriel'};
        for (Integer i=0; i<myGrades.size(); i++){
            System.debug('associate ' + i+1 + ' : ' + associates[i]);
        }
        
        Set<String> associatesS = new Set<String>{'Harry', 'Matt', 'Matthew', 'Gabriel'};
        System.debug('associates: ' + associatesS);
        
        Map<String, Integer> monthsToDays = new Map<String, Integer>();
        monthsToDays.put('Jan', 31);
        monthsToDays.put('Feb', 28);
        System.debug('monthsToDays: ' + monthsToDays);
        System.debug('Jan: ' + monthsToDays.get('Jan'));
        
        for (Integer i : myGrades){
            System.debug(i);
        }
        
        List<Account> accountList = [SELECT ID, BillingState FROM Account];
        System.debug('accounts: ' + accountList);
        for(Integer i = 0; i < AccountList.size(); i++){
            accountList[i].BillingState = 'VA';
        }
        System.debug('accounts: ' + accountList);
        
        List<Account> accountList2 = [SELECT ID, BillingState FROM Account];
        for (Account a : accountList2){
            a.BillingState = 'VA';
        }
        System.debug('accounts: ' + accountList2);
    }
}