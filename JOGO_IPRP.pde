Botao[] botoes;
Nave nave;
PImage[] img_naves;
Tela tela;
Tela[] telas;

int tlWidth = 509;
int tlHeight = 720;

int xcentro = tlWidth/2;
int ycentro = tlHeight/2;

void setup() {
    // size() de acordo com as variaveis tlWidth e tlHeight
    size(509, 720);

    // carregar imagens
    PImage tlMenu = loadImage("img/menu.png");
    PImage tlGrama = loadImage("img/grama.png");
    PImage tlNaves = loadImage("img/naves.png");

    PImage nave_cor = loadImage("img/nave_cor.png");
    PImage nave_fla = loadImage("img/nave_fla.png");
    PImage nave_flu = loadImage("img/nave_flu.png");
    PImage nave_gre = loadImage("img/nave_gre.png");
    PImage nave_int = loadImage("img/nave_int.png");
    PImage nave_pal = loadImage("img/nave_pal.png");

    img_naves = new PImage[] {
        nave_cor, nave_fla, nave_flu, nave_gre, nave_int, nave_pal
    };

    // criar objs de Botao
    int sep = 90;
    Botao btJogar = new Botao("Jogar", 3, xcentro, ycentro + sep);
    Botao btNaves = new Botao("Naves", 1, xcentro, ycentro + sep*2);
    Botao btSair = new Botao("Sair", 0, tlWidth-70, 30, 125, 50);

    // botoes disponiveis em cada tela
    Botao[] btsMenu = {btJogar, btNaves, btSair};
    Botao[] btsNaves = new Botao[img_naves.length+1];
    Botao[] btsNivel = {btSair};

    // inicializar array de botoes da selecao de naves
    for (int i = 0; i < img_naves.length; i++) {
        if (i % 2 == 0) {
            btsNaves[i] = new Botao(img_naves[i], 10+i, xcentro-sep, sep*(i+2), 125, 125);
        } else {
            btsNaves[i] = new Botao(img_naves[i], 10+i, xcentro+sep, sep*(i+1), 125, 125);
        }
    }
    btsNaves[btsNaves.length-1] = btSair;

    Tela menu = new Tela(tlMenu, 0, btsMenu);
    Tela naves = new Tela(tlGrama, 1, btsNaves);
    Tela creditos = new Tela(tlMenu, 2, btsMenu);
    Tela nivel = new Tela(tlGrama, 3, btsNivel);
    telas = new Tela[] {menu, naves, creditos, nivel};

    tela = telas[menu.id];
    tela.draw();

    nave = new Nave(img_naves[0], xcentro, ycentro);

    // botao de proximo clareia quando o usuario coletar N coins
    // quando mudar de nivel, apenas mudar o background e aumentar a dificuldade
    // aumenta a dificuldade diminuindo tempo para coletar moedas (?)
}

void draw() {
    // antes do ID 3 sao apenas menus, nao niveis
    if (tela.id != 3) return;

    tela.draw();
    nave.draw();
}

void keyPressed() {
    nave.move(keyCode, tlWidth, tlHeight);
}

void mousePressed() {
    for (Botao b : tela.botoes) {
        int rval = b.colide(mouseX, mouseY);
        if (rval == 0 && tela.id == 0) {
            exit();
            break;
        } else if (rval >= 0) {
            if (rval > 9) {
                nave.setSprite(img_naves[rval-10]);
                tela = telas[0];
            } else {
                tela = telas[rval];
            }
            tela.draw();
            break;
        }
    }
}
