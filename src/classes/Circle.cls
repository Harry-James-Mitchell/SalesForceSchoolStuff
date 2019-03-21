public class Circle extends Shape {
    
    private final double PI = 3.141592;
    
    public Integer radius{
        get;
        set;
    }
    
    public Integer calculateArea(){
        return (Integer)(Math.pow(this.radius, 2) * PI);
    }
    
    public Integer calculatePerimeter(){
        return (Integer)(this.radius * 2 * PI);
    }
    
    
    public  void draw(){
		System.debug('Drawing a circle with a radius of: ' + this.radius);
    }

}