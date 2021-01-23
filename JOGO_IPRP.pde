Tela tela;
Botao[] botoes;
PImage[] naves = new PImage[6];
PImage[] campos = new PImage[3];

String[] naves_nomes = {"fla", "flu", "cor", "inter", "gre", "pal"};
String[] campos_nomes = {"grama", "espaco", "deserto"};

int estado = 0;
//int estadoNaves = int(random(0, naves.length));
int estadoNaves = 0;

int tela_width = 509;
int tela_height = 720;

void setup() {
    // como size() consegue ler apenas numeros,
    // ajuste as variaveis tela_width e tela_height de acordo
    size(509, 720);

    // carregar imagens
    PImage tlMenu = loadImage("img/grama.png");
    PImage tlNaves = loadImage("img/naves.png");
    PImage tlNiveis = loadImage("img/niveis.png");
    PImage tlCreditos = loadImage("img/creditos.png");
    PImage tlPerdeu = loadImage("img/perdeu.png");
    PImage tlGanhou = loadImage("img/ganhou.png");
    PImage[] telas = {tlMenu, tlNaves, tlNiveis, tlCreditos, tlPerdeu, tlGanhou};

    tela = new Tela(telas);
    tela.set(0);

    for (int i = 0; i < naves_nomes.length; i++) {
        // => "img/fla.png" ... para cada nave
        naves[i] = loadImage("img/"+naves_nomes[i]+".png");
    }

    for (int i = 0; i < campos.length; i++) {
        // => "img/grama.png" ... para cada campo
        campos[i] = loadImage("img/"+campos_nomes[i]+".png");
    }

    Botao btNaves = new Botao("Naves", 1, tela_width/2, tela_height/2);
    Botao btNiveis = new Botao("Niveis", 2, tela_width/2, tela_height/2+130);
    Botao btSair = new Botao("Sair", 3, tela_width/2, tela_height/2+260);
    botoes = new Botao[]{btNaves, btNiveis, btSair};

    tela.draw();
    for (Botao b : botoes) {
        b.draw();
    }

    // passar array de botoes pra tela
    // quando chamar tela.draw() desenha os botoes designados pelo array
    // tela.botoes = {btSair, btProxima};

    // botao de proximo muda pra uma cor mais clara quando o usuario coletar X
    // coins
}

void draw() {}

void mousePressed() {
    println(mouseX, mouseY);
    for (Botao b : botoes) {
        int tela_id = b.colide(mouseX, mouseY);
        if (tela_id > 0) {
            tela.set(tela_id);
            println("colide");
            break;
        }
    }
}
