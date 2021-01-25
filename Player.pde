class Player {
    PImage sprite;
    int x = 0;
    int y = 0;
    int dt = 10;
    int w = 55;

    Player(PImage sprite, int x, int y) {
        this.sprite = sprite;
        this.x = x;
        this.y = y;
    }

    Player(PImage sprite, int x, int y, int w) {
        this.sprite = sprite;
        this.x = x;
        this.y = y;
        this.w = w;
    }

    void setSprite(PImage sprite) {
        this.sprite = sprite;
    }

    void draw() {
        imageMode(CENTER);
        image(sprite, x, y, w, w);
    }

    int getX() { return this.x; };
    int getY() { return this.y; };

    void move(int pos, int limx, int limy) {
        // movimento limitado pelas dimensoes do mapa
        if (pos == RIGHT && this.x+this.dt < limx) this.x += this.dt;
        else if (pos == LEFT && this.x-this.dt > 0) this.x -= this.dt;
        else if (pos == DOWN && this.y+this.dt < limy) this.y += this.dt;
        else if (pos == UP && this.y-this.dt > 0) this.y -= this.dt;
    }

    void move_para(int x, int y) {
        if (x < 0) {
            this.y = y;
        } else if (y < 0) {
            this.x = x;
        } else {
            this.x = x;
            this.y = y;
        }
    }

    // checar se o (posx, posy) colide com as coords do objeto
    boolean colide(int posx, int posy) {
        int xcalc = posx - this.x;
        int ycalc = posy - this.y;

        if (xcalc > -w/2 && xcalc < w/2 && ycalc > -w/2 && ycalc < w/2) {
            return true;
        } else {
            return false;
        }
    }
}
