public class DMLExamples {
    
    public static void insertAndUpdateExample(){
        
        List<Account> accountsToInsert = new List<Account>();
        
        for(Integer i = 0; i<3; i++){
			Account a = new Account(name = 'Wal-Mart' + (i+1), BillingCity = 'San Francisco');
            accountsToInsert.add(a);
        }

        
        try {     
            insert accountsToInsert;
           //update account Wal-Mart2
       	   Account accountToUpdate = [SELECT BillingCity 
                               FROM Account 
                               WHERE Name='Wal-Mart2' 
                               LIMIT 1];
            System.debug('Wal-Mart2: ' + accountToUpdate);
            //Update the billing city
            accountToUpdate.BillingCity = 'New York';
            update accountToUpDate;
            System.debug('Wal-Mart2: ' + accountToUpdate);
        } catch(DMLException E){
            System.debug('an unexpected error has occurred: ' + E.getMessage());
        }       
        
    }
    
    /*
     * You can insert records related to existing records if a relationship has already been defined
     * between the two objects. A record is associated with a related record through a foreign key ID.
     * 
     * This example adds a contact to an Account (the related record) by setting the accountID field
     * on the contact.
     */
    public static void insertingRelatedRecord(){
        try{
            Account a = new Account(Name = 'SFDC Account');
            //before you insert an account record it has no ID
            insert a;
            Id aID = A.Id;
            //add a contact to this account
            contact c = new Contact(FirstName = 'Harry', LastName = 'Mitchell', Phone='3196318648', AccountID=aId);
            insert c;
            
        } catch(DMLException E){
            System.debug('an unexpected error has occurred: ' + E.getMessage());
        } 
    }
    
    /*
     * Fields on related records can't be updated with the same call to the DML operation and require a seperate DML call
     * for example, if inserting a new contact, you can specify the contact's related account record by setting the value of the
     * AccountId field however, you can't change the account's name without updating the account iself with a seperate DML call.
     * Similary, when updating a contact, if you also want to update the contact's related account, you msut make two DML calls
     */
    public static void updatingRelatedRecords(){
        try{
            //Query for contact
           Contact queriedContact = [SELECT Phone, Account.Industry
                                     FROM Contact 
                                     WHERE FirstName = 'Harry' 
                                     AND LastName = 'Mitchell'
                                     LIMIT 1]; 
            //UPdate the contact's phone number
            queriedContact.phone = '3196318648';
            //Update related account inductry
            queriedContact.Account.Industry = 'Technology';
            /*
             * Make two seperate calls
             * 1. this call is to update the contact's phone
             * 2. this call is to update the realated account's industry field
             */
            update queriedContact;
            update queriedContact.Account;
            
        } catch (DMLException E){
			System.debug('an unexpected error has occurred: ' + E.getMessage());
        }
    }
    
    /*
     * Using the upsert operation, you can either insert or update an existing record in one call
     * To determine wheter a record already exists, the upsert statement or database method uses the
     * record's ID as the key to match records, a custom external ID, or a standard field with the 
     * idLookup attribute set to true.
     * - if the key is not matched, then a new record is created
     * - if the key is matched once, then the existing record is updated
     * - if the key is matched multiple times, then an error is generated and the object is neither inserted or updated.
     */
    public static void upsertExample(){
        List<Account> accountList = [SELECT BillingCity
                                    FROM account
                                    WHERE BillingCity = 'San Francisco'];
        for(Account a: accountList){
			a.BillingCity = 'Mumbai';
        }   
        Account a = new Account(Name = 'ACME', BillingCity = 'San Francisco');
        accountList.add(a);
        
        try{
            upsert accountList;
        } catch (DMLException e){
            System.debug('An error occured! Idiot >:<( ' + e.getMessage());
        }
    }
    
    /*
     * Only available for lead, contact, or account records. You can merge up to three records of the same sObject type.
     * The merge operation merges up to three records into one of the records, deletes the others, and reparents any 
     * related records
     */
    public static void mergeExample(){
        //Insert new accounts
        List<Account> ls = new List<Account> { new Account(Name = 'Dunkin Inc.'),
            								   new Account(Name = 'Dunkin')};
        insert ls;
        //Queries to get the inserted accounts
        Account masterAccount = [SELECT Id,Name 
                                 FROM Account 
                                 WHERE Name = 'Dunkin Inc.' 
                                 LIMIT 1];
        Account mergeAccount = [SELECT Id,Name 
                                 FROM Account 
                                 WHERE Name = 'Dunkin' 
                                 LIMIT 1];
        //Add a new contact to the account to be merged
        Contact c = new Contact(FirstName = 'Harry', LastName = 'Merged');
        c.AccountId = mergeAccount.Id;
        insert c;
        
        Account[] result = [SELECT Id, Name 
                            FROM Account 
                            WHERE Name 
                            LIKE '%Dunkin%'];
        System.debug('Before Merge ' + result);
        try{
            merge MasterAccount mergeAccount;
        } catch (DMLException E){
            System.debug('it borke :( ' + E.getMessage());
        }
        Account[] res = [SELECT Id, Name 
                            FROM Account 
                            WHERE Name 
                            LIKE '%Dunkin%'];
        System.debug('After Merge ' + res);
    }
    
