//https://youtu.be/ul76OTd9Uew
PImage xviii;
int columnas = 25;
int filas = 23;
float ancho, alto;
float factorColor = 1.0;
boolean distorsionar = false;
void setup() {
size(800, 400);
xviii = loadImage("28.jpg");
ancho = 400 / columnas;
alto = 400.0 / filas;
}

void draw() {
background(0); 
image(xviii, 0, 0, 400, 400);
pushMatrix();
translate(400, 0); 
imagendeldiavlo();
popMatrix();

fill(255);
textSize(12);
text("Click: Cambiar color | Tecla 'R': Reiniciar", 415, 390);
}

void imagendeldiavlo() {
  
  for (int c = 0; c < columnas; c++) {
    for (int f = 0; f < filas; f++) {
      
      float x = c * ancho;
      float y = f * alto;
      float centroX = x + ancho/2;
      float centroY = y + alto/2;
      float normY = (float)f / filas;
      color colorFondo;
      int nivelCuadradoIzq = max(c, f); 
      if (nivelCuadradoIzq < 12) {
        float pctRojo = map(nivelCuadradoIzq, 0, 11, 0, 1);
        colorFondo = lerpColor(color(225, 45, 10), color(18, 20, 55), pctRojo);
      } 
      else if (nivelCuadradoIzq < 15) {
        float pctAzulMedio = map(nivelCuadradoIzq, 12, 14, 0, 1);
        color azulOscuroBase = color(18, 20, 55);
        color azulUnPocoMasClaro = color(35, 50, 110);
        colorFondo = lerpColor(azulOscuroBase, azulUnPocoMasClaro, pctAzulMedio);
      } 
      else {
        float pctCelesteTotal = map(nivelCuadradoIzq, 15, 24, 0, 1);
        color azulTransicion = color(35, 50, 110);
        color celesteMuyClarito = color(140, 185, 250);
        colorFondo = lerpColor(azulTransicion, celesteMuyClarito, pctCelesteTotal);
      }
      

      noStroke();
      fill(colorFondo);
      rect(x, y, ancho, alto);
      color colorfigura = color(0);
      if (c < 8 || f < 8) {
        int nivelBorde;
        if (c < 8 && f < 8) {
          nivelBorde = min(c, f); 
        } else if (c < 8) {
          nivelBorde = c;        
        } else {
          nivelBorde = f;        
        }
        
        float pctAzul = map(nivelBorde, 0, 7, 0, 1);
        color celesteClaro = color(145, 195, 255);
        color azulOscuro = color(12, 22, 55);
        colorfigura = lerpColor(celesteClaro, azulOscuro, pctAzul);
      } 
      else {
        int sumaDiagonal = c + f;

        int centroFocoC = 18; 
        int centroFocoF = 18; 
        
        int distCuadradaFoco = max(abs(c - centroFocoC), abs(f - centroFocoF));
        
        if (distCuadradaFoco <= 3) {
          float pctAmarillo = map(distCuadradaFoco, 0, 3, 0, 1);
          color amarillito = color(220, 248, 15); 
          color verdetransicion = color(95, 130, 90);   
          
          colorfigura = lerpColor(amarillito, verdetransicion, pctAmarillo);
        } 
        else {
          if ((f >= 12 && c >= 20) || (f >= 22 && c >= 12) || (f >= 12 && c >= 12 && sumaDiagonal > 32)) {
            colorfigura = color(105, 115, 120); 
          } 
          else {
            float pctDiagonal = map(sumaDiagonal, 16, 32, 0, 1);
            
            if (pctDiagonal < 0) {
              pctDiagonal = 0;
            } else if (pctDiagonal > 1) {
              pctDiagonal = 1;
            }
            
            color verdeGrisOscuro = color(22, 38, 30); 
            color verdeClaroGris = color(90, 125, 100);  
            
            colorfigura = lerpColor(verdeGrisOscuro, verdeClaroGris, pctDiagonal);
            if (f == 8 || c == 8) {
              colorfigura = color(22, 38, 30);
            }
          }
        }
      }
      
      float factorOscurecerY = map(normY, 0, 1, 1.0, 0.75);
      colorfigura = color(red(colorfigura) * factorOscurecerY, 
                          green(colorfigura) * factorOscurecerY, 
                          blue(colorfigura) * factorOscurecerY);
            colorfigura = lerpColor(colorfigura, color(255, 100, 255), (factorColor - 1.0));
      boolean esCentroRectangular = (c >= 7 && c <= 17 && f >= 6 && f <= 16);
      dibujarElemento(centroX, centroY, ancho * 0.76, esCentroRectangular, colorfigura);
    }
  }
}

void dibujarElemento(float x, float y, float tamanio, boolean esCuadrado, color col) {
pushMatrix();
  translate(x, y);
  
  if (distorsionar) {
    float angulo = calcularAnguloRotacion(x, y); 
    rotate(angulo);
  }
  
  fill(col);
  noStroke();
  
  if (esCuadrado) {
    rectMode(CENTER);
    rect(0, 0, tamanio, tamanio);
    rectMode(CORNER); 
  } else {
    ellipse(0, 0, tamanio, tamanio);
  }
  
popMatrix();
}
float calcularAnguloRotacion(float posX, float posY) {
  float distanciaMouse = dist(mouseX - 400, mouseY, posX, posY);
  return map(distanciaMouse, 0, 400, 0, TWO_PI);
}
void mousePressed() {
  if (mouseX > 400 && mouseX < 800 && mouseY > 0 && mouseY < 400) {
    factorColor = random(1.0, 1.2); 
    distorsionar = !distorsionar;   
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    factorColor = 1.0;
    distorsionar = false;
  }
}
