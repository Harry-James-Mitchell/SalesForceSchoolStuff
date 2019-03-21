public class PostToChatterContact {
	
    public static void postChatterContact(list<Contact> newContacts){
        System.debug('postChatterContact is starting');
        
        for(Contact c: newContacts) {
            if(c.email == null){
                System.debug('Conctact with last name: ' + c.lastName + ' does not have an email');
            } else {
                ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), c.Id, ConnectApi.FeedElementType.FeedItem, 'Email this person!');
            }
        }
        
        System.debug('postChatterContact is ending');
    }
}