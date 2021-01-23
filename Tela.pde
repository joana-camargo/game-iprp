class Tela {
    PImage[] telas;
    PImage tela;
    int estado = 0;

    Tela(PImage[] telas) {
        this.telas = telas;
        this.tela = this.telas[0];
    }

    Tela(PImage tela) {
        this.telas[0] = tela;
        this.tela = this.telas[0];
    }

    void set(int n) {
        this.estado = n;
        this.tela = this.telas[n];
        this.draw();
    }

    int get() {
        return this.estado;
    }

    void draw() {
        imageMode(CORNER);
        image(this.tela, 0, 0);
    }

}
