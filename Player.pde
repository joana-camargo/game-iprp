class Player {
    PImage sprite;
    int x = 0;
    int y = 0;
    int dt = 5;

    Player(PImage sprite, int x, int y) {
        this.sprite = sprite;
        this.x = x;
        this.y = y;
    }

    void setSprite(PImage sprite) {
        this.sprite = sprite;
    }

    void draw() {
        imageMode(CENTER);
        image(sprite, x, y, 60, 60);
    }

    void move(int pos, int limx, int limy) {
        // quando for sair do mapa, cancelar o movimento do usuario
        if (pos == RIGHT && this.x+this.dt < limx) this.x += this.dt;
        else if (pos == LEFT && this.x-this.dt > 0) this.x -= this.dt;
        else if (pos == DOWN && this.y+this.dt < limy) this.y += this.dt;
        else if (pos == UP && this.y-this.dt > 0) this.y -= this.dt;
    }
}
