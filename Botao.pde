class Botao {
    String nome;
    int id;
    int x;
    int y;

    // width e height do botao, respectivamente
    int rectw = 200;
    int recth = 65;

    // nome: para identificacao/debug
    // id: indice no array de telas
    // (x, y): par ordenado do centro do botao
    Botao(String nome, int id, int x, int y) {
        this.nome = nome;
        this.id = id;
        this.x = x;
        this.y = y;
    }

    // checar se o (posx, posy) colide com as coords do botao
    int colide(int posx, int posy) {
        int xcalc = (posx - this.x - rectw/2);
        int ycalc = (posy - this.y - recth/2);
        println(nome, ":", xcalc, ycalc);
        if (xcalc > 0 && ycalc > 0) {
            return this.id;
        } else {
            return -1;
        }
    }

    void draw() {
        fill(0, 230);
        rectMode(CENTER);
        rect(this.x, this.y, rectw, recth);

        fill(255);
        textSize(32);
        textAlign(CENTER);
        text(nome, this.x, this.y+10);
    }
}
