
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import flash.geom.Point;
import flash.geom.Rectangle;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import flash.utils.Timer;
import flash.ui.Keyboard;

import haxe.Timer;

import Images;
import AttackButton;
import MonsterButton;
import ItemButton;

class BattleScreenEvent extends Event{
	public var Won:Bool;
	public function new(customEventString:String,inWon:Bool){
        Won = inWon;
	super(customEventString, true, false);

    }
}

class BattleScreen extends Sprite{
private var myTimer:Timer;
public var isRandomBattle:Bool;

public var PlayerAvatar:Int;
public var OpponentAvatar:Int;

public var Trainer1:Trainer;
public var Trainer2:Trainer;
public var Monster1Health:Sprite;
public var Monster2Health:Sprite;
public var OpponentMonstersLeft:TextField;
public var RandomMonster:Monster;

public var State:String;
public var BattleVSScreen:Sprite;
public var BattleVSScreenTime:Int;
public var BattleField:Sprite;

public var AttackMenu:Sprite;
public var AttackPage:Int;
public var PrevAttackPage:Sprite;
public var NextAttackPage:Sprite;


public var MonsterMenu:Sprite;
public var MonsterMenuTitle:TextField;

public var ItemMenu:Sprite;
public var ItemPage:Int;
public var PrevItemPage:Sprite;
public var NextItemPage:Sprite;
public var currentItem:String;
public var ItemState:String;
public var ItemDisabledBackground:Sprite;
public var ItemConfirmBackground:Sprite;
public var ItemYes:Sprite;
public var ItemNo:Sprite;
public var ItemConfirm:TextField;

public var WikiButton:Sprite;
public var WikiScreen:Sprite;
public var MonsterWiki:MnstrWikiMenu;

public var RunAway:Sprite;
public var RunAwayYes:Sprite;
public var RunAwayNo:Sprite;
public var RunAwayState:String;
public var RunAwayPrompt:TextField;


public var BattleFieldMenu:Sprite;
public var BattleFieldFight:TextField;
public var BattleFieldItem:TextField;
public var BattleFieldSwitch:TextField;
public var BattleFieldFlee:TextField;
public var ActionLocation:Int;
private var mKeyDown:Array<Bool>;
private var _stage:Dynamic;

private var _VSBitmapData:BitmapData;
private var _VSBitmap:Bitmap;
private var _VSMap:Array<Array<Int>>;

private var _BattleBitmapData:BitmapData;
private var _BattleBitmap:Bitmap;
private var _BattleMap:Array<Array<Int>>;

  private static inline var MAX_TILE_SIZE:Int = 64;
  private var MAP_COLUMNS:Int;
  private var MAP_ROWS:Int;
  private var _tileSheetBitmapData:BattleSprites;

private var FinishedScreen:Sprite;
private var FinishedAvatar:Sprite;
private var FinishedText:TextField;
private var Continue:Sprite;

public var Won:Bool;

public function new(stage:Dynamic,inRandomMonster:Monster,inTrainer1:Trainer,inTrainer2:Trainer){
super();
Trainer1 = inTrainer1;
Trainer2 = inTrainer2;
Won = false;

AttackPage = 1;
ItemPage = 1;
isRandomBattle = (inRandomMonster != null);
if(isRandomBattle)
{
  RandomMonster = inRandomMonster;
  RandomMonster.LevelUp();
}

  flash.Lib.current.addChild(this);
  this._stage = stage;
  mKeyDown = [];
  MAP_COLUMNS = 5;
  MAP_ROWS = 5;

_tileSheetBitmapData = new BattleSprites();
setupVSMap();

  _VSBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          MAP_ROWS * MAX_TILE_SIZE, true, 0);
  _VSBitmap = new Bitmap(_VSBitmapData);
  buildMap(_VSMap,_VSBitmapData);

   _BattleMap = [ 
	  [-1,-1,-1,-1,getOpponentMonster().getTileNumber(false)],
	  [-1,-1,-1,-1,-1],
	  [-1,-1,-1,-1,-1],
	  [TrainerTileNumber(),-1,-1,-1,-1],
	  [-1,-1,-1,-1,-1]
	 ];

  _BattleBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          (MAP_ROWS-1) * MAX_TILE_SIZE, true, 0);
  _BattleBitmap = new Bitmap(_BattleBitmapData);
  buildMap(_BattleMap,_BattleBitmapData);

// myTimer = new Timer(12);
//   myTimer.addEventListener("timer", OnEnter);
//   myTimer.start();
  BattleVSScreen = new Sprite();
  BattleVSScreen.graphics.beginFill(0xFFFFFF);
  BattleVSScreen.graphics.lineStyle(5);
  BattleVSScreen.graphics.drawRect(0,0,320,320);
  BattleVSScreen.x = 150;BattleVSScreen.y=75;
  BattleVSScreen.graphics.endFill();
  BattleVSScreen.addChild(_VSBitmap);

  BattleField = new Sprite();
  BattleField.graphics.beginFill(0xFFFFFF);
  BattleField.graphics.lineStyle(5);
  BattleField.graphics.drawRect(0,0,320,256);
  BattleField.graphics.endFill();
  BattleField.x = 150;BattleField.y = 139;
  BattleField.addChild(_BattleBitmap);
  BattleFieldMenu = new Sprite();
  BattleFieldMenu.graphics.beginFill(0xFFFFFF);
  BattleFieldMenu.graphics.lineStyle(2);
  BattleFieldMenu.graphics.drawRect(0,0,316,73);
  BattleFieldMenu.x = 2;BattleFieldMenu.y = 249;
  BattleFieldMenu.graphics.endFill();

  BattleFieldFight = new TextField();
  BattleFieldFight.htmlText = "<font size='20'>[ ]FIGHT</font>";
  BattleFieldFight.selectable = false;
  BattleFieldMenu.addChild(BattleFieldFight);


  BattleFieldItem = new TextField();
  BattleFieldItem.htmlText = "<font size='20'>[ ]ITEM</font>";
  BattleFieldItem.selectable = false;
  BattleFieldMenu.addChild(BattleFieldItem);
  BattleFieldItem.x = 150;
  

  BattleFieldSwitch = new TextField();
  BattleFieldSwitch.htmlText = "<font size='20'>[ ]SWITCH</font>";
  BattleFieldSwitch.selectable = false;
  BattleFieldMenu.addChild(BattleFieldSwitch);
  BattleFieldSwitch.y = 30;

  BattleFieldFlee = new TextField();
  BattleFieldFlee.htmlText = "<font size='20'>[ ]FLEE</font>";
  BattleFieldFlee.selectable = false;
  BattleFieldMenu.addChild(BattleFieldFlee);
  //BattleField.addChild(BattleFieldMenu);
  BattleFieldFlee.x = 150;
  BattleFieldFlee.y = 30;

  ActionLocation = 1;
  getActionText();
  addChild(BattleVSScreen);
  this.addEventListener(Event.ENTER_FRAME, OnEnter);
  _stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown );
  _stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp );

  PrevAttackPage = new Sprite();
  var PrevAttackPageText = new TextField();
  PrevAttackPageText.htmlText = "<font size='14'>Prev</font>";
