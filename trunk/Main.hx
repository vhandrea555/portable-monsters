import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.geom.Point;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.display.Sprite;
import flash.media.Sound;
import flash.ui.Keyboard;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.filters.GlowFilter;
import haxe.FastList;
import flash.events.MouseEvent;
import flash.net.SharedObject;
import flash.Lib;
import haxe.Log;

import flash.utils.Timer;
import haxe.Timer;
import flash.events.Event;
import flash.display.MovieClip;
import flash.media.SoundChannel;


//imports
import Images; 
//import Sounds; 

//Pages
import InstructionPage;
import CreditsPage;
import OptionsPage;
import PauseMenu;

//Levels

import CustomSprite;
import Kongregate;
import Logo;
import SoundPlayer;


class Main extends Sprite{
private var ground : Int;
private var currentLevel : Int;
private var damageTaken : Int;
private var difficultly : Int;
private var BaseLevels : Array<World>;

private var State : String;
private var savedData:SharedObject;
private var ContinueGameButton:Sprite;
private var StartGameButton:Sprite;
private var MainMenuButton:Sprite;
private var InstructionsButton:Sprite;
private var CreditsButton:Sprite;
private var OptionsButton:Sprite;
private var BoxyPic:CustomSprite;
private var Title:TextField;
private var myLogo : Logo;

private var label1:TextField;
private var TryAgainPic:Sprite;
private var TryAgainMenu:Sprite;
var myTimer:Timer;
var music:Sound;          
private var player:SoundPlayer;

private var BackgroundImage : Sprite;
private var StartGameDifficulty:Sprite;
private var StartGameDifficultyAdded:Bool;
public var Instruction : InstructionPage;
public var Credit: CreditsPage;
public var OptionsMenu : OptionsPage;
public var MouseImage : Sprite;
public var KeysImage : Sprite;
public var textBubble : Sprite;
public var textBubbleText : TextField;

var mKeyDown:Array<Bool>;
var pausePosition:Float;
//             music.play();
var volume:Bool;
var sound:Bool;
var framerate:Int;

var kongVar : CKongregate;
public function new(){
super();
BaseLevels = [];
//CutScences = [];
getLevelData();
//inPostion,inMoveSpeed,inJumpSpeed,inAttackSpeed,inHealth:Int
initLevels();

var txtFormat:TextFormat = new TextFormat();
txtFormat.align = TextFormatAlign.CENTER;

//Add Main to Current Flash
flash.Lib.current.addChild(this);
//Create Menu (own Class?)
Title = new TextField();
    
  Title.x = 50; Title.y = 20;
  Title.width = Constants.flashWidth-100; Title.height = Constants.flashHeight;
  Title.multiline = true;
  var myFormat:TextFormat = new TextFormat();
  myFormat.size = 25;
  myFormat.align = TextFormatAlign.CENTER;
  Title.defaultTextFormat = myFormat;
  
  Title.htmlText = "<font color='#FFFFFF'>Boxy Boxumber</font>";
  Title.selectable = false;


//It seems like there should be a better way to add a bitmap to a Sprite than filling the background with the bitmap. But this works.
StartGameButton = new Sprite();
StartGameButton.graphics.beginFill(0xFFFFFF);
StartGameButton.graphics.lineStyle(1,0x000000);
StartGameButton.graphics.drawRect(0, 0, 250 ,48);
var StartGameButtonText = new TextField();
StartGameButtonText.htmlText = "<font size='26'>"+"Start Game"+"</font>";
StartGameButtonText.width = 250;
StartGameButtonText.x = 0;
StartGameButtonText.y = 5;
StartGameButtonText.setTextFormat(txtFormat);
StartGameButtonText.selectable = false;
StartGameButtonText.mouseEnabled = false;
StartGameButton.addChild(StartGameButtonText);
StartGameButton.x = 20;
StartGameButton.y = 20;

StartGameButton.buttonMode = true;
StartGameButton.addEventListener(MouseEvent.ROLL_OVER,onStartGameHover);
StartGameButton.addEventListener(MouseEvent.ROLL_OUT,onHoverOut);
StartGameButton.addEventListener(MouseEvent.CLICK, onStartGameButtonClick);

ContinueGameButton = new Sprite();

ContinueGameButton.graphics.beginFill(0xFFFFFF);
ContinueGameButton.graphics.lineStyle(1,0x000000);
ContinueGameButton.graphics.drawRect(0, 0, 250 ,48);
var ContinueGameButtonText = new TextField();
ContinueGameButtonText.htmlText = "<font size='26'>"+"Continue Game"+"</font>";
ContinueGameButtonText.width = 250;
ContinueGameButtonText.x = 0;
ContinueGameButtonText.setTextFormat(txtFormat);
ContinueGameButtonText.y = 5;
ContinueGameButtonText.selectable = false;
ContinueGameButtonText.mouseEnabled = false;
ContinueGameButton.addChild(ContinueGameButtonText);
ContinueGameButton.x = 20;
ContinueGameButton.y = 80;

ContinueGameButton.buttonMode = true;
ContinueGameButton.addEventListener(MouseEvent.ROLL_OVER,onContinueGameHover);
ContinueGameButton.addEventListener(MouseEvent.ROLL_OUT,onHoverOut);
ContinueGameButton.addEventListener(MouseEvent.CLICK, onContinueGameButtonClick);


InstructionsButton = new Sprite();
InstructionsButton.graphics.beginFill(0x000000);
InstructionsButton.graphics.lineStyle(1,0xFFFFFF);
InstructionsButton.graphics.drawRect(0, 0, 250 ,48);
var InstructionsButtonText = new TextField();
InstructionsButtonText.htmlText = "<font size='26' color='#FFFFFF'>"+"Instructions"+"</font>";
InstructionsButtonText.width = 250;
InstructionsButtonText.x = 0;
InstructionsButtonText.setTextFormat(txtFormat);
InstructionsButtonText.y = 5;
InstructionsButtonText.selectable = false;
InstructionsButtonText.mouseEnabled = false;
InstructionsButton.addChild(InstructionsButtonText);
InstructionsButton.x = 20;
InstructionsButton.y = 0;

InstructionsButton.buttonMode = true;
InstructionsButton.addEventListener(MouseEvent.CLICK, onInstrutionsButtonClick);

Instruction = new InstructionPage();
Instruction.addEventListener("Back",onInstrutionsBack);

CreditsButton = new Sprite();
CreditsButton.graphics.beginFill(0xFFFFFF);
CreditsButton.graphics.lineStyle(1,0x000000);
CreditsButton.graphics.drawRect(0, 0, 250 ,48);
var CreditsButtonText = new TextField();
CreditsButtonText.htmlText = "<font size='14'>"+"Everything by ZeroCreativity1"+"</font>";
CreditsButtonText.width = 250;
CreditsButtonText.x = 0;
CreditsButtonText.setTextFormat(txtFormat);
CreditsButtonText.y = 5;
CreditsButtonText.selectable = false;
CreditsButtonText.mouseEnabled = false;
CreditsButton.addChild(CreditsButtonText);
CreditsButton.x = 20;
CreditsButton.y = 140;

CreditsButton.buttonMode = false;
CreditsButton.addEventListener(MouseEvent.ROLL_OVER,onCreditsHover);
CreditsButton.addEventListener(MouseEvent.ROLL_OUT,onHoverOut);
//CreditsButton.addEventListener(MouseEvent.CLICK, onCreditsButtonClick);

Credit = new CreditsPage();
Credit.addEventListener("Back",onCreditsBack);

OptionsButton = new Sprite();
OptionsButton.graphics.beginFill(0xFFFFFF);
OptionsButton.graphics.lineStyle(1,0x000000);
OptionsButton.graphics.drawRect(0, 0, 250 ,48);
var OptionsButtonText = new TextField();
OptionsButtonText.htmlText = "<font size='26'>"+"Options"+"</font>";
OptionsButtonText.width = 250;
OptionsButtonText.x = 0;
OptionsButtonText.setTextFormat(txtFormat);
OptionsButtonText.y = 5;
OptionsButtonText.selectable = false;
OptionsButtonText.mouseEnabled = false;
OptionsButton.addChild(OptionsButtonText);
OptionsButton.x = 20;
OptionsButton.y = 200;

OptionsButton.buttonMode = true;
OptionsButton.addEventListener(MouseEvent.ROLL_OVER,onOptionsHover);
OptionsButton.addEventListener(MouseEvent.ROLL_OUT,onHoverOut);
OptionsButton.addEventListener(MouseEvent.CLICK, onOptionsButtonClick);

OptionsMenu = new OptionsPage();
OptionsMenu.addEventListener("Back",onOptionsMenuBack);
OptionsMenu.addEventListener("ResetSavedData",onOptionsMenuResetSavedData);
OptionsMenu.addEventListener("VolumeToggle",onOptionsMenuVolumeToggle);
OptionsMenu.addEventListener("PrevTrack",onPrevTrack);
OptionsMenu.addEventListener("NextTrack",onNextTrack);
OptionsMenu.addEventListener("SoundEffectsToggle",onOptionsMenuSoundEffectsToggle);
//this.addEventListener(Event.ENTER_FRAME, OnEnter);
  myTimer = new Timer(12);
  myTimer.addEventListener("timer", OnEnter);
  myTimer.start();

  label1 = new TextField();

TryAgainMenu = new Sprite();
//TryAgainMenu.width = Constants.flashWidth;
TryAgainMenu.graphics.beginFill(0x000000);
TryAgainMenu.graphics.drawRect(0,0,Constants.flashWidth,Constants.flashHeight);
TryAgainMenu.graphics.endFill();
label1.width = 600;
label1.height = Constants.flashHeight;
label1.x = 25;
label1.y = 25;
label1.wordWrap = true;
label1.selectable = false;
label1.htmlText = "<font size='30' color='#FFFFFF'>" +"Play Again"  + "</font>";

TryAgainMenu.addChild(label1);


TryAgainPic = new Sprite();
TryAgainPic.graphics.beginBitmapFill(new Menu());
TryAgainPic.graphics.drawRect(0, 0, 46,52);
TryAgainPic.x = 300;
TryAgainPic.y = 75;

MainMenuButton  = new Sprite();
MainMenuButton.graphics.beginFill(0x000000);
MainMenuButton.graphics.lineStyle(1,0xFFFFFF);
MainMenuButton.graphics.drawRect(0, 0, 250 ,48);
var MainMenuButtonText = new TextField();
MainMenuButtonText.htmlText = "<font size='30' color='#FFFFFF'>"+"Main Menu"+"</font>";
MainMenuButtonText.width = 250;
MainMenuButtonText.x = 50;
MainMenuButtonText.y = 5;
MainMenuButtonText.selectable = false;
MainMenuButtonText.mouseEnabled = false;
MainMenuButton.addChild(MainMenuButtonText);
MainMenuButton.x = 200;
MainMenuButton.y = 300;
MainMenuButton.buttonMode = true;
MainMenuButton.addEventListener(MouseEvent.CLICK, onMainMenuButtonClick);

MouseImage = new Sprite();
MouseImage.graphics.beginBitmapFill(new RightClick());
MouseImage.graphics.drawRect(0, 0, 200,200);
MouseImage.x = 290;
MouseImage.y = 270;
var MouseImageText = new TextField();
MouseImageText.htmlText = "<font size='20' color='#FFFFFF'>"+"Shoot"+"</font>";
MouseImageText.width = 250;
MouseImageText.x = 70;
MouseImageText.y =180;
MouseImageText.selectable = false;
MouseImage.addChild(MouseImageText);

textBubble = new Sprite();
textBubble.graphics.beginBitmapFill(new Bubble());
textBubble.graphics.drawRect(0, 0, 250,213);
textBubble.x = 390;
textBubble.y = 40;

    textBubbleText = new TextField();
    textBubbleText.htmlText = "<font size='16' color='#000000'></font>";
    textBubbleText.autoSize = TextFieldAutoSize.CENTER;
    textBubbleText.width = 180;
    textBubbleText.wordWrap = true;
    textBubbleText.multiline = true;
    textBubbleText.selectable = false;
    textBubbleText.mouseEnabled = false;
    textBubbleText.x = 25;
    textBubble.addChild(textBubbleText);
    textBubbleText.y=25;

KeysImage = new Sprite();
KeysImage.graphics.beginBitmapFill(new Keys());
KeysImage.graphics.drawRect(0, 0, 172,116);
KeysImage.x = 450;
KeysImage.y = 320;
var KeysImageText = new TextField();
KeysImageText.htmlText = "<font size='20' color='#FFFFFF'>"+"Jump"+"</font>";
KeysImageText.width = 250;
KeysImageText.x = 62;
KeysImageText.y =-25;
KeysImageText.selectable = false;
KeysImage.addChild(KeysImageText);
var LeftText = new TextField();
LeftText.htmlText = "<font size='20' color='#FFFFFF'>"+"Left"+"</font>";
LeftText.width = 250;
LeftText.x = 10;
LeftText.y =105;
LeftText.selectable = false;
KeysImage.addChild(LeftText);
var RightText = new TextField();
RightText.htmlText = "<font size='20' color='#FFFFFF'>"+"Right"+"</font>";
RightText.width = 250;
RightText.x = 115;
RightText.y =105;
RightText.selectable = false;
KeysImage.addChild(RightText);


//The State Will determine whether to load a level, or show Main Menu, or whatever.  Used in the OnEnterEvent.
//State = "StartGame";
State = "LoadMainMenu";
// track1 = new Track1();
// track2 = new Track2();
// track3 = new Track3();
//preloader = new PreloaderHost();
BackgroundImage = new Sprite();
BackgroundImage.graphics.beginFill(0xFFFFFF);
BackgroundImage.graphics.drawRect(0,0,Constants.flashWidth,Constants.flashHeight);
BackgroundImage.graphics.endFill();

//player = new SoundPlayer(track1,track2,track3);

volume = true;
sound = true;
myLogo = new Logo();
addChild(myLogo);
try
{
kongVar = new CKongregate();
}
catch (msg:Dynamic)
{
}
mKeyDown = [];
stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown );
stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp );
//preloader.addEventListener(Event.ENTER_FRAME, OnMovieEnter);
}

