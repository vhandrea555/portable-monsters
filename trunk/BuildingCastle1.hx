
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

class BuildingCastle1 extends Building{

public static inline var MAX_TILE_SIZE:Int = 32;
public function new(){
super();
ExitLocation.x = 59;ExitLocation.y = 24;
ExitLocation1.x = 59;ExitLocation1.y=24;
MapDoorLocation.x = 59;MapDoorLocation.y = 23;
MapDoorLocation2.x = 57;MapDoorLocation2.y=21;
ExitLocation2.x = 58;ExitLocation2.y = 21;
//flash.Lib.current.addChild(this);

// myTimer = new Timer(12);
//   myTimer.addEventListener("timer", OnEnter);
//   myTimer.start();


}
override function setExitLocation()
{
  if(_MainCharacterModel.top == 0 && _MainCharacterModel.left == 7)
    {
    ExitLocation.x = ExitLocation2.x;ExitLocation.y = ExitLocation2.y;
    }
  else
  {
    ExitLocation.x = ExitLocation1.x;ExitLocation.y = ExitLocation1.y;
  }
}
override public function getNextLine()
{
  currentTalkingStep++;
  if(currentTalkingCharacter.ID == 1)
  {
    if(currentTalkingCharacter.TalkedTo >= 0)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>It's a statue.</font>";
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
	Text.htmlText = "<font size='16'>It's a statue.</font>";
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


}
override public function getTrainerNextLine()
{
  currentTalkingStep++;
  if(currentTrainer.ID == 1)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I'm going to be the top trainer one, just you watch.</font>";
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
	  Text.htmlText = "<font size='16'>They say if you put you mind to you can accolipsh anything.</font>";
	}
      	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>But you better like what you do, because it's not easy.</font>";
	}
	else
	{
	  WorldMap.removeChild(TextBox);
	  currentTrainer.Model.setX = currentTrainer.Model.xPos+MAX_TILE_SIZE;
	  updateTrainerMap();
	  State = "Playing";
	  currentTalkingStep = -1;
	  currentTrainer = null;
	}
    }
  }
}
// override public function startTrainerBattle(trainer:EnemyTrainer)
// {
//   
//   if(trainer.ID == 1)
//   {
//     _backgroundMap[5][6] = -1;
//   }
//   if(trainer.ID == 2)
//   {
//     _backgroundMap[4][7] = -1;
//   }
//   if(trainer.ID == 3)
//   {
//     _backgroundMap[5][8] = -1;
//   }
// 	
//   redraw();
//   for(char in Characters)
//   {
//   drawGameObject(char, _foregroundBitmapData);
//   }
//   for(trainer in Trainers)
//   {
//       drawGameObject(trainer.Model, _foregroundBitmapData);
//   }
//   drawGameObject(_MainCharacterModel, _foregroundBitmapData);
//   super.startTrainerBattle(trainer);
// }
override public function initializeTrainers()
{ 
  var tileSheetColumn:Int = 4;
  var tileSheetRow:Int = 11;
  var Row = 1; var Column = 7;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var GymLeader = new EnemyTrainer(TrainerModel);
    GymLeader.ID = 1;
    GymLeader.AvatarTile = 0004;
    Trainers.add(GymLeader);
    GymLeader.CurrentMonster = new Monster();
    GymLeader.CurrentMonster.Character = "Jelly Fish";
    GymLeader.CurrentMonster.XP = 3160;
    GymLeader.CurrentMonster.LevelUp();
    GymLeader.addNewMonster(GymLeader.CurrentMonster);

    var newMonster = new Monster();
    newMonster.Character = "Ground Turtle";
    newMonster.XP = 3260;
    newMonster.LevelUp();
    GymLeader.addNewMonster(newMonster);

    var newMonster = new Monster();
    newMonster.Character = "Flower";
    newMonster.XP = 3360;
    newMonster.LevelUp();
    GymLeader.addNewMonster(newMonster);   

    _trainerMap[GymLeader.Model.centerY][GymLeader.Model.centerX] = GymLeader.ID;
//     GymLeader.SightMap.add(new Point(GymLeader.Model.centerX-1,GymLeader.Model.centerY));
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

  override public function LoadBuilding(inVolume:Bool,inKongVar:CKongregate,inTrainer:Trainer,inPlot:Plot)
  {
     super.LoadBuilding(inVolume,inKongVar,inTrainer,inPlot);
     if(EnterLocation2)
     {
	_MainCharacterModel.setX = 7 * MAX_TILE_SIZE; 
	_MainCharacterModel.setY = 1 * MAX_TILE_SIZE;
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
		    [PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,-100,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL],
		    [PTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PTIL,-100,-100,-100,-100,PTIL],
		    [PTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PTIL,-100,-100,-100,-100,PTIL],
		    [PTIL,-100,-100,-100,-100,-100,-100,-100,-199,-100,-100,-100,-100,-100,PTIL,-100,-100,-100,-100,PTIL],
		    [PTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PTIL,-100,-100,-100,-100,PTIL],
		    [PTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PTIL,-100,-100,-100,-100,PTIL],
		    [PTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PTIL,-100,-100,-100,-100,PTIL],
		    [PTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PTIL,-100,-100,-100,-100,PTIL],
		    [PTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PTIL,-100,-100,-100,-100,PTIL],
		    [PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,-100,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL]
	  ];

  _doorsMap = 
	  [
		    [-1,-1,-1,-1,-1,-1,-1,EXIT,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
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
  /*01*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR],
  /*02*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR],
  /*03*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR],
  /*04*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR],
  /*05*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR],
  /*06*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR],
  /*07*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR],
  /*08*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR],
  /*09*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR],
  /*10*/[GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR,GFLR]
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