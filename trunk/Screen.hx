
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.utils.Timer;


import haxe.Timer;

import Images;
import Kongregate;
import Monster;



class Screen extends Sprite{
  private var myTimer:Timer;
  public var volume:Bool;
  var kongVar : CKongregate;
  
  public var Items:List<Item>;
  public var Characters:List<Trainer>;
  
  private var _terrainBitmapData:BitmapData;
  private var _terrainBitmap:Bitmap;
  private var _backgroundBitmapData:BitmapData;
  private var _backgroundBitmap:Bitmap;

  private var _doorsBitmapData:BitmapData;
  private var _doorsBitmap:Bitmap;

  private var _itemsBitmapData:BitmapData;
  private var _itemsBitmap:Bitmap;

  private var _foregroundBitmapData:BitmapData;
  private var _foregroundBitmap:Bitmap;

  private var _tileSheetBitmapData:TileSheet;
  private var _collisionController:TileCollisionController;

  private var _MainCharacterModel:TileModel;
  private var _MainCharacterController:MainCharacterController;
  private var _MainCharacterView:MainCharacterView;
  public static inline var MAX_TILE_SIZE:Int = 32;
  private var MAP_COLUMNS:Int;
  private var MAP_ROWS:Int;

  private var _terrainMap:Array<Array<Int>>;
  private var _backgroundMap:Array<Array<Int>>;
  private var _doorsMap:Array<Array<Int>>;
  private var _itemsMap:Array<Array<Int>>;
  private var _gameObjectMap:Array<Array<Int>>;

  private var MAIN:Int;

//Objects
  private var ITEM:Int;
  private var TOMB:Int;  


//House
  private  var HUPL:Int;
  private  var HUPC:Int;
  private  var HUPR:Int;
  private  var HLOL:Int;
  private  var DOOR:Int;
  private  var HLOR:Int;
  public var TNHL:Int;


//Terrian
  private  var GRAS:Int;
  private  var GGRA:Int;
  private  var MONT:Int;

//Roads
//Regular
  private  var ROAD:Int;
//up
  private  var ROUP:Int;
//Corners
  private  var RURC:Int;

//1 openings
  private  var RD1O:Int;

//Fence
 private  var FEUP:Int;
 private  var FERT:Int;
 private  var FEDN:Int;
 private  var FELT:Int;

  public var EXIT:Int;
  public var EXRI:Int;
  public var EXUP:Int;
  public var EXLE:Int;

  public var TILE:Int;


  public var WorldMap:Sprite;
  public var TextBox:Sprite;
  public var Text:TextField;
  public var RandomBattleImage:Sprite;
  public var BattleField:Sprite;
  public var CurrentBattle:BattleScreen;
  public var BattleWait:Int;
  public var State:String;

  public var MainTrainer:Trainer;

