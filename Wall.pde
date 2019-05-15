class Wall {
    PVector start;
    PVector end;
    
    public Wall(PVector start, PVector end) {
        this.start = start;
        this.end = end;
    }
    
    public void show() {
        push();
        stroke(360);
        strokeWeight(2);
        noFill();
        line(this.start.x, this.start.y, this.end.x, this.end.y);
        pop();
    }
}
