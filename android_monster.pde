import processing.javafx.*;
import java.util.concurrent.*;
import java.util.List;        // Import List
import java.util.ArrayList;  // Import ArrayList

ExecutorService executor;
List<Future<?>> futures = new ArrayList<>();

// Walter Gordy 2008, 2016, 2023

// Updates code to run for processing 3
// New mode FX2D runs much much faster
// Increased particle count from 25,000 to 1,000,000!
// Decreases alpha color on particles
// Updates to use executor threads

int neg = 0;
int pos = 1;
int neutral = 2;
int count = 1000000; // running this many particles real-time requires beefy computer
int sx = 1280;
int sy = 720;
color currentcolor;
int numThreads = 32; // i9 with 32 logical cores

int threadcount = 0;

class Particle
{
  public float px, py, pz=0;
  public float vx, vy, vz=0;
  
  public int type = pos;
  
  color c = color(0,0,0);
  
  public float force;
  
  float npx, npy, npz=0;
  float nvx, nvy, nvz=0;
  
  public void interact(Particle p)
  {
    float dis;
    float fx;
    float fy;
    float f;
    
    dis = (p.px - px)*(p.px - px) + (p.py - py)*(p.py - py);

    f = (force + p.force) / (dis);
    
    if(f > 1700)
    {  
      f = 1700;
    }
    
    fx = f * (p.px - px);
    fy = f * (p.py - py);
    
    vx += fx;
    vy += fy;
  }
  
  public void update()
  {
    vx += nvx;
    vy += nvy;
    vz += nvz;
    
    px += vx;
    py += vy;
    
    if(px < -3000)
    {
       px = 0;
       vx = 0;
       vy += random(-1,1); 
    }
    else if(px > sx + 3000)
    {
      px = sx;
      vx = 0;
      vy += random(-1,1);
    }
    
    if(py < -3000)
    {
       py = 0;
       vy = 0;
       vx += random(-1,1); 
    }
    else if(py > sy + 3000)
    {
      py = sy;
      vy = 0;
      vx += random(-1,1);
    }

    vx *= .5f;
    vy *= .5f;    
  }
}

Particle[] p = new Particle[count];

void setup()
{
  size(1280,720, FX2D);
  background(255);
  frameRate(30);
  for(int i = 0; i < count; i++)
  {
     p[i] = new Particle();
     p[i].type = (int)random(0,3);
     p[i].px = random(-2500, sx+2500);
     p[i].py = random(-2500, sy+2500);
     p[i].vx = random(-4,4);
     p[i].vy = random(-4,4);
     p[i].force = .1 + p[i].type / 200.0;     
  }
  
  executor = Executors.newFixedThreadPool(numThreads); // Adjust based on your CPU core count
}

Particle lastParticle;




void draw() {
  background(255, 255, 255);
  stroke(0,0,0,50);

  Particle lastParticle = p[count-1];
  
  lastParticle.px += random(-99,99);
  lastParticle.py += random(-99,99);
  lastParticle.px = constrain(lastParticle.px, 200, sx - 200);
  lastParticle.py = constrain(lastParticle.py, 200, sy - 200);
  lastParticle.type = 2;
  lastParticle.force = 2000;
  
  int particlesPerThread = count / numThreads;
  
  for (int t = 0; t < numThreads; t++) {
    final int start = t * particlesPerThread;
    final int end = (t == numThreads - 1) ? count : start + particlesPerThread;
    
    Future<?> future = executor.submit(() -> {
      for (int i = start; i < end; i++) {
        p[i].interact(lastParticle);
        p[i].update();
      }
    });
    futures.add(future);
  }

  // Wait for all threads to finish before drawing
  for (Future<?> future : futures) {
    try {
      future.get();
    } catch (InterruptedException | ExecutionException e) {
      e.printStackTrace();
    }
  }
  futures.clear();
  
  beginShape(POINTS);
  for (int i = 0; i < count; i++) {
    vertex(p[i].px, p[i].py);
  }
  endShape();
  // saveFrame();
}

void exit() {
  executor.shutdown(); // Shut down the executor when quitting
  super.exit();
}
