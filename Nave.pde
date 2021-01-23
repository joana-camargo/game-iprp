class Nave {
    PImage sprite;
    int xc = 0;
    int yc = 0;
    int dt = 5;

    Nave(PImage sprite, int x, int y) {
        this.sprite = sprite;
        this.xc = x;
        this.yc = y;
    }

    void setSprite(PImage sprite) {
        this.sprite = sprite;
    }

    void draw() {
        imageMode(CENTER);
        image(sprite, xc, yc);
    }

    void move(int pos, int limx, int limy) {
        // quando for sair do mapa, cancelar o movimento do usuario
        if (pos == RIGHT && this.xc+this.dt < limx) this.xc += this.dt;
        else if (pos == LEFT && this.xc-this.dt > 0) this.xc -= this.dt;
        else if (pos == DOWN && this.yc+this.dt < limy) this.yc += this.dt;
        else if (pos == UP && this.yc-this.dt > 0) this.yc -= this.dt;
    }
}
