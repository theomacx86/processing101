class Mandelbrot {
  // rectangle du plan complexe qu'on veut afficher sur la fenêtre
  Complexe zMin;
  Complexe zMax;

  int nMax; // nombre maximal d'itérations

  Mandelbrot(float reMin, float imMin, float largeur, int nMax) {
    float reMax = reMin + largeur;
    // Calculé en fonction de la taille de la fenêtre
    // pour garder la même échelle sur les deux axes
    float imMax = imMin + largeur * height / width;

    zMin = new Complexe(reMin, imMin);
    zMax = new Complexe(reMax, imMax);
    this.nMax = nMax;
  }

  void dessiner() {
    colorMode(HSB, nMax, 1, 1);
    loadPixels();
    // Pour chaque pixel (x, y) de la fenêtre
    int i = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        // Calculer le nombre complexe correspondant à (x, y)
        Complexe c = zPlan(x, y);
        // Itérer la suite
        int n = itererSuite(c);
        // Si la suite n'a pas divergé, colorer le pixel en noir
        // sinon, colorer en fonction du nombre d'itérations
        if (n == nMax) {
          pixels[i] = color(0);
        } else {
          pixels[i] = color(n, 1, 1);
        }
        i++;
      }
    }
    updatePixels();
  }

  // Transforme un pixel de la fenêtre en point du plan complexe
  Complexe zPlan(int x, int y) {
    float re = map(x, 0, width, zMin.re(), zMax.re());
    float im = map(y, 0, height, zMin.im(), zMax.im());
    return new Complexe(re, im);
  }

  // Itère la suite z(0) = 0, z(n+1) = f(z(n)) pendant nMax itérations
  // ou jusqu'à ce qu'elle sorte du cercle de rayon 2
  // Renvoie le nombre d'itérations effectuées
  int itererSuite(Complexe c) {
    Complexe z = new Complexe();
    int n = 0;
    while (n < nMax && z.mod2() < 4) {
      z = f(z, c);
      n++;
    }
    return n;
  }

  Complexe f(Complexe z, Complexe c) {
    return z.mult(z).plus(c);
  }
}
