// Charles J. Mizikar IV Revisions
//
//
//
// Position Variables
int tvx, tvy;
int vidx, vidy;
int deck1x, deck1y;
int deck2x, deck2y;
int track1x, track1y;
int track2x, track2y;
int trackvx, trackvy;
int play1x, play1y;
int play2x, play2y;
int playvx, playvy;
int prevx, prevy;
int prev1x, prev1y;
int prev2x, prev2y;
int skipvx, skipvy;
int skip1x, skip1y;
int skip2x, skip2y;
int ftrack1x, ftrack1y;
int ftrack2x, ftrack2y;
int ftrackvx, ftrackvy;

//Frame Variables
int i = 0;
int j = 0;
float k = 0;

//Div Definitions
int area1x, area1y;
int area2x, area2y;
int areavx, areavy;

//Buffer/Margin definition
int margin = 30;
int buffer = 100;

//Image Definitions
PImage [] video;
PImage [] rot;
PImage vinyl;
PImage ftrack;
PImage fader;
PImage selfader;
PImage tv;
PImage glass;
PImage play;
PImage playact;
PImage playsel;
PImage ftrackv;

//Playback speed Definitions
float speed1 = 1.0;
float speed2 = 1.0;
float speedv = 1.0;

//image scaling
float tvscale = 0.5;
float videoscale = 0.8;
float deckscale = 0.8;
float faderscale = 0.4;
float buttonscale = 0.5;

//Track Constraints
float ftrack1low;
float ftrack1high;
float ftrack2low;
float ftrack2high;
float ftrackvlow;
float ftrackvhigh;
float fader1x;
float fader1y;
float fader2x;
float fader2y;
float fadervx;
float fadervy;

//scale result
float tvxscale;
float tvyscale;
float videoxscale;
float videoyscale;
float deckxscale;
float deckyscale;
float faderxscale;
float faderyscale;
float ftrackxscale;
float ftrackyscale;
float playxscale;
float playyscale;


//Playback triggers
boolean vplay = false;
boolean deck1play = false;
boolean deck2play = false;

//Click buffer
boolean firstclk = false;

//Audio Definitions
Maxim maxim;
AudioPlayer player1;
AudioPlayer player2;


