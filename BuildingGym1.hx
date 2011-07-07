
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

class BuildingGym1 extends Building{

public static inline var MAX_TILE_SIZE:Int = 32;

public function new(){
super();
Cost = 500;
ExitLocation.x = 13;ExitLocation.y = 25;
MapDoorLocation.x = 13;MapDoorLocation.y = 24;
//flash.Lib.current.addChild(this);

// myTimer = new Timer(12);
//   myTimer.addEventListener("timer", OnEnter);
//   myTimer.start();


}
override public function initializeCharacters()
{


}
override public function getTrainerNextLine()
{
  currentTalkingStep++;
  if(currentTrainer.ID == 2)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I can't lose.</font>";
	}
	else
	{
	  WorldMap.removeChild(TextBox);
	  State = "BattleFlash1";
	  currentTalkingStep = -1;
	}
     }
    else
    {
      	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>We don't need to train as hard because the monsters around here are weak to electric.</font>";
	}
	else
	{
	  WorldMap.removeChild(TextBox);
	  State = "Playing";
	  currentTalkingStep = -1;
	  currentTrainer = null;
	}
    }
  }
  if(currentTrainer.ID == 3)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>Gym Leader: Your Trainer's card says your 13.  Isn't that a little old to start Training?</font>";
	}
	else if(currentTalkingStep == 1)
	{
	 Text.htmlText = "<font size='16'>Corliss: Heh. You shouldn't believe everything you see on TV.</font>"; 
	}
	else
	{
	  WorldMap.removeChild(TextBox);
	  State = "BattleFlash1";
	  currentTalkingStep = -1;
	}
    }
    else
    {
      	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>Congrats. You beat me! But it only get harder from here on out.</font>";
	}
      	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>You recieved the Joy Badge.</font>";
	  currentPlot.JoyBadge = true;
	}
	else
	{
	  WorldMap.removeChild(TextBox);
	  State = "Playing";
	  currentTalkingStep = -1;
	  currentTrainer = null;
	}
    }
   }
}
override public function initializeTrainers()
{
  var tileSheetColumn:Int = 2;
  var tileSheetRow:Int = 7;
  var Row = 7; var Column = 0;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var RandomTrainer1 = new EnemyTrainer(TrainerModel);
    RandomTrainer1.ID = 2;
    RandomTrainer1.AvatarTile = 0103;
    Trainers.add(RandomTrainer1);

    RandomTrainer1.CurrentMonster = new Monster();
    RandomTrainer1.CurrentMonster.Character = "Jelly Fish";
    RandomTrainer1.CurrentMonster.XP = 70;
    RandomTrainer1.CurrentMonster.LevelUp();
    RandomTrainer1.addNewMonster(RandomTrainer1.CurrentMonster);
    RandomTrainer1.Model.direction = "right";

    var newMonster = new Monster();
    newMonster.Character = "Jelly Fish";
    newMonster.XP = 70;
    newMonster.LevelUp();
    RandomTrainer1.addNewMonster(newMonster);


    _trainerMap[RandomTrainer1.Model.centerY][RandomTrainer1.Model.centerX] = RandomTrainer1.ID;
    RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX+1,RandomTrainer1.Model.centerY));
    RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX+2,RandomTrainer1.Model.centerY));
    RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX+3,RandomTrainer1.Model.centerY));
    RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX+4,RandomTrainer1.Model.centerY));
    RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX+5,RandomTrainer1.Model.centerY));
    RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX+6,RandomTrainer1.Model.centerY));
    RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX+7,RandomTrainer1.Model.centerY));
    RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX+8,RandomTrainer1.Model.centerY));

  var tileSheetColumn:Int = 3;
  var tileSheetRow:Int = 7;
  var Row = 2; var Column = 0;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var GymLeader = new EnemyTrainer(TrainerModel);
    GymLeader.ID = 3;
    GymLeader.AvatarTile = 0104;
    Trainers.add(GymLeader);
    GymLeader.CurrentMonster = new Monster();
    GymLeader.CurrentMonster.Character = "Jelly Fish";
    GymLeader.CurrentMonster.XP = 70;
    GymLeader.CurrentMonster.LevelUp();
    GymLeader.addNewMonster(GymLeader.CurrentMonster);

    var newMonster = new Monster();
    newMonster.Character = "Electric Eel";
    newMonster.XP = 85;
    newMonster.LevelUp();
    GymLeader.addNewMonster(newMonster);

    var newMonster = new Monster();
    newMonster.Character = "Electric Zebra";
    newMonster.XP = 100;
    newMonster.LevelUp();
    GymLeader.addNewMonster(newMonster);   
    GymLeader.Model.direction = "right";

    _trainerMap[GymLeader.Model.centerY][GymLeader.Model.centerX] = GymLeader.ID;
    GymLeader.SightMap.add(new Point(GymLeader.Model.centerX+1,GymLeader.Model.centerY));
    GymLeader.SightMap.add(new Point(GymLeader.Model.centerX+2,GymLeader.Model.centerY));
    GymLeader.SightMap.add(new Point(GymLeader.Model.centerX+3,GymLeader.Model.centerY));
    GymLeader.SightMap.add(new Point(GymLeader.Model.centerX+4,GymLeader.Model.centerY));
    GymLeader.SightMap.add(new Point(GymLeader.Model.centerX+5,GymLeader.Model.centerY));
    GymLeader.SightMap.add(new Point(GymLeader.Model.centerX+6,GymLeader.Model.centerY));
    GymLeader.SightMap.add(new Point(GymLeader.Model.centerX+7,GymLeader.Model.centerY));
    GymLeader.SightMap.add(new Point(GymLeader.Model.centerX+8,GymLeader.Model.centerY));
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
		    [YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL],
		    [YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL],
		    [-100,-100,-100,-100,-100,-100,-100,-1,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL],
		    [YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL],
		    [YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,-1],
		    [YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,-1],
		    [YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,-1],
		    [-100,-100,-100,-100,-100,-100,-100,-1,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,-1],
		    [YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,-1],
		    [YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,YTIL,-1,-1]
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
		    [-1,-1,-1,-1,-1,-1,-1,EXIT,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
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
  /*01*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR],
  /*02*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR],
  /*03*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR],
  /*04*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR],
  /*05*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR],
  /*06*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR],
  /*07*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR],
  /*08*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR],
  /*09*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR],
  /*10*/[BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR,BFLR]
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
		    [-1,-1,-1,-1,-1,-1,-1,MAIN,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
		    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
	  ];
    buildItems();
    initBlankArrays();
  }
}