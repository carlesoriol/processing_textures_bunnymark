/*******************************************************************************************
*
*   raylib [textures] example - Bunnymark
*
*   This example has been created using raylib 1.6 (www.raylib.com)
*   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
*
*   Migrated to processing just for fun by Carles Oriol 
*
*   Copyright (c) 2014-2019 Ramon Santamaria (@raysan5)
*   Copyright (c) 2020 Carles Oriol (@carlesoriol) processing version
*
********************************************************************************************/

int MAX_BUNNIES = 50000;    // 50K bunnies limit

// This is the maximum amount of elements (quads) per batch
// NOTE: This value is defined in [rlgl] module and can be changed there
int MAX_BATCH_ELEMENTS = 8192;

class Bunny {   
      float x;
      float y;
      float dx;
      float dy;      
      color col;
      
};

PImage texBunny; 
int bunniesCount;
Bunny[] bunnies;

void setup() 
{
    size(800, 450); surface.setTitle("Processing [textures] example - bunnymark");
    
    // Load bunny texture
    texBunny = loadImage("wabbit_alpha.png");  // Load the image into the program
    
    bunnies = new Bunny[MAX_BUNNIES];    // Bunnies array
    
    bunniesCount = 0;      // Bunnies counter
    frameRate(60);          // Set our game to run at 60 frames-per-second
}

void draw() 
{
  
  if (mousePressed) 
  {
                // Create more bunnies
            for (int i = 0; i < 100; i++)
            {
                if (bunniesCount < MAX_BUNNIES)
                {
                    bunnies[bunniesCount] = new Bunny();
                    bunnies[bunniesCount].x = mouseX;
                    bunnies[bunniesCount].y = mouseY;                                       
                    bunnies[bunniesCount].dx = (float)random(-250, 250)/60.0f;
                    bunnies[bunniesCount].dy = (float)random(-250, 250)/60.0f;
                    bunnies[bunniesCount].col     = color( random(50, 240),
                                                       random(80, 240),
                                                       random(100, 240)) ;
                    bunniesCount++;
                }
            }
  }
  
      // Update bunnies
    for (int i = 0; i < bunniesCount; i++)
    {
        bunnies[i].x += bunnies[i].dx;
        bunnies[i].y += bunnies[i].dy;

        if (((bunnies[i].x + texBunny.width/2) > width) ||
            ((bunnies[i].x + texBunny.width/2) < 0)) bunnies[i].dx *= -1;
        if (((bunnies[i].y + texBunny.height/2) > height) ||
            ((bunnies[i].y + texBunny.height/2 - 40) < 0)) bunnies[i].dy *= -1;
    }
  
  background(255,255,255);
  
  for (int i = 0; i < bunniesCount; i++) 
  {
      tint(bunnies[i].col);
      image(texBunny, bunnies[i].x, bunnies[i].y);
  }
  
  fill(0,0,0);
  noStroke();
  rect(0, 0, width, 40, color(0,0,0));
  textSize(20);
  textAlign(LEFT, TOP);
  fill(0,255,0);
  text("bunnies: "+bunniesCount, 120, 10);      
  fill(255,64,0);
  text("batched draw calls: "+ (1 + bunniesCount/MAX_BATCH_ELEMENTS), 320, 10);
  fill(0,128,0);
  text(int(frameRate)+" FPS", 10, 10);
  
}
