PImage coracao, neymar, kanye, luacheia, terra;
float angle = 0;

void setup(){
  size(800, 600, P3D);
  coracao = loadImage("coracao.jpg");
  neymar = loadImage("neymar.jpg");
  kanye = loadImage("kanye.jpg");
 luacheia = loadImage("luacheia.jpg");
  terra = loadImage("texture5.jpg");
}

void draw(){
  background(200);
  
  // Criação e movimentação da câmera na cena
  float camX = map(mouseX, 0, width, -500, 500);
  float camY = map(mouseY, 0, height, -500, 500);
  camera(camX, camY, 500, 0, 0, 0, 0, 1, 0);

  // Desenho do chão
  pushMatrix();
  translate(0, 200, 0);
  fill(10, 200, 50);
  rotateX(HALF_PI);
  box(1500, 500, 10); // Chão
  popMatrix();

  // Desenho da parede
  pushMatrix();
  translate(0, 0, -200);
  fill(10, 10, 100);
  box(1500, 500, 10); // Parede
  popMatrix();
  
  // Desenho das figuras geométricas 3D com animações e texturas
  angle += 0.01;
  
  // Cubo
  pushMatrix();
  translate(-300, 100, 0);
  rotateY(angle);
  fill(255, 0, 0);
  box(50);
  popMatrix();
  
  // Esfera
  pushMatrix();
  translate(-150, 100, 0);
  rotateY(angle);
  fill(0, 255, 0);
  sphere(30);
  popMatrix();
  
  // Cilindro
  pushMatrix();
  translate(0, 100, 0);
  rotateY(angle);
  fill(0, 0, 255);
  texture(coracao);
  cylinder(30, 80);
  popMatrix();
  
  // Cone
  pushMatrix();
  translate(150, 100, 0);
  rotateY(angle);
  fill(255, 255, 0);
  texture(neymar);
  cone(30, 80);
  popMatrix();
  
  // Torus
  pushMatrix();
  translate(300, 100, 0);
  rotateY(angle);
  fill(255, 0, 255);
  texture(kanye);
  torus(30, 10);
  popMatrix();
  
  // Caixa
  pushMatrix();
  translate(-300, -100, 0);
  rotateY(angle);
  fill(0, 255, 255);
  texture(luacheia);
  box(60, 30, 90);
  popMatrix();
  
  // Ellipsoid
  pushMatrix();
  translate(-150, -100, 0);
  rotateY(angle);
  fill(255, 165, 0);
 // ellipsoid(40, 60, 30);
  popMatrix();
  
  // Pyramide
  pushMatrix();
  translate(0, -100, 0);
  rotateY(angle);
  fill(128, 0, 128);
  pyramid(40, 60);
  popMatrix();
  
  // Hexágono
  pushMatrix();
  translate(150, -100, 0);
  rotateY(angle);
  fill(0, 128, 128);
  texture(terra);
  hexagon(40, 60);
  popMatrix();
  
  // Prism
  pushMatrix();
  translate(300, -100, 0);
  rotateY(angle);
  fill(128, 128, 0);
  prism(40, 60, 80);
  popMatrix();
}

void cylinder(float r, float h) {
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= 360; i += 10) {
    float x = cos(radians(i)) * r;
    float z = sin(radians(i)) * r;
    vertex(x, -h / 2, z);
    vertex(x, h / 2, z);
  }
  endShape();
}

void cone(float r, float h) {
  beginShape(TRIANGLE_FAN);
  vertex(0, -h / 2, 0);
  for (int i = 0; i <= 360; i += 10) {
    float x = cos(radians(i)) * r;
    float z = sin(radians(i)) * r;
    vertex(x, h / 2, z);
  }
  endShape();
}

void torus(float r1, float r2) {
  int sides = 24;
  int rings = 12;
  for (int i = 0; i < sides; i++) {
    float theta1 = map(i, 0, sides, 0, TWO_PI);
    float theta2 = map(i + 1, 0, sides, 0, TWO_PI);
    beginShape(QUAD_STRIP);
    for (int j = 0; j <= rings; j++) {
      float phi = map(j, 0, rings, 0, TWO_PI);
      float x1 = cos(theta1) * (r1 + r2 * cos(phi));
      float y1 = sin(theta1) * (r1 + r2 * cos(phi));
      float z1 = r2 * sin(phi);
      float x2 = cos(theta2) * (r1 + r2 * cos(phi));
      float y2 = sin(theta2) * (r1 + r2 * cos(phi));
      float z2 = r2 * sin(phi);
      vertex(x1, y1, z1);
      vertex(x2, y2, z2);
    }
    endShape();
  }
}

void pyramid(float base, float height) {
  beginShape(TRIANGLES);
  vertex(-base / 2, height / 2, -base / 2);
  vertex(base / 2, height / 2, -base / 2);
  vertex(0, -height / 2, 0);
  
  vertex(base / 2, height / 2, -base / 2);
  vertex(base / 2, height / 2, base / 2);
  vertex(0, -height / 2, 0);
  
  vertex(base / 2, height / 2, base / 2);
  vertex(-base / 2, height / 2, base / 2);
  vertex(0, -height / 2, 0);
  
  vertex(-base / 2, height / 2, base / 2);
  vertex(-base / 2, height / 2, -base / 2);
  vertex(0, -height / 2, 0);
  endShape();
}

void hexagon(float radius, float height) {
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= 360; i += 60) {
    float x = cos(radians(i)) * radius;
    float z = sin(radians(i)) * radius;
    vertex(x, -height / 2, z);
    vertex(x, height / 2, z);
  }
  endShape();
}

void prism(float r, float h, float w) {
  beginShape(QUADS);
  vertex(-w / 2, -h / 2, -r);
  vertex(w / 2, -h / 2, -r);
  vertex(w / 2, h / 2, -r);
  vertex(-w / 2, h / 2, -r);
  
  vertex(-w / 2, -h / 2, r);
  vertex(w / 2, -h / 2, r);
  vertex(w / 2, h / 2, r);
  vertex(-w / 2, h / 2, r);
  
  vertex(-w / 2, -h / 2, -r);
  vertex(-w / 2, -h / 2, r);
  vertex(-w / 2, h / 2, r);
  vertex(-w / 2, h / 2, -r);
  
  vertex(w / 2, -h / 2, -r);
  vertex(w / 2, -h / 2, r);
  vertex(w / 2, h / 2, r);
  vertex(w / 2, h / 2, -r);
  
  vertex(-w / 2, h / 2, -r);
  vertex(w / 2, h / 2, -r);
  vertex(w / 2, h / 2, r);
  vertex(-w / 2, h / 2, r);
  
  vertex(-w / 2, -h / 2, -r);
  vertex(w / 2, -h / 2, -r);
  vertex(w / 2, -h / 2, r);
  vertex(-w / 2, -h / 2, r);
  endShape();
}
