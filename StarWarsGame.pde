/**
Nevis Macintyre
Feb 14 2021
Program allows you play a game about avoiding circles and increasing your score as it continues
*/

void setup() {
  size(1450, 950);//size of the game screen
  noStroke();

  hit= new SoundFile(this, "hit.wav");//load sound effect

  int wideCount = width / unit;
  int highCount = height / unit;
  count = wideCount * highCount;
  mods = new Module[count];//not my code

  int index = 0;
  for (int y = 0; y < highCount; y++) {//not my code
    for (int x = 0; x < wideCount; x++) {
      mods[index++] = new Module(x*unit, y*unit, unit/2, unit/2, random(0.05, 0.8), unit);
    }
  }

  textAlign(LEFT);
  imageMode(CENTER);

  twoD = new int [row][column];

  for (int i = 0; i < twoD.length; i++) {//this goes through all the rows (y)
    for (int j = 0; j < twoD[0].length; j++) {//this goes through all the columns (x)
      rect(j*beadW, i*beadH, beadW, beadH);
    }
  }

  for (int i = 0; i < astroids.length; i++ )//load and format astroids 
  {
    astroids[i] = loadImage("astroid"+i+".png");
    astroids[i].resize(100, 100);//make all the images the same size
  }
  for (int i = 0; i < player.length; i++ )//load and format astroids 
  {
    player[i] = loadImage("falcon."+i+".png");
    player[i].resize(100, 100);//make all the images the same size
  }

  shield = loadImage("shield.png");//load shield image
  sX = random(width);
  sY = random(-12000, 0);//spawn shield image

  for (int i = 0; i < xs.length; i++)
  {//go through each element of the array
    //set to initial values
    xs[i] = random(width);
    ys[i] = random(-1000, 0);
    imgs[i] = (int)random(astroids.length);//get a random image
  }
}//setup

boolean isTouching(float x1, float y1, float r1, float x2, float y2, float r2 ) {//so we know when they are touching
  return dist(x1, y1, x2, y2)< r1+r2;
}
float getDirection(float x, float y) {//to rotate the players image
  return atan2(y, x);
}