public function OnKeyUp (event:KeyboardEvent)
    {
      mKeyDown[event.keyCode] = false;
      //lastUp = event.keyCode;
    }

public function OnKeyDown(event:KeyboardEvent)
   {
      // When a key is held down, multiple KeyDown events are generated.
      // This check means we only pick up the first one.
      if (!mKeyDown[event.keyCode])
      {
         // Store for use in game
         mKeyDown[event.keyCode] = true;
	  //I do this here, because if they hold down P,
	 // it won't pause and unpause constantly.
	  if(mKeyDown[ 77 ] == true)
	  {
	    volume = !volume;
	    BaseLevels[currentLevel-1].pauseMenu.renderVolume(volume);
	  }
      }
  }

function loadMenu()
{
  addChild(BackgroundImage);
  addChild(Title);
  addChild(StartGameButton);
  addChild(ContinueGameButton);
  //addChild(InstructionsButton);
  addChild(CreditsButton);
// addChild(OptionsButton);
//   addChild(BoxyPic);
//   addChild(textBubble);
//   addChild(MouseImage);
//   addChild(KeysImage);
}
function removeMenu()
{
  removeChild(Title);
  removeChild(StartGameButton);
  removeChild(ContinueGameButton);
  removeChild(BackgroundImage);
  //removeChild(InstructionsButton);
  removeChild(CreditsButton);
 // removeChild(OptionsButton);
//   removeChild(BoxyPic);
//   removeChild(textBubble);
//   removeChild(MouseImage);
//   removeChild(KeysImage);
  if(StartGameDifficultyAdded)
    {removeChild(StartGameDifficulty);StartGameDifficultyAdded=false;}
}

