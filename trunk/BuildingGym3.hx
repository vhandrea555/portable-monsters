
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

class BuildingGym3 extends Building{

public static inline var MAX_TILE_SIZE:Int = 32;
public function new(){
super();
Cost = 1200;
ExitLocation.x = 78;ExitLocation.y = 79;
MapDoorLocation.x = 78;MapDoorLocation.y = 78;
//flash.Lib.current.addChild(this);

// myTimer = new Timer(12);
//   myTimer.addEventListener("timer", OnEnter);
//   myTimer.start();


}

override public function getNextLine()
{
  currentTalkingStep++;
  if(currentTalkingCharacter.ID >= 1 && currentTalkingCharacter.ID <= 12)
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
 var tileSheetColumn:Int = 2;
 var tileSheetRow:Int = 11;
 var Row = 3; var Column = 3;
 var Statue1 = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue1.ID = 1;
  Characters.add(Statue1);
_characterMap[Statue1.centerY][Statue1.centerX] = Statue1.ID;

 var Row = 5; var Column = 3;
 var Statue2 = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue2.ID = 2;
  Characters.add(Statue2);
  _characterMap[Statue2.centerY][Statue2.centerX] = Statue2.ID;

 var Row = 7; var Column = 3;
 var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 3;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;

 var Row = 1; var Column = 6;
 var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 4;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;

 var Row = 3; var Column = 6;
 var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 5;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;

 var Row = 7; var Column = 6;
 var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 6;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;


  var tileSheetColumn:Int = 3;
  var tileSheetRow:Int = 11;
  var Row = 1; var Column = 8;
   var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 7;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;

  var Row = 3; var Column = 8;
   var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 8;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;

  var Row = 5; var Column = 8;
   var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 89;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;

  var Row = 1; var Column = 11;
   var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 10;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;

  var Row = 5; var Column = 11;
   var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 11;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;

  var Row = 7; var Column = 11;
   var Statue = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Statue.ID = 12;
  Characters.add(Statue);
  _characterMap[Statue.centerY][Statue.centerX] = Statue.ID;




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
	  Text.htmlText = "<font size='16'>Have you found the leader yet?</font>";
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
	  Text.htmlText = "<font size='16'>He doesn't automattically start a battle you have to talk to him.</font>";
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
	  Text.htmlText = "<font size='16'>I think these costumes are ridiculous.</font>";
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
	  Text.htmlText = "<font size='16'>What a weird place to work.</font>";
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
	  Text.htmlText = "<font size='16'>I never understood why a Trainer would use only one type.</font>";
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
	  Text.htmlText = "<font size='16'>That's why we use all types of monsters.</font>";
	}
	else
	{
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
	  Text.htmlText = "<font size='16'>You found me!</font>";
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
	  Text.htmlText = "<font size='16'>I don't really like fighting...</font>";
	}
      	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>You recieved the Confusion Badge.</font>";
	  currentPlot.ConfusionBadge = true;
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
  //
  var tileSheetColumn:Int = 2;
  var tileSheetRow:Int = 11;
  var Row = 1; var Column = 3;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var RandomTrainer1 = new EnemyTrainer(TrainerModel);
    RandomTrainer1.ID = 1;
    RandomTrainer1.AvatarTile = 0002;


    RandomTrainer1.CurrentMonster = new Monster();
    RandomTrainer1.CurrentMonster.Character = "Jelly Fish";
    RandomTrainer1.CurrentMonster.XP = 1380;
    RandomTrainer1.CurrentMonster.LevelUp();
    RandomTrainer1.addNewMonster(RandomTrainer1.CurrentMonster);

    var newMonster = new Monster();
    newMonster.Character = "Water Rabbit";
    newMonster.XP = 1400;
    newMonster.LevelUp();
    RandomTrainer1.addNewMonster(newMonster);

    var newMonster = new Monster();
    newMonster.Character = "Ground Turtle";
    newMonster.XP = 1550;
    newMonster.LevelUp();
    RandomTrainer1.addNewMonster(newMonster);

    _trainerMap[RandomTrainer1.Model.centerY][RandomTrainer1.Model.centerX] = RandomTrainer1.ID;
    RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX+1,RandomTrainer1.Model.centerY));