//
this.addChild(PrevAttackPageText);
PrevAttackPageText.width = 70;
PrevAttackPageText.autoSize = TextFieldAutoSize.CENTER;
PrevAttackPageText.selectable = false;
PrevAttackPageText.mouseEnabled = false;
PrevAttackPage.buttonMode = true;
PrevAttackPage.addChild(PrevAttackPageText);
PrevAttackPage.addEventListener(MouseEvent.CLICK, onPrevAttackPageClick);
PrevAttackPage.graphics.beginFill(0xFFFFFF);
PrevAttackPage.graphics.lineStyle(1);
PrevAttackPage.graphics.drawRect(0,0,70,32);
PrevAttackPage.graphics.endFill();
PrevAttackPage.y = 512-32;

NextAttackPage = new Sprite();
  var NextAttackPageText = new TextField();
  NextAttackPageText.htmlText = "<font size='14'>Next</font>";
//
this.addChild(NextAttackPageText);
NextAttackPageText.width = 70;
NextAttackPageText.autoSize = TextFieldAutoSize.CENTER;
NextAttackPageText.selectable = false;
NextAttackPageText.mouseEnabled = false;
NextAttackPage.buttonMode = true;
NextAttackPage.addChild(NextAttackPageText);
NextAttackPage.addEventListener(MouseEvent.CLICK, onNextAttackPageClick);
NextAttackPage.graphics.beginFill(0xFFFFFF);
NextAttackPage.graphics.lineStyle(1);
NextAttackPage.graphics.drawRect(0,0,70,32);
NextAttackPage.graphics.endFill();
NextAttackPage.y = 512-32;NextAttackPage.x = 72;


  PrevItemPage = new Sprite();
  var PrevItemPageText = new TextField();
  PrevItemPageText.htmlText = "<font size='14'>Prev</font>";
//
this.addChild(PrevItemPageText);
PrevItemPageText.width = 70;
PrevItemPageText.autoSize = TextFieldAutoSize.CENTER;
PrevItemPageText.selectable = false;
PrevItemPageText.mouseEnabled = false;
PrevItemPage.buttonMode = true;
PrevItemPage.addChild(PrevItemPageText);
PrevItemPage.addEventListener(MouseEvent.CLICK, onPrevItemPageClick);
PrevItemPage.graphics.beginFill(0xFFFFFF);
PrevItemPage.graphics.lineStyle(1);
PrevItemPage.graphics.drawRect(0,0,70,32);
PrevItemPage.graphics.endFill();
PrevItemPage.y = 512-32;

  NextItemPage = new Sprite();
  var NextItemPageText = new TextField();
  NextItemPageText.htmlText = "<font size='14'>Next</font>";
//
  NextItemPage.addChild(NextItemPageText);
  NextItemPageText.width = 70;
  NextItemPageText.autoSize = TextFieldAutoSize.CENTER;
  NextItemPageText.selectable = false;
  NextItemPageText.mouseEnabled = false;
  NextItemPage.buttonMode = true;
  NextItemPage.addChild(NextItemPageText);
  NextItemPage.addEventListener(MouseEvent.CLICK, onNextItemPageClick);
  NextItemPage.graphics.beginFill(0xFFFFFF);
  NextItemPage.graphics.lineStyle(1);
  NextItemPage.graphics.drawRect(0,0,70,32);
  NextItemPage.graphics.endFill();
  NextItemPage.y = 512-32;NextItemPage.x = 72;


RunAwayState = "";
RunAway = new Sprite();
RunAway.mouseChildren = true;
var RunAwayText = new TextField();

RunAwayText.autoSize = TextFieldAutoSize.CENTER;
RunAwayText.width = 316;
RunAwayText.selectable = false;
RunAwayText.mouseEnabled = false;
RunAway.addChild(RunAwayText);
if(isRandomBattle)
{
RunAwayText.htmlText = "<font size='22'>Run Away!</font>";
RunAway.addEventListener(MouseEvent.CLICK, onRunAwayClick);
RunAway.buttonMode = true;

  RunAway.graphics.beginFill(0xFFFFFF);
  RunAway.graphics.lineStyle(1);
  RunAway.graphics.drawRect(0,0,316,115);
  RunAway.graphics.endFill();
  RunAway.x =152;RunAway.y = 512-115;
}
else
{
RunAwayText.htmlText = "<font size='22'>Can't Run Away</font>";

  RunAway.graphics.beginFill(0x8C8C8C);
  RunAway.graphics.lineStyle(1);
  RunAway.graphics.drawRect(0,0,316,115);
  RunAway.graphics.endFill();
  RunAway.x =152;RunAway.y = 512-115;
}

WikiScreen = new Sprite();
WikiScreen.graphics.beginFill(0xFFFFFF);
  WikiScreen.graphics.lineStyle(1);
  WikiScreen.graphics.drawRect(0,0,640,512);
  WikiScreen.graphics.endFill();
  WikiScreen.x =0;WikiScreen.y = 0;

WikiButton = new Sprite();
WikiButton.mouseChildren = true;
var WikiButtonText = new TextField();
WikiButtonText.htmlText = "<font size='22'>Wiki</font>";
WikiButtonText.autoSize = TextFieldAutoSize.CENTER;
WikiButtonText.width = 20;
WikiButtonText.selectable = false;
WikiButtonText.mouseEnabled = false;
WikiButton.addChild(WikiButtonText);
WikiButton.addEventListener(MouseEvent.CLICK, onWikiButtonClick);
WikiButton.buttonMode = true;
  WikiButton.graphics.beginFill(0xFFFFFF);
  WikiButton.graphics.lineStyle(1);
  WikiButton.graphics.drawRect(0,0,75,50);
  WikiButton.graphics.endFill();
  WikiButton.x =392;WikiButton.y = 512-50;

MonsterWiki = new MnstrWikiMenu();

  MonsterWiki.addEventListener("Back",onBack);


  RunAwayPrompt = new TextField();
  RunAwayPrompt.htmlText = "<font size='14'>Are you sure?</font>";
  RunAwayPrompt.autoSize = TextFieldAutoSize.CENTER;
  RunAwayPrompt.width = 302;
  RunAwayPrompt.selectable = false;
  RunAwayPrompt.mouseEnabled = false;
  RunAwayPrompt.y = 35;
//

  RunAwayYes = new Sprite();
  var RunAwayYesText = new TextField();
  RunAwayYesText.htmlText = "<font size='14'>Yes</font>";

  RunAwayYes.addChild(RunAwayYesText);
  RunAwayYesText.width = 70;
  RunAwayYesText.autoSize = TextFieldAutoSize.CENTER;
  RunAwayYesText.selectable = false;
  RunAwayYesText.mouseEnabled = false;
  RunAwayYes.buttonMode = true;
  RunAwayYes.addChild(RunAwayYesText);
  RunAwayYes.addEventListener(MouseEvent.CLICK, onRunAwayYesClick);
  RunAwayYes.graphics.beginFill(0xFFFFFF);
  RunAwayYes.graphics.lineStyle(1);
  RunAwayYes.graphics.drawRect(0,0,70,32);
  RunAwayYes.graphics.endFill();
  RunAwayYes.y = 70;
  RunAwayYes.x = 80;

  RunAwayNo = new Sprite();
RunAwayNo.mouseChildren = false;
  var RunAwayNoText = new TextField();
  RunAwayNoText.htmlText = "<font size='14'>No</font>";
