final float LIGHTS = 6;
final float WALLS = 12;

//noiseloop variables
final float NL_R_MIN = 1;
final float NL_R_MAX = 1;

final float NL_FR_MIN = 180;
final float NL_FR_MAX = 600;

final float NL_POS_MIN = -1000;
final float NL_POS_MAX = 1000;

final float NL_NOISE_MIN = -360;
final float NL_NOISE_MAX = 360;

//lightsource variables
final float LS_LUM_MIN = 25;
final float LS_LUM_MAX = 200;

final float LS_FOV_MIN = radians(360);
final float LS_FOV_MAX = radians(360);

final float LS_HU_MIN = 0;
final float LS_HU_MAX = 360;

final float LS_SA_MIN = 100;
final float LS_SA_MAX = 360;

final float LS_BR_MIN = 250;
final float LS_BR_MAX = 360;

ArrayList<LightSource> sources;
ArrayList<PVector> startingPos;
ArrayList<NoiseLoop> loops;
ArrayList<Wall> walls;

void setup() {
    fullScreen();
    colorMode(HSB,360);
    refresh();
}

void refresh() {
    loops = new ArrayList<NoiseLoop>();
    sources = new ArrayList<LightSource>();
    startingPos = new ArrayList<PVector>();
    
    for(int i=0; i<LIGHTS; i++) {
        for(int j=0; j<2; j++) {
            NoiseLoop nl = new NoiseLoop (
                random(NL_R_MIN,NL_R_MAX)
              , random(NL_FR_MIN,NL_FR_MAX)
              , new PVector(random(NL_POS_MIN, NL_POS_MAX),random(NL_POS_MIN,NL_POS_MAX))
            );
            loops.add(nl);
        }
        
        PVector start = new PVector(random(width),random(height));
        
        startingPos.add(start);
        
        LightSource ls = new LightSource (
            random(LS_LUM_MIN,LS_LUM_MAX)
          , start
          , random(LS_FOV_MIN,LS_FOV_MAX)
          , random(LS_HU_MIN,LS_HU_MAX)
          , random(LS_SA_MIN,LS_SA_MAX)
          , random(LS_BR_MIN,LS_BR_MAX)
        );
        sources.add(ls);
        
    }
    
    walls = new ArrayList<Wall>();
    for(int i=0; i<WALLS; i++) {
        walls.add(new Wall(new PVector(random(width),random(height)),new PVector(random(width),random(height))));
    }
    walls.add(new Wall(new PVector(0,0),new PVector(width,0)));
    walls.add(new Wall(new PVector(width,0),new PVector(width,height)));
    walls.add(new Wall(new PVector(width,height),new PVector(0,height)));
    walls.add(new Wall(new PVector(0,height),new PVector(0,0)));
}

void draw() {
    background(0);
    
    for(int i=0; i<sources.size(); i++) {
        LightSource ls = sources.get(i);
        PVector sp = startingPos.get(i);
        NoiseLoop nlX = loops.get(2*i);
        NoiseLoop nlY = loops.get(2*i+1);
        
        PVector newPos = PVector.add(
            sp
          , new PVector (
              nlX.getNoise(frameCount,NL_NOISE_MIN,NL_NOISE_MAX)
            , nlY.getNoise(frameCount,NL_NOISE_MIN,NL_NOISE_MAX)
          )
        );
        
        ls.update(newPos);
        ls.cast(walls);
        ls.show();
    }
    
    for(Wall w : walls) {
        w.show();
    }
    
    push();
    textAlign(RIGHT,BOTTOM);
    fill(360);
    noStroke();
    text(frameRate,width,height);
    pop();
}

void push() {
    pushMatrix();
    pushStyle();
}

void pop() {
    popStyle();
    popMatrix();
}

void mouseClicked() {
    refresh();
}