  private var mKeyDown:Array<Bool>;
  private var Pause:String;
  public var pauseMenu:PauseMenu;

private var _camera:Rectangle;

public function new(){
  super();

  LoadConstants();
  volume = false;
  WorldMap = new Sprite();
  Items = new List<Item>();
  addChild(WorldMap);
  State = "Playing";
  mKeyDown = [];
  Pause = "UnPaused";
  pauseMenu = new PauseMenu();
  pauseMenu.addEventListener("Quit",onQuit);

  initializeNewData();


// myTimer = new Timer(12);
//   myTimer.addEventListener("timer", OnEnter);
//   myTimer.start();

  RandomBattleImage = new Sprite();
  RandomBattleImage.graphics.beginFill(0x000000);
  RandomBattleImage.graphics.drawRect(0,0,640,512);
  RandomBattleImage.graphics.endFill();
  TextBox = new Sprite();
  TextBox.graphics.beginFill(0xFFFFFF);
  TextBox.graphics.lineStyle(10);
  TextBox.graphics.drawRect(5,5,630,100);
  TextBox.graphics.endFill();
  Text = new TextField();
  Text.htmlText = "";
  Text.x = 10;
  Text.y = 10;
  Text.width = 620;
  Text.wordWrap = true;
  Text.selectable = false;
  TextBox.addChild(Text);
  


  _tileSheetBitmapData = new TileSheet();

  _collisionController = new TileCollisionController();

  LoadMapData();

   buildMap(_terrainMap,_terrainBitmapData);
   buildMap(_backgroundMap,_backgroundBitmapData);
   buildMap(_doorsMap,_doorsBitmapData);

   drawItems();

    WorldMap.addChild(_terrainBitmap);
    WorldMap.addChild(_backgroundBitmap);
    WorldMap.addChild(_doorsBitmap);
    WorldMap.addChild(_itemsBitmap);
    WorldMap.addChild(_foregroundBitmap);


//Buildings

    

}
public function LoadConstants()
{
  MAIN = Constants.MAIN;
//Objects
  ITEM = Constants.ITEM;
  TOMB = Constants.TOMB;  


//House
  HUPL = Constants.HUPL;
  HUPC = Constants.HUPC;
  HUPR = Constants.HUPR;
  HLOL = Constants.HLOL;
  DOOR = Constants.DOOR;
  HLOR = Constants.HLOR;

  
  
//Terrian
  GRAS = Constants.GRAS;
  GGRA = Constants.GGRA;
  MONT = Constants.MONT;

//Roads
//Regular
  ROAD = Constants.ROAD;
//up
  ROUP = Constants.ROUP;
//Corners
  RURC = Constants.RURC;

//1 openings
  RD1O = Constants.RD1O;

//Fence
 FEUP = Constants.FEUP;
 FERT = Constants.FERT;
 FEDN = Constants.FEDN;
 FELT = Constants.FELT;

  EXIT= Constants.EXIT;
  EXRI= Constants.EXRI;
  EXUP= Constants.EXUP;
  EXLE= Constants.EXLE;

  TILE = Constants.TILE;

}

public function LoadMapData()
{
  MAP_COLUMNS = 40;
  MAP_ROWS = 16;

  _terrainBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          MAP_ROWS * MAX_TILE_SIZE, true, 0);
  _terrainBitmap = new Bitmap(_terrainBitmapData);


  _backgroundBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          MAP_ROWS * MAX_TILE_SIZE, true, 0);
  _backgroundBitmap = new Bitmap(_backgroundBitmapData);

  _doorsBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          MAP_ROWS * MAX_TILE_SIZE, true, 0);
  _doorsBitmap = new Bitmap(_doorsBitmapData);

  _itemsBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          MAP_ROWS * MAX_TILE_SIZE, true, 0);
  _itemsBitmap = new Bitmap(_itemsBitmapData);
  _foregroundBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          MAP_ROWS * MAX_TILE_SIZE, true, 0);
  _foregroundBitmap = new Bitmap(_foregroundBitmapData);


 _backgroundMap = 
	[
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,HUPL,HUPC,HUPR,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,HLOL,-1,HLOR,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-100,FEDN,-100,FEDN,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,FERT,-100,-100,-100,FELT,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,FERT,TOMB,-100,TOMB,FELT,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,FERT,-100,-100,-100,FELT,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-100,FEUP,FEUP,FEUP,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	];

 _doorsMap = 
	[
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,DOOR,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	];
 _terrainMap = 
	[
//	01   02   03   04   05   06   07   08   09   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27 
/*01*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*02*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*03*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*04*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*05*/[ROAD,ROAD,ROAD,ROAD,RD1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*06*/[GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*07*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*08*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GGRA,GGRA,GGRA,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*09*/[GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GGRA,GGRA,GGRA,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*10*/[GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GGRA,GGRA,GGRA,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*11*/[GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*12*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*13*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*14*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*15*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*16*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS]
	];
  _gameObjectMap = 
	[
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,MAIN,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	  ]  ;
  buildItems();
}

public function initializeNewData()
{
  MainTrainer = new Trainer();
  MainTrainer.CurrentMonster = new Monster();
  MainTrainer.CurrentMonster.XP =10;
  MainTrainer.CurrentMonster.LevelUp(); 
  MainTrainer.addNewMonster(MainTrainer.CurrentMonster);
  MainTrainer.addNewMonster(new Monster());

  building = new Building();
}


  public function onQuit(event:Event)
  {
    removeChild(pauseMenu);
    this.removeEventListener(Event.ENTER_FRAME, OnEnter);
    UnLoad();
    dispatchEvent(new Event("LevelQuit"));
  }
  public function UnLoad()
  {
      flash.Lib.current.removeChild(this);
      //_MainCharacterController = null;
      stage.removeEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown );
      stage.removeEventListener(KeyboardEvent.KEY_UP, OnKeyUp );
  }

public function Load(inVolume:Bool,inKongVar:CKongregate)
{
  initializeNewData();
  flash.Lib.current.addChild(this);  
  this.addEventListener(Event.ENTER_FRAME, OnEnter);
  volume = inVolume;
  kongVar = inKongVar;
  buildMap(_gameObjectMap,_foregroundBitmapData);
  stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown );
  stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp );
  _camera = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
  building.addEventListener("Exit",onBuildingExit);
}