//Change to stat Menu
function loadTryAgainMenu(text:String)
{
  try
  {
    
  }
  catch(msg: Dynamic) 
  {
    
  }
  addChild(TryAgainMenu);
  addChild(MainMenuButton);
  //addChild(TryAgainPic);
  //player.stop();
}
function removeTryAgainMenu()
{
 removeChild(TryAgainMenu);
 removeChild(MainMenuButton);
 //removeChild(TryAgainPic);
}
function initLevels()
{
  BaseLevels[currentLevel-1] = new World();
}

function OnEnter(e:flash.events.Event)
{
if(player !=null)
  {
      if(!volume)
      {
	 pausePosition = player.getPosition();
         player.stop();         
      }
      else
      {
        player.play(pausePosition);
      }
  }
if(State == "LoadMainMenu")
{
 loadMenu();
 State = "MainMenu";
}
if(State == "MainMenu" )
   {
     return;
   }
if(State == "TryAgain")
  {
    AnimateTryAgainPic();
    return;
  }
if(State == "InitLoad")
  {
   
//     addChild(preloader);
//     preloader.play();
    State = "InitLoading";
  }
if(State == "InitLoading")
   { 
initLevels();
    //Always Playing. Possible error with swfmill
    //Skipping for now.
 
//     if(!preloader.playing)
//        {
//         preloader.stop();
//         removeChild(preloader);
        State = "LoadingLogo";
	myLogo.start();
//        }

   }
if(State == "LoadingLogo")
  {

     if(!myLogo.play())
     {
       State = "LoadMainMenu";
     }
  }
if(State == "StartGame")
   {
    //player.play(pausePosition);
    currentLevel =1;
    loadCurrentLevel(false);
   }
if(State == "ContinueGame")
   {
    //player.play(pausePosition);
    loadCurrentLevel(true);
   }
if(State == "Playing")
   {
    if(BaseLevels[currentLevel-1] != null)
    {
      if(!volume)
      {
	 pausePosition = player.getPosition();
         player.stop();
         
      }
      else
      {
        player.play(pausePosition);
      }
      return;
//       else
//       { 
//       
//           try
//           {
//           //kongVar.SubmitStat("Won",1);
//           }
//           catch(msg: Dynamic) 
// 	  {
//            
//           }
//        
//       loadTryAgainMenu("Try Again?");
//       State = "TryAgain";
//       return;
//       } 
        
    }
   }
// try
// {
// //             var req:flash.net.URLRequest = new flash.net.URLRequest("http://av.adobe.com/podcast/csbu_dev_podcast_epi_2.mp3");
// //             
// //             Sound.load(req);
// var music = new BackgroundMusic();            
//             music.play();
// }
// catch (err:flash.Error)
// {
// trace(err.message);
// }


}
public function AnimateTryAgainPic()
{
var randomNumber = Std.random(24);
if(randomNumber == 1)
  TryAgainPic.x = TryAgainPic.x + 5;
if(randomNumber == 2)
  TryAgainPic.x = TryAgainPic.x - 5;

}

