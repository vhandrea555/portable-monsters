
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

class BuildingHealthCenter2 extends Building{

public static inline var MAX_TILE_SIZE:Int = 32;
public function new(){
super();
ExitLocation.x = 20;ExitLocation.y = 77;
MapDoorLocation.x = 20;MapDoorLocation.y = 76;
//flash.Lib.current.addChild(this);

// myTimer = new Timer(12);
//   myTimer.addEventListener("timer", OnEnter);
//   myTimer.start();


}
override public function initializeCharacters()
{
 var tileSheetColumn:Int = 3;
 var tileSheetRow:Int = 6;
 var Row = 5; var Column = 5;
 var Nurse = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Characters.add(Nurse);
  Nurse.ID = 5;
  _characterMap[Nurse.centerY][Nurse.centerX] = Nurse.ID;

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


  override public function getNextLine()
  {
  currentTalkingStep++;
  if(currentTalkingCharacter.ID == 5)
  {
    if(currentTalkingCharacter.TalkedTo >= 0)
      {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>Nurse: People always expect to make everything better, but what about me? No one cares about me.</font>";
	}
	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>Healed.</font>";
	  for(monster in MainTrainer.Monsters)
	  {
	    monster.Health = monster.MaxHealth;
	    monster.Burned = false;
	    monster.Poisoned = false;
	    monster.Seeded = false;
	    for(move in monster.Moves)
	    {
	      move.MP = move.TotalMP;
	    }
	  }
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
  else
  {
    	currentTalkingStep = -1;
	WorldMap.removeChild(TextBox);
	currentTalkingCharacter.TalkedTo += 1;
	State = "Playing";
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