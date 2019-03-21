trigger ContactTrigger on Contact (before insert, after insert, before update) {
	//use trigger context to pinpoint trigger type
    if(Trigger.isAfter && Trigger.isInsert){
		PostToChatterContact.postChatterContact(Trigger.new);
    } else if (Trigger.isBefore && Trigger.isInsert){
        DuplicateChecker.checkForContactDuplicates(Trigger.new);
    }
    
    /* Example
     * Contact c = new Contact(LastName = 'HAHAHA4', email='fake@gmail.com');
		Contact c2 = new Contact(LastName = 'HAHAHA2', email='fake@gmail.com');
		Contact c3 = new Contact(LastName = 'HAHAHA3');
		list<Contact> contacts = new List<Contact>{c, c2, c3};
		insert c;
     */
    
    /*if(Trigger.isBefore){
        if(Trigger.isInsert){
            
        }
    } else {
        if(Trigger.isInsert){
            
        }
    }*/
}