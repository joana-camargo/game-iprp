class Botao {
    String nome = "none";
    PImage img = null;
    int id;
    int x;
    int y;

    // width e height para os botoes, respectivamente
    int rectw = 150;
    int recth = 60;

    // nome: para identificacao/debug
    // id: valor retornado quando for clicado
    // (x, y): coordenada do centro do botao
    Botao(String nome, int id, int x, int y) {
        this.nome = nome;
        this.id = id;
        this.x = x;
        this.y = y;
    }

    // inicializar especificando dimensoes, nome e imagem
    Botao(PImage img, String nome, int id, int x, int y, int rectw, int recth) {
        this.img = img;
        this.nome = nome;
        this.id = id;
        this.x = x;
        this.y = y;
        this.rectw = rectw;
        this.recth = recth;
    }

    // checar se o (posx, posy) colide com as coords do botao
    int colide(int posx, int posy) {
        // calcular o (x,y) do canto superior esq. do botao
        int xcalc = posx - (this.x - rectw/2);
        int ycalc = posy - (this.y - recth/2);

        if (xcalc >= 0 && xcalc <= rectw
            && ycalc >= 0 && ycalc <= recth) {
            return this.id;
        } else {
            return -1;
        }
    }

    // desenha botao centralizado com texto
    void draw() {
        noStroke();
        rectMode(CENTER);
        rect(this.x, this.y, rectw, recth);

        if (this.img != null) {
            imageMode(CENTER);
            image(img, this.x/4, this.y, img.width*0.2, img.height*0.2);
            image(img, this.x*2-this.x/4, this.y, img.width*0.2, img.height*0.2);
        }
        fill(0);
        textAlign(CENTER);
        text(nome, this.x, this.y+15);
        noFill();
    }
}
