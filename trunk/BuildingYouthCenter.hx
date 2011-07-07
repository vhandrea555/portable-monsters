
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

class BuildingYouthCenter extends Building{

public static inline var MAX_TILE_SIZE:Int = 32;
public function new(){
super();
ExitLocation.x = 14;ExitLocation.y = 48;
MapDoorLocation.x = 14;MapDoorLocation.y = 47;
//flash.Lib.current.addChild(this);

// myTimer = new Timer(12);
//   myTimer.addEventListener("timer", OnEnter);
//   myTimer.start();


}
override public function getNextLine()
{
  currentTalkingStep++;
  if(currentTalkingCharacter.ID == 1)
  {
    if(currentTalkingCharacter.TalkedTo == 0)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>Nathan: Here it is. It's not much, but we spend most of time outside anyways.</font>";
      }
      else if(currentTalkingStep == 1)
      {
	Text.htmlText = "<font size='16'>Nathan: Hey, I got you something.</font>";
      }
      else if(currentTalkingStep == 2)
      {
	Text.htmlText = "<font size='16'>*recieves Rock Dog*</font>";
	var monster = new Monster();
	monster = new Monster();
	monster.Character = "Rock Dog";
	monster.XP = 1500;
	monster.LevelUp();
	MainTrainer.addNewMonster(monster);
      }
      else if(currentTalkingStep == 3)
      {
	Text.htmlText = "<font size='16'>Corliss: I...can't take this.</font>";
      }
      else if(currentTalkingStep == 4)
      {
	Text.htmlText = "<font size='16'>Nathan: No worries. You can use it more than i can anyways.<font>";
      }
      else if(currentTalkingStep == 5)
      {
	Text.htmlText = "<font size='16'>Corliss:...<font>";
      }
      else if(currentTalkingStep == 6)
      {
	Text.htmlText = "<font size='16'>Nathan: Take Care.<font>";
      }
      else if(currentTalkingStep == 7)
      {
	Text.htmlText = "<font size='16'>Corliss: Thank You.<font>";
      }
      else
      {
	currentTalkingStep = -1;
	WorldMap.removeChild(TextBox);
	currentTalkingCharacter.TalkedTo += 1;
	State = "Playing";
      }
    }
    else
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>You're Welcome!</font>";
      }
      else
      {
	currentTalkingStep = -1;
	WorldMap.removeChild(TextBox);
	currentTalkingCharacter.TalkedTo += 1;
	State = "Playing";
      }
    }
  }

}
override public function initializeCharacters()
{
 var tileSheetColumn:Int = 3;
 var tileSheetRow:Int = 9;
 var Row = 5; var Column = 5;
 var Nathan = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Characters.add(Nathan);
  Nathan.ID = 1;
  _characterMap[Nathan.centerY][Nathan.centerX] = Nathan.ID;

}

  public override function checkBoundaries()
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
     var maxY = (MAP_ROWS * MAX_TILE_SIZE);
     var minY = 0;
      if (_MainCharacterModel.yPos <= minY )
      {
	      _MainCharacterModel.setY = minY;
	      _MainCharacterModel.vy = 0;
      }
      else if (_MainCharacterModel.yPos + _MainCharacterModel.height >= maxY)
      {
	      _MainCharacterModel.setY = maxY - _MainCharacterModel.height;
	      _MainCharacterModel.vy = 0;
      } 
  }

 override function  OnEnter(e:flash.events.Event)
  {
    try
    {
      if(currentPlot.State == "Nathan Inside")
      {
	_MainCharacterModel.setX = 5 * MAX_TILE_SIZE;
	_MainCharacterModel.setY = 6 * MAX_TILE_SIZE;
	_MainCharacterController.ManualMovement("up");
	super.OnEnter(e);
	currentPlot.State = "Nathan Inside Talking";
      }
      else if(currentPlot.State == "Nathan Inside Talking")
      {
	getCharacterText(1);
	currentPlot.State = "Nathan Talked";
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

  override public function LoadMapData()
  {
    MAP_COLUMNS = 15;
    MAP_ROWS = 10;
    MAP_WIDTH = 15;
    MAP_HEIGHT = 10;

    _terrainBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
	    MAP_ROWS * MAX_TILE_SIZE, true, 0);
    _terrainBitmap = new Bitmap(_terrainBitmapData);


    _backgroundBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
	    MAP_ROWS * MAX_TILE_SIZE, true, 0);
    _backgroundBitmap = new Bitmap(_backgroundBitmapData);

  _frontBitmapData = new BitmapData(MAP_COLUMNS * MAX_TILE_SIZE, 
          MAP_ROWS * MAX_TILE_SIZE, true, 0);
  _frontBitmap = new Bitmap(_frontBitmapData);

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
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	  ];

  _doorsMap = 
	  [
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,EXIT,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	  ];
  _frontMap = 
	  [
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	  ];
  _terrainMap = 
	  [
  //	01   02   03   04   05   06   07   08   09   10  
  /*01*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*02*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*03*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*04*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*05*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*06*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*07*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*08*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*09*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*10*/[TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE]
	  ];

    _gameObjectMap = 
	  [
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,MAIN,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	  ];
    buildItems();
    initBlankArrays();
  }
}