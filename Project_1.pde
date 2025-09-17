// COLOR PALETTES 
color[] backcolor = { 
  color(70, 130, 180),   // blue sky
  color(200, 100, 150),  // pink
  color(100, 180, 120)   // green
};

color[] circlecolors = { 
  color(255, 80, 80),    // red sun
  color(80, 200, 255),   // blue sun
  color(255, 200, 80)    // yellow sun
};

color[] rectcolors = { 
  color(150, 80, 120), 
  color(80, 150, 200), 
  color(200, 150, 80) 
};

color[] qudacolor = { 
  color(255,211,232), 
  color(239,131,84), 
  color(243,255,225), 
  color(73,65,109) 
};

int colorState = 0;
int scene = 0; // which landscape we are on

// sun animation vars
float sunX = 400, sunY = 150;
float targetSunX = 400, targetSunY = 150;

void setup() {
  size(600, 600);
  noStroke();
}

void draw() {
  background(backcolor[colorState]);

  // Sun circle with lerp lag
  fill(circlecolors[colorState]);
  sunX = lerp(sunX, targetSunX, 0.05);
  sunY = lerp(sunY, targetSunY, 0.05);
  circle(sunX, sunY, 180);

  // Switch scenes
  if (scene == 0) {
    drawStairsScene();
  } else if (scene == 1) {
    drawBalconyScene();
  }
}

// SCENE 0 
void drawStairsScene() {
  // Stairs
  fill(240);
  int stepHeight = 40;
  int stepWidth = 200;
  for (int i = 0; i < 6; i++) {
    rect(100, 500 - i*stepHeight, stepWidth, stepHeight);
  }

  // Arches
  fill(20, 30, 60);
  for (int i = 0; i < 2; i++) {
    rect(150 + i*100, 200, 60, 150, 40, 40, 0, 0);
  }

  // Vertical decorative lines
  fill(circlecolors[colorState]);
  for (int i = 0; i < 3; i++) {
    rect(420 + i*30, 400, 10, 100);
  }

  // Quad wall
  fill(qudacolor[colorState]);
  quad(350, 400, 500, 300, 600, 500, 400, 650);
}

// SCENE 1 
void drawBalconyScene() {
  // Sea background strip (aligned horizon)
  fill(80, 150, 255);
  rect(0, 280, width, 150);

  // Balcony wall left
  fill(rectcolors[colorState]);
  rect(0, 400, 250, 200);

  // Balcony railing (center)
  fill(qudacolor[colorState]);
  rect(250, 400, 350, 40);

  // Floor across bottom
  fill(200, 80, 80);
  rect(0, 440, width, 160);

  // Sunlight ray from sun
  fill(255, 240, 200, 150);
  quad(sunX, sunY,   // start at sun center
       sunX + 200, sunY + 300, 
       sunX - 400, sunY + 600, 
       sunX, sunY + 600);
}

void mousePressed() {
  // Change scene
  scene = (scene + 1) % 2;

  // Also cycle colors
  colorState = (colorState + 1) % 3;

  // Move sun target randomly
  targetSunX = random(150, width-150);
  targetSunY = random(80, 220);
}
