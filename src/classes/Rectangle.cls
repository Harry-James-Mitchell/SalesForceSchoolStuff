public virtual class Rectangle extends Shape {
    
    public Integer height{
        get;
        set;
    }
    public Integer width{
        get;
        set;
    }
    
    public Rectangle(){
		super.setNumberOfSides(4);        
    }
    
    public Rectangle(Integer height, Integer width){
        this.height = height;
        this.width = width;
        super.setNumberOfSides(4);
    }
    
    public virtual Integer calculateArea(){
        return this.width * this.height;
    }
    
    public virtual Integer calculatePerimeter(){
        return 2*this.width + 2*this.height;
    }
    
    public virtual void draw(){
		System.debug('Drawing a rectanglewith a width of: ' + this.width + ' and height of: ' + this.height);
    }

}