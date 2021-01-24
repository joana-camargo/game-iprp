Botao[] botoes;
PImage[] campos_img;
PImage[] times_img;
Player player;
Player[] clones;
String[] times_nome;
Tela tela;
Tela[] telas;

int pontos = 0;

int tlWidth = 509;
int tlHeight = 720;

int xcentro = tlWidth/2;
int ycentro = tlHeight/2;

PImage clone_img;

void setup() {
    // size() de acordo com as variaveis tlWidth e tlHeight
    size(509, 720);

    // carregar imagens
    PImage tlMenu = loadImage("img/menu.png");
    PImage tlTimes = loadImage("img/times.png");
    PImage tlCampos = loadImage("img/times.png");

    clone_img = loadImage("img/bola.png");

    // campos
    PImage campo_grama = loadImage("img/campo_grama.png");
    PImage campo_espaco = loadImage("img/campo_espaco.png");
    PImage campo_deserto = loadImage("img/campo_deserto.png");
    campos_img = new PImage[] {
        campo_grama, campo_espaco, campo_deserto
    };

    // times
    PImage time_cor = loadImage("img/time_cor.png");
    PImage time_fla = loadImage("img/time_fla.png");
    PImage time_flu = loadImage("img/time_flu.png");
    PImage time_gre = loadImage("img/time_gre.png");
    PImage time_int = loadImage("img/time_int.png");
    PImage time_pal = loadImage("img/time_pal.png");
    times_img = new PImage[] {
        time_cor, time_fla, time_flu, time_gre, time_int, time_pal
    };
    times_nome = new String[] {
        "Corinthians", "Flamengo", "Fluminense", "Gremio", "Internacional", "Palmeiras"
    };

    // criar objs de Botao
    int sep = 90;
    Botao btJogar = new Botao("Jogar", 4, xcentro, ycentro + sep);
    Botao btCampos = new Botao("Campos", 1, xcentro, ycentro + sep*2);
    Botao btTimes = new Botao("Times", 2, xcentro, ycentro + sep*3);
    Botao btSair = new Botao(null, "Sair", 0, tlWidth-70, 28, 130, 50);

    // botoes disponiveis em cada tela
    Botao[] btsMenu = {btJogar, btCampos, btTimes, btSair};
    Botao[] btsTimes = new Botao[times_img.length+1];
    Botao[] btsCampos = new Botao[campos_img.length+1];
    Botao[] btsNivel = {btSair};

    // inicializar array de botoes da tela de times (tlTimes)
    for (int i = 0; i < times_img.length; i++) {
        btsTimes[i] = new Botao(times_img[i], times_nome[i], 10+i, xcentro, sep*(i+2), tlWidth+2, 60);
    }
    btsTimes[btsTimes.length-1] = btSair;

    btsCampos[0] = new Botao(campo_grama, "clássico", 20, xcentro, sep*3, tlWidth+2, 80);
    btsCampos[1] = new Botao(campo_espaco, "espaço", 21, xcentro, sep*5, tlWidth+2, 80);
    btsCampos[2] = new Botao(campo_deserto, "deserto", 22, xcentro, sep*7, tlWidth+2, 80);
    btsCampos[3] = btSair;

    // telas
    Tela menu = new Tela(tlMenu, 0, btsMenu);
    Tela times = new Tela(tlTimes, 1, btsTimes);
    Tela campos = new Tela(tlCampos, 2, btsCampos);
    Tela creditos = new Tela(tlMenu, 3, btsMenu);
    Tela nivel = new Tela(campos_img[0], 4, btsNivel);
    telas = new Tela[] {menu, campos, times, creditos, nivel};

    tela = telas[menu.id];
    tela.draw();

    player = new Player(times_img[0], xcentro, ycentro);

    // tamanho do array = numero max. de clones
    clones = new Player[6];
    for (int i = 0; i < clones.length; i++) {
        int randx = int(random(60, tlWidth-60));
        int randy = int(random(60, tlHeight-60));
        clones[i] = new Player(clone_img, randx, randy, 35);
    }
}

void draw() {
    if (tela.id != telas.length) return;

    tela.draw();

    for (int i = 0; i < clones.length; i++) {
        clones[i].draw();
        // quando colidir, deletar o clone adicionar +1 ponto e criar um novo clone
        if (clones[i].colide(player.getX(), player.getY())) {
            // usar 60 como margem, mantendo os clones longes da beirada
            int randx = int(random(60, tlWidth-60));
            int randy = int(random(60, tlHeight-60));
            clones[i] = new Player(clone_img, randx, randy, 35);
            pontos += 1;
            break;
        }
    }
    player.draw();
}

void keyPressed() {
    player.move(keyCode, tlWidth, tlHeight);
}

void mousePressed() {
    for (Botao b : tela.botoes) {
        int rval = b.colide(mouseX, mouseY);
        println(rval);
        // if (rval == 0 && tela.id == 0) {
        //     exit();
        //     break;
        // } else if (rval >= 20) {
        //     telas[4].setBg(campos_img[rval-20]);
        //     tela = telas[0];
        //     break;
        // } else if (rval >= 10) {
        //     player.setSprite(times_img[rval-10]);
        //     tela = telas[0];
        // } else if (rval >= 0) {
        //     tela = telas[rval];
        //     tela.draw();
        //     break;
        // }

        if (rval == 0 && tela.id == 0) {
            exit();
            break;
        } else if (rval >= 0) {
            if (rval >= 20) {
                telas[4].setBg(campos_img[rval-20]);
                tela = telas[0];
            } else if (rval >= 10) {
                player.setSprite(times_img[rval-10]);
                tela = telas[0];
            } else {
                tela = telas[rval];
            }
            tela.draw();
            break;
        }
    }
}