public function loadCutScence() : Bool
{
  State="CutScence";

  return true;
}
//Loads Level based on Current Level
public function loadCurrentLevel(inContinue:Bool) : Bool
{
  State = "Playing";
  if(currentLevel > BaseLevels.length)
    {State="TryAgain";loadTryAgainMenu("YOU WON");}
  BaseLevels[currentLevel-1].addEventListener("Won",onLevelFinished);
  BaseLevels[currentLevel-1].addEventListener("LevelQuit",onLevelQuit);
  BaseLevels[currentLevel-1].addEventListener("VolumeToggle",onBaseLevelVolumeToggle);
  BaseLevels[currentLevel-1].addEventListener("PrevTrack",onPrevTrack);
  BaseLevels[currentLevel-1].addEventListener("NextTrack",onNextTrack);

  State = "Playing";
//Level1.Load();
  BaseLevels[currentLevel-1].Load(inContinue,volume,kongVar);
// BaseLevels[currentLevel-1].pauseMenu.renderVolume(volume);
// BaseLevels[currentLevel-1].pauseMenu.renderSoundEffects(sound);
// BaseLevels[currentLevel-1].addEventListener("SoundEffectsToggle",onBaseLevelSoundEffectsToggle);
   return true;
}


public function getLevelData()
{
  currentLevel = 1;
  pausePosition = 0;
  damageTaken = 0;
  difficultly = 2;
  //Load Save Data
  savedData = SharedObject.getLocal("LevelData");
  if(savedData.data.Level != null)
  {
    currentLevel = savedData.data.Level;
    pausePosition = savedData.data.SoundPosition;
    damageTaken = savedData.data.damageTaken;
    difficultly = savedData.data.difficultly;
  }
}
public function removeClip(preloader)
{
 removeChild(preloader);
}
private function onStartGameButtonClick(event:MouseEvent) {
removeMenu();
State = "StartGame";
}
private function onEasyGameButtonClick(event:MouseEvent)
{
removeMenu();
State = "StartGame";
savedData.data.Level = 1;
savedData.data.damageTaken = 0;
savedData.data.difficultly = 1;
}