//
  RunAwayNo.addChild(RunAwayNoText);
  RunAwayNoText.width = 70;
  RunAwayNoText.autoSize = TextFieldAutoSize.CENTER;
  RunAwayNoText.selectable = false;
  RunAwayNoText.mouseEnabled = false;
  RunAwayNo.buttonMode = true;
  RunAwayNo.addChild(RunAwayNoText);
  RunAwayNo.addEventListener(MouseEvent.CLICK, onRunAwayNoClick);
  RunAwayNo.graphics.beginFill(0xFFFFFF);
  RunAwayNo.graphics.lineStyle(1);
  RunAwayNo.graphics.drawRect(0,0,70,32);
  RunAwayNo.graphics.endFill();
  RunAwayNo.y = 70;RunAwayNo.x = 166;


  FinishedScreen = new Sprite();
  FinishedScreen.graphics.beginFill(0xFFFFFF);
  FinishedScreen.graphics.lineStyle(5);
  FinishedScreen.graphics.drawRect(0,0,320,320);
  FinishedScreen.x = 150;FinishedScreen.y=75;
  FinishedScreen.graphics.endFill();
  FinishedAvatar = new CustomSprite();
  FinishedAvatar.graphics.drawRect(0,0,64,64);
  FinishedAvatar.graphics.endFill(); 
  var tileSheetColumn:Int = 1;
  var tileSheetRow:Int = 1;
  var sourceRectangle:Rectangle = new Rectangle
  (tileSheetColumn * 64, tileSheetRow * 64, 64,64);
		    
  var destinationPoint:Point = new Point(0, 0);
  var modelBitmapData = new BitmapData(64, 64, true, 0);
    modelBitmapData.copyPixels
    (
      new BattleSprites(), 
      sourceRectangle, 
      destinationPoint,
      null, null, true
    );
  var resizeBitmapData = HelperMethods.resize(64,64,modelBitmapData);
  var modelBitmap = new Bitmap(resizeBitmapData);
  FinishedAvatar.addChild(modelBitmap);
  FinishedScreen.addChild(FinishedAvatar);
  FinishedAvatar.y = 50;
  //FinishedScreen.ad
  FinishedText = new TextField();

  FinishedText.htmlText = "<font size='14'>You Won!</font>";
  FinishedScreen.addChild(FinishedText);
  FinishedText.width = 70;
FinishedText.x = 0;
  FinishedText.autoSize = TextFieldAutoSize.LEFT;
  FinishedText.selectable = false;
  FinishedText.mouseEnabled = false;
  Continue = new Sprite();
  Continue.mouseChildren = false;
  var ContinueText = new TextField();
  ContinueText.htmlText = "<font size='14'>Continue</font>";
//
  Continue.addChild(ContinueText);
  ContinueText.width = 70;
  ContinueText.autoSize = TextFieldAutoSize.CENTER;
  ContinueText.selectable = false;
  ContinueText.mouseEnabled = false;
  Continue.buttonMode = true;
  Continue.addChild(ContinueText);
  Continue.addEventListener(MouseEvent.CLICK, onContinueClick);
  Continue.graphics.beginFill(0xFFFFFF);
  Continue.graphics.lineStyle(1);
  Continue.graphics.drawRect(0,0,70,32);
  Continue.graphics.endFill();
  Continue.y = 281;Continue.x = 320-77;
  FinishedScreen.addChild(Continue);

  
  this.addEventListener("Attack",onAttack);
  this.addEventListener("Item",onItem);
  this.addEventListener("Monster",onMonsterSelected);

  BattleVSScreenTime = 0;
  State = "WaitForBattleVS";
}

private function setupVSMap()
{
  if(isRandomBattle)
  {
    _VSMap = [ 
	  [-1,-1,-1,-1,getOpponentMonster().getTileNumber(false)],
	  [-1,-1,-1,-1,-1],
	  [-1,-1,0100,-1,-1],
	  [-1,-1,-1,-1,-1],
	  [Trainer1.CurrentMonster.getTileNumber(true),-1,-1,-1,-1]
	 ];
  }
  else
  {
    _VSMap = [ 
	  [-1,-1,-1,-1,Trainer2.AvatarTile],
	  [-1,-1,-1,-1,-1],
	  [-1,-1,0100,-1,-1],
	  [-1,-1,-1,-1,-1],
	  [Trainer1.AvatarTile,-1,-1,-1,-1]
	 ];
  }
}
private function drawField()
{
MonsterMenu = new Sprite();
addChild(MonsterMenu);
addChild(BattleField);
drawAttackMenu(AttackPage);
  
drawMonstersHealth();
drawMonsterMenu();

drawItemMenu(ItemPage);
addChild(RunAway);
addChild(WikiButton);
}

