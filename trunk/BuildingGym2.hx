
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

class BuildingGym2 extends Building{

public static inline var MAX_TILE_SIZE:Int = 32;
public function new(){
super();
Cost = 1000;
ExitLocation.x = 12;ExitLocation.y = 69;
MapDoorLocation.x = 12;MapDoorLocation.y = 68;
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
  if(currentTrainer.ID == 1)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I hate Water.</font>";
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
	  Text.htmlText = "<font size='16'>Fire is just so cool, who'd want to use anything else?</font>";
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
  if(currentTrainer.ID == 2)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>This place used to be number one in the region, until an insane amount of new trainers started out with water types. It's all that Youth Center's fault! </font>";
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
	  Text.htmlText = "<font size='16'>Now I'm just a hack...</font>";
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
	  Text.htmlText = "<font size='16'>I only cause pain for those around me.  Like a wildfire spreading</font>";
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
	  Text.htmlText = "<font size='16'>They say fire can be used to create or destory.  I wonder if that's true.</font>";
	}
	else
	{
	  _backgroundMap[6][8] = -1;
	  _backgroundMap[7][8] = -1;
	  _backgroundMap[6][6] = -1;
	  _backgroundMap[7][6] = -1;

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
	  WorldMap.removeChild(TextBox);
	  State = "Playing";
	  currentTalkingStep = -1;
	  currentTrainer = null;
	  
	}
    }
   }
  if(currentTrainer.ID == 4)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>Have you ever done something you regreted?</font>";
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
	  Text.htmlText = "<font size='16'>...</font>";
	}
      	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>You recieved the Anger Badge.</font>";
	  currentPlot.AngerBadge = true;
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
override public function startTrainerBattle(trainer:EnemyTrainer)
{
  
  if(trainer.ID == 1)
  {
    _backgroundMap[5][6] = -1;
  }
  if(trainer.ID == 2)
  {
    _backgroundMap[4][7] = -1;
  }
  if(trainer.ID == 3)
  {
    _backgroundMap[5][8] = -1;
  }
	
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
  super.startTrainerBattle(trainer);
}
override public function initializeTrainers()
{
  //
  var tileSheetColumn:Int = 3;
  var tileSheetRow:Int = 10;
  var Row = 5; var Column = 0;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var RandomTrainer1 = new EnemyTrainer(TrainerModel);
    RandomTrainer1.ID = 1;
    RandomTrainer1.AvatarTile = 0106;
    RandomTrainer1.Model.direction = "right";

    RandomTrainer1.CurrentMonster = new Monster();
    RandomTrainer1.CurrentMonster.Character = "Ember Bug";
    RandomTrainer1.CurrentMonster.XP = 1000;
    RandomTrainer1.CurrentMonster.LevelUp();
    RandomTrainer1.addNewMonster(RandomTrainer1.CurrentMonster);

    var newMonster = new Monster();
    newMonster.Character = "Ember Bug";
    newMonster.XP = 1036;
    newMonster.LevelUp();
    RandomTrainer1.addNewMonster(newMonster);

    var newMonster = new Monster();
    newMonster.Character = "Ember Bug";
    newMonster.XP = 1082;
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


  var tileSheetColumn:Int = 2;
  var tileSheetRow:Int = 10;
  var Row = 0; var Column = 7;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var RandomTrainer2 = new EnemyTrainer(TrainerModel);
    RandomTrainer2.ID = 2;
    RandomTrainer2.AvatarTile = 0107;
    

    RandomTrainer2.CurrentMonster = new Monster();
    RandomTrainer2.CurrentMonster.Character = "Ember Bug";
    RandomTrainer2.CurrentMonster.XP = 1082;
    RandomTrainer2.CurrentMonster.LevelUp();
    RandomTrainer2.addNewMonster(RandomTrainer2.CurrentMonster);

    var newMonster = new Monster();
    newMonster.Character = "Pyro Cat";
    newMonster.XP = 1130;
    newMonster.LevelUp();
    RandomTrainer2.addNewMonster(newMonster);

    var newMonster = new Monster();
    newMonster.Character = "Pyro Cat";
    newMonster.XP = 1130;
    newMonster.LevelUp();
    RandomTrainer2.addNewMonster(newMonster);

    _trainerMap[RandomTrainer2.Model.centerY][RandomTrainer2.Model.centerX] = RandomTrainer2.ID;
    RandomTrainer2.SightMap.add(new Point(RandomTrainer2.Model.centerX,RandomTrainer2.Model.centerY+5));

  var tileSheetColumn:Int = 4;
  var tileSheetRow:Int = 10;
  var Row = 5; var Column = 13;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var RandomTrainer3 = new EnemyTrainer(TrainerModel);
    RandomTrainer3.ID = 3;
    RandomTrainer3.AvatarTile = 0207;
    

    RandomTrainer3.CurrentMonster = new Monster();
    RandomTrainer3.CurrentMonster.Character = "Flame Fox";
    RandomTrainer3.CurrentMonster.XP = 1485;
    RandomTrainer3.CurrentMonster.LevelUp();
    RandomTrainer3.addNewMonster(RandomTrainer3.CurrentMonster);

    _trainerMap[RandomTrainer3.Model.centerY][RandomTrainer3.Model.centerX] = RandomTrainer3.ID;
    RandomTrainer3.SightMap.add(new Point(RandomTrainer3.Model.centerX-6,RandomTrainer3.Model.centerY));
    RandomTrainer3.Model.direction = "left";

    Trainers.add(RandomTrainer3);
    Trainers.add(RandomTrainer2);
    Trainers.add(RandomTrainer1);

  var tileSheetColumn:Int = 4;
  var tileSheetRow:Int = 9;
  var Row = 0; var Column = 19;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var GymLeader = new EnemyTrainer(TrainerModel);
    GymLeader.ID = 4;
    GymLeader.AvatarTile = 0206;
    Trainers.add(GymLeader);
    GymLeader.CurrentMonster = new Monster();
    GymLeader.CurrentMonster.Character = "Fire Bat";
    GymLeader.CurrentMonster.XP = 1771;
    GymLeader.CurrentMonster.LevelUp();
    GymLeader.addNewMonster(GymLeader.CurrentMonster);

    _trainerMap[GymLeader.Model.centerY][GymLeader.Model.centerX] = GymLeader.ID;
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
    MAP_COLUMNS = 20;
    MAP_ROWS = 10;
    MAP_WIDTH = 20;
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
		    [-100,-100,-100,-100,-100,RTIL,RTIL,-100,RTIL,RTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
		    [-100,-100,-100,-100,-100,RTIL,RTIL,-100,RTIL,RTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
		    [-100,-100,-100,-100,RTIL,RTIL,RTIL,-100,RTIL,RTIL,RTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100],
		    [RTIL,RTIL,RTIL,RTIL,RTIL,RTIL,-100,-100,-199,RTIL,RTIL,RTIL,RTIL,RTIL,RTIL,RTIL,-100,-100,-100,-100],
		    [RTIL,RTIL,RTIL,RTIL,RTIL,-100,-100,FEDN,-100,-100,RTIL,RTIL,RTIL,RTIL,RTIL,RTIL,-100,-100,-100,-100],
		    [-100,-100,-100,-100,-100,-100,FERT,-100,FELT,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
		    [RTIL,RTIL,RTIL,RTIL,RTIL,-100,FERT,-100,FELT,-100,RTIL,RTIL,RTIL,RTIL,RTIL,RTIL,-100,-100,-100,-100],
		    [RTIL,RTIL,RTIL,RTIL,RTIL,RTIL,FERT,-100,FELT,RTIL,RTIL,RTIL,RTIL,RTIL,RTIL,RTIL,-100,-100,-100,-100],
		    [-100,-100,-100,-100,RTIL,RTIL,RTIL,-100,RTIL,RTIL,RTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100],
		    [-100,-100,-100,-100,-100,RTIL,RTIL,-100,RTIL,RTIL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100]
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
  /*01*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR],
  /*02*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR],
  /*03*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR],
  /*04*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR],
  /*05*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR],
  /*06*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR],
  /*07*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR],
  /*08*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR],
  /*09*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR],
  /*10*/[OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR,OFLR]
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