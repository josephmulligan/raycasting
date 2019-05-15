class NoiseLoop {
    PVector pos;
    float r;
    float fr;
    
    public NoiseLoop(float r, float fr) {
        this.r = r;
        this.fr = fr;
        this.pos = new PVector(0,0);
    }
    
    public NoiseLoop(float r, float fr, PVector pos) {
        this(r,fr);
        this.pos = pos;
    }
    
    public float getNoise(float frame) {
        float phase = (frame % this.fr) / this.fr;
        float phaseRad = map(phase,0,1,0,TWO_PI);
        float x = this.pos.x + r * cos(phaseRad);
        float y = this.pos.y + r * sin(phaseRad);
        return noise(x,y);
    }
    
    public float getNoise(float frame, float max) {
        float phase = (frame % this.fr) / this.fr;
        float phaseRad = map(phase,0,1,0,TWO_PI);
        float x = this.pos.x + r * cos(phaseRad);
        float y = this.pos.y + r * sin(phaseRad);
        return map(noise(x,y),0,1,0,max);
    }
    
    public float getNoise(float frame, float min, float max) {
        float phase = (frame % this.fr) / this.fr;
        float phaseRad = map(phase,0,1,0,TWO_PI);
        float x = this.pos.x + r * cos(phaseRad);
        float y = this.pos.y + r * sin(phaseRad);
        return map(noise(x,y),0,1,min,max);
    }
}
