class LightSource {
    
    //number of rays to cast
    float lum;
    
    //position & velocity
    PVector pos;
    PVector vel;
    
    //angle to cast rays over
    float fov;
    
    //hsb of light
    float hue;
    float sat;
    float bri;
    
    //Ray list
    ArrayList<Ray> rays;
    
    public LightSource(float lum, PVector pos) {
        this.lum = lum;
        this.pos = pos;
        this.vel = new PVector(0,0);
        this.fov = radians(360);
        this.hue = 0;
        this.sat = 0;
        this.bri = 360;
        
        this.rays = new ArrayList<Ray>();
        for(int i=0; i<this.lum; i++) {
            float a = map(i,0,this.lum,0,radians(360));
            this.rays.add(new Ray(this.pos,a));
        }
        
    }
    
    public LightSource(float lum, PVector pos, float fov) {
        this(lum, pos);
        this.fov = fov;
        
        this.rays = new ArrayList<Ray>();
        for(int i=0; i<this.lum; i++) {
            float a = map(i,0,this.lum,-.5*this.fov,.5*this.fov);
            this.rays.add(new Ray(this.pos,a));
        }
        
    }
    
    public LightSource(float lum, PVector pos, float fov, float hue, float sat, float bri) {
        this(lum, pos, fov);
        this.hue = hue;
        this.sat = sat;
        this.bri = bri;
        
        this.rays = new ArrayList<Ray>();
        for(int i=0; i<this.lum; i++) {
            float a = map(i,0,this.lum,-.5*this.fov,.5*this.fov);
            this.rays.add(new Ray(this.pos,a,this.hue,this.sat,this.bri));
        }
        
    }
    
    public void cast(ArrayList<Wall> walls) {
        for(Ray r : this.rays) {
            boolean b = r.cast(walls);
            //println(r,b);
        }
    }
    
    public void show() {
        for(Ray r : rays) {
            r.show();
        }
    }
    
    public void update(PVector newPos) {
        if(newPos.x < 0) {newPos.x = width;}
        if(newPos.x > width) {newPos.x = 0;}
        if(newPos.y < 0) {newPos.y = height;}
        if(newPos.y > height) {newPos.y = 0;}
        this.pos = newPos;
        for(Ray r : this.rays) {
            r.start = newPos;
        }
    }
    
    public String toString() {
        return this.rays.toString();
    }
}
