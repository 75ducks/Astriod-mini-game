//game varibles
import processing.sound.*;

int gameState = 0;//0 is pregame, 1 is playing, 2 is game over
int timer = 0;// timer to keep track of your time
int duration = 180;
int [][] twoD;// a start button
float beadH = 75;
float beadW = beadH*4 ;
int row = 3;
int column = 1;
float xP = 575;
float yP = 300;

int highscore = 0;
int temp = 0;
int score = 0;
int scoreTimer = 0;
int health = 100;//health
int healthBar = 400;
SoundFile hit;//sound effect

//ship selection
int [][] shipSelect = new int [1][4];
int ship = 0;
int aW = 175;
int aH = 175;
int XP = 375;
int YP = 400;

//player variables
float playerX = 400;  //player location
float playerY = 400;
PImage [] player = new PImage[5];

float speedX = 0;   //speed
float speedY = 0;
float speedy = 0;

float maxSpeed = 5;  //max speed in any direction

int sizW = 100;   //length and width of player icon
int sizH = 90;

float dir = 0;   //direction player is facing

//astroid variables
PImage [] astroids = new PImage[5];//stores all the available images

int numCircles = 25;
float [] xs = new float[numCircles];//x positions 
float [] ys = new float[numCircles];//y positions
int [] imgs = new int[numCircles];
int diff = 5;

int unit = 40;
int count;
Module[] mods;

PImage shield;  //shield variables
int shieldHealth = 0;
float sX = 200;
float sY = 200;