RandomTrainer1.Model.direction = "right";

  var tileSheetColumn:Int = 2;
  var tileSheetRow:Int = 11;
  var Row = 5; var Column = 6;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var RandomTrainer2 = new EnemyTrainer(TrainerModel);
    RandomTrainer2.ID = 2;
    RandomTrainer2.AvatarTile = 0002;
    

    RandomTrainer2.CurrentMonster = new Monster();
    RandomTrainer2.CurrentMonster.Character = "Flower";
    RandomTrainer2.CurrentMonster.XP = 1275;
    RandomTrainer2.CurrentMonster.LevelUp();
    RandomTrainer2.addNewMonster(RandomTrainer2.CurrentMonster);

    var newMonster = new Monster();
    newMonster.Character = "Flower";
    newMonster.XP = 1275;
    newMonster.LevelUp();
    RandomTrainer2.addNewMonster(newMonster);

    var newMonster = new Monster();
    newMonster.Character = "Tsunami Cat";
    newMonster.XP = 1380;
    newMonster.LevelUp();
    RandomTrainer2.addNewMonster(newMonster);

    _trainerMap[RandomTrainer2.Model.centerY][RandomTrainer2.Model.centerX] = RandomTrainer2.ID;
    RandomTrainer2.SightMap.add(new Point(RandomTrainer2.Model.centerX+1,RandomTrainer2.Model.centerY));
    RandomTrainer2.Model.direction = "right";
  var tileSheetColumn:Int = 3;
  var tileSheetRow:Int = 11;
  var Row = 3; var Column = 11;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var RandomTrainer3 = new EnemyTrainer(TrainerModel);
    RandomTrainer3.ID = 3;
    RandomTrainer3.AvatarTile = 0002;
    

    RandomTrainer3.CurrentMonster = new Monster();
    RandomTrainer3.CurrentMonster.Character = "Flower";
    RandomTrainer3.CurrentMonster.XP = 1550;
    RandomTrainer3.CurrentMonster.LevelUp();
    RandomTrainer3.addNewMonster(RandomTrainer3.CurrentMonster);

    var newMonster = new Monster();
    newMonster.Character = "Water Jay";
    newMonster.XP = 1550;
    newMonster.LevelUp();
    RandomTrainer3.addNewMonster(newMonster);

    var newMonster = new Monster();
    newMonster.Character = "Ember Bug";
    newMonster.XP = 1655;
    newMonster.LevelUp();
    RandomTrainer3.addNewMonster(newMonster);
    RandomTrainer3.Model.direction = "left";


    _trainerMap[RandomTrainer3.Model.centerY][RandomTrainer3.Model.centerX] = RandomTrainer3.ID;
    RandomTrainer3.SightMap.add(new Point(RandomTrainer3.Model.centerX-1,RandomTrainer3.Model.centerY));


    Trainers.add(RandomTrainer3);
    Trainers.add(RandomTrainer2);
    Trainers.add(RandomTrainer1);

  var tileSheetColumn:Int = 3;
  var tileSheetRow:Int = 11;
  var Row = 7; var Column = 8;
  var TrainerModel = new TileModel
    (
      MAX_TILE_SIZE,
      tileSheetColumn, tileSheetRow, 
      Row, Column, 
      MAX_TILE_SIZE, MAX_TILE_SIZE
    );
    var GymLeader = new EnemyTrainer(TrainerModel);
    GymLeader.ID = 4;
    GymLeader.AvatarTile = 0002;
    Trainers.add(GymLeader);
    GymLeader.CurrentMonster = new Monster();
    GymLeader.CurrentMonster.Character = "Storm Dragon";
    GymLeader.CurrentMonster.XP = 1800;
    GymLeader.CurrentMonster.LevelUp();
    GymLeader.addNewMonster(GymLeader.CurrentMonster);

    var newMonster = new Monster();
    newMonster.Character = "Boulder Bear";
    newMonster.XP = 1800;
    newMonster.LevelUp();
    GymLeader.addNewMonster(newMonster);

    var newMonster = new Monster();
    newMonster.Character = "Electric Eel";
    newMonster.XP = 1840;
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
		    [PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL,PTIL],
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