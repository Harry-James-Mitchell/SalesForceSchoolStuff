public virtual class Play {

    private String title;
    private String author;
    private String genre;
    
    public Play(){
        this.title = '';
        this.author = '';
        this.genre = '';
    }
    
    public Play(String aTitle){
        this.title = aTitle;
        this.author = '';
        this.genre = '';
    }
    
    public void setTitle(String aTitle){
        this.title = aTitle;
    }
    
    public void setAuthor(String anAuthor){
        this.author = anAuthor;
    }
    
    public void setGenre(String aGenre){
        this.genre = aGenre;
    }
    
    public String getTitle(){
        return this.title;
    }
    
    public String getAuthor(){
        return this.author;
    }
    
    public String getGenre(){
        return this.genre;
    }
    
    public void display(){
        System.debug('Title of play: ' + this.title);
        System.debug('Author of play: ' + this.author);
        System.debug('Genre of play: ' + this.genre);
    }
}