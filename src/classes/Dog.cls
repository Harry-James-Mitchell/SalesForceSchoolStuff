public class Dog extends Animal {
    
    public override void Sound(){
        System.debug('wOOF');
    }
    // You could also do
    // public override abstract void sound();
    
    //concrete method - one that is not abstract
    public void wagTail(){
        System.debug('/ | \\');
    }
}