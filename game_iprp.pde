import processing.sound.*;

PImage[] campos_img;
PImage[] times_img;
String[] times_nome;

PImage clone_img;
PImage cone_img;
PImage taca_img;

Player player;
Player[] clones;
Player[] obstaculos;

Tela tela;
Tela[] telas;

Botao[] botoes;

SoundFile aud_ponto;
SoundFile aud_ganhar;
SoundFile aud_perder;
SoundFile aud_hit;

PFont mainFont;

int tlWidth = 509;
int tlHeight = 720;

int xcentro = tlWidth/2;
int ycentro = tlHeight/2;

int clones_width = 35;
int obstaculos_width = clones_width*2;

int player_pontos = 0;
int player_hp = 3;
int nNivel = 1;

void setup() {
    // size() de acordo com as variaveis tlWidth e tlHeight
    size(509, 720);

    PFont mainFont = createFont("barcelona-2012.ttf", 46);
    textFont(mainFont);

    // audios
    aud_ponto = new SoundFile(this, "wav/ponto.wav");
    aud_ganhar = new SoundFile(this, "wav/ganhar.wav");
    aud_perder = new SoundFile(this, "wav/perder.wav");
    aud_hit = new SoundFile(this, "wav/hit.wav");

    // imagens
    PImage tlMenu = loadImage("img/menu.png");
    PImage tlTimes = loadImage("img/times.png");
    PImage tlCampos = loadImage("img/times.png");
    PImage tlPerder = loadImage("img/perder.png");
    PImage tlGanhar = loadImage("img/ganhar.png");

    clone_img = loadImage("img/bola.png");
    cone_img = loadImage("img/cone.png");
    taca_img = loadImage("img/taca.png");

    // campos
    PImage campo_grama = loadImage("img/campo_grama.png");
    PImage campo_deserto = loadImage("img/campo_deserto.png");
    PImage campo_espaco = loadImage("img/campo_espaco.png");
    campos_img = new PImage[] {
        campo_grama, campo_deserto, campo_espaco
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

    // objs de Botao
    int sep = 90;
    Botao btJogar = new Botao("Jogar", 4, xcentro, ycentro + sep);
    Botao btCampos = new Botao("Campos", 1, xcentro, ycentro + sep*2);
    Botao btTimes = new Botao("Times", 2, xcentro, ycentro + sep*3);
    Botao btSair = new Botao(loadImage("img/seta.png"), "", 0, 50, 30, 60, 60);

    // botoes disponiveis em cada tela
    Botao[] btsMenu = {btJogar, btCampos, btTimes, btSair};
    Botao[] btsTimes = new Botao[times_img.length+1];
    Botao[] btsCampos = new Botao[campos_img.length+1];
    Botao[] btsNivel = {};
    Botao[] btsBasico = {btSair};

    // inicializar array de botoes da tela de times (tlTimes)
    for (int i = 0; i < times_img.length; i++) {
        btsTimes[i] = new Botao(times_img[i], times_nome[i], 10+i, xcentro, sep*(i+2), tlWidth+2, 60);
    }
    btsTimes[btsTimes.length-1] = btSair;

    // botoes na tela de campos
    btsCampos[0] = new Botao(campo_grama, "clássico", 20, xcentro, sep*3, tlWidth+2, 80);
    btsCampos[2] = new Botao(campo_deserto, "deserto", 21, xcentro, sep*5, tlWidth+2, 80);
    btsCampos[1] = new Botao(campo_espaco, "espaço", 22, xcentro, sep*7, tlWidth+2, 80);
    btsCampos[3] = btSair;

    // telas
    Tela menu = new Tela(tlMenu, 0, btsMenu);
    Tela times = new Tela(tlTimes, 1, btsTimes);
    Tela campos = new Tela(tlCampos, 2, btsCampos);
    Tela creditos = new Tela(tlMenu, 3, btsMenu);
    Tela nivel = new Tela(campos_img[0], 4, btsNivel);
    Tela perder = new Tela(tlPerder, 5, btsBasico);
    Tela ganhar = new Tela(tlGanhar, 6, btsBasico);
    telas = new Tela[] {menu, campos, times, creditos, nivel, perder, ganhar};

    tela = telas[menu.id];
    tela.draw();

    player = new Player(times_img[0], xcentro, ycentro);

    // tamanho do array = numero max. de clones
    clones = new Player[5];
    for (int i = 0; i < clones.length; i++) {
        int randx = int(random(60, tlWidth-60));
        int randy = int(random(60, tlHeight-60));
        clones[i] = new Player(clone_img, randx, randy, clones_width);
    }

    obstaculos = new Player[3];
    for (int i = 0; i < obstaculos.length; i++) {
        int randx = int(random(60, tlWidth-60));
        int randy = int(random(60, tlHeight-60));
        obstaculos[i] = new Player(cone_img, randx, randy, obstaculos_width);
    }

    aud_ponto.play();
}

void draw() {
    if (player_hp < 1) {
        // perdeu o jogo
        tela = telas[5];
        tela.draw();
        aud_perder.play();
        resetGame();
        return;
    } else if (player_pontos >= nNivel*5) {
        player_pontos = 0;
        player_hp += 1;
        nNivel += 1;
        if (nNivel > campos_img.length) {
            // ganhou o jogo
            tela = telas[6];
            tela.draw();
            aud_ganhar.play();
            resetGame();
            return;
        }
        tela.setBg(campos_img[nNivel-1]);
    }

    if (tela.id != 4) return;
    tela.draw();

    // atualizar clones
    for (int i = 0; i < clones.length; i++) {
        // quando colidir, deletar o clone adicionar +1 ponto e criar um novo clone
        if (clones[i].colide(player.getX(), player.getY())) {
            // usar 60 como margem, mantendo os clones longes da beirada
            int randx = int(random(60, tlWidth-60));
            int randy = int(random(60, tlHeight-60));
            clones[i] = new Player(clone_img, randx, randy, clones_width);
            player_pontos += 1;
            aud_ponto.play();
            break;
        }
        clones[i].draw();
    }

    // atualizar obstaculos
    for (int i = 0; i < obstaculos.length; i++) {
        if (obstaculos[i] == null) {
            int randx = int(random(60, tlWidth-60));
            int randy = int(random(60, tlHeight-60));
            obstaculos[i] = new Player(cone_img, randx, randy, obstaculos_width);
        } else if (obstaculos[i].colide(player.getX(), player.getY())) {
            // quando colidir, deletar o clone subtrair 1 de player_hp e criar um novo clone
            int randx = int(random(60, tlWidth-60));
            int randy = int(random(60, tlHeight-60));
            obstaculos[i] = new Player(cone_img, randx, randy, obstaculos_width);
            player_hp -= 1;
            aud_hit.play();
            break;
        }
        obstaculos[i].draw();
    }

    player.draw();

    // rect branco de fundo
    fill(255, 200);
    rect(tlWidth/2, 0, tlWidth+10, 150, 40);
    noFill();

    // mostra quanto o player tem de HP
    for (int i = 0; i < player_hp; i++) {
        image(taca_img, 50*(i+1), 40, taca_img.width*0.2, taca_img.height*0.2);
    }

    // mostra quantas bolas foram coletadas
    fill(0);
    text(player_pontos+"  golos", tlWidth-100, 50);
    noFill();

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
            if (rval >= 20) {
                telas[4].setBg(campos_img[rval-20]);
                // vai para a tela de times
                tela = telas[2];
            } else if (rval >= 10) {
                player.setSprite(times_img[rval-10]);
                // volta para a tela do menu principal
                tela = telas[0];
            } else {
                tela = telas[rval];
            }
            tela.draw();
            break;
        }
    }
}

void resetGame() {
    nNivel = 1;
    player_pontos = 0;
    player_hp = 3;
}