private function onMediumGameButtonClick(event:MouseEvent)
{
removeMenu();
State = "StartGame";
savedData.data.Level = 1;
savedData.data.damageTaken = 0;
savedData.data.difficultly = 2;
}

private function onHardGameButtonClick(event:MouseEvent)
{
removeMenu();
State = "StartGame";
savedData.data.Level = 1;
savedData.data.damageTaken = 0;
savedData.data.difficultly = 3;
}

private function onContinueGameButtonClick(event:MouseEvent) {
removeMenu();
State = "ContinueGame";
}

//Hover Texts
 private function onStartGameHover(event:MouseEvent)
  {
    textBubbleText.htmlText = "<font size='16' color='#000000'>This will erase saved game information</font>";
    
  }

private function onContinueGameHover(event:MouseEvent)
{
    textBubbleText.htmlText = "<font size='16' color='#000000'>Continue an Existing Game</font>";
}

private function onOptionsHover(event:MouseEvent)
{
    textBubbleText.htmlText = "<font size='16' color='#000000'>Disable Sound or Reset Saved Data</font>";
    textBubbleText.autoSize = TextFieldAutoSize.CENTER;
}
private function onCreditsHover(event:MouseEvent)
{
    textBubbleText.htmlText = "<font size='16' color='#000000'>This is where I give people credit for making the game. Mostly me.</font>";
    textBubbleText.autoSize = TextFieldAutoSize.CENTER;
}


