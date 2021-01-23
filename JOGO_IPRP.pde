Botao[] botoes;
Player player;
PImage[] times_img;
Tela tela;
Tela[] telas;
String[] times_nome;
Player[] clones;

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
    PImage tlGrama = loadImage("img/grama.png");
    PImage tlTimes = loadImage("img/times.png");

    // mudar para o png certo do clone:
    clone_img = loadImage("clone.png");

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
    Botao btJogar = new Botao("Jogar", 3, xcentro, ycentro + sep);
    Botao btTimes = new Botao("Times", 1, xcentro, ycentro + sep*2);
    Botao btSair = new Botao("Sair", 0, tlWidth-70, 28);

    // botoes disponiveis em cada tela
    Botao[] btsMenu = {btJogar, btTimes, btSair};
    Botao[] btsTimes = new Botao[times_img.length+1];
    Botao[] btsNivel = {btSair};

    // inicializar array de botoes da selecao de times
    for (int i = 0; i < times_img.length; i++) {
        if (i % 2 == 0) {
            btsTimes[i] = new Botao(times_img[i], 10+i, xcentro-sep, sep*(i+2), 125, 125);
        } else {
            btsTimes[i] = new Botao(times_img[i], 10+i, xcentro+sep, sep*(i+1), 125, 125);
        }
    }
    btsTimes[btsTimes.length-1] = btSair;

    Tela menu = new Tela(tlMenu, 0, btsMenu);
    Tela times = new Tela(tlGrama, 1, btsTimes);
    Tela creditos = new Tela(tlMenu, 2, btsMenu);
    Tela nivel = new Tela(tlGrama, 3, btsNivel);
    telas = new Tela[] {menu, times, creditos, nivel};

    tela = telas[menu.id];
    tela.draw();

    player = new Player(times_img[0], xcentro, ycentro);
    clones = new Player[3];
    for (int i = 0; i < clones.length; i++) {
        int randx = int(random(60, tlWidth-60));
        int randy = int(random(60, tlHeight-60));
        clones[i] = new Player(clone_img, randx, randy);
    }
}

void draw() {
    // ID==3 eh o unico que necessita de atualizacao constante
    if (tela.id != 3) return;

    tela.draw();

    for (int i = 0; i < clones.length; i++) {
        clones[i].draw();
        // quando colidir, deletar o clone adicionar +1 ponto e criar um novo clone
        if (clones[i].colide(player.getX(), player.getY())) {
            // usar 60 como margem, mantendo os clones longes da beirada
            int randx = int(random(60, tlWidth-60));
            int randy = int(random(60, tlHeight-60));
            clones[i] = new Player(clone_img, randx, randy);
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
        if (rval == 0 && tela.id == 0) {
            exit();
            break;
        } else if (rval >= 0) {
            if (rval > 9) {
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
