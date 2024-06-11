
PImage texture1, texture2, texture3, texture4, texture5;
float angle = 0;

// Variáveis para posição da câmera
float camX = 0;
float camY = 0;
float camZ = 500;

// Velocidade da câmera
float camSpeed = 10;

int tubeRes = 32;
float[] tubeX = new float[tubeRes];
float[] tubeY = new float[tubeRes];

void setup(){
  size(800, 600, P3D);
  texture1 = loadImage("texture1.jpg");
  texture2 = loadImage("texture2.jpg");
  texture3 = loadImage("texture3.jpg");
  texture4 = loadImage("texture4.jpg");
  texture5 = loadImage("texture5.jpg");

  // Inicialização da câmera de frente
  camX = 0;
  camY = 0;
  camZ = 500;
  
   size(640, 360, P3D);
  texture3 = loadImage("texture3.jpg");
  float angle = 270.0 / tubeRes;
  for (int i = 0; i < tubeRes; i++) {
    tubeX[i] = cos(radians(i * angle));
    tubeY[i] = sin(radians(i * angle));
  }
  noStroke();
}


void draw(){
  background(200);
  translate(width / 2, height / 2);
  rotateX(map(mouseY, 0, height, -PI, PI));
  rotateY(map(mouseX, 0, width, -PI, PI));
  
  // Atualiza a posição da câmera com base no mouse e teclado
  updateCamera();

  // Criação e movimentação da câmera na cena
  camera(camX, camY, camZ, 0, 0, 0, 0, 1, 0);

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
  texture(texture1);
  box(50);
  drawLabel("Cubo");
  popMatrix();
  
  // Esfera
  pushMatrix();
  translate(-150, 100, 0);
  rotateY(angle);
  texture(texture2);
  sphere(30);
  drawLabel("Esfera");
  popMatrix();
  
  // Cilindro
  pushMatrix();
  translate(0, 100, 0);
  rotateY(angle);
  texture(texture3);
  cylinder(30, 80);
  drawLabel("Cilindro");
  popMatrix();
  
  // Cone
  pushMatrix();
  translate(150, 100, 0);
  rotateY(angle);
  texture(texture4);
  cone(30, 80);
  drawLabel("Cone");
  popMatrix();
  
  // Torus
  pushMatrix();
  translate(300, 100, 0);
  rotateY(angle);
  texture(texture5);
  torus(30, 10);
  drawLabel("Torus");
  popMatrix();
  
  // Caixa
  pushMatrix();
  translate(-300, -100, 0);
  rotateY(angle);
  texture(texture1);
  box(60, 30, 90);
  drawLabel("Caixa");
  popMatrix();
  
  // Ellipsoid
  pushMatrix();
  translate(-150, -100, 0);
  rotateY(angle);
  texture(texture2);
  //ellipsoid(40, 60, 30);
  drawLabel("Ellipsoid");
  popMatrix();
  
  // Pirâmide
  pushMatrix();
  translate(0, -100, 0);
  rotateY(angle);
  texture(texture3);
  pyramid(40, 60);
  drawLabel("Pirâmide");
  popMatrix();
  
  
  // Hexágono
  pushMatrix();
  translate(150, -100, 0);
  rotateY(angle);
  texture(texture4);
  hexagon(40, 60);
  drawLabel("Hexágono");
  popMatrix();
  
  // Prisma
  pushMatrix();
  translate(300, -100, 0);
  rotateY(angle);
  texture(texture5);
  prism(40, 60, 80);
  drawLabel("Prisma");
  popMatrix();
}

void updateCamera() {
  // Movimento com o mouse
  float mouseSpeed = 0.01;
  camX += (mouseX - width / 2) * mouseSpeed;
  camY += (mouseY - height / 2) * mouseSpeed;

  // Movimento com o teclado
  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      camY -= camSpeed;
    }
    if (key == 's' || key == 'S') {
      camY += camSpeed;
    }
    if (key == 'a' || key == 'A') {
      camX -= camSpeed;
    }
    if (key == 'd' || key == 'D') {
      camX += camSpeed;
    }
    if (key == 'q' || key == 'Q') {
      camZ -= camSpeed;
    }
    if (key == 'e' || key == 'E') {
      camZ += camSpeed;
    }
  }

  // Recentrar a posição do mouse
  mouseX = width / 2;
  mouseY = height / 2;
}

void drawLabel(String name) {
  fill(0);
  textSize(12);
  textAlign(CENTER);
  text(name, 0, 40, 0); // Desenha o nome abaixo do objeto
}

void cylinder(float r, float h) {
  beginShape(QUAD_STRIP);
  texture(texture3);
  for (int i = 0; i < tubeRes; i++) {
    float x = tubeX[i] * 100;
    float z = tubeY[i] * 100;
    float u = texture3.width / tubeRes * i;
    vertex(x, -100, z, u, 0);
    vertex(x, 100, z, u, texture3.height);
  }
  endShape();
  endShape();
  beginShape(QUADS);
  texture(texture3);
  vertex(0, -100, 0, 0, 0);
  vertex(100, -100, 0, 100, 0);
  vertex(100, 100, 0, 100, 100);
  vertex(0, 100, 0, 0, 100);
  endShape();
}

void cone(float r, float h) {
  beginShape(TRIANGLE_FAN);
  texture(texture1);
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
  //pyramid.vertex(tuboX[0]*100, -100, tuboY[0]*100, img.width, img.height);
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
  texture(texture4);
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
  texture(texture5);
  vertex(-w / 2, -h / 2, -r);
  vertex(w / 2, -h / 2, -r);
  vertex(w / 2, h / 2, -r);
  vertex(-w / 2, h / 2, -r);
  endShape();
}
