public class Square extends Rectangle {
    
/*    public Integer width{
        get;
        set;
    } */
    
    public Square(){
        super();
    }
    
    public Square(Integer width){
        super.width = width;
    }
    
    public override Integer calculateArea(){
        return super.width * super.width;
    }
    
    public override Integer calculatePerimeter(){
        return 4*super.width;
    }
    
    public override void draw(){
		System.debug('Drawing a square with a width of: ' + super.Width);
    }

}