private function onEasyGameHover(event:MouseEvent)
{
    textBubbleText.htmlText = "<font size='16' color='#000000'>You have 20 health and enemies have 5 health. It will be a piece of cake</font>";
    textBubbleText.autoSize = TextFieldAutoSize.CENTER;
}


private function onMediumGameHover(event:MouseEvent)
{
    textBubbleText.htmlText = "<font size='16' color='#000000'>You have 10 health and enemies have 10 health. This may take some effort</font>";
    textBubbleText.autoSize = TextFieldAutoSize.CENTER;
}

private function onHardGameHover(event:MouseEvent)
{
    textBubbleText.htmlText = "<font size='16' color='#000000'>You have 8 health and enemies have 15 health.  Only for the Hard Core gamers.</font>";
    textBubbleText.autoSize = TextFieldAutoSize.CENTER;
}

private function onHoverOut(event:MouseEvent)
{	
  textBubbleText.htmlText = "<font size='16' color='#000000'>I'm Boxy!</font>";
}


private function onLevelFinished(event:Event)
{
  removeLevelEventListeners();
  State = "InitLoading";
}

private function onLevelQuit(event:Event)
{
  removeLevelEventListeners();
  State = "InitLoading";
}

private function removeLevelEventListeners()
{
  BaseLevels[currentLevel-1].removeEventListener("LevelFinished",onLevelFinished);
  BaseLevels[currentLevel-1].removeEventListener("LevelQuit",onLevelQuit);
  BaseLevels[currentLevel-1].removeEventListener("PrevTrack",onPrevTrack);
  BaseLevels[currentLevel-1].removeEventListener("NextTrack",onNextTrack);
}

private function removeCutScencesEventListeners()
{
  //CutScences[currentLevel-1].removeEventListener("LevelFinished",onLevelFinished);
}
private function onMainMenuButtonClick(event:MouseEvent) {
removeTryAgainMenu();
State = "LoadMainMenu";
}
private function onInstrutionsButtonClick(event:MouseEvent) {
removeMenu();
addChild(Instruction);
}

