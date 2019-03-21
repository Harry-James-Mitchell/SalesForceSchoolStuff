@isTest
public class ProjectZeroTest {
	
    @isTest static void testFibonacci(){
        // Single Action - Positive
        System.assertEquals(1, P0.fibonacci(1));
        System.assertEquals(1, P0.fibonacci(2));
        System.assertEquals(2, P0.fibonacci(3));
        System.assertEquals(89, P0.fibonacci(11));
        System.assertEquals(6765, P0.fibonacci(20));
        System.assertEquals(196418, P0.fibonacci(27));
        
        //Single Action - Negative
        System.assertEquals(-1, P0.fibonacci(-5));
    }
    
    @isTest static void testSortArray(){
        // Single action - Positive
        List<Integer> unsortedArray = new List<integer>{2, 4, 5, 1, 3, 1};
        List<Integer> sortedArray = new List<integer>{1, 1, 2, 3, 4, 5};
        List<Integer> returnedArray = P0.sortArray(unsortedArray);
        
        for(Integer i=0; i<sortedArray.size(); i++){
            System.assertEquals(sortedArray[i], returnedArray[i]);
        }
        
        
    }
    
    @isTest static void testFactorial(){
        //Single action - positive
        System.assertEquals(1, P0.factorial(1));
        System.assertEquals(2, P0.factorial(2));
        System.assertEquals(6, P0.factorial(3));
        System.assertEquals(120, P0.factorial(5));
        //System.assertEquals(3628800, P0.factorial(20));
    }
    
    @isTest static void testRotateLeft(){
        //Single Action - positive
        List<Integer> unrotatedArray = new List<integer>{2, 4, 5, 1, 3, 1};
        List<Integer> rotatedArray = new List<integer>{4, 5, 1, 3, 1, 2};
        List<Integer> returnedArray = P0.rotateLeft(unrotatedArray, 1);
        
        for(Integer i = 0; i<rotatedArray.size()-1; i++){
			System.assertEquals(rotatedArray[i], returnedArray[i]);
        }
    }
    
    @isTest static void testBalancedBrackets(){
        System.assertEquals(true, P0.balancedBrackets('[](){}'));
        System.assertEquals(true, P0.balancedBrackets('([{}])'));
        System.assertEquals(false, P0.balancedBrackets('([)]'));
        System.assertEquals(false, P0.balancedBrackets('([{]})'));
        System.assertEquals(true, P0.balancedBrackets('({[({[]})]})'));
    }
    
    @isTest static void testUpdateAccountSize(){
		//Test single action - positive
		insert new Account(Name = 'test12345', NumberOfEmployees=1);
        insert new Account(Name = 'test123456', NumberOfEmployees=1001);
        insert new Account(Name = 'test1234567', NumberOfEmployees=1000001);
        P0.updateAccountSize();
        
        Account a = [SELECT Size__c FROM Account WHERE Name = 'Test12345' LIMIT 1];
        System.assertEquals('small', a.size__c);       
        a = [SELECT Size__c FROM Account WHERE Name = 'Test123456' LIMIT 1];
        System.assertEquals('medium', a.size__c); 
        a = [SELECT Size__c FROM Account WHERE Name = 'Test1234567' LIMIT 1];
        System.assertEquals('large', a.size__c);
        
        //Test bulk Action - Postitive
        List<Account> accs = [SELECT NumberOfEmployees, Size__c FROM Account WHERE Name LIKE 'TEst%'];
        for(Account acc : accs){
            if (acc.NumberOfEmployees < 1000){
				System.assertEquals('small', acc.size__c);
            } else if (acc.NumberOfEmployees < 10000) {
                System.assertEquals('medium', acc.size__c);
            } else {
                System.assertEquals('large', acc.size__c);
            }
        }
    }
    
    @isTest static void testUpdateCALeads(){
		List<Lead> leads = new List<Lead>();
        leads.add(new Lead(LastName='Test1234', State='CA', Company='WhatEverYouNeedApex'));
        //leads.add(new Lead(LastName='Test12345', State='IA'));
        leads.add(new Lead(LastName='Test123456', State='CA', Company='WhatEverYouNeedApex'));
        leads.add(new Lead(LastName='Test1234567', State='CA', Company='WhatEverYouNeedApex'));
        insert leads;
        p0.updateCALeads();
        
        for(Lead l : [SELECT Status, Description, State FROM Lead WHERE State='CA']){
            System.assertEquals('Closed - Not Converted', l.Status);
            System.assertEquals('We are no longer doing business in California.', l.Description);
        }
    }
    
    @isTest static void testUpdateOpportunitiesPastClosedDate(){
        List<Opportunity> ops = new List<Opportunity>();
        ops.add(new Opportunity(StageName = 'Prospecting', CloseDate = Date.newInstance(2018, 4, 20), Name='HaveABall'));
        ops.add(new Opportunity(StageName = 'Needs Analysis', CloseDate = Date.newInstance(2018, 2, 20), Name='Bad Idea'));
       // ops.add(new Opportunity(StageName = 'Open', CloseDate = Date.newInstance(2019, 4, 20)));
        ops.add(new Opportunity(StageName = 'Negotiation/Review', CloseDate = Date.newInstance(2018, 3, 30), Name='UniqueOpportunityName'));
        insert ops;
        P0.updateOpportunitiesPastClosedDate();
        
        for(Opportunity op: [SELECT StageName, CloseDate FROM Opportunity WHERE CloseDate<Today]){
            System.assertEquals('Closed Lost', op.StageName);
        }
    }
}