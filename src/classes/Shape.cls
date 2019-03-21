public abstract class Shape implements Drawable, Calculatable {
    private Integer numberOfSides;
    
    public Integer getNumberOfSide(){
        return numberOfSides;
    }
    
    public void setNumberOfSides(Integer numberOfSides){
        this.numberOfSides = numberOfSides;
    }
    
    //public abstract void draw();
}