void setup()
{
  //Screen Size
  size(1366,768);
  
  //Background color
  background(154,152,152);
  
  //Set Areas
  areavx = width/2;
  areavy = height/3;
  
  area1x = width/6;
  area1y = height/2;
  
  area2x = width*5/6;
  area2y = height/2;
  
  //Center Images
  imageMode(CENTER);
  
  //Load Images
  vinyl = loadImage("imgs/Vinyl/Vinyl.png");
  ftrack = loadImage("imgs/Fader/FaderTrack.png");
  fader = loadImage("imgs/Fader/Fader.png");
  selfader = loadImage("imgs/Fader/FaderClick.png");
  tv = loadImage("imgs/Video Surround/Surround.png");
  glass = loadImage("imgs/Video Surround/Glass.png");
  play = loadImage("imgs/Play/Play.png");
  playact = loadImage("imgs/Play/PlayActive.png");
  playsel = loadImage("imgs/Play/PlayClick.png");
  ftrackv = loadImage("imgs/Fader/FaderTrackvideo.png");
  
  //Load Animations
  rot = loadImages("imgs/Vinyl/Rotation/Vrot", ".png", 66);
  video = loadImages("imgs/video/movie", ".jpg", 134);
  
  //Setup Audio
  maxim = new Maxim(this);
  
  //Load Audio
  player1 = maxim.loadFile("audio/drums.wav");
  player2 = maxim.loadFile("audio/bass.wav");
  
  //Setup x,y Positions
  tvx = areavx;
  tvy = areavy;
  
  vidx = areavx;
  vidy = areavy - 94;
  
  deck1x = area1x;
  deck1y = area1y - 100;
  deck2x = area2x;
  deck2y = area2y - 100;
  
  playvx = areavx;
  playvy = areavy + 100;
  play1x = area1x;
  play1y = area1y + 120;
  play2x = area2x;
  play2y = area2y + 120;
  
  ftrack1x = area1x;
  ftrack1y = area1y + 180;
  fader1x = ftrack1x;
  fader1y = ftrack1y;
  ftrack2x = area2x;
  ftrack2y = area2y + 180;
  fader2x = ftrack2x;
  fader2y = ftrack2y;
  ftrackvx = areavx;
  ftrackvy = areavy+160;
  fadervx = ftrackvx;
  fadervy = ftrackvy;
  
  //Setup scales
  tvxscale = tv.width*tvscale;
  tvyscale = tv.height*tvscale;
  
  deckxscale = vinyl.width*deckscale;
  deckyscale = vinyl.height*deckscale;
  
  videoxscale = video[0].width * videoscale;
  videoyscale = video[0].height * videoscale;
  
  playxscale = play.width * buttonscale;
  playyscale = play.height * buttonscale;
  
  faderxscale = fader.width * faderscale;
  faderyscale = fader.height * faderscale;
  
  ftrackxscale = ftrack.width * faderscale;
  ftrackyscale = ftrack.height * faderscale;
  
  //setup constraints
  ftrack1low = ftrack1x - ftrackxscale/2;
  ftrack1high = ftrack1x + ftrackxscale/2;
  
  ftrack2low = ftrack2x - ftrackxscale/2;
  ftrack2high = ftrack2x + ftrackxscale/2;
  
  ftrackvlow = ftrackvx - ftrackxscale/2;
  ftrackvhigh = ftrackvx + ftrackxscale/2;
  
  //draw background Images.
  image(tv, tvx, tvy, tvxscale, tvyscale);
  image(video[0], vidx, vidy, videoxscale, videoyscale);
  image(glass, tvx, tvy, tvxscale, tvyscale);
  image(vinyl, deck1x, deck1y, deckxscale, deckyscale);
  image(vinyl, deck2x, deck2y, deckxscale, deckyscale);
  image(rot[0], deck1x, deck1y, deckxscale, deckyscale);
  image(rot[0], deck2x, deck2y, deckxscale, deckyscale);
  image(play, playvx, playvy, playxscale, playyscale);
  image(play, play1x, play1y, playxscale, playyscale);
  image(play, play2x, play2y, playxscale, playyscale);
  image(ftrack, ftrack1x, ftrack1y, ftrackxscale, ftrackyscale);
  image(ftrack, ftrack2x, ftrack2y, ftrackxscale, ftrackyscale);
  image(fader, ftrack1x, ftrack1y, faderxscale, faderyscale);
  image(fader, ftrack2x, ftrack2y, faderxscale, faderyscale);
  image(ftrackv, ftrackvx, ftrackvy, ftrackxscale, ftrackyscale);
  image(fader, ftrackvx, ftrackvy, faderxscale, faderyscale);
}

void draw()
{
  //Animate Deck 1 if playing
  
  if(deck1play)
  {
    image(vinyl, deck1x, deck1y, deckxscale, deckyscale);
    image(rot[i], deck1x, deck1y, deckxscale, deckyscale);
    i += (10 * speed1);
    if(i>=65)
    {
      i = i - 65;
    }
  }
  
  //Animate Deck 2 if playing
  
  if(deck2play)
  {
    image(vinyl, deck2x, deck2y, deckxscale, deckyscale);
    image(rot[j], deck2x, deck2y, deckxscale, deckyscale);
    j += (10 * speed2);
    if(j>=65)
    {
      j = j - 65;
    }
  }
  
  if(vplay)
  {
    image(tv, tvx, tvy, tvxscale, tvyscale);
    image(video[(int)k], vidx, vidy, videoxscale, videoyscale);
    image(glass, tvx, tvy, tvxscale, tvyscale);
    image(playact, playvx, playvy, playxscale, playyscale);
    image(ftrackv, ftrackvx, ftrackvy, ftrackxscale, ftrackyscale);
    image(fader, fadervx, fadervy, faderxscale, faderyscale);
    
    k = k + 1 * speedv;
    if(k >= video.length)
    {
      k = 0;
    }
  }
  
}