    /*
     * you can delete records using the delete operation. deleted records arn't deleted permanently from salesforce, but they
     * are placed in the recycle bin for 14 days from where they can be restored
     */
    public static void deleteExample(){
		insert new Account(Name = 'DotCom');
        Account[] doomedAccounts = [SELECT Name
                                   FROM Account
                                   WHERE Name = 'DotCom'];
        
        System.debug('Doom Accounts ' + doomedAccounts);
        try{
            delete doomedAccounts;
        } catch (DMLException E){
            System.debug('it borke :( ' + E.getMessage());
        }
        doomedAccounts = [SELECT Name
                          FROM Account
                          WHERE Name = 'DotCom'];
        System.debug('Doom Accounts ' + doomedAccounts);
    }
    
    public static void undeleteExample(){
		/*
		 * SOQL statements can use the ALL ROWS keywords to query all records in an organization,
		 * including deleted records and archived activities. You can use ALL ROWS to query records in your org's Recyle Bin.
		 * You can't use the ALL ROWS keywords with the FOR UPDATE keywords.
		 */
        Account[] savedAccounts = [SELECT Name
                                  FROM Account
                                  WHERE Name = 'DotCom'
                                  ALL ROWS];
        System.debug('Saved Accounts before undelete: ' + savedAccounts);
        try{
            undelete savedAccounts;
        } catch (DMLException E){
            System.debug('it borke :( ' + E.getMessage());
        }
        savedAccounts = [SELECT Name
                         FROM Account
                         WHERE Name = 'DotCom'];
        System.debug('the following accounts were saved: ' + savedAccounts);
    }
    
    public static void queryForLoop(){
        List<Account> accountList = [SELECT Id, Name FROM Account LIMIT 5];
        
        For (Account a: accountList){
            System.debug('a ' + a);
        }
        for (Account a: [SELECT Id, Name FROM Account LIMIT 5]){
            System.debug('a ' + a);
        }
    }
    
    public static void badPratices(){
        //bad becuase you have 100 insert statements used of your 150
        for(Integer i=0; i<100; i++){
            Account a = new Account(Name = 'Account ' + i);
            insert a;
        }
        //instead do the following
        Account[] accList = new List<Account>();
        for (Integer i=0; i< 100; i++){
            Account a = new Account(Name = 'Account ' + i);
            accList.add(a);
        }
        insert accList;
        
        //don't query will inside a loop, instead do it before a loop
    }
    
    /*
     * 
     */
    public static void databaseClass(){
		List<Account> accList = new List<Account>();
        accList.add(new Account(Name = 'Acme1'));
        accList.add(new Account(Name = 'Acme2'));
        accList.add(new Account());
        //DML statement using Database class
        Database.SaveResult[] srList = Database.insert(accList, false);
        //Iterate through each returned result
        for (Database.SaveResult sr : srList){
            if (sr.isSuccess()){
				System.debug('Successfully inserted account. Account ID: ' + sr.getId());
            } else {
                for (Database.Error err : sr.getErrors()){
                    System.debug('The following error has occured.' + err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Accoounts fields that affected this error: ' + err.getFields());
                }
            }
        }
    }
    
    /*
     * Creates a class, Assessment, and Grade
     * then associates them to a student
     */
    public static void createSchoolRecords(String ClassName, String ClassSubject, String assessmentName, String studentName){
        try {
            //Creating the class
            Class__c c = new Class__c(Name = ClassName, ClassSubject__c = ClassSubject, ClassTopic__c = 'Drawing');
            insert c;
            //creating the Assement
            Id cId = c.Id;
            RecordType rt = [SELECT Id,Name FROM RecordType WHERE SobjectType='Assessment__c' AND Name like 'Pro%'];
            Assessment__c a = new Assessment__c(Name = assessmentName, RecordTypeId = rt.Id, Retakable__c=true, Class__c = cId);
            insert a;
            //creating the Grade
            Id aId = a.Id;
            Grade__c g = new Grade__c(Grade__c = 97.79, Assessment__c = aId);
            insert g;
            
            //Creating the student to associate all of this with
            Student__C student = new Student__c(Name = studentName);
            insert student;
            //Creating a class enrollement to link the student and class
            Id sId = student.Id;
            ClassEnrollment__c CE = new ClassEnrollment__c(Class__c = cId, Student__c = sId);
            insert CE;
        } catch (DMLException e){
            System.debug('ERROR: ' + e.getMessage());
        }
    }
}