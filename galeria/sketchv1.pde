PImage texture1, texture2, texture3, texture4, texture5;
float angle = 0;

// Variáveis para posição da câmera
float camX = 0;
float camY = 0;
float camZ = 500;

// Velocidade da câmera
float camSpeed = 10;

// Variável de zoom
float zoom = 1.0;

int tubeRes = 32;
float[] tubeX = new float[tubeRes];
float[] tubeY = new float[tubeRes];

// Variáveis da figura fornecida
int cuantos = 4000;
Pelo[] lista;
float radio;
float rx = 0;
float ry = 0;

void setup() {
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
  
  float angle = 270.0 / tubeRes;
  for (int i = 0; i < tubeRes; i++) {
    tubeX[i] = cos(radians(i * angle));
    tubeY[i] = sin(radians(i * angle));
  }
  noStroke();

  // Inicialização da figura fornecida
  radio = 30; // Ajustar o tamanho da figura fornecida
  lista = new Pelo[cuantos];
  for (int i = 0; i < cuantos; i++) {
    lista[i] = new Pelo();
  }
  noiseDetail(3);
}

void draw() {
  background(200);
  translate(width / 2, height / 2);
  scale(zoom);
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
  fill(255, 0, 0);
  box(1500, 500, 10); // Parede
  popMatrix();
  
  // Desenho das figuras geométricas 3D com animações e texturas
  angle += 0.01;
  
  // Cubo
  pushMatrix();
  translate(-300, 100, 0);
  rotateY(angle);
  beginShape(QUADS);
  texture(texture1);
  boxWithTexture(50, 50, 50, texture1);
  endShape();
  drawLabel("Cubo");
  popMatrix();
  
  // Esfera
  pushMatrix();
  translate(-150, 100, 0);
  rotateY(angle);
  beginShape(TRIANGLE_STRIP);
  texture(texture2);
  sphereWithTexture(30, texture2);
  endShape();
  drawLabel("Esfera");
  popMatrix();
  
    // Cilindro
  pushMatrix();
  translate(0, 100, 0);
  rotateY(angle);
  beginShape(QUAD_STRIP);
  texture(texture1); // Usando texture1 para o cilindro
  cylinder(30, 80, texture1);
  endShape();
  drawLabel("Cilindro");
  popMatrix();
  
  // Cone
  pushMatrix();
  translate(150, 100, 0);
  rotateY(angle);
  beginShape(TRIANGLE_FAN);
  texture(texture4);
  cone(30, 80, texture4);
  endShape();
  drawLabel("Cone");
  popMatrix();
  
 // Torus
  pushMatrix();
  translate(300, 100, 0);
  rotateY(angle);
  beginShape(TRIANGLE_STRIP);
  texture(texture2); // Usando texture2 para o torus
 // torus(30, 10, texture2);
  endShape();
  drawLabel("Torus");
  popMatrix();
  
 // Caixa
  pushMatrix();
  translate(-300, -100, 0);
  rotateY(angle);
  beginShape(QUADS);
  texture(texture1);
  boxWithTexture(60, 30, 90, texture1);
  endShape();
  drawLabel("Caixa");
  popMatrix();
  
  // Desenho da nova figura fornecida
  pushMatrix();
  translate(-150, -100, 0);
  rotateY(angle);
  drawFiguraFornecida();
  drawLabel("Figura Fornecida");
  popMatrix();
  
  // Pirâmide
  pushMatrix();
  translate(0, -100, 0);
  rotateY(angle);
  beginShape(TRIANGLES);
  texture(texture3); // Usando texture3 para a pirâmide
  pyramid(40, 60, texture3);
  endShape();
  drawLabel("Pirâmide");
  popMatrix();
  
  /// Hexágono
  pushMatrix();
  translate(150, -100, 0);
  rotateY(angle);
  beginShape(QUAD_STRIP);
  texture(texture4); // Usando texture4 para o hexágono
  hexagon(40, 60, texture4);
  endShape();
  drawLabel("Hexágono");
  popMatrix();
  
  // Prisma
  pushMatrix();
  translate(300, -100, 0);
  rotateY(angle);
  beginShape(QUADS);
  texture(texture5); // Usando texture5 para o prisma
  prism(40, 60, 80, texture5);
  endShape();
  drawLabel("Prisma");
  popMatrix();
  
  // Nomes no canto direito da tela
  drawNames();
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
    if (key == '+') {
      zoom += 0.05;
    }
    if (key == '-') {
      zoom -= 0.05;
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

void drawNames() {
  fill(0);
  textSize(16);
  textAlign(CENTER);
  float wallCenterX = 0; // Posição X central da parede
  float wallBottomY = -250; // Posição Y da base da parede

  // Primeiro nome
  text("Jean Woodly Estime", wallCenterX, wallBottomY);

  // Segundo nome
  text("Nathan Pinheiro", wallCenterX, wallBottomY + textAscent() + 5);

  // Terceiro nome
  text("Saulo Suassuna", wallCenterX, wallBottomY + 2 * (textAscent() + 5));
}


void drawFiguraFornecida() {
  float rxp = ((mouseX - (width / 2)) * 0.005);
  float ryp = ((mouseY - (height / 2)) * 0.005);
  rx = (rx * 0.9) + (rxp * 0.1);
  ry = (ry * 0.9) + (ryp * 0.1);
  rotateY(rx);
  rotateX(ry);
  fill(0);
  noStroke();
  sphere(radio);

  for (int i = 0; i < cuantos; i++) {
    lista[i].dibujar();
  }
}

class Pelo {
  float z = random(-radio, radio);
  float phi = random(TWO_PI);
  float largo = random(1.15, 1.2);
  float theta = asin(z / radio);

  void dibujar() {
    float off = (noise(millis() * 0.0005, sin(phi)) - 0.5) * 0.3;
    float offb = (noise(millis() * 0.0007, sin(z) * 0.01) - 0.5) * 0.3;

    float thetaff = theta + off;
    float phff = phi + offb;
    float x = radio * cos(theta) * cos(phi);
    float y = radio * cos(theta) * sin(phi);
    float z = radio * sin(theta);
    float msx = screenX(x, y, z);
    float msy = screenY(x, y, z);
    float nx = radio * largo * cos(thetaff) * cos(phff);
    float ny = radio * largo * cos(thetaff) * sin(phff);
    float nz = radio * largo * sin(thetaff);

    stroke(255, 0, 0);
    line(x, y, z, nx, ny, nz);
  }
}

void boxWithTexture(float w, float h, float d, PImage texture) {
  beginShape(QUADS);
  texture(texture);
  // Frente
  vertex(-w/2, -h/2,  d/2, 0, 0);
  vertex( w/2, -h/2,  d/2, texture.width, 0);
  vertex( w/2,  h/2,  d/2, texture.width, texture.height);
  vertex(-w/2,  h/2,  d/2, 0, texture.height);
  // Trás
  vertex( w/2, -h/2, -d/2, 0, 0);
  vertex(-w/2, -h/2, -d/2, texture.width, 0);
  vertex(-w/2,  h/2, -d/2, texture.width, texture.height);
  vertex( w/2,  h/2, -d/2, 0, texture.height);
  // Direita
  vertex( w/2, -h/2,  d/2, 0, 0);
  vertex( w/2, -h/2, -d/2, texture.width, 0);
  vertex( w/2,  h/2, -d/2, texture.width, texture.height);
  vertex( w/2,  h/2,  d/2, 0, texture.height);
  // Esquerda
  vertex(-w/2, -h/2, -d/2, 0, 0);
  vertex(-w/2, -h/2,  d/2, texture.width, 0);
  vertex(-w/2,  h/2,  d/2, texture.width, texture.height);
  vertex(-w/2,  h/2, -d/2, 0, texture.height);
  // Topo
  vertex(-w/2, -h/2, -d/2, 0, 0);
  vertex( w/2, -h/2, -d/2, texture.width, 0);
  vertex( w/2, -h/2,  d/2, texture.width, texture.height);
  vertex(-w/2, -h/2,  d/2, 0, texture.height);
  // Fundo
  vertex(-w/2,  h/2,  d/2, 0, 0);
  vertex( w/2,  h/2,  d/2, texture.width, 0);
  vertex( w/2,  h/2, -d/2, texture.width, texture.height);
  vertex(-w/2,  h/2, -d/2, 0, texture.height);
  endShape();
}

void sphereWithTexture(float radius, PImage texture) {
  noFill();
  stroke(255);
  beginShape(POINTS);
  texture(texture);
  for (float i = -HALF_PI; i < HALF_PI; i += PI/24) {
    for (float j = 0; j < TWO_PI; j += PI/24) {
      float x = radius * cos(i) * cos(j);
      float y = radius * cos(i) * sin(j);
      float z = radius * sin(i);
      vertex(x, y, z);
    }
  }
  endShape();
}

void cylinder(float r, float h, PImage texture) {
  beginShape(QUAD_STRIP);
  texture(texture);
  for (int i = 0; i < tubeRes; i++) {
    float x = tubeX[i] * r;
    float y = tubeY[i] * r;
    vertex(x, y, -h / 2);
    vertex(x, y, h / 2);
  }
  endShape();
}

void cone(float base, float height, PImage texture) {
  beginShape(TRIANGLES);
  texture(texture);
  for (int i = 0; i < 360; i += 60) {
    float x1 = cos(radians(i)) * base;
    float y1 = sin(radians(i)) * base;
    float x2 = cos(radians(i + 60)) * base;
    float y2 = sin(radians(i + 60)) * base;
    vertex(x1, y1, height / 2);
    vertex(x2, y2, height / 2);
    vertex(0, 0, -height / 2);
  }
  endShape();
}

void pyramid(float base, float height, PImage texture) {
  beginShape(TRIANGLES);
  texture(texture);
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

void hexagon(float r, float h, PImage texture) {
  beginShape(QUAD_STRIP);
  texture(texture);
  for (int i = 0; i <= 360; i += 60) {
    float x1 = cos(radians(i)) * r;
    float y1 = sin(radians(i)) * r;
    float x2 = cos(radians(i + 60)) * r;
    float y2 = sin(radians(i + 60)) * r;
    vertex(x1, -h / 2, y1);
    vertex(x2, -h / 2, y2);
    vertex(x2, h / 2, y2);
    vertex(x1, h / 2, y1);
  }
  endShape();
}

void prism(float r, float h, float depth, PImage texture) {
  beginShape(QUADS);
  texture(texture);
  for (int i = 0; i < 360; i += 60) {
    float x1 = cos(radians(i)) * r;
    float y1 = sin(radians(i)) * r;
    float x2 = cos(radians(i + 60)) * r;
    float y2 = sin(radians(i + 60)) * r;
    vertex(x1, y1, -depth / 2);
    vertex(x2, y2, -depth / 2);
    vertex(x2, y2, depth / 2);
    vertex(x1, y1, depth / 2);
  }
  endShape();
}
