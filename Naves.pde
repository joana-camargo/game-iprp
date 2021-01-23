class Nave {
    PImage tlNaves;
    String nome;
    float xc, yc;
    int nBotao;

    Nave(PImage tlNaves, String nome, float x, float y) {
        this.tlNaves = tlNaves;
        this.nome = nome;
        this.xc = x;
        this.yc = y;
    }

    void desenhaNave() {
        imageMode(CORNER);
        image(tlNaves, xc, yc);
    }

    void movimento() {
        int d = 3;
        if (keyCode == RIGHT) {
            xc += d;
        } else if (keyCode == LEFT) {
            xc -= d;
        } else if (keyCode == UP) {
            yc -= d;
        } else if (keyCode == DOWN) {
            yc += d;
        }
    }

    int botao() {
        nBotao = 0;
        if ((mouseX > 167) && (mouseX < 334) && (mouseY > 640) && (mouseY < 700)) {
            nBotao = 5;
            println("menu");
        }
        if ((mouseX > 350) && (mouseX < 509) && (mouseY > 0) && (mouseY < 150)) {
            nBotao = 6;
            println("exit");
        }
        return nBotao;
    }

    // getter e setter
    float getX() { return xc; }
    float getY() { return yc; }
    void setX(float x) { this.xc = x; }
    void setY(float y) { this.yc = y; }

    // checar se a nave colide em (x, y)
    boolean colide(float x, float y) {
        return (x - xc) >= 0
            && (x - xc) <= tlNaves.width
            && (y - yc) >= 0
            && (y - yc) <= tlNaves.height;
    }
}
