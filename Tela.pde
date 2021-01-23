class Tela {
    Botao[] botoes;
    PImage bg;
    int id;

    Tela(PImage bg, int id, Botao[] botoes) {
        this.bg = bg;
        this.id = id;
        this.botoes = botoes;
    }

    int id() {
        return this.id;
    }

    void draw() {
        background(this.bg);
        for (Botao b : botoes) b.draw();
    }

    void setBg(PImage bg) {
        this.bg = bg;
    }
}