void draw() {
  //clear the last frame
  if (gameState == 0) {
    background(10);
  } else if (gameState == 1) {
    background(0);
  } else if (gameState == 2) {
    background(10);
  } else if (gameState == 3) {
    background(10);
  } else if (gameState == 4) {
    background(10);
  } 
  //update stuff
  if (gameState == 0) {
    health = 100;
    healthBar = 400;
    timer = 0;
    score = 0;
  }//reset health, score and time on new game

  if (gameState == 5) {
    maxSpeed = 10;
  }
  if (gameState == 1) {
    maxSpeed = 5;
  }
  if (gameState == 6) {
    maxSpeed = 0;
  }//change players speed depending on game state

  if (timer == 1000) {//speed increases as game goes on
    diff += 1;
  } else if ( timer == 2000) {
    diff += 1;
  } else if ( timer == 3000) {
    diff += 1;
  } else if ( timer == 4000) {
    diff += 1;
  } else if ( timer == 5000) {
    diff += 1;
  }

  for (int i = 0; i < xs.length; i++) {
    if (gameState == 1) {//move down the screen
      ys[i] += diff;
      xs[i] += 0;
    }
  }

  playerX += speedX;
  playerY += speedY;

  if (shieldHealth <=0 && gameState == 1) {
    sY += 5;
  }// only move shield after players shield has run out


  //update stuff
  if (gameState == 1) {// only update and check if were are playing the game
    timer ++;


    //check stuff
    if (playerX < 50) {
      playerX = 50;
    } else if (playerX > width - 50) {
      playerX = width - 50;
    }//keep the player on the screen

    if (playerY < 50) {
      playerY = 50;
    } else if (playerY > height - 50) {
      playerY = height - 50;
    }//keep the player on the screen

    if (sY > height+50)
    {//is it off the scene
      sY = random(-12000, 0);//yes? then put it back to the top
      sX = random(width);
    }//respawns if it goes past the bottom border

    for (int i = 0; i < xs.length; i++)
    {//check each element
      if (ys[i] > height+50)
      {//is it off the scene
        ys[i] = -50;//yes? then put it back to the top
        xs[i] = random(width);
      }//respawns if it goes past the bottom border

      if (gameState == 1) {
        if (isTouching(playerX, playerY, 35, xs[i], ys[i], 35))
        {
          hit.play();//play sound effect on impact
          ys[i] = -50;//yes? then put it back to the top
          xs[i] = random(width);
          health= health - 4;//loses health if the player is hit
          if (shieldHealth <= 0) {
            healthBar = healthBar - 16;
          }//only loses health if player doesn't have shield
          shieldHealth = shieldHealth - 100;//loses shield if hit
          if (health <= 0) {//end the game when health = 0
            gameState = 2;
          }
        }
      }
    }
    if (isTouching(playerX, playerY, 35, sX, sY, 35))
    {
      score = score + 15;//increase score by 15 when player picks up shield
      sY = random(-12000, 0);//yes? then put it back to the top
      sX = random(width);
      shieldHealth = 400;
    }
  }
  //draw stuff

  if (gameState == 0) {
    for (int i = 0; i < xs.length; i++)
    {//go through each element of the array
      //set to initial values
      xs[i] = random(width);
      ys[i] = random(-1000, 0);
    }
    textAlign(CENTER);
    fill(255);
    textSize(100);
    text("Astriod Dodge", width/2, 100);  
    for (int i = 0; i < twoD.length; i++) {
      for (int j = 0; j < twoD[0].length; j++) { 
        fill(255);
        rect(j*beadW+ xP, i*beadH+ yP, beadW, 70, 25);
        fill(0);
        textSize(50);
        text("Start", 725, 355);
        text("Ship Select", 725, 430);
        text("How to play", 725, 505);
      }
    }//selection menu
  } else if (gameState == 1) {//while player is playing
    for (Module mod : mods) {//not my code
      mod.update();
      mod.display();
    }
    textAlign(LEFT);

    scoreTimer--;
    println(scoreTimer);
    if (scoreTimer == 0) {//increases score automatically
      scoreTimer = 75;
      score = score + 1;
    }

    noCursor();//takes your cursor away during the game
    fill(255, 0, 0);
    rect(50, 125, 400, 50);
    fill(0, 255, 0);
    rect(50, 125, healthBar, 50);//healthbar

    textSize(50);
    fill(111);
    text("time: "+timer, 50, 50);
    text("score: "+score, 50, 100);
    pushMatrix();  //store transformations to the image
    translate(playerX, playerY);  //move origin to the player
    rotate(dir);  //rotate the universe
    image(player[ship], 0, 0);//draw the player at the origin 
    popMatrix();  //undo all the transformations//draw the player
    image(shield, sX, sY, 100, 100);
    if (shieldHealth > 0) {
      fill(0, 100, 255, 150);
      ellipse(playerX, playerY, 120, 120);
      fill(255);
      rect(50, 200, 400, 50);
      fill(0, 100, 255);
      rect(50, 200, shieldHealth, 50);//shield bar
    }
    for (int i = 0; i < ys.length; i++)
    {
      //ellipse(xs[i], ys[i], 100, 100 );
      image(astroids[imgs[i]], xs[i], ys[i], 100, 100);
    }
  } else if (gameState == 2) {
    if (score > highscore) {//checks to see if current score is a new highscore
      highscore = score;
    }
    fill(255);
    textAlign(CENTER);
    textSize(125);
    text("Game Over", width/2, height/2 -200); 
    text("Score: "+ score, width/2, height/2+100);
    text("highScore: "+ highscore, width/2, height/2+225);
    textSize(50);
    text("press b to return to main menu", width/2, height/2+325);
  } else if (gameState == 3) {

    background(0);
    fill(255);
    ellipse(100, 65, 110, 110);
    fill(0);
    textSize(50);
    text("exit", 100, 75);
    fill(255);
    textSize(100);
    text("Ship Select", 725, 100);
    for (int i = 0; i < shipSelect.length; i++) {
      for (int j = 0; j < shipSelect[0].length; j++) { 
        fill(255);
        rect(j* aW + XP, i * aH + YP, aW-10, aH, 15);
        fill(0);
        image(player[0], 455, 485);
        image(player[1], 630, 485);
        image(player[2], 805, 485);
        image(player[3], 980, 485);
      }
    }//displays ships
  } else if (gameState == 4) {//instructions
    fill(255);
    ellipse(100, 65, 110, 110);
    fill(0);
    textSize(50);
    text("exit", 100, 75);
    fill(255);
    textSize(100);
    text("How To Play", width/2, 100);
    textSize(25);
    text("The goal of the game is to get the highest score you can", width/2, 170);
    text("you can use your score to purchase different abilitys in the game", width/2, 200);
    text("press W, A, S or D to move around", width/2, 260);
    text("press E to teleport  >  Cost: 3 points & half the damage of an astroid", width/2, 320);
    text("teleport freezes everything and you have to navigate your ship to a safe space without being able to see it move", width/2, 350);
    text("press C to clear astriods in your radius  >  Cost: 10  ", width/2, 410);
    text("press Q to to heal %10 0f your health  >  Cost: 5  ", width/2, 470);
    text("press SHIFT to pause", width/2, 530);
    text("picking up a shield gives you 15 points and allows you to be hit 4 times without taking damage", width/2, 590);
    text("Although you can use these abilitys keep track that you don't use all your score because even if you survive", width/2, 650);
    text("there's no point if you have a bad score", width/2, 680);
  } else if (gameState == 6 ) {//pause function
    fill(255);
    textAlign(CENTER);
    text("Paused", width/2, 200);
    rect(width/2 + 25, 275, 40, 250);
    rect(width/2 - 60, 275, 40, 250 );
  }
}
