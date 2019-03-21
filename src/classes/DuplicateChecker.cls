public class DuplicateChecker {

    public static void checkForContactDuplicates(List<contact> newContacts){
        //step1: Exxtract email from new Contacts
        set<String> newEmailSet = new Set<String>();
        for(contact newContact: newContacts){
            if(newContact.email != null){
                newEmailSet.add(newContact.email);
            }
        }
        //Step2: find duplicate contacts from database
        Map<String, contact> existingContactMap = new Map<String, Contact>();
        for(Contact existingContact: [SELECT Id, Name, Email 
                        FROM Contact 
                        WHERE Email in :newEmailSet]){
            existingContactMap.put(existingContact.Email, existingContact);
        }
        //Step3: compare and throw error
        for(Contact newContact : newContacts){
            Contact duplicateContact = existingContactMap.get(newContact.email);
            if(duplicateContact != null){
                newContact.addError('ERROR: There is already an Identical Record: ' + duplicateContact.Id);
            }
        }
    }
}