
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;


import haxe.Timer;

import Images;
import Kongregate;

class Building extends World{
// private var myTimer:Timer;
//   private var _staticBackgroundBitmapData:BitmapData;
//   private var _staticBackgroundBitmap:Bitmap;
//   private var _backgroundBitmapData:BitmapData;
//   private var _backgroundBitmap:Bitmap;
//   private var _foregroundBitmapData:BitmapData;
//   private var _foregroundBitmap:Bitmap;
// 
//   private var _tileSheetBitmapData:TileSheet;
//   private var _MainCharacterModel:TileModel;
//   private var _MainCharacterController:MainCharacterController;
//   private var _MainCharacterView:MainCharacterView;
//   private static inline var MAX_TILE_SIZE:Int = 32;
//   private var MAP_COLUMNS:Int;
//   private var MAP_ROWS:Int;
// 
//   private var _platformMap:Array<Array<Int>>;
//   private var _gameObjectMap:Array<Array<Int>>;
// 
// 
// private var _camera:Rectangle;
public var Cost:Int;
public static inline var MAX_TILE_SIZE:Int = 32;
public var ExitLocation:Point;
public var MapDoorLocation:Point;

public var ExitLocation1:Point;
public var ExitLocation2:Point;
public var MapDoorLocation2:Point;
public var EnterLocation2:Bool;

public function new(){
super();
Cost = -1;
ExitLocation = new Point();
ExitLocation.x = 4;ExitLocation.y = 4;

MapDoorLocation = new Point();
ExitLocation1 = new Point();
ExitLocation2 = new Point();
MapDoorLocation2 = new Point();
EnterLocation2 = false;
//flash.Lib.current.addChild(this);

// myTimer = new Timer(12);
//   myTimer.addEventListener("timer", OnEnter);
//   myTimer.start();


}
override public function buildItems()
{

}
override public function checkBackground()
{

}
override function getInsideBuilding(x:Int,y:Int)
{
    //removeChild(WorldMap);
    
    this.removeEventListener(Event.ENTER_FRAME, OnEnter);
    //flash.Lib.current.removeChild(this);
    setExitLocation();
    _MainCharacterModel = null;
    dispatchEvent(new Event("Exit"));
}
// override public function onBuildingExit(event:Event)
// {
// }

function setExitLocation()
{
  //
}

override public function initializeTrainers()
{
}
override public function initializeCharacters()
{

}
override public function getObjectText(y:Int,x:Int)
{
}
override public function LoadMapData()
{
  MAP_COLUMNS = 10;
  MAP_ROWS = 10;
  MAP_WIDTH = 10;
  MAP_HEIGHT = 10;

  _terrainBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          MAP_ROWS * MAX_TILE_SIZE, true, 0);
  _terrainBitmap = new Bitmap(_terrainBitmapData);

  _frontBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          MAP_ROWS * MAX_TILE_SIZE, true, 0);
  _frontBitmap = new Bitmap(_frontBitmapData);

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
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	];

 _doorsMap = 
	[
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,EXIT,-1,-1,-1,-1,-1,-1]
	];
 _frontMap = 
	[
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	];
 _terrainMap = 
	[
//	01   02   03   04   05   06   07   08   09   10  
/*01*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
/*02*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
/*03*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
/*04*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
/*05*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
/*06*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
/*07*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
/*08*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
/*09*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
/*10*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE]
	];

  _gameObjectMap = 
	[
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,MAIN,-1,-1,-1,-1,-1,-1],
		  [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	];
  buildItems();
}

override public function initializeNewData(?inContinue:Bool=false)
{

}

override public function Load(inContinue:Bool,inVolume:Bool,inKongVar:CKongregate)
{

}
  public function LoadBuilding(inVolume:Bool,inKongVar:CKongregate,inTrainer:Trainer,inPlot:Plot)
  {
    MainTrainer = inTrainer;
    currentPlot = inPlot;
    
    pauseMenu = new PauseMenu(MainTrainer,currentPlot,inKongVar);
    pauseMenu.addEventListener("Quit",onQuit);
    pauseMenu.addEventListener("Save",onSave);

    flash.Lib.current.addChild(this);
    this.addEventListener(Event.ENTER_FRAME, OnEnter);
    volume = inVolume;
    kongVar = inKongVar;
    buildMap(_gameObjectMap,_foregroundBitmapData);
    stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown );
    stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp );
    _camera = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
//stage.focus = stage;
    //mKeyDown = [];
  }

  override public function onSave(event:Event)
  {
    dispatchEvent(new Event("Save"));
  }

  override function  OnEnter(e:flash.events.Event)
  {
    try
    {
      if(currentPlot.State == "Step Outside")
      {
	getInsideBuilding(3,9);
      }
      else
      {
      super.OnEnter(e);
      }
    }
    catch(err:flash.Error)
    {
      trace(err.message);
    }
  }
}