public function buildItems()
{
  //Column then Row
  Items.add(new Item(new Point(0,2),"Potion",false));
  Items.add(new Item(new Point(0,2),"Potion",false));
  Items.add(new Item(new Point(10,2),"Nothing",false));	
}
public function drawItems()
{
  _itemsMap = [[]];
  
  for(mapRow in 0...MAP_ROWS)
  {
    _itemsMap[mapRow] = [];
  }
  for(mapColumn in 0...MAP_COLUMNS)
  {
    for(mapRow in 0...MAP_ROWS)
    {
      _itemsMap[mapRow][mapColumn] = -1;
    }
  }
  for (item in Items)
  {	
      _itemsMap[Std.int(item.Location.y)][Std.int(item.Location.x)] = 20;
  }
  _itemsBitmapData.fillRect(_itemsBitmapData.rect, 0);
  buildMap(_itemsMap,_itemsBitmapData);
  
}

  //Create tile Models and map them to the
  //correct positions on the tile sheet
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
	  var tileSheetColumn:Int = Std.int(currentTile / 10);
	  var tileSheetRow:Int = Std.int(currentTile % 10);
	  switch(currentTile)
	  {

	      case MAIN:
	      _MainCharacterModel
		  = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    mapRow, mapColumn, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  ); 
		//Add the UIView and UIController  
		_MainCharacterController
		  = new MainCharacterController(_MainCharacterModel);
		_MainCharacterView
			= new MainCharacterView
			(_MainCharacterModel, _MainCharacterController, stage);  
			
		drawGameObject(_MainCharacterModel, mapBitmapData);
	      var Grass:TileModel 
		= new TileModel
		(
		  MAX_TILE_SIZE,
		      tileSheetColumn, tileSheetRow, 
		    mapRow, mapColumn, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		);
		  drawGameObject(Grass, mapBitmapData);
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

function getInsideBuilding()
{
    removeChild(WorldMap);
    building.LoadBuilding(volume,kongVar,MainTrainer);
    addChild(building);
    State = "InsideBuilding";
    trace("HERE");
}
public function checkItem()
{
  var x = _MainCharacterModel.centerX;
  var y = _MainCharacterModel.centerY;
  if(_MainCharacterModel.direction == "left")
  {
    x--;
  }
  if(_MainCharacterModel.direction == "right")
  {
    x++;
  }
  if(_MainCharacterModel.direction == "up")
  {
    y--;
  }
  if(_MainCharacterModel.direction == "down")
  {
    y++;
  }
  if(_backgroundMap[y][x] >= 0)
  {
    getObjectText(y,x);
  }
  if(_itemsMap[y][x] >= 0)
  {
    removeItem(y,x);
  }
}

