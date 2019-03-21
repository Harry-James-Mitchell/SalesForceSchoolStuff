public class Critic extends Person {
    
    private integer yearsOfExperience;
    
    public Critic(){
        yearsOfExperience = 0;
    }
    
    public Critic(String name, String email){
        super(name);
        super.setEmail(email);
        yearsOfExperience = 0;
    }
    
    public Integer getYearsOfExperience(){
		return this.yearsOfExperience;
    }
    
    public void setYearsOfExperience(Integer years){
        if(years < 0){
            System.debug('You can\' have negative years of experience');
        }
        this.yearsOfExperience = years;
    }
    
    public override void display(){
        super.display();
        System.debug('Years of Experience: ' + this.yearsOfExperience);
    }
}