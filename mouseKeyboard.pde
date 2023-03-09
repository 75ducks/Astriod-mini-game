//mouse and key controls

void keyPressed() {
  if (key == 'w') {
    speedY = -maxSpeed;
    speedy = maxSpeed;
  } else if (key == 's') {
    speedY = maxSpeed;
    speedy = -maxSpeed;
  } else if (key == 'd') {
    speedX = maxSpeed;
  } else if (key == 'a') {
    speedX = -maxSpeed;
  }
  //controls direction
  dir = getDirection(speedy, speedX);
  if (gameState == 2 && key == 'b') {//returns to menu
    gameState = 0;
  }
  if (gameState == 1 && key == 'e' && score >= 2) {//teleport function
    gameState = 5;
  } else if (gameState == 5 && key == 'e') {
    gameState = 1; 
    score = score - 3;
    health = health -2;
    healthBar = healthBar - 8;
  }

  if (gameState == 1 && key == 'q' && score >= 5) {//teleport function
    score -= 5;
    health += 10;
    healthBar = healthBar +40;
  }

  if (key == CODED) {
    if (gameState == 1 && keyCode == SHIFT) {//pause function
      gameState = 6;
    } else if (gameState == 6 && keyCode == SHIFT) {
      gameState = 1;
    }
  }
  if (gameState == 1 && key == 'c' && score >= 10) {
    score -= 10;
    for (int i = 0; i < xs.length; i++) {
      if (isTouching(playerX, playerY, 250, xs[i], ys[i], 250))
      {
        ys[i] = -50;//yes? then put it back to the top
        xs[i] = random(width);
      }
    }
  }
}


void keyReleased() {// stops the ship when you let go
  if (key == 's' || key == 'w') {
    speedY = 0;
  }
  if (key == 'a' || key == 'd') {
    speedX = 0;
  }
}

void mousePressed() {//return to menu if in ship select or instructions
  if (gameState == 3 || gameState == 4) {
    if (isTouching(mouseX, mouseY, 1, 100, 65, 50))
    {
      gameState = 0;
    }
  }
  for (int i = 0; i < twoD.length; i++) {//menu options
    for (int j = 0; j < twoD[0].length; j++) {
      if (i == 0 && gameState == 0) {
        if ((mouseX>(j)*beadW+ xP&&mouseX<(j+1)*beadW+ xP) && (mouseY>i*beadH+ yP&&mouseY<(i+1)*beadH+ yP)) {//start button
          gameState = 1;
        }
      }
      if (i == 1 && gameState == 0) {
        if ((mouseX>(j)*beadW+ xP&&mouseX<(j+1)*beadW+ xP) && (mouseY>i*beadH+ yP&&mouseY<(i+1)*beadH+ yP)) {//ship select button
          gameState = 3;
        }
      }
      if (i == 2 && gameState == 0) {
        if ((mouseX>(j)*beadW+ xP&&mouseX<(j+1)*beadW+ xP) && (mouseY>i*beadH+ yP&&mouseY<(i+1)*beadH+ yP)) {//how to play button
          gameState = 4;
        }
      }
    }
  }
  for (int i = 0; i < shipSelect.length; i++) {//selects a ship using mouse cordinates
    for (int j = 0; j < shipSelect[0].length; j++) {
      if (j == 0 && gameState == 3) {
        if ((mouseX>(j)*aW+ XP&&mouseX<(j+1)*aW+ XP) && (mouseY>i*aH+ YP&&mouseY<(i+1)*aH+ YP)) {
          ship = 0;
        }
      }
      if (j == 1 && gameState == 3) {
        if ((mouseX>(j)*aW+ XP&&mouseX<(j+1)*aW+ XP) && (mouseY>i*aH+ YP&&mouseY<(i+1)*aH+ YP)) {
          ship = 1;
        }
      }
      if (j == 2 && gameState == 3) {
        if ((mouseX>(j)*aW+ XP&&mouseX<(j+1)*aW+ XP) && (mouseY>i*aH+ YP&&mouseY<(i+1)*aH+ YP)) {
          ship = 2;
        }
      }
      if (j == 3 && gameState == 3) {
        if ((mouseX>(j)*aW+ XP&&mouseX<(j+1)*aW+ XP) && (mouseY>i*aH+ YP&&mouseY<(i+1)*aH+ YP)) {
          ship = 3;
        }
      }
    }
  }
}
