final float LIGHTS = 2;
final float WALLS = 8;

//misc constants
final float WALL_LEN_MIN = 300;
final float WALL_LEN_MAX = 500;

//noiseloop variables
final float NL_R_MIN = 1;
final float NL_R_MAX = 5;

final float NL_FR_MIN = 1000;
final float NL_FR_MAX = 5000;

final float NL_POS_MIN = -1000;
final float NL_POS_MAX = 1000;

final float NL_NOISE_MIN_POS = -360;
final float NL_NOISE_MAX_POS = 360;

final float NL_NOISE_MIN_HD = radians(-180);
final float NL_NOISE_MAX_HD = radians(180);

//lightsource variables
final float LS_LUM_MIN = 50;
final float LS_LUM_MAX = 150;

final float LS_HD_MIN = radians(-90);
final float LS_HD_MAX = radians(270);

final float LS_FOV_MIN = radians(60);
final float LS_FOV_MAX = radians(240);

final float LS_HU_MIN = 0;
final float LS_HU_MAX = 360;

final float LS_SA_MIN = 360;
final float LS_SA_MAX = 360;

final float LS_BR_MIN = 360;
final float LS_BR_MAX = 360;

ArrayList<DirectionalLightSource> sources;
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
    sources = new ArrayList<DirectionalLightSource>();
    startingPos = new ArrayList<PVector>();
    
    for(int i=0; i<LIGHTS; i++) {
        for(int j=0; j<3; j++) {
            NoiseLoop nl = new NoiseLoop (
                random(NL_R_MIN,NL_R_MAX)
              , random(NL_FR_MIN,NL_FR_MAX)
              , new PVector(random(NL_POS_MIN, NL_POS_MAX),random(NL_POS_MIN,NL_POS_MAX))
            );
            loops.add(nl);
        }
        
        PVector start = new PVector(random(width),random(height));
        
        startingPos.add(start);
        
        DirectionalLightSource ls = new DirectionalLightSource (
            random(LS_LUM_MIN,LS_LUM_MAX)
          , start
          , random(LS_HD_MIN,LS_HD_MAX)
          , random(LS_FOV_MIN,LS_FOV_MAX)
          , random(LS_HU_MIN,LS_HU_MAX)
          , random(LS_SA_MIN,LS_SA_MAX)
          , random(LS_BR_MIN,LS_BR_MAX)
        );
        sources.add(ls);
        
    }
    
    walls = new ArrayList<Wall>();
    for(int i=0; i<WALLS; i++) {
        PVector p1 = new PVector(random(width),random(height));
        PVector p2;
        float d;
        do {
            p2 = new PVector(random(width),random(height));
            d = dist(p1.x,p1.y,p2.x,p2.y);
        } while (d<WALL_LEN_MIN || d>WALL_LEN_MAX);
        walls.add(new Wall(p1,p2));
    }
    walls.add(new Wall(new PVector(0,0),new PVector(width,0)));
    walls.add(new Wall(new PVector(width,0),new PVector(width,height)));
    walls.add(new Wall(new PVector(width,height),new PVector(0,height)));
    walls.add(new Wall(new PVector(0,height),new PVector(0,0)));
}

void draw() {
    background(0);
    
    for(int i=0; i<sources.size(); i++) {
        DirectionalLightSource ls = sources.get(i);
        PVector sp = startingPos.get(i);
        NoiseLoop nlX = loops.get(3*i);
        NoiseLoop nlY = loops.get(3*i+1);
        NoiseLoop nlH = loops.get(3*i+2);
        
        PVector newPos = PVector.add(
            sp
          , new PVector (
              nlX.getNoise(frameCount,NL_NOISE_MIN_POS,NL_NOISE_MAX_POS)
            , nlY.getNoise(frameCount,NL_NOISE_MIN_POS,NL_NOISE_MAX_POS)
          )
        );
        
        float newHeading = nlH.getNoise(frameCount,NL_NOISE_MIN_HD,NL_NOISE_MAX_HD);
        
        ls.updateHeading("REPLACE", newHeading);
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
