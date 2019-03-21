public virtual class Person {
    
    private String name;
    private String email;
    
    public Person(){
    	System.debug('Hello Moto!');
        this.name = '';
        this.email = '';
    }
    
    public Person(String name){
        this.name = name;
//        this.email = '';
    }
    
    public void setName(String name){
        this.name = name;
    }

    public void setEmail(String email){
        this.email = email;
    }
    
    public String getName(){
        return this.name;
    }
    
    public String getEmail(){
        return this.email;
    }
    
    public virtual void display(){
        System.debug('Name: ' + this.name);
        System.debug('Email: ' + this.email);
    }
}