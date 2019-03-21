public class Employee extends Person {
    
    public String company{
        get{
            return company;
        }
        set{
            company = value;
        }
    }
    
    public Employee(){
        this.company = '';
    }
    
    public Employee(String name, String email){
        super(name);        
        super.setEmail(email);
        this.company = '';
    }
    
    public override void display(){
        super.display();
        System.debug('Comapny: ' + this.company);
    }

}