public function getStatus(monster:Monster):String
{
  var Status = "";
  if(monster.Poisoned)
  {
    Status += "PSN ";
  }
  if(monster.Burned)
  {
    Status += "BRN ";
  }
  if(monster.Encase > 0)
  {
    Status += "ENC ";
  }
  if(monster.Protect > 0)
  {
    Status += "PRT ";
  }
  if(monster.Charged > 0)
  {
    Status += "CHR ";
  }
  if(monster.Seeded )
  {
    Status += "SEED ";
  }
  return Status;
}
private function drawMonstersHealth()
{
var monstersLeft = 0;
var opponentMonsters = getOpponentMonsters();
if(opponentMonsters != null)
{
  for(monster in getOpponentMonsters())
  {
    if(monster.Health > 0)
    {
      monstersLeft++;
    }
  }
}
//RunAway.addChild(OpponentMonstersLeft);
  Monster1Health = new Sprite();
  Monster1Health.graphics.beginFill(0x000000);
  Monster1Health.graphics.drawRect(0,0,200,32);
  Monster1Health.graphics.endFill();
  Monster1Health.graphics.beginFill(0x0000FF);
  Monster1Health.graphics.drawRect(1,1,198*(Trainer1.CurrentMonster.Health/Trainer1.CurrentMonster.MaxHealth),30);
  Monster1Health.graphics.endFill();
 
  var Monster1StatusText = new TextField();
  var Status = getStatus(Trainer1.CurrentMonster);

  Monster1StatusText.htmlText = "<font size='14' >" + Status +  "</font>";
  //
  Monster1Health.addChild(Monster1StatusText);
  Monster1StatusText.width = 200;
  Monster1StatusText.y = -30;
  Monster1StatusText.autoSize = TextFieldAutoSize.LEFT;
  Monster1StatusText.selectable = false;
  Monster1StatusText.mouseEnabled = false;

  var Monster1HealthText = new TextField();
  Monster1HealthText.htmlText = "<font size='22' color='#FFFFFF'>"+Trainer1.CurrentMonster.Health+"/" + Trainer1.CurrentMonster.MaxHealth +   "</font>";
  //
  Monster1Health.addChild(Monster1HealthText);
  Monster1HealthText.width = 200;
  Monster1HealthText.y = 0;
  Monster1HealthText.autoSize = TextFieldAutoSize.RIGHT;
  Monster1HealthText.selectable = false;
  Monster1HealthText.mouseEnabled = false;


  Monster1Health.x = 85;
  Monster1Health.y = 64*3+16;
  var Monster1LevelText = new TextField();
  Monster1LevelText.htmlText = "<font size='14' >"+"Level: " + Trainer1.CurrentMonster.Level +  "</font>";
  //
  Monster1Health.addChild(Monster1LevelText);
  Monster1LevelText.width = 200;
  Monster1LevelText.y = -20;
  Monster1LevelText.autoSize = TextFieldAutoSize.LEFT;
  Monster1LevelText.selectable = false;
  Monster1LevelText.mouseEnabled = false;
  Monster1Health.x = 85;
  Monster1Health.y = 64*3+16;

 
  BattleField.addChild(Monster1Health);

  Monster2Health = new Sprite();
  Monster2Health.graphics.beginFill(0x000000);
  Monster2Health.graphics.drawRect(0,0,200,32);
  Monster2Health.graphics.endFill();
  Monster2Health.graphics.beginFill(0x0000FF);
  Monster2Health.graphics.drawRect(1,1,198*(getOpponentMonster().Health/getOpponentMonster().MaxHealth),30);
  Monster2Health.graphics.endFill();

  var Monster2StatusText = new TextField();
  var Status = getStatus(getOpponentMonster());

  Monster2StatusText.htmlText = "<font size='14' >" + Status +  "</font>";
  //
  Monster2Health.addChild(Monster2StatusText);
  Monster2StatusText.width = 200;
  Monster2StatusText.y = 30;
  Monster2StatusText.autoSize = TextFieldAutoSize.LEFT;
  Monster2StatusText.selectable = false;
  Monster2StatusText.mouseEnabled = false;

  var Monster2HealthText = new TextField();
  Monster2HealthText.htmlText = "<font size='22' color='#FFFFFF'>"+getOpponentMonster().Health+"/" + getOpponentMonster().MaxHealth +   "</font>";
  //
  Monster2Health.addChild(Monster2HealthText);
  Monster2HealthText.width = 200;
  Monster2HealthText.y = 0;
  Monster2HealthText.autoSize = TextFieldAutoSize.RIGHT;
  Monster2HealthText.selectable = false;
  Monster2HealthText.mouseEnabled = false;

  var Monster2LevelText = new TextField();
  Monster2LevelText.htmlText = "<font size='14' >"+"Level: " + getOpponentMonster().Level+ if (monstersLeft > 0)  " Monsters Left: " + Std.string(monstersLeft) else "" +  "</font>";
  //
  Monster2Health.addChild(Monster2LevelText);
  Monster2LevelText.width = 200;
  Monster2LevelText.y = -20;
  Monster2LevelText.autoSize = TextFieldAutoSize.LEFT;
  Monster2LevelText.selectable = false;
  Monster2LevelText.mouseEnabled = false;
  Monster2Health.x = 21;
  Monster2Health.y = 20;
 
  BattleField.addChild(Monster2Health);
}
private function drawMonsterMenu()
{
  removeChild(MonsterMenu);
  MonsterMenu = new Sprite();
  MonsterMenu.graphics.beginFill(0xFFFFFF);
  MonsterMenu.graphics.lineStyle(1);
  MonsterMenu.graphics.drawRect(0,0,316,137);
  MonsterMenu.graphics.endFill();
  MonsterMenu.x =152;

  MonsterMenuTitle = new TextField();
  MonsterMenuTitle.width = 316;
  MonsterMenuTitle.htmlText = "<font size='14'><u>Switch Monsters</u></font>";
  MonsterMenuTitle.autoSize = TextFieldAutoSize.CENTER;
  MonsterMenuTitle.selectable = false;
  MonsterMenuTitle.mouseEnabled = false;
  MonsterMenu.addChild(MonsterMenuTitle);
  addChild(MonsterMenu);

  var buttonPosition = 0;
  for(monster in Trainer1.Monsters)
  {
    var MonsterIcon = new MonsterButton(monster);    
    MonsterIcon.x = 5 + 150*Math.floor(buttonPosition/2);MonsterIcon.y=23+((buttonPosition*55)-(110*Math.floor(buttonPosition/2)));

    MonsterMenu.addChild(MonsterIcon);
    buttonPosition++;
  }
  
}
private function drawAttackMenu(?Page:Int=1)
{
  AttackMenu = new Sprite();
  var start = 13*(Page-1);
  var finish = 13*Page;
  var buttonPosition = 0;
    var Title = new TextField();
    Title.selectable = false;
    Title.htmlText = "<u><font size = '16'>Attack</font></u>";
    Title.width = 150;
    Title.autoSize = TextFieldAutoSize.CENTER;
    AttackMenu.addChild(Title);
  for(move in Trainer1.CurrentMonster.Moves)
  {
    
    if(buttonPosition < start || buttonPosition >=finish)
    {
      if(buttonPosition == 0)
	{
	  AttackMenu.addChild(PrevAttackPage);
	}
      if(buttonPosition == finish+1)
	{
	  AttackMenu.addChild(NextAttackPage);
	}
      buttonPosition++;
      continue;
    }
    var Attack = new AttackButton(move);
    Attack.x = 5;Attack.y=26+((buttonPosition-((Page-1)*13))*35);


    AttackMenu.addChild(Attack);
    buttonPosition++;
  }
      AttackMenu.y = (Math.max(512-(31+((buttonPosition)*35)),0))/2;
      AttackMenu.graphics.beginFill(0xFFFFFF);
      AttackMenu.graphics.lineStyle(1);
      AttackMenu.graphics.drawRect(0,0,150,31+((buttonPosition)*35));
      AttackMenu.graphics.endFill();
  addChild(AttackMenu);
}

