class Botao {
    String nome = "none";
    PImage img = null;
    int id;
    int x;
    int y;
    int pxs = 46;
    boolean hoverAtivo = false;
    PFont mainFont = createFont("barcelona-2012.ttf", this.pxs);


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

    // inicializar especificando dimensoes para o rect()
    Botao(String nome, int id, int x, int y, int rectw, int recth) {
        this.nome = nome;
        this.id = id;
        this.x = x;
        this.y = y;
        this.rectw = rectw;
        this.recth = recth;
    }

    // inicializar com dimensoes customizadas e imagem
    Botao(PImage img, int id, int x, int y, int rectw, int recth) {
        this.img = img;
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
        stroke(255);
        strokeWeight(2);
        fill(0, 230);
        rectMode(CENTER);
        rect(this.x, this.y, rectw, recth);

        if (this.img != null) {
            imageMode(CENTER);
            image(img, this.x, this.y, rectw*0.8, recth*0.8);
        } else {
            fill(255);
            textFont(mainFont);
            textAlign(CENTER);
            text(nome, this.x, this.y+15);
        }
    }
}