private function onCreditsButtonClick(event:MouseEvent) {
removeMenu();
addChild(Credit);
}

private function onOptionsButtonClick(event:MouseEvent) {
removeMenu();
addChild(OptionsMenu);
OptionsMenu.renderVolume(volume);

//OptionsMenu.renderSoundEffects(sound);
}

private function onInstrutionsBack(event:InstructionPageEvent)
{
removeChild(Instruction);
loadMenu();
}

private function onOptionsMenuBack(event:OptionsPageEvent)
{
removeChild(OptionsMenu);
loadMenu();
}
private function onPrevTrack(event:Event)
{
  if(volume && player != null)
    {player.getPrevTrack();}
}
private function onNextTrack(event:Event)
{
  if(volume && player != null)
    {player.getNextTrack();}
}

private function onOptionsMenuVolumeToggle(event:OptionsPageEvent)
{
volume = !volume;
OptionsMenu.renderVolume(volume);
}
private function onOptionsMenuSoundEffectsToggle(event:OptionsPageEvent)
{
sound = !sound;
OptionsMenu.renderSoundEffects(sound);
}

private function onBaseLevelVolumeToggle(event:PauseMenuEvent)
{
volume = !volume;
BaseLevels[currentLevel-1].volume = volume;
BaseLevels[currentLevel-1].pauseMenu.renderVolume(volume);
}
private function onBaseLevelSoundEffectsToggle(event:PauseMenuEvent)
{
sound = !sound;
//BaseLevels[currentLevel-1].sound = sound;
//BaseLevels[currentLevel-1].pauseMenu.renderSoundEffects(sound);
}
private function onOptionsMenuResetSavedData(event:OptionsPageEvent)
{
      savedData.data.Level = 1;
      savedData.data.SoundPosition = 0;
      savedData.data.damageTaken = 0;
      savedData.data.difficultly = 2;
      savedData.flush();
      getLevelData();
      pausePosition = 0;
      currentLevel = 1;
}
private function onCreditsBack(event:CreditsPageEvent)
{
removeChild(Credit);
loadMenu();
}

//Couldn't get preloader to work.
	    static function onEnterFrame(event : Event)
	    {
		LoadingBar.graphics.beginFill(0x0000FF);
		LoadingBar.graphics.drawRect(1,1,(Lib.current.root.loaderInfo.bytesLoaded/Lib.current.root.loaderInfo.bytesTotal)*498,48);
		LoadingBar.graphics.endFill();
	        if (Lib.current.root.loaderInfo.bytesLoaded >= Lib.current.root.loaderInfo.bytesTotal)
	        {
	            Lib.current.root.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	           // Lib.current.gotoAndStop("start");
                  // new Images();
		  removeLoadingBar();
	          
		  try
		  {
		    var mainInstance:Main = new Main();
		  }
		  catch (err:flash.Error)
		  {
		    trace(err.message);
		  }
	        }
	    }
private static var LoadingBar:Sprite;
public static function removeLoadingBar()
{
  flash.Lib.current.removeChild(LoadingBar);
}
public static function addLoadingBar()
{
  LoadingBar = new Sprite();
  LoadingBar.graphics.beginFill(0x000000);
  LoadingBar.graphics.drawRect(0,0,500,50);
  LoadingBar.graphics.endFill();
  flash.Lib.current.addChild(LoadingBar);
  LoadingBar.x = 50; LoadingBar.y = 225;
}
    static function main() {
// Log.trace("Starting preloader");
    addLoadingBar();
  Lib.current.root.addEventListener(Event.ENTER_FRAME, onEnterFrame);
      // Create the request object...
//       var loader = new flash.display.Loader();
//       // When the image is ready, instanciate the game class...
//       loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,
//           function(_) { new Main(untyped loader.content.bitmapData); });
//       // Fire off the request and wait...
//       loader.load(new flash.net.URLRequest("img/file.gif"));
        //new Main();    
      
	
    }
}