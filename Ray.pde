class Ray {
    
    PVector start;
    float angle;
    float len;
    
    float hue;
    float sat;
    float bri;
    
    public Ray (PVector start, float angle) {
        this.start = start;
        this.angle = angle;
        this.len = 0;
        this.hue = 0;
        this.sat = 0;
        this.bri = 360;
    }
    
    public Ray (PVector start, float angle, float hue, float sat, float bri) {
        this(start, angle);
        this.hue = hue;
        this.sat = sat;
        this.bri = bri;
    }
    
    public boolean cast(ArrayList<Wall> walls) {
        float minDist = dist(0,0,width,height);
        
        float x3 = this.start.x;
        float y3 = this.start.y;
        
        PVector dir = PVector.fromAngle(this.angle);
        float x4 = x3 + dir.x;
        float y4 = y3 + dir.y;
        
        //println(x3,y3,x4,y4);
        
        for(Wall w : walls) {
            float x1 = w.start.x;
            float y1 = w.start.y;
            
            float x2 = w.end.x;
            float y2 = w.end.y;
            
            float chkPara = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
            
            if(chkPara == 0) {
                continue;
            }
            
            float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / chkPara;
            float u = ((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / chkPara;
            
            if(t > 0 && t < 1 && u > 0) {
                
                //push();
                //fill(360);
                //noStroke();
                //ellipse(x3 + u * (x3 - x4), y3 + u * (y3 - y4), 50, 50);
                //pop();
                
                PVector intersect = new PVector(u * (x3 - x4),u * (y3 - y4));
                
                minDist = min(intersect.mag(), minDist);
            }
        }
        
        if(minDist < dist(0,0,width,height)) {
            this.len = minDist;
            return true;
        }
        
        this.len = 0;
        return false;
    }
    
    public void show() {
        
        PVector end = PVector.fromAngle(this.angle);
        end.setMag(-this.len);
        end.add(this.start);
        
        push();
        stroke(this.hue,this.sat,this.bri,200);
        strokeWeight(2);
        noFill();
        line(this.start.x, this.start.y, end.x, end.y);
        pop();
    }
    
    public String toString() {
        String ret = "";
        ret += "START: (" + this.start.x + "," + this.start.y + ")"
             + " DIR: " + degrees(this.angle)
             + " LEN: " + this.len
             + " COLOR: (" + this.hue + "," + this.sat + "," + this.bri + ")";
        return ret;
    }
}