private function drawItemMenu(?Page:Int=1)
{
  ItemMenu = new Sprite();
  ItemMenu.x = 640-160;
  var start = 13*(Page-1);
  var finish = 13*Page;
  var buttonPosition = 0;
    var Title = new TextField();
    Title.selectable = false;
    Title.htmlText = "<u><font size = '16'>Items</font></u>";
    Title.width = 150;
    Title.autoSize = TextFieldAutoSize.CENTER;
    ItemMenu.addChild(Title);
  var countedItems = new List<String>();
  for(item in Trainer1.CurrentInventory)
  {
    var skip = false;
    if(!item.useInTrainerBattle() && !isRandomBattle)
      {continue;}
    for(name in countedItems)
    {
      if(name == item.ID)
      {
	skip = true;
	break;
      }
    }
    if(skip)
      {continue;}
    
    var count = Trainer1.CurrentInventory.getItemsByName(item.ID);
    
    if(buttonPosition < start || buttonPosition >=finish)
    {
      if(buttonPosition == 0)
	{
	  ItemMenu.addChild(PrevItemPage);
	}
      if(buttonPosition == finish+1)
	{
	  ItemMenu.addChild(NextItemPage);
	}
      buttonPosition++;
      continue;
    }
    countedItems.add(item.ID);
    var Item = new ItemButton(item.ID,count);
    Item.x = 5;Item.y=26+((buttonPosition-((Page-1)*13))*35);


    ItemMenu.addChild(Item);
    buttonPosition++;
  }
  var menuSize = ((buttonPosition-((Page-1)*13))*35);
      ItemMenu.y = (Math.max(512-(31+((buttonPosition)*35)),0))/2;
      ItemMenu.graphics.beginFill(0xFFFFFF);
      ItemMenu.graphics.lineStyle(1);
      ItemMenu.graphics.drawRect(0,0,150,31+((buttonPosition)*35));
      ItemMenu.graphics.endFill();
  addChild(ItemMenu);

  ItemDisabledBackground = new Sprite();
  //ItemDisabledBackground.y = (Math.max(512-(31+((buttonPosition)*35)),0))/2;
  ItemDisabledBackground.graphics.beginFill(0xFFFFFF);
  ItemDisabledBackground.graphics.lineStyle(1);
  ItemDisabledBackground.graphics.drawRect(0,0,150,31+(menuSize));
  ItemDisabledBackground.graphics.endFill();
  ItemDisabledBackground.alpha = 0.5;

  ItemConfirmBackground = new Sprite();
  //ItemConfirmBackground.y = (Math.max(512-(31+((buttonPosition)*35)),0))/2;
  ItemConfirmBackground.graphics.beginFill(0xFFFFFF);
  ItemConfirmBackground.graphics.lineStyle(1);
  ItemConfirmBackground.graphics.drawRect(0,0,150,31+(menuSize));
  ItemConfirmBackground.graphics.endFill();
  ItemConfirmBackground.alpha = 0.5;

  ItemConfirm = new TextField();
  ItemConfirm.background = true;
  ItemConfirm.backgroundColor = 0xFFFFFF;
  ItemConfirm.htmlText = "<font size='14'>Use Item?</font>";
  ItemConfirm.autoSize = TextFieldAutoSize.CENTER;
  ItemConfirm.width = (150 - ItemConfirm.width/2);
  ItemConfirm.y = 15;
  ItemConfirm.selectable = false;
  ItemConfirm.mouseEnabled = false;
  //ItemConfirm.y = 12;

  ItemYes = new Sprite();
  var ItemYesText = new TextField();
  ItemYesText.htmlText = "<font size='14'>Confirm</font>";

  ItemYes.addChild(ItemYesText);
  ItemYesText.width = 70;
  ItemYesText.autoSize = TextFieldAutoSize.CENTER;
  ItemYesText.selectable = false;
  ItemYesText.mouseEnabled = false;
  ItemYes.buttonMode = true;
  ItemYes.addChild(ItemYesText);
  ItemYes.addEventListener(MouseEvent.CLICK, onItemYesClick);
  ItemYes.graphics.beginFill(0xFFFFFF);
  ItemYes.graphics.lineStyle(1);
  ItemYes.graphics.drawRect(0,0,70,32);
  ItemYes.graphics.endFill();
  ItemYes.y = 30;
  ItemYes.x = 0;


  ItemNo = new Sprite();
  ItemNo.mouseChildren = false;
  var ItemNoText = new TextField();
  ItemNoText.htmlText = "<font size='14'>Cancel</font>";
//
  ItemNo.addChild(ItemNoText);
  ItemNoText.width = 70;
  ItemNoText.autoSize = TextFieldAutoSize.CENTER;
  ItemNoText.selectable = false;
  ItemNoText.mouseEnabled = false;
  ItemNo.buttonMode = true;
  ItemNo.addChild(ItemNoText);
  ItemNo.addEventListener(MouseEvent.CLICK, onItemNoClick);
  ItemNo.graphics.beginFill(0xFFFFFF);
  ItemNo.graphics.lineStyle(1);
  ItemNo.graphics.drawRect(0,0,70,32);
  ItemNo.graphics.endFill();
  ItemNo.y = 30;ItemNo.x = 80;

  if(Trainer1.CurrentMonster.Health <= 0)
  {
    ItemMenu.addChild(ItemConfirmBackground);
  }
}

private function onBack(event:Event) {
removeChild(MonsterWiki);
removeChild(WikiScreen);
State = "WaitBattle";
}
private function onWikiButtonClick(event:MouseEvent)
{
//add Wiki
addChild(WikiScreen);
addChild(MonsterWiki);
State = "MonsterWiki";
}
private function onRunAwayClick(event:MouseEvent)
{
  if(RunAwayState == "")
  {
    RunAwayState = "Prompt";
    RunAway.addChild(RunAwayYes);
    RunAway.addChild(RunAwayNo);
    RunAway.addChild(RunAwayPrompt);
  }
  if(RunAwayState == "Buffer")
  {
    RunAwayState = "";
  }

}
private function onPrevAttackPageClick(event:MouseEvent)
{
  AttackPage--;
  drawAttackMenu(AttackPage);
}
private function onNextAttackPageClick(event:MouseEvent)
{
  AttackPage++;
  drawAttackMenu(AttackPage);
}

private function onPrevItemPageClick(event:MouseEvent)
{
  ItemPage--;
  drawItemMenu(ItemPage);
}
private function onNextItemPageClick(event:MouseEvent)
{
  ItemPage++;
  drawItemMenu(ItemPage);
}

private function onRunAwayYesClick(event:MouseEvent)
{
  State = "Finish";
}
private function onRunAwayNoClick(event:MouseEvent)
{
  RunAwayState = "Buffer";
  RunAway.removeChild(RunAwayYes);
  RunAway.removeChild(RunAwayNo);
  RunAway.removeChild(RunAwayPrompt);
}

private function onItemYesClick(event:MouseEvent)
{
  //State = "Finish";
    MonsterMenuTitle.htmlText = "<font size='14'><u>Switch Monsters</u></font>";
    ItemMenu.removeChild(ItemConfirmBackground);
    ItemMenu.removeChild(ItemConfirm);
    ItemMenu.removeChild(ItemNo);
    ItemMenu.removeChild(ItemYes);
    
    var ItemInfo = new Item();
    ItemInfo.updateItem(new Point(),currentItem);
    var text =Trainer1.CurrentInventory.useItem(currentItem,Trainer1.CurrentMonster,Trainer1,RandomMonster);
   var Postion1 = new Point(155,325);
   var Postion2 = new Point(460,208);
  if(text.Text != "")
  {
    var Damage = new FadingMovingText();
    Damage.htmlText = text.Text;
    Damage.x = Postion1.x;
    Damage.y = Postion1.y+32;
    Damage.start();
  }
  if(text.OpponentText != "")
  {
    var Damage = new FadingMovingText();
    Damage.htmlText = text.OpponentText;
    Damage.Direction = "DOWN";
    Damage.x = Postion2.x-Damage.width-5;
    Damage.y = Postion2.y-32;
    Damage.start();
  }
  if(!getOpponentMonster().Captured)
  {
    attackPhase(false,"");
  }
  
    //if(currentItem.isCaputureDevice() && !ran

    currentItem = "";
    ItemState = "";
    
    //removeChild(MonsterMenu);
    drawMonsterMenu();
    removeChild(ItemMenu);
    drawItemMenu(ItemPage);
    BattleField.removeChild(Monster1Health);
    BattleField.removeChild(Monster2Health);
    drawMonstersHealth();
    removeChild(AttackMenu);
    drawAttackMenu(AttackPage);
}
private function onContinueClick(event:MouseEvent)
{
  State = "Finish";
}
private function onItemNoClick(event:MouseEvent)
{
//   RunAwayState = "Buffer";
    MonsterMenuTitle.htmlText = "<font size='14'><u>Switch Monsters</u></font>";
    ItemMenu.removeChild(ItemConfirmBackground);
    ItemMenu.removeChild(ItemConfirm);
    ItemMenu.removeChild(ItemNo);
    if(ItemState == "Confirm")
    {
       ItemMenu.removeChild(ItemYes);
    }
    currentItem = "";
    ItemState = "";
    
    //removeChild(MonsterMenu);
    drawMonsterMenu();
    removeChild(ItemMenu);
    drawItemMenu(ItemPage);
    BattleField.removeChild(Monster1Health);
    BattleField.removeChild(Monster2Health);
    drawMonstersHealth();
    
}