public function getObjectText(y:Int,x:Int)
{

  if(x == 21 && y == 8)
  {
    Text.htmlText = "<font size='16'><u>Jacob</u>\nDied age 33.\nTook his life a year after his wife died.\nSurviving is his oldest of 10, eve and 5 sons.</font>";
    State = "addText";
  }
  else if(x == 23 && y== 8)
  {
    Text.htmlText = "<font size='16'><u>Amanda</u>\nDied age 31 during a boating accident.\nWife and Mother of 6.</font>";
    State = "addText";
  }
}

public function removeItem(y:Int,x:Int)
{
  
  for(item in Items)
  {
    if(item.Location.x == x && item.Location.y == y)
      {
	TryToPickUpItem(item);
	break;
      }
  }
  drawItems();
}

public function TryToPickUpItem(item:Item)
{
  switch(item.ID)
  {
    case "Nothing":
      Text.htmlText = "<font size='16'>You got Nothing...Well, that's disappointing.<font size='16'>";
      State = "addText";
      Items.remove(item);
    case "Potion":
      Text.htmlText = "<font size='16'>You got a Potion!<font size='16'>";
      MainTrainer.CurrentInventory.Items.add(item);
      State = "addText";
      Items.remove(item);
    default:
      State = "Playing";

  }
}
public function onBuildingExit(event:Event)
{
    building.UnLoad();
    //removeChild(building);
    _MainCharacterModel.setY = _MainCharacterModel.yPos + 64;
    State = "Playing";
    addChild(WorldMap);
    trace("HERE5");
}
public function OnKeyDown(event:KeyboardEvent)
   {
      // When a key is held down, multiple KeyDown events are generated.
      // This check means we only pick up the first one.
      if (!mKeyDown[event.keyCode])
      {
//         if(ignoreKeyPress != "")
//            {return;}
// 
//                   
// 
//          //Press any key to continue scence
//          PauseTillKeyPressed = false;
         // Store for use in game
         mKeyDown[event.keyCode] = true;
        if(State == "Playing")
        {
//I do this here, because if they hold down P,
	 // it won't pause and unpause constantly.
	  if(mKeyDown[ 80 ] == true)
	  {
	      if(Pause == "Paused")
                {
                  Pause = "UnPaused";
		  removeChild(pauseMenu);
                }
              else 
                {
                  Pause = "Paused";
		  addChild(pauseMenu);
                }
	  }
	  if(Pause == "Paused")
	    {return;}
	  BattleWait += 50;
	  if(event.keyCode == 65 || event.keyCode == 13)
	  {
	    checkItem();
	  }


	}
	else if(State == "Text")
	{
	  WorldMap.removeChild(TextBox);
	  State = "Playing";
	}
// 	  if(mKeyDown[ 77 ] == true)
// 	  {
// 	      Mute = !Mute;
// 	  }
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
    if(State == "addText")
    {
      WorldMap.addChild(TextBox);
      State = "Text";
    }
    if(State == "BattleFlash1")
    {
      WorldMap.addChild(RandomBattleImage);
      RandomBattleImage.alpha = 1;
      State = "BattleFlash2";
    }
    if(State == "BattleFlash2")
    {
      RandomBattleImage.alpha = 0;
      State = "BattleFlash3";
    }
    if(State == "BattleFlash3")
    {
      RandomBattleImage.alpha = 1;
      State = "BattleFlash4";
    }
    if(State == "BattleFlash4")
    {
      RandomBattleImage.alpha = 0;
      State = "BattleFade";
    }
    if(State == "BattleFade")
    {
      RandomBattleImage.alpha += 0.1;
      if( RandomBattleImage.alpha >= 1)
        {State="InitBattle";}
    }
    if(State == "InitBattle")
    {
      State = "Battle";
      CurrentBattle = new BattleScreen(stage,true,MainTrainer,null);
      CurrentBattle.addEventListener("BattleFinished",onBattleFinished);
      //addnew
    }
    trace("PLATING");
    if(State != "Playing")
      {trace("Ereturn");return;}
    trace("EAE");
    if(Pause == "Paused")
      {return;}
    _foregroundBitmapData.fillRect(_foregroundBitmapData.rect, 0);
    

    _MainCharacterModel.update();
    checkBoundaries();
    _collisionController.platformCollisionAnything(_MainCharacterModel, _backgroundMap, MAX_TILE_SIZE);
    _collisionController.platformCollisionAnything(_MainCharacterModel, _itemsMap, MAX_TILE_SIZE);

    if(_doorsMap[_MainCharacterModel.top][_MainCharacterModel.left] != -1 &&  _MainCharacterModel.moving <= 1)
      {getInsideBuilding();}
    if(WaitForNextRandomBattle())
    {
      if(_terrainMap[_MainCharacterModel.top][_MainCharacterModel.left] == MONT &&  _MainCharacterModel.moving <= 1)
	{checkRandomEncouter();}
    }
    drawGameObject(_MainCharacterModel, _foregroundBitmapData);
      _camera.x = _MainCharacterModel.xPos - stage.stageHeight * 0.5;
      _camera.y = _MainCharacterModel.yPos - stage.stageHeight * 0.5;
      //Check the camera's game world boundaries
      //Left
      if(_camera.x < 0)
      {
	_camera.x = 0;
      }
      
      //Right
      if(_camera.x > (MAP_COLUMNS * MAX_TILE_SIZE) 
	- stage.stageWidth)
      {
	_camera.x = (MAP_COLUMNS * MAX_TILE_SIZE) - stage.stageWidth;
      }
      
      //Bottom
      if(_camera.y > (MAP_ROWS * MAX_TILE_SIZE) - stage.stageHeight)
      {
	_camera.y = (MAP_ROWS * MAX_TILE_SIZE) - stage.stageHeight;
      }
      
      //Top
      if(_camera.y < 0)
      {
	_camera.y = 0;
      }
          //Scroll the game world
      _terrainBitmap.scrollRect = _camera;
      _foregroundBitmap.scrollRect = _camera;
      _backgroundBitmap.scrollRect = _camera;
      _doorsBitmap.scrollRect = _camera;
      _itemsBitmap.scrollRect = _camera;
    }
    catch(err:flash.Error)
    {
      trace(err.message);
    }
}

  public function WaitForNextRandomBattle()
  {
    
     BattleWait++;
     return(BattleWait > 50);

  }
  public function onBattleFinished(e:Event)
  {
     CurrentBattle = null;
     BattleWait = 0;
     WorldMap.removeChild(RandomBattleImage);
     State = "Playing";

  }

  public function checkRandomEncouter()
  {
    var randomNumber = Std.random(50);
    if(randomNumber == 1)
    {
      State="BattleFlash1";
    }
  }

  public function checkBoundaries()
  {
     var maxX = (MAP_COLUMNS * MAX_TILE_SIZE);
     var minX = 0;
     if (_MainCharacterModel.xPos + (_MainCharacterModel.width) > maxX)
      {
	_MainCharacterModel.setX = maxX - (_MainCharacterModel.width);
	_MainCharacterModel.vx = 0;
      }
      else if (_MainCharacterModel.xPos < minX)
      {
	      _MainCharacterModel.setX = minX;
	      _MainCharacterModel.vx = 0;
      }
      if (_MainCharacterModel.yPos <= 0)
      {
	      _MainCharacterModel.setY = 0;
	      _MainCharacterModel.vy = 0;
      }
      else if (_MainCharacterModel.yPos + _MainCharacterModel.height >= stage.stageHeight)
      {
	      _MainCharacterModel.setY = stage.stageHeight - _MainCharacterModel.height;
	      _MainCharacterModel.vy = 0;
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
}