void mouseClicked()
{
  if((dist(mouseX, mouseY, playvx, playvy) < playxscale/2) || (dist(mouseX, mouseY, playvx, playvy) < playyscale/2))
{
  image(playsel, playvx, playvy, playxscale, playyscale);
  vplay = !vplay;
}
  if((dist(mouseX, mouseY, play1x, play1y) < playxscale/2) || (dist(mouseX, mouseY, play1x, play1y) < playyscale/2))
{
  image(playsel, play1x, play1y, playxscale, playyscale);
  deck1play = !deck1play;
}
  if((dist(mouseX, mouseY, play2x, play2y) < playxscale/2) || (dist(mouseX, mouseY, play2x, play2y/2) < playyscale/2))
{
  image(playsel, play2x, play2y, playxscale, playyscale);
  deck2play = !deck2play;
}

if(deck1play)
{
  player1.play();
  image(playact, play1x, play1y, playxscale, playyscale);
}
if(!deck1play)
{
  player1.stop();
  image(play, play1x, play1y, playxscale, playyscale);
}


if(deck2play)
{
  player2.play();
  image(playact, play2x, play2y, playxscale, playyscale);
}
if(!deck2play)
{
  player2.stop();
  image(play, play2x, play2y, playxscale, playyscale);
}

if(!vplay)
{
  image(play, playvx, playvy, playxscale, playyscale);
}
}

void mouseDragged()
{
  if(dist(mouseX, mouseY, fader1x, fader1y) < faderxscale/2 || dist(mouseX, mouseY, fader1x, fader1y) < faderyscale/2)
 {
  fader1x = mouseX;
  if(fader1x > ftrack1high - margin)
  {
    fader1x = ftrack1high - margin;
  }
  if(fader1x < ftrack1low + margin)
  {
    fader1x = ftrack1low + margin;
  }
  image(ftrack, ftrack1x, ftrack1y, ftrackxscale, ftrackyscale);
  image(fader, fader1x, fader1y, faderxscale, faderyscale); 
  speed1 = map(fader1x, ftrack1low, ftrack1high, 0.1, 2);
  player1.speed(speed1);
 }
  if(dist(mouseX, mouseY, fader2x, fader2y) < faderxscale/2 || dist(mouseX, mouseY, fader2x, fader2y) < faderyscale/2)
 {
  fader2x = mouseX;
  if(fader2x > ftrack2high - margin)
  {
    fader2x = ftrack2high - margin;
  }
  if(fader2x < ftrack2low + margin)
  {
    fader2x = ftrack2low + margin;
  }
  image(ftrack, ftrack2x, ftrack2y, ftrackxscale, ftrackyscale);
  image(fader, fader2x, fader2y, faderxscale, faderyscale); 
  speed2 = map(fader2x, ftrack2low, ftrack2high, 0.1, 2);
  player2.speed(speed2);
 }
 
   if(dist(mouseX, mouseY, fadervx, fadervy) < faderxscale/2 || dist(mouseX, mouseY, fadervx, fadervy) < faderyscale/2)
 {
  fadervx = mouseX;
  if(fadervx > ftrackvhigh - margin)
  {
    fadervx = ftrackvhigh - margin;
  }
  if(fadervx < ftrackvlow + margin)
  {
    fadervx = ftrackvlow + margin;
  }
  image(ftrackv, ftrackvx, ftrackvy, ftrackxscale, ftrackyscale);
  image(fader, fadervx, fadervy, faderxscale, faderyscale); 
  speedv = map(fadervx, ftrackvlow, ftrackvhigh, 0.1, 2);
  }
}