private function getOpponentMonsters():List<Monster>
{
  if(isRandomBattle)
  {
    return null;
  }
  else
  {
    return Trainer2.Monsters;
  }

}

private function getOpponentMonster():Monster
{
  if(isRandomBattle)
  {
    return RandomMonster;
  }
  else
  {
    return Trainer2.CurrentMonster;
  }
}

private function Trainer1AttackPhase(attackName:String)
{
  getOpponentMonster().addEnemyAttacked(Trainer1.CurrentMonster.ID);
  var Postion1 = new Point(155,325);
  var Postion2 = new Point(460,208);
  for(move in Trainer1.CurrentMonster.Moves)
  {
     if(move.Name == attackName)
     {
	move.MP--;
	var AttackString = move.getAttack(Trainer1.CurrentMonster,getOpponentMonster(),Trainer1.Monsters,getOpponentMonsters());
	if(AttackString.Text != "")
	{
	  var Damage = new FadingMovingText();
	  Damage.htmlText = AttackString.Text;
	  Damage.x = Postion1.x;
	  Damage.y = Postion1.y;
	  Damage.start();
	}
	if(AttackString.OpponentText != "")
	{
	  var Damage = new FadingMovingText();
	  Damage.htmlText = AttackString.OpponentText;
	  Damage.Direction = "DOWN";
	  Damage.x = Postion2.x-Damage.width-5;
	  Damage.y = Postion2.y;
	  Damage.start();
	}
	BattleField.removeChild(Monster1Health);
	BattleField.removeChild(Monster2Health);
	drawMonstersHealth();
	break;
     }
  }

      var Damage = getStatusAligments(Trainer1.CurrentMonster,getOpponentMonster());
      if(Damage != "")
      {
	var DamageText = new FadingMovingText();
	DamageText.htmlText = Damage;
	DamageText.x = Postion1.x;
	DamageText.y = Postion1.y+10;
	DamageText.start();
      }

}
private function checkFainted()
{
  var Postion1 = new Point(155,325);
  var Postion2 = new Point(460,208);
  if(Trainer1.CurrentMonster.Health <= 0)
  {
    ItemMenu.addChild(ItemDisabledBackground);
    var Damage = new FadingMovingText();
    Damage.htmlText = "Fainted";
    Damage.x = Postion1.x;
    Damage.y = Postion1.y+32;
    Damage.start();
  }
  if(getOpponentMonster().Health <= 0)
  {
    var Damage = new FadingMovingText();
    Damage.htmlText = "Fainted";
    Damage.Direction = "DOWN";
    Damage.x = Postion2.x-Damage.width-5;
    Damage.y = Postion2.y-32;
    Damage.start();

    switchOpponentMonster();
  }

}

private function switchOpponentMonster()
{
    if(!isRandomBattle)
    {
      for(monster in Trainer2.Monsters)
      {
	if(monster.Health > 0)
	{
	  Trainer2.CurrentMonster = monster;
	  break;
	}
  
      }
    }
	BattleField.removeChild(Monster1Health);
	BattleField.removeChild(Monster2Health);
	drawMonstersHealth();
	drawBattleScreen();
}
private function OpponentAttackPhase()
{
  Trainer1.CurrentMonster.addEnemyAttacked(getOpponentMonster().ID);

  var Postion1 = new Point(155,325);
  var Postion2 = new Point(460,208);
  var NumOfMoves = 0;
  for(move in getOpponentMonster().Moves)
  {
    if(move.MP > 0 || move.TotalMP <= -1 )
    {
      NumOfMoves++;
    }
  }
 var randomNumber = Std.random(NumOfMoves);

 var NumOfMoves = 0;
   for(move in getOpponentMonster().Moves)
  {
    if(move.MP > 0 || move.TotalMP <= -1)
    {
      if(NumOfMoves == randomNumber)
      {
	move.MP--;
	var AttackString = move.getAttack(getOpponentMonster(),Trainer1.CurrentMonster,getOpponentMonsters(),Trainer1.Monsters);
	if(AttackString.Text != "")
	{
	  var Damage = new FadingMovingText();
	  Damage.htmlText = AttackString.Text;
	  Damage.Direction = "DOWN";
	  Damage.x = Postion2.x-Damage.width-5;
	  Damage.y = Postion2.y+14;
	  Damage.start();
	}
	if(AttackString.OpponentText != "")
	{
	  var Damage = new FadingMovingText();
	  Damage.htmlText = AttackString.OpponentText;
	  Damage.x = Postion1.x;
	  Damage.y = Postion1.y-14;
	  Damage.start();
	}
	BattleField.removeChild(Monster1Health);
	BattleField.removeChild(Monster2Health);
	drawMonstersHealth();
	break;
      }
      NumOfMoves++;
    }
  }
      var Damage = getStatusAligments(getOpponentMonster(),Trainer1.CurrentMonster);
      if(Damage != "")
      {
	var DamageText = new FadingMovingText();
	DamageText.htmlText = Damage;
	DamageText.Direction = "DOWN";
	DamageText.x = Postion2.x-DamageText.width-5;
	DamageText.y = Postion2.y+20;
	DamageText.start();
      }

}

private function checkLoss():Bool
{
  var loss = true;
  for(monster in Trainer1.Monsters)
  {
     if(monster.Health > 0)
      {
	loss = false;
	break;
      }

  }
  return loss;

}

private function checkWin():Bool
{
  var win = true;
  if(isRandomBattle)
  {
    if(!RandomMonster.Captured && RandomMonster.Health > 0)
    {
      RandomMonster.Captured = false;
      win = false;
    }
    else
    {
      if( RandomMonster.Captured)
      {
       FinishedText.htmlText = "<font size='14'>You Captured " +  RandomMonster.Character +"</font>";
       RandomMonster.Captured = false;
      }
    }
  }
  else
  {
    for(monster in Trainer2.Monsters)
    {
      if(monster.Health > 0)
	{
	  win = false;
	  break;
	}

    }
  }
  return win;

}
private function CheckExp()
{
  if(getOpponentMonster().Health <= 0)
  {
    Trainer1.CurrentMonster.XP += getOpponentMonster().Level / 2.0;
  }
  

}

public function getStatusAligments(monster:Monster,opponentMonster:Monster):String
{
  var text = "";
  if(monster.Burned)
  {
    monster.Health -= Std.int(monster.MaxHealth/17);
    text += "Burned: -"+Std.int(monster.MaxHealth/17) + " ";
  }
  if(monster.Poisoned)
  {
    monster.Health -= Std.int(monster.MaxHealth/15);
    text += "Poisoned: -"+Std.int(monster.MaxHealth/15)+ " ";
  }
  if(monster.Seeded)
  {
    monster.Health -= Std.int(monster.MaxHealth/30);
    if(opponentMonster.Health > 0)
    {
      opponentMonster.Health += Std.int(monster.MaxHealth/30);
    }
    text += "Seeded: -"+Std.int(monster.MaxHealth/30)+ " ";
  }
  return text;
  drawMonsterMenu();
  BattleField.removeChild(Monster1Health);
  BattleField.removeChild(Monster2Health);
  drawMonstersHealth();
}
private function attackPhase(attacking:Bool,attackName:String)
{
  if(Trainer1.CurrentMonster.Health <= 0 || getOpponentMonster().Health <= 0)
  {
   return; 
  }
  if(Trainer1.CurrentMonster.Speed >= getOpponentMonster().Speed)
  {
    if(attacking)
    {
      Trainer1AttackPhase(attackName);
    }
    checkFainted();
    if(getOpponentMonster().Health > 0)
    {
      OpponentAttackPhase(); 
    }
    checkFainted();
  }
  else
  {
    OpponentAttackPhase(); 
    checkFainted();
    if(attacking)
    {
      if(Trainer1.CurrentMonster.Health > 0)
      {
	Trainer1AttackPhase(attackName);
      }
    }
    checkFainted();
  }

  var Postion1 = new Point(155,325);
  var Postion2 = new Point(460,208);
  if(Trainer1.CurrentMonster.Health <= 0)
  {
    var xp = DistrubuteXp(Trainer1.CurrentMonster,getOpponentMonster(),getOpponentMonsters());
    var Damage = new FadingMovingText();
    Damage.htmlText = "XP: " + xp;
    Damage.Direction = "DOWN";
    Damage.x = Postion2.x-Damage.width-5;
    Damage.y = Postion2.y-32;
    Damage.start();
  }
  if(getOpponentMonster().Health <= 0)
  {
    var xp = DistrubuteXp(getOpponentMonster(),Trainer1.CurrentMonster, Trainer1.Monsters);
    var Damage = new FadingMovingText();
    Damage.htmlText = "XP: " + xp;
    Damage.x = Postion1.x;
    Damage.y = Postion1.y+32;
    Damage.start();
  }
  drawBattleScreen();
}

public function DistrubuteXp(faintedMonster:Monster,currentMonster:Monster,Team:List<Monster>):Float
{
  var count = 0;
  var xp:Float = 0;
  if(Team != null)
  {
    for(monster in Team)
    {
     if(faintedMonster.Fought(monster.ID) && monster.Health > 0)
      {count++;}
    }
    for(monster in Team)
    {
     if(monster.ID == currentMonster.ID)
      {
	xp = faintedMonster.Level / (count);
      }
     if(faintedMonster.Fought(monster.ID) && monster.Health > 0)
      {
	monster.XP += faintedMonster.Level / (count);
	monster.LevelUp();
      }
    }
  }
  else
  {
    xp = faintedMonster.Level / 1.0;
    currentMonster.XP += faintedMonster.Level / 1.0;
    currentMonster.LevelUp();
  }
  faintedMonster.clearEnemyMonster();
  return xp;
}
public function drawBattleScreen()
{
  _BattleBitmapData.fillRect(_BattleBitmapData.rect, 0);
   _BattleMap = [ 
	  [-1,-1,-1,-1,OpponentTileNumber()],
	  [-1,-1,-1,-1,-1],
	  [-1,-1,-1,-1,-1],
	  [TrainerTileNumber(),-1,-1,-1,-1],
	  [-1,-1,-1,-1,-1]
	 ];
  buildMap(_BattleMap,_BattleBitmapData);
}

private function TrainerTileNumber()
{
    if(Trainer1.CurrentMonster.Health  <= 0)
    {
      return -1;
    }
    else
    {
     return Trainer1.CurrentMonster.getTileNumber(true);
    }
}

private function OpponentTileNumber()
{
    if(getOpponentMonster().Health  <= 0)
    {
      return -1;
    }
    else
    {
      return getOpponentMonster().getTileNumber(false);
    }
}

private function onItem(event:ItemButtonEvent){
  var count = 0;
  currentItem = event.Name;
  var ItemInfo = new Item();
  ItemInfo.updateItem(new Point(),currentItem);
  ItemState = "UseItem";
  ItemMenu.addChild(ItemConfirmBackground);

  ItemMenu.addChild(ItemConfirm);
  ItemMenu.addChild(ItemNo);
  if(!ItemInfo.useOnMonster())
  {
    ItemState ="Confirm";
    //addChild Confirm Menu
    ItemMenu.addChild(ItemYes);
  }
  else
  {
    MonsterMenuTitle.htmlText = "<font size='14'><u>Choose Monsters</u></font>";
  }

}
private function onAttack(event:AttackButtonEvent) {
  for(move in Trainer1.CurrentMonster.Moves)
  {
     if(move.Name == event.Name)
     {
	attackPhase(true,event.Name);
	break;
     }
    
  }
  removeChild(AttackMenu);
  drawAttackMenu(AttackPage);
  drawMonsterMenu();
  BattleField.removeChild(Monster1Health);
  BattleField.removeChild(Monster2Health);
  drawMonstersHealth();
}

private function onMonsterSelected (event:MonsterButtonEvent) {
  if(State == "MonsterWiki")
  {
    return;
  }
  
  for(monster in Trainer1.Monsters)
  {
     if(monster.ID == event.ID)
     {

	if(ItemState == "UseItem")
	{
	    MonsterMenuTitle.htmlText = "<font size='14'><u>Switch Monsters</u></font>";
	    ItemMenu.removeChild(ItemConfirmBackground);
	    ItemMenu.removeChild(ItemConfirm);
	    ItemMenu.removeChild(ItemNo);
	    Trainer1.CurrentInventory.useItem(currentItem,monster,null,null);
	    currentItem = "";
	    ItemState = "";
	    
	    //removeChild(MonsterMenu);
	    drawMonsterMenu();
	    removeChild(ItemMenu);
	    drawItemMenu(ItemPage);
	    BattleField.removeChild(Monster1Health);
	    BattleField.removeChild(Monster2Health);
	    drawMonstersHealth();
	    attackPhase(false,"");
	    removeChild(AttackMenu);
	    drawAttackMenu(AttackPage);
	    
	}
	else
	{
	  if(monster.Health > 0)
	  {
	    Trainer1.CurrentMonster = monster;
	  }
	  removeChild(AttackMenu);
	  drawAttackMenu(AttackPage);
	  BattleField.removeChild(Monster1Health);
	  BattleField.removeChild(Monster2Health);
	  drawMonstersHealth();
	  drawBattleScreen();
	  drawItemMenu();
	}
	break;
    
     }
    
  }

}


public function getActionText()
{
  BattleFieldFight.htmlText = "<font size='20'>[   ]FIGHT</font>";
  BattleFieldItem.htmlText = "<font size='20'>[   ]ITEM</font>";
  BattleFieldSwitch.htmlText = "<font size='20'>[   ]SWITCH</font>";
  BattleFieldFlee.htmlText = "<font size='20'>[   ]FLEE</font>";
  if(ActionLocation == 1)
  {BattleFieldFight.htmlText = "<font size='20'>[X]FIGHT</font>";}
  if(ActionLocation == 2)
  {BattleFieldItem.htmlText = "<font size='20'>[X]ITEM</font>";}
  if(ActionLocation == 3)
  {BattleFieldSwitch.htmlText = "<font size='20'>[X]SWITCH</font>";}
  if(ActionLocation == 4)
  {BattleFieldFlee.htmlText = "<font size='20'>[X]FLEE</font>";}

  
}

 private function buildMap(map:Array<Array<Int>>,mapBitmapData:BitmapData)
  {
    for(mapColumn in 0...MAP_COLUMNS)
    {
      for(mapRow in 0...MAP_ROWS)
      {
	var currentTile:Int = map[mapRow][mapColumn];
	if(currentTile > -1)
	{
	  //Find the tile's column and row position
	  //on the tile sheet
	  var tileSheetColumn:Int = Std.int(currentTile / 100);
	  var tileSheetRow:Int = Std.int(currentTile % 100);
	    
	  switch(currentTile)
	  {
	      default:
	      	var Blank:TileModel 
		= new TileModel
		(
		  MAX_TILE_SIZE,
		      tileSheetColumn, tileSheetRow, 
		    mapRow, mapColumn, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		);
		  drawGameObject(Blank, mapBitmapData);
          }
        }
       }
     }
   }

 private function drawGameObject
    (
      tileModel:TileModel, 
      screen:BitmapData
    )
    {
      var sourceRectangle:Rectangle = new Rectangle
	    (
	      tileModel.tileSheetColumn * MAX_TILE_SIZE+ tileModel.ImageX, 
	      tileModel.tileSheetRow * MAX_TILE_SIZE+ tileModel.ImageY, 
	      tileModel.ImageWidth, 
	      tileModel.ImageHeight
	    );
		
      var destinationPoint:Point = new Point
      (
      tileModel.xPos-(tileModel.ImageXOffset), 
      tileModel.yPos-(tileModel.ImageYOffset)
      );

      screen.copyPixels
      (
      _tileSheetBitmapData, 
      sourceRectangle, 
      destinationPoint,
      null, null, true
      );
    }

public function OnKeyDown(event:KeyboardEvent)
   {
      // When a key is held down, multiple KeyDown events are generated.
      // This check means we only pick up the first one.	
      if (!mKeyDown[event.keyCode])
      {
         // Store for use in game
        mKeyDown[event.keyCode] = true;
        if(State == "WaitBattle2")
        {
	  if(mKeyDown[Keyboard.LEFT])
	  {
	    ActionLocation-=1;
	    if(ActionLocation < 1)
	      {ActionLocation = 4;}
	  }
	  else if(mKeyDown[Keyboard.RIGHT])
	  {
	    ActionLocation +=1;
	    if(ActionLocation > 4)
	      {ActionLocation = 1;}
	  }
	  else if(mKeyDown[Keyboard.UP])
	  {
	    ActionLocation -=2;
	    if(ActionLocation < 1)
	      {ActionLocation = 4+ActionLocation;}
	    
	  }
	  else if(mKeyDown[Keyboard.DOWN])
	  {
	    ActionLocation +=2;
	    if(ActionLocation > 4)
	      {ActionLocation = ActionLocation-4;}
	  }
	  getActionText();
	  if(mKeyDown[13] == true)
	    {ExecuteAction();}
	}
      }
      
    }
public function ExecuteAction()
{
  if(ActionLocation == 4)
    {
      State = "Finish";
    }
}
public function OnKeyUp (event:KeyboardEvent)
    {
      mKeyDown[event.keyCode] = false;
    }



function OnEnter(e:flash.events.Event)
{
    try
    {
      if(State == "WaitForBattleVS")
      {
	BattleVSScreenTime++;
	if(BattleVSScreenTime >= 70)
	{
	  removeChild(BattleVSScreen);
	  State = "LoadBattle";
	}
      }
      if(State == "LoadBattle")
      {
	drawField();
	State = "WaitBattle";
      }
      if(State == "WaitBattle")
      {
	if(checkWin())
	{
	  //remove Battlefield
	  removeChild(BattleField);
	  removeChild(AttackMenu);
	  removeChild(MonsterMenu);
	  removeChild(ItemMenu);
	  removeChild(RunAway);
	  removeChild(WikiButton);
	  //Add Win Screen
	  addChild(FinishedScreen);
	  State = "WaitExit";
	  Won = true;
	  if(!isRandomBattle)
	  {
	    var tax =  Std.int(Math.ceil(0.2 * Trainer2.Money));
  
	    if(Trainer2.Money > 0)
	    {
	      Trainer1.Money += Trainer2.Money -tax;
	      var MoneyText= new TextField();

	      MoneyText.htmlText = "<font size='14'>You Won: "+Trainer2.Money+"\nBattle Tax (20%) = "+tax+"\nYou Gain " + Std.string(Trainer2.Money-tax) +"\nTotal Money: "+ Trainer1.Money+"</font>";
	      FinishedScreen.addChild(MoneyText);
	      MoneyText.width = 320;
	      MoneyText.x = 0;
	      MoneyText.y = 100;
	      MoneyText.autoSize = TextFieldAutoSize.RIGHT;
	      MoneyText.selectable = false;
	      MoneyText.mouseEnabled = false;
	    }
	  }
	}
	if(checkLoss())
	{
	  //remove Battlefield
	  removeChild(BattleField);
	  removeChild(AttackMenu);
	  removeChild(MonsterMenu);
	  removeChild(ItemMenu);
	  removeChild(RunAway);
	  removeChild(WikiButton);
	  //Add LossScreen
	  FinishedText.htmlText = "<font size='14'>You Lose...</font>";

	  if(!isRandomBattle)
	  {
	    if(Trainer2.Money > 0)
	    {
	      var oldMoney = Trainer1.Money;
	      var loss =  Std.int(Math.min(Trainer2.Money,Trainer1.Money));
	      loss = Std.int(Math.max(loss,0));
	      Trainer1.Money -= loss;
	      var MoneyText = new TextField();
	      var tax = Std.int(Math.ceil(0.2 * loss));
	      MoneyText.htmlText = "<font size='14'>You Loss: "+loss+"\nBattle Tax (20%) = "+tax+"\nOpponent Gain " + Std.string(loss-tax) +"\nTotal Money: "+ Trainer1.Money+"</font>";
	      FinishedScreen.addChild(MoneyText);
	      MoneyText.width = 320;
	      MoneyText.x = 0;
	      MoneyText.y = 100;
	      MoneyText.autoSize = TextFieldAutoSize.RIGHT;
	      MoneyText.selectable = false;
	      MoneyText.mouseEnabled = false;
	    }
	  }

	  addChild(FinishedScreen);
	  State = "WaitExit";
	  Won = false;
	}
      }
      if(State == "Finish")
      {

	for(monster in Trainer1.Monsters)
	{
	  monster.Seeded = false;
	  monster.Protect = 0;
	  monster.Encase = 0;
	  monster.Charged = 0;
	}
	this.removeEventListener(Event.ENTER_FRAME, OnEnter);
	dispatchEvent(new Event("BattleFinished"));
	flash.Lib.current.removeChild(this);
      }
    
    }
    catch(err:flash.Error)
    {
    trace(err.message);
    }
}
}