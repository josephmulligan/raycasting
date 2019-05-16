class DirectionalLightSource extends LightSource {
    
    ////number of rays to cast
    //float lum;
    
    ////position & velocity
    //PVector pos;
    //PVector vel;
    
    ////angle to cast rays over
    //float fov;
    
    //angle representing direction of light
    float heading;
    
    ////hsb of light
    //float hue;
    //float sat;
    //float bri;
    
    ////Ray list
    //ArrayList<Ray> rays;
    
    public DirectionalLightSource(float lum, PVector pos, float heading) {
        super(lum,pos);
        
        this.heading = heading;
        
        for(Ray r : this.rays) {
            r.angle += this.heading;
        }
    }
    
    public DirectionalLightSource(float lum, PVector pos, float heading, float fov) {
        super(lum,pos,fov);
        
        this.heading = heading;
        
        for(Ray r : this.rays) {
            r.angle += this.heading;
        }
    }
    
    public DirectionalLightSource(float lum, PVector pos, float heading, float fov, float hue, float sat, float bri) {
        super(lum,pos,fov,hue,sat,bri);
        
        this.heading = heading;
        
        for(Ray r : this.rays) {
            r.angle += this.heading;
        }
    }
    
    public String updateHeading(String mode, float h) {
        
        float currHeading = this.heading;
        
        switch(mode) {
            case "ADD" : this.heading += h; break;
            case "REPLACE" : this.heading = h; break;
            default: return "Invalid heading update mode. Use 'ADD' or 'REPLACE'";
        }
        
        for(Ray r : this.rays) {
            r.angle += currHeading - this.heading;
        }
        
        return "Success";
    }
    
    public void cast(ArrayList<Wall> walls) {
        super.cast(walls);
    }
    
    public void show() {
        super.show();
    }
    
    public void update(PVector newPos) {
        super.update(newPos);
    }
    
    public String toString() {
        return this.rays.toString();
    }
}
