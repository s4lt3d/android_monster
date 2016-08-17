
int neg = 0;
int pos = 1;
int neutral = 2;
int count = 7500000;
int sx = 1280;
int sy = 720;
color currentcolor;

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
   // float fz;
    float f;
    
    dis = (p.px - px)*(p.px - px) + (p.py - py)*(p.py - py);

    f = (force + p.force) / (dis);
    
    if(f > 1700)
    {  
      f = 1700;
    }
    
    fx = f * (p.px - px);
    
    fy = f * (p.py - py);
    
    
    
    vx += fx;// + random(-.01, 0.01);
    vy += fy;// + random(-.01, 0.01);
//    int co = 128 - (int)(vx * vx + vy * vy / 128);
    
//    if(vx * vx + vy * vy > 70)
 //   {
//     int r = (int)random(0, 3);
//      if(r == 0)
  //      c = color(0,0,0);
 //     else if(r == 1)
 //       c = color(250,0,0);
 //     else if(r == 1)
  //      c = color(0,0,0);
   //   else 
    //    c = color(0,0,0);    
  //  }
  //  else
//      c = color(0,0,co);
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
      
 //   npx = 0;
 //   npy = 0;
 //   npz = 0;
 //   nvx = 0;
 //   nvy = 0;
 //   nvz = 0;
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
}



void draw()
{

  background(255, 255, 255);
  stroke(0,0,0,5);

  
  p[count-1].px += random(-99,99);
  p[count-1].py += random(-99,99);
  
  if(p[count-1].px < 200)
    p[count-1].px = 200;
  if(p[count-1].px > (sx - 200))
  
    p[count-1].px = sx - 200;
  
  if(p[count-1].py < 200)
    p[count-1].py = 200;
  if(p[count-1].py > (sy - 200))
    p[count-1].py = sy - 200;
    
    
  p[count-1].vx = 0;
  p[count-1].vy = 0;
  p[count-1].type = 2;
  p[count-1].force = 2000;
//  for (int i = 0; i < count-1; i++)
//  {     
//  }
    
   beginShape(POINTS);
   for (int i = 0; i < count; i++)
   {
       p[i].interact(p[count-1]);
       p[i].update();  
   
   //  if(((int)p[i].px + (int)p[i].py * sy) < (sy * sx) && ((int)p[i].px + (int)p[i].py * sx) > 0) 
     vertex(p[i].px, p[i].py);                  
   }
 
    endShape();

   //  beginShape(POINTS);
   //for (int i = 100000; i < count; i++)
   //{
   //
   //  p[i].update();
   //  if(((int)p[i].px + (int)p[i].py * sy) < (sy * sx) && ((int)p[i].px + (int)p[i].py * sx) > 0) 
   //    vertex(p[i].px, p[i].py);                  
   //}
//   endShape();
  saveFrame(); 
}
int moveCounter=0;
void mouseMoved()
{
 // moveCounter++;
 // if(moveCounter > 10)
  // exit(); 
}