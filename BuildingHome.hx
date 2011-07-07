
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

class BuildingHome extends Building{

public static inline var MAX_TILE_SIZE:Int = 32;
public var Tristan:Character;
public var Paul:Character;
public var ZakI:Character;
public function new(){
super();
ExitLocation.x = 4;ExitLocation.y = 4;
MapDoorLocation.x = 4;MapDoorLocation.y = 3;
//flash.Lib.current.addChild(this);

// myTimer = new Timer(12);
//   myTimer.addEventListener("timer", OnEnter);
//   myTimer.start();


}
override public function initializeCharacters()
{
 var tileSheetColumn:Int = 3;
 var tileSheetRow:Int = 4;
 var Row = 1; var Column = 1;
 ZakI = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Characters.add(ZakI);
  ZakI.ID = 1;
  _characterMap[ZakI.centerY][ZakI.centerX] = ZakI.ID;


 var tileSheetColumn:Int = 3;
 var tileSheetRow:Int = 5;
 Row = 5; Column = 9;
 var Chris = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Characters.add(Chris);
  Chris.ID = 2;
  _characterMap[Chris.centerY][Chris.centerX] = Chris.ID;

 var tileSheetColumn:Int = 2;
 var tileSheetRow:Int = 5;
 var Row = 3; var Column = 6;
 Paul = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Characters.add(Paul);
  Paul.ID = 3;
  _characterMap[Paul.centerY][Paul.centerX] = Paul.ID;

 var tileSheetColumn:Int = 2;
 var tileSheetRow:Int = 12;
 var Row = 1; var Column = 5;
 Tristan = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Characters.add(Tristan);
  Tristan.ID = 4;
  _characterMap[Tristan.centerY][Tristan.centerX] = Tristan.ID;

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
override public function getObjectText(y:Int,x:Int)
{
  if(x == 14 && y == 9)
  {
    Text.htmlText = "<font size='16'>Lying in this bed somehow heals your monsters.</font>";
    HealMonsters();
    State = "addText";
  }
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
	Text.htmlText = "<font size='16'>Zaki: I got the groceries and they're all put away.</font>";
      }
      else if(currentTalkingStep == 1)
      {
	Text.htmlText = "<font size='16'>Corliss: I think its time for a break.</font>";
      }
      else
      {
	currentTalkingCharacter.TalkedTo += 3;
	currentPlot.State = "Step Outside";
	currentTalkingStep = -1;
	WorldMap.removeChild(TextBox);
	State = "Playing";
      }
    }
    else if(currentTalkingCharacter.TalkedTo >= 1)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>...</font>";
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
  else if(currentTalkingCharacter.ID == 2)
  {
    if(currentTalkingCharacter.TalkedTo <= 3)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>I understand. It's for the best.</font>";
      }
      else
      {
	currentTalkingStep = -1;
	WorldMap.removeChild(TextBox);
	currentTalkingCharacter.TalkedTo += 1;
	State = "Playing";
      }
    }
    else if(currentTalkingCharacter.TalkedTo == 4)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>Just GO already!</font>";
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
	Text.htmlText = "<font size='16'>...</font>";
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

 if(currentTalkingCharacter.ID == 3)
  {
    if(currentTalkingCharacter.TalkedTo >= 0)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>Why are you going?</font>";
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
	Text.htmlText = "<font size='16'>...</font>";
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
 if(currentTalkingCharacter.ID == 4)
  {
    if(currentTalkingCharacter.TalkedTo == 0)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>Paul: Eve!!!</font>";
	Paul.setX = 4 * MAX_TILE_SIZE;
	Paul.setY = 8 * MAX_TILE_SIZE;
      }
      else if(currentTalkingStep == 1)
      {
	    redraw();
	    for(char in Characters)
	    {
	    drawGameObject(char, _foregroundBitmapData);
	    }
	    for(trainer in Trainers)
	    {
	      drawGameObject(trainer.Model, _foregroundBitmapData);
	    }
	    drawGameObject(_MainCharacterModel, _foregroundBitmapData);
	Text.htmlText = "<font size='16'>*hugs*</font>";
      }
      else if(currentTalkingStep == 2)
      {
	Text.htmlText = "<font size='16'>Paul: I missed you so much. Don't ever leave again, okay?</font>";
      }
      else if(currentTalkingStep == 3)
      {
	Text.htmlText = "<font size='16'>Chris: You should see this Vine Cat I got.  I've been training really hard.  I can't wait to get my badge.</font>";
      }
      else if(currentTalkingStep == 4)
      {
	Text.htmlText = "<font size='16'>Zaki: Didn't expect you back so soon.</font>";
	ZakI.setX = 2 * MAX_TILE_SIZE;
	ZakI.setY = 8 * MAX_TILE_SIZE;
      }
      else if(currentTalkingStep == 5)
      {
	    redraw();
	    for(char in Characters)
	    {
	    drawGameObject(char, _foregroundBitmapData);
	    }
	    for(trainer in Trainers)
	    {
	      drawGameObject(trainer.Model, _foregroundBitmapData);
	    }
	    drawGameObject(_MainCharacterModel, _foregroundBitmapData);
	Text.htmlText = "<font size='16'>Eve: You Should be old enough to train Zak, are you heading out pretty soon?</font>";
      }
      else if(currentTalkingStep == 6)
      {
	Text.htmlText = "<font size='16'>Zaki: No way! I'm no trainer. Besides, I'm more intereseted in studying science.</font>";
      }
      else if(currentTalkingStep == 7)
      {
	Text.htmlText = "<font size='16'>Zaki: I'm glad you're back though. You should stay awhile.</font>";
      }
      else if(currentTalkingStep == 8)
      {
	TextBox.y = 412;
	Text.htmlText = "<font size='16'>Tristan: Hey...</font>";
      }
      else if(currentTalkingStep == 9)
      {
	TextBox.y = 412;
	Text.htmlText = "<font size='16'>Eve: Hey...</font>";
      }
      else if(currentTalkingStep == 10)
      {
	TextBox.y = 0;
	Text.htmlText = "<font size='16'>Eve: It's good to be home.</font>";
      }
      else
      {
	
	currentTalkingStep = -1;
	WorldMap.removeChild(TextBox);
	currentTalkingCharacter.TalkedTo += 1;
	getInsideBuilding(5,9);
      }
    }
    if(currentTalkingCharacter.TalkedTo >= 1)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>Hey.</font>";
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
  override public function LoadBuilding(inVolume:Bool,inKongVar:CKongregate,inTrainer:Trainer,inPlot:Plot)
  {
      for(char in Characters)
      {
	if(char.ID == Tristan.ID)
	{
	  Characters.remove(char);
	}
      }
    if(inPlot.TristanHome)
    {	
      Characters.add(Tristan);
    }
      updateCharacterMap();
    super.LoadBuilding(inVolume,inKongVar,inTrainer,inPlot);
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
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,HBED,-1,-1,-1,-1,-1]
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
  /*01*/[KTIL,KTIL,KTIL,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*02*/[KTIL,KTIL,KTIL,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
  /*03*/[KTIL,KTIL,KTIL,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE,TILE],
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

    override function  OnEnter(e:flash.events.Event)
  {
    try
    {
      if(currentPlot.State == "Home End")
      {
	_MainCharacterModel.direction = "up";
	
      }
      super.OnEnter(e);
      if(currentPlot.State == "Home End")
      {
	getCharacterText(4);
	currentPlot.State = "Home Talk";
      }
    }
    catch(err:flash.Error)
    {
      trace(err.message);
    }
  }
}