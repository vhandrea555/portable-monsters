
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


import haxe.Timer;

import flash.net.SharedObject;

import Images;
import Kongregate;
import Monster;
import CustomList;



class World extends Sprite{
  private var myTimer:Timer;
  public var volume:Bool;
  var kongVar : CKongregate;
  
  public var Items:ItemList;
  public var Characters:List<Character>;
  public var Trainers:List<EnemyTrainer>;
  public var currentTrainer:EnemyTrainer;
  public var currentTalkingCharacter:Character;
  public var currentTalkingStep:Int;
  public var ExclamationMark:TileModel;

  public var currentPlot:Plot;
  public var WaitTime:Int;
  //List Of Buildings
  public var Buildings:List<Building>;
  public var currentBuilding:Building;
  
  private var _terrainBitmapData:BitmapData;
  private var _terrainBitmap:Bitmap;
  private var _backgroundBitmapData:BitmapData;
  private var _backgroundBitmap:Bitmap;

  private var _frontBitmapData:BitmapData;
  private var _frontBitmap:Bitmap;

  private var _doorsBitmapData:BitmapData;
  private var _doorsBitmap:Bitmap;

  private var _itemsBitmapData:BitmapData;
  private var _itemsBitmap:Bitmap;

  private var _foregroundBitmapData:BitmapData;
  private var _foregroundBitmap:Bitmap;

  private var _tileSheetBitmapData:TileSheet;
  private var _collisionController:TileCollisionController;


  public  var Nathan:Character;
  private var _MainCharacterModel:TileModel;
  private var _MainCharacterController:MainCharacterController;
  private var _MainCharacterView:MainCharacterView;
  public static inline var MAX_TILE_SIZE:Int = 32;
  private var MAP_COLUMNS:Int;
  private var MAP_ROWS:Int;

  private var MAP_WIDTH:Int;
  private var MAP_HEIGHT:Int;

  private var MAP_X:Int;
  private var MAP_Y:Int;

  public var _terrainMap:Array<Array<Int>>;
  public var _backgroundMap:Array<Array<Int>>;
  private var _frontMap:Array<Array<Int>>;
  private var _doorsMap:Array<Array<Int>>;
  public var _itemsMap:Array<Array<Int>>;
  private var _gameObjectMap:Array<Array<Int>>;
  private var _trainerMap:Array<Array<Int>>;
  private var _trainerSightMap:Array<Array<Int>>;
  private var _characterMap:Array<Array<Int>>;

  private var MAIN:Int;

//Objects
  private var ITEM:Int;
  private var TOMB:Int;  
  public var TREE:Int;
  public var PLNT:Int;
  public var HBED:Int;


//House
  private  var HUPL:Int;
  private  var HUPC:Int;
  private  var HUPR:Int;
  private  var HLOL:Int;
  private  var DOOR:Int;
  private  var HLOR:Int;
  
  public var HBUL:Int;
  public var HBUC:Int;
  public var HBUR:Int;
  public var HBLL:Int;
  public var BDOR:Int;
  public var HBLR:Int;

  public var HOUL:Int;
  public var HOUC:Int;
  public var HOUR:Int;
  public var HOLL:Int;
  public var ODOR:Int;
  public var HOLR:Int;

  public var HPUL:Int;
  public var HPUC:Int;
  public var HPUR:Int;
  public var HPLL:Int;
  public var PDOR:Int;
  public var HPLR:Int;

  public var HWUL:Int;
  public var HWUC:Int;
  public var HWUR:Int;
  public var HWLL:Int;
  public var WDOR:Int;
  public var HWLR:Int;

  public var HCUL:Int;
  public var HCUC:Int;
  public var HCUR:Int;
  public var HCLL:Int;
  public var CDOR:Int;
  public var HCLR:Int;

  public var TNHL:Int;
  public var HLTH:Int;
  public var MART:Int;
  public var STRS:Int;

//Gym
  public var BGM1:Int;
  public var BGM2:Int;
  public var BGM3:Int;
  public var BGM4:Int;
  public var BGM5:Int;
  public var BGM6:Int;
  public var BGM7:Int;
  public var BGM8:Int;

  public var OGM1:Int;
  public var OGM2:Int;
  public var OGM3:Int;
  public var OGM4:Int;
  public var OGM5:Int;
  public var OGM6:Int;
  public var OGM7:Int;
  public var OGM8:Int;

  public var PGM1:Int;
  public var PGM2:Int;
  public var PGM3:Int;
  public var PGM4:Int;
  public var PGM5:Int;
  public var PGM6:Int;
  public var PGM7:Int;
  public var PGM8:Int;

  public var WGM1:Int;
  public var WGM2:Int;
  public var WGM3:Int;
  public var WGM4:Int;
  public var WGM5:Int;
  public var WGM6:Int;
  public var WGM7:Int;
  public var WGM8:Int;
//Terrian
  private var GRAS:Int;
  private var GGRA:Int;
  private var MONT:Int;
  private var STRM:Int;
  private var BRDG:Int;
  private var BRKN:Int;
  private var SAND:Int;

  private var LK01:Int;
  private var LK02:Int;
  private var LK03:Int;
  private var LK04:Int;
  private var LK05:Int;
  private var LK06:Int;
  private var LK07:Int;
  private var LK08:Int;
  private var LK09:Int;

//Roads
//Regular
  private var ROAD:Int;
//up
  private var ROUP:Int;
//Corners
  private var RURC:Int;
  public var RLRC:Int;
  public var RLLC:Int;
  public var RULC:Int;

//1 openings
  public var RD1O:Int;
  public var RL1O:Int;
  public var RU1O:Int;
  public var RR1O:Int;

  public var R4WY:Int;

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

  public var KTIL:Int;
  public var YTIL:Int;
  public var BFLR:Int;
  public var RTIL:Int;
  public var OFLR:Int;
  public var PTIL:Int;
  public var GFLR:Int;

  public var E400:Int;
  public var E401:Int;
  public var E402:Int;
  public var E403:Int;
  public var E404:Int;
  public var E405:Int;
  public var E406:Int;
  public var E407:Int;

  public var E408:Int;
  public var E409:Int;
  public var E410:Int;
  public var E411:Int;
  public var E412:Int;
  public var E413:Int;
  public var E414:Int;
  public var E415:Int;
  public var E416:Int;
  public var E417:Int;
  public var E418:Int;
  public var E419:Int;
  public var E420:Int;
  public var E421:Int;
  public var E422:Int;
  public var E423:Int;
  public var E424:Int;
  public var E425:Int;
  public var E426:Int;
  public var E427:Int;
  public var E428:Int;
  public var E429:Int;
  public var E430:Int;
  public var E431:Int;
  public var E432:Int;
  public var E433:Int;
  public var E434:Int;
  public var E435:Int;
  public var E436:Int;
  public var E437:Int;
  public var E438:Int;
  public var E439:Int;
  public var E440:Int;
  public var E441:Int;
  public var E442:Int;
  public var E443:Int;
  public var E444:Int;
  public var E445:Int;
  public var E446:Int;
  public var E447:Int;
  public var E448:Int;
  public var E449:Int;
  public var E450:Int;
  public var E451:Int;
  public var E452:Int;
  public var E453:Int;
  public var E454:Int;
  public var E455:Int;
  public var E456:Int;
  public var E457:Int;
  public var E458:Int;
  public var E459:Int;
  public var E460:Int;
  public var E461:Int;
  public var E462:Int;
  public var E463:Int;
  public var E464:Int;
  public var E465:Int;
  public var E466:Int;
  public var E467:Int;
  public var E468:Int;
  public var E469:Int;
  public var E470:Int;
  public var E471:Int;
  public var E472:Int;
  public var E473:Int;
  public var E474:Int;
  public var E475:Int;
  public var E476:Int;
  public var E477:Int;
  public var E478:Int;
  public var E479:Int;
  public var E480:Int;
  public var E481:Int;
  public var E482:Int;
  public var E483:Int;
  public var E484:Int;
  public var E485:Int;
  public var E486:Int;
  public var E487:Int;
  public var E488:Int;
  public var E489:Int;
  public var E490:Int;
  public var E491:Int;
  public var E492:Int;
  public var E493:Int;
  public var E494:Int;
  public var E495:Int;

  public var TE00:Int;
  public var TE01:Int;
  public var TE02:Int;
  public var TE03:Int;
  public var TE04:Int;
  public var TE05:Int;
  public var TE06:Int;
  public var TE07:Int;
  public var TE08:Int;
  public var TE09:Int;
  public var TE10:Int;
  public var TE11:Int;
  public var TE12:Int;
  public var TE13:Int;
  public var TE14:Int;
  public var TE15:Int;
  public var TE16:Int;
  public var TE17:Int;
  public var TE18:Int;
  public var TE19:Int;
  public var TE20:Int;
  public var TE21:Int;
  public var TE22:Int;
  public var TE23:Int;

  public var PromptYes:Sprite;
  public var PromptNo:Sprite;
  public var WorldMap:Sprite;
  public var TextBox:Sprite;
  public var Text:TextField;
  public var RandomBattleImage:Sprite;
  public var BattleField:Sprite;
  public var CurrentBattle:BattleScreen;
  public var BattleWait:Int;
  public var State:String;

  public var MainTrainer:Trainer;
  public var ZakiTrainer:EnemyTrainer;

  private var mKeyDown:Array<Bool>;
  private var Pause:String;
  public var pauseMenu:PauseMenu;

  private var _camera:Rectangle;

public function new(){
  super();

  haxe.remoting.AMFConnection.registerClassAlias("TrainerAlias",Trainer);
  haxe.remoting.AMFConnection.registerClassAlias("MonsterAlias",Monster); 
  haxe.remoting.AMFConnection.registerClassAlias("PlotAlias",Plot); 

  haxe.remoting.AMFConnection.registerClassAlias("ItemAlias",Item); 
  haxe.remoting.AMFConnection.registerClassAlias("MoveAlias",  Move);
  haxe.remoting.AMFConnection.registerClassAlias("AttackTextAlias",  AttackText);
  haxe.remoting.AMFConnection.registerClassAlias("PointAlias",Point);
  haxe.remoting.AMFConnection.registerClassAlias("EnemyTrainerDataAlias",EnemyTrainerData); 
  haxe.remoting.AMFConnection.registerClassAlias("CharactersDataAlias",CharactersData); 
  haxe.remoting.AMFConnection.registerClassAlias("BuildingDataAlias",BuildingData); 

  haxe.remoting.AMFConnection.registerClassAlias("MonsterListAlias",MonsterList);
  haxe.remoting.AMFConnection.registerClassAlias("ItemListAlias",ItemList);
  haxe.remoting.AMFConnection.registerClassAlias("MoveListAlias",MoveList);
  haxe.remoting.AMFConnection.registerClassAlias("EnemyTrainerDataListAlias",EnemyTrainerDataList); 
  haxe.remoting.AMFConnection.registerClassAlias("CharactersDataListAlias",CharactersDataList); 
  haxe.remoting.AMFConnection.registerClassAlias("BuildingDataListAlias",BuildingDataList);

  LoadConstants();
  volume = false;

  Items = new ItemList();
  //addChild(WorldMap);
  State = "Playing";
  mKeyDown = [];
  Pause = "UnPaused";

  var tileSheetColumn:Int = Std.int(03 / 100);
  var tileSheetRow:Int = Std.int(03 % 100);
  ExclamationMark = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    1, 1, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  MAP_X = 0;
  MAP_Y = 0;
  initializeNewData();

  Trainers = new List<EnemyTrainer>();
  Characters = new List<Character>();
  currentTalkingStep = 0;

  // myTimer = new Timer(12);
  // myTimer.addEventListener("timer", OnEnter);
  // myTimer.start();

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
  
  PromptYes = new Sprite();
  PromptYes.graphics.beginFill(0xFFFFFF);
  PromptYes.graphics.lineStyle(1);
  PromptYes.graphics.drawRect(5,5,30,30);
  PromptYes.graphics.endFill();
  var YesText = new TextField();
  YesText.htmlText = "Yes";
  YesText.x = 10;
  YesText.y = 10;
  YesText.width = 620;
  YesText.wordWrap = true;
  YesText.selectable = false;
  YesText.mouseEnabled = false;
  PromptYes.addChild(YesText);
  PromptYes.addEventListener(MouseEvent.CLICK, onPromptYesClicked);
  PromptYes.buttonMode =true;
  //TextBox.addChild(PromptYes);
  PromptYes.y = 60;
PromptYes.x = 300;

  PromptNo = new Sprite();
  PromptNo.graphics.beginFill(0xFFFFFF);
  PromptNo.graphics.lineStyle(1);
  PromptNo.graphics.drawRect(5,5,30,30);
  PromptNo.graphics.endFill();
  var NoText = new TextField();
  NoText.htmlText = "No";
  NoText.x = 10;
  NoText.y = 10;
  NoText.width = 620;
  NoText.wordWrap = true;
  NoText.selectable = false;
  NoText.mouseEnabled = false;
  PromptNo.addChild(NoText);
  PromptNo.buttonMode = true;PromptNo.addEventListener(MouseEvent.CLICK, onPromptNoClicked);
  //TextBox.addChild(PromptNo);
  PromptNo.y = 60;
  PromptNo.x = 360;

  _tileSheetBitmapData = new TileSheet();

  _collisionController = new TileCollisionController();
  
  LoadMapData();
  LoadTrainerData();

   buildMap(_terrainMap,_terrainBitmapData);
   buildMap(_backgroundMap,_backgroundBitmapData);
  buildMap(_frontMap,_frontBitmapData);
   buildMap(_doorsMap,_doorsBitmapData);
   drawItems();

  WorldMap = new Sprite();
  addChild(WorldMap);
    WorldMap.addChild(_terrainBitmap);
    WorldMap.addChild(_backgroundBitmap);
    WorldMap.addChild(_doorsBitmap);
    WorldMap.addChild(_itemsBitmap);
    WorldMap.addChild(_foregroundBitmap);
    WorldMap.addChild(_frontBitmap);

//Buildings
}
  public function updateGymCost()
  {
    var tempBuilding:Building;
    if(currentPlot.JoyBadge)
    {
      tempBuilding = new BuildingGym1();
      for(building in Buildings)
      {
	if(building.MapDoorLocation.x == tempBuilding.MapDoorLocation.x &&  building.MapDoorLocation.y == tempBuilding.MapDoorLocation.y)
	{
	  building.Cost = -1;
	  break;
	}
      }
    }
    if(currentPlot.AngerBadge)
    {
      var tempBuilding = new BuildingGym2();
      for(building in Buildings)
      {
	if(building.MapDoorLocation.x == tempBuilding.MapDoorLocation.x &&  building.MapDoorLocation.y == tempBuilding.MapDoorLocation.y)
	{
	  building.Cost = -1;
	  break;
	}
      }
    }
    if(currentPlot.ConfusionBadge)
    {
      var tempBuilding = new BuildingGym3();
      for(building in Buildings)
      {
	if(building.MapDoorLocation.x == tempBuilding.MapDoorLocation.x &&  building.MapDoorLocation.y == tempBuilding.MapDoorLocation.y)
	{
	  building.Cost = -1;
	  break;
	}
      }
    }
    if(currentPlot.BlankBadge)
    {
      var tempBuilding = new BuildingGym4();
      for(building in Buildings)
      {
	if(building.MapDoorLocation.x == tempBuilding.MapDoorLocation.x &&  building.MapDoorLocation.y == tempBuilding.MapDoorLocation.y)
	{
	  building.Cost = -1;
	  break;
	}
      }
    }
  }

  public function onPromptYesClicked(event:MouseEvent)
  {
    TextBox.removeChild(PromptYes);
    TextBox.removeChild(PromptNo);
    removeChild(TextBox);
    stage.focus = stage;
    MainTrainer.Money -= currentBuilding.Cost;
      removeChild(WorldMap);
      currentBuilding.LoadBuilding(volume,kongVar,MainTrainer,currentPlot);
      addChild(currentBuilding);
      currentBuilding.addEventListener("Exit",onBuildingExit);
      currentBuilding.addEventListener("Save",onSave);
      State = "";
  }

  public function onPromptNoClicked(event:MouseEvent)
  {
    TextBox.removeChild(PromptYes);
    TextBox.removeChild(PromptNo);
    removeChild(TextBox);
  stage.focus = stage;
    _MainCharacterModel.setY = _MainCharacterModel.yPos + MAX_TILE_SIZE;
    _MainCharacterModel.vy = 0;_MainCharacterModel.vx = 0;
    _MainCharacterModel.update();
      State = "Playing";
  }
  public function onSaveBuildingData():BuildingDataList
  {
    var buildings =  new BuildingDataList();
    for(building in Buildings)
    {
      var buildingData = new BuildingData();
      
      buildingData.Characters =  new CharactersDataList();
      for(char in building.Characters)
      {
	var charData = new CharactersData();
	charData.TalkedTo = char.TalkedTo;
	charData.ID = char.ID;
	charData.Location = new Point(char.centerX*MAX_TILE_SIZE,char.centerY*MAX_TILE_SIZE);
	buildingData.Characters.add(charData);
      }
      buildingData.Trainers =  new EnemyTrainerDataList();
    for(trainer in building.Trainers)
    {
      var trainerData = new EnemyTrainerData();
      trainerData.Battled = trainer.Battled;
      trainerData.ID = trainer.ID;
      trainerData.Location = new Point(trainer.Model.centerX*MAX_TILE_SIZE,trainer.Model.centerY*MAX_TILE_SIZE);
      buildingData.Trainers.add(trainerData);
    }
      buildingData.BackgroundMap = building._backgroundMap;
      buildingData.Location = new Point(building.MapDoorLocation.x,building.MapDoorLocation.y);
      buildings.add(buildingData);
    }
    return buildings;
  }
  public function onSaveCharacterData():CharactersDataList
  {
    var characters =  new CharactersDataList();
    for(char in Characters)
    {
      var charData = new CharactersData();
      charData.TalkedTo = char.TalkedTo;
      charData.ID = char.ID;
      charData.Location = new Point(char.centerX*MAX_TILE_SIZE,char.centerY*MAX_TILE_SIZE);
      characters.add(charData);
    }
    return characters;
  }

  public function onSaveTrainerData():EnemyTrainerDataList
  {
    var trainers =  new EnemyTrainerDataList();
    for(trainer in Trainers)
    {
      var trainerData = new EnemyTrainerData();
      trainerData.Battled = trainer.Battled;
      trainerData.ID = trainer.ID;
      trainerData.Location = new Point(trainer.Model.centerX*MAX_TILE_SIZE,trainer.Model.centerY*MAX_TILE_SIZE);
      trainers.add(trainerData);
    }
    return trainers;
  }
  public function onSave(event:Event)
  {
      try
      {
      kongVar.SubmitStat("MoneySentHome", MainTrainer.MoneySentHome);
      var count = 0;
      for(monster in MainTrainer.Monsters)
      {
	count++;
      }
      for(monster in MainTrainer.MonstersArchive)
      {
	count++;
      }
      kongVar.SubmitStat("MonstersCaught", count);
      var Badges = 0;
      if(currentPlot.JoyBadge)
      {
      Badges++;
      }
      if(currentPlot.AngerBadge)
      {
      Badges++;
      }
      if(currentPlot.ConfusionBadge)
      {
      Badges++;
      }
      if(currentPlot.BlankBadge)
      {
      Badges++;
      }
      kongVar.SubmitStat("Badges", Badges);
      }

      catch (e:Dynamic)
      {

      }
      var savedData = SharedObject.getLocal("GameData");
      //savedData.data.DoorsMap = _doorsMap;
     savedData.data.MainTrainer = MainTrainer;
     savedData.data.Plot = currentPlot;
     savedData.data.ModelXPos = _MainCharacterModel.centerX*MAX_TILE_SIZE;
     savedData.data.ModelYPos = _MainCharacterModel.centerY*MAX_TILE_SIZE;
     savedData.data.ModelDirection = _MainCharacterModel.direction;

    //Maps
    savedData.data.Items = Items;
    savedData.data.TerrianMap = _terrainMap;
    savedData.data.BackgroundMap = _backgroundMap;

    savedData.data.EnemyTrainerDataList = onSaveTrainerData();
    savedData.data.CharactersDataList = onSaveCharacterData();
    savedData.data.BuildingDataList = onSaveBuildingData();

    var Saved = new FadingMovingText();
    Saved.htmlText = "Saved";
    Saved.Direction = "DOWN";
    Saved.x =640-75;
    Saved.y =255;
    Saved.start();
//       savedData.data.Money = MainTrainer.Money;
//       savedData.data.Monsters = MainTrainer.Monsters;
//       savedData.data.MonstersArchive = MainTrainer.MonstersArchive;
//       savedData.data.CurrentMonster = MainTrainer.CurrentMonster;
//       savedData.data.CurrentInventory = Items;
//       savedData.flush();
//       trace(savedData.data.Money);
  }
public function LoadConstants()
{
  MAIN = Constants.MAIN;
//Objects
  ITEM = Constants.ITEM;
  TOMB = Constants.TOMB;  
  TREE = Constants.TREE;
  PLNT = Constants.PLNT;
  HBED = Constants.HBED;


//House
  HUPL = Constants.HUPL;
  HUPC = Constants.HUPC;
  HUPR = Constants.HUPR;
  HLOL = Constants.HLOL;
  DOOR = Constants.DOOR;
  HLOR = Constants.HLOR;

  HBUL = Constants.HBUL;
  HBUC = Constants.HBUC;
  HBUR = Constants.HBUR;
  HBLL = Constants.HBLL;
  BDOR = Constants.BDOR;
  HBLR = Constants.HBLR;

  HOUL = Constants.HOUL;
  HOUC = Constants.HOUC;
  HOUR = Constants.HOUR;
  HOLL = Constants.HOLL;
  ODOR = Constants.ODOR;
  HOLR = Constants.HOLR;

  HPUL = Constants.HPUL;
  HPUC = Constants.HPUC;
  HPUR = Constants.HPUR;
  HPLL = Constants.HPLL;
  PDOR = Constants.PDOR;
  HPLR = Constants.HPLR;

  HWUL = Constants.HWUL;
  HWUC = Constants.HWUC;
  HWUR = Constants.HWUR;
  HWLL = Constants.HWLL;
  WDOR = Constants.WDOR;
  HWLR = Constants.HWLR;

  HCUL = Constants.HCUL;
  HCUC = Constants.HCUC;
  HCUR = Constants.HCUR;
  HCLL = Constants.HCLL;
  CDOR = Constants.CDOR;
  HCLR = Constants.HCLR;

  TNHL = Constants.TNHL;
  HLTH = Constants.HLTH;
  MART = Constants.MART;
  STRS = Constants.STRS;

//Gym
  BGM1 = Constants.BGM1;
  BGM2 = Constants.BGM2;
  BGM3 = Constants.BGM3;
  BGM4 = Constants.BGM4;
  BGM5 = Constants.BGM5;
  BGM6 = Constants.BGM6;
  BGM7 = Constants.BGM7;
  BGM8 = Constants.BGM8;

  OGM1 = Constants.OGM1;
  OGM2 = Constants.OGM2;
  OGM3 = Constants.OGM3;
  OGM4 = Constants.OGM4;
  OGM5 = Constants.OGM5;
  OGM6 = Constants.OGM6;
  OGM7 = Constants.OGM7;
  OGM8 = Constants.OGM8;

  PGM1 = Constants.PGM1;
  PGM2 = Constants.PGM2;
  PGM3 = Constants.PGM3;
  PGM4 = Constants.PGM4;
  PGM5 = Constants.PGM5;
  PGM6 = Constants.PGM6;
  PGM7 = Constants.PGM7;
  PGM8 = Constants.PGM8;

  WGM1 = Constants.WGM1;
  WGM2 = Constants.WGM2;
  WGM3 = Constants.WGM3;
  WGM4 = Constants.WGM4;
  WGM5 = Constants.WGM5;
  WGM6 = Constants.WGM6;
  WGM7 = Constants.WGM7;
  WGM8 = Constants.WGM8;

//Terrian
  GRAS = Constants.GRAS;
  GGRA = Constants.GGRA;
  MONT = Constants.MONT;
  STRM = Constants.STRM;
  BRDG = Constants.BRDG;
  BRKN = Constants.BRKN;
  SAND = Constants.SAND;

  LK01 = Constants.LK01;
  LK02 = Constants.LK02;
  LK03 = Constants.LK03;
  LK04 = Constants.LK04;
  LK05 = Constants.LK05;
  LK06 = Constants.LK06;
  LK07 = Constants.LK07;
  LK08 = Constants.LK08;
  LK09 = Constants.LK09;

//Roads
//Regular
  ROAD = Constants.ROAD;
//up
  ROUP = Constants.ROUP;
//Corners
  RURC = Constants.RURC;
  RLRC = Constants.RLRC;
  RLLC = Constants.RLLC;
  RULC = Constants.RULC;

//1 openings
  RD1O = Constants.RD1O;
  RL1O = Constants.RL1O;
  RU1O = Constants.RU1O;
  RR1O = Constants.RR1O;
 
  R4WY = Constants.R4WY;
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
  KTIL = Constants.KTIL;
  YTIL = Constants.YTIL;
  BFLR = Constants.BFLR;
  RTIL = Constants.RTIL;
  OFLR = Constants.OFLR;
  PTIL = Constants.PTIL;
  GFLR = Constants.GFLR;

  E400 = Constants.E400;
  E401 = Constants.E401;
  E402 = Constants.E402;
  E403 = Constants.E403;
  E404 = Constants.E404;
  E405 = Constants.E405;
  E406 = Constants.E406;
  E407 = Constants.E407;
  E408 = Constants.E408;
  E409 = Constants.E409;
  E410 = Constants.E410;
  E411 = Constants.E411;
  E412 = Constants.E412;
  E413 = Constants.E413;
  E414 = Constants.E414;
  E415 = Constants.E415;
  E416 = Constants.E416;
  E417 = Constants.E417;
  E418 = Constants.E418;
  E419 = Constants.E419;
  E420 = Constants.E420;
  E421 = Constants.E421;
  E422 = Constants.E422;
  E423 = Constants.E423;
  E424 = Constants.E424;
  E425 = Constants.E425;
  E426 = Constants.E426;
  E427 = Constants.E427;
  E428 = Constants.E428;
  E429 = Constants.E429;
  E430 = Constants.E430;
  E431 = Constants.E431;
  E432 = Constants.E432;
  E433 = Constants.E433;
  E434 = Constants.E434;
  E435 = Constants.E435;
  E436 = Constants.E436;
  E437 = Constants.E437;
  E438 = Constants.E438;
  E439 = Constants.E439;
  E440 = Constants.E440;
  E441 = Constants.E441;
  E442 = Constants.E442;
  E443 = Constants.E443;
  E444 = Constants.E444;
  E445 = Constants.E445;
  E446 = Constants.E446;
  E447 = Constants.E447;
  E448 = Constants.E448;
  E449 = Constants.E449;
  E450 = Constants.E450;
  E451 = Constants.E451;
  E452 = Constants.E452;
  E453 = Constants.E453;
  E454 = Constants.E454;
  E455 = Constants.E455;
  E456 = Constants.E456;
  E457 = Constants.E457;
  E458 = Constants.E458;
  E459 = Constants.E459;
  E460 = Constants.E460;
  E461 = Constants.E461;
  E462 = Constants.E462;
  E463 = Constants.E463;
  E464 = Constants.E464;
  E465 = Constants.E465;
  E466 = Constants.E466;
  E467 = Constants.E467;
  E468 = Constants.E468;
  E469 = Constants.E469;
  E470 = Constants.E470;
  E471 = Constants.E471;
  E472 = Constants.E472;
  E473 = Constants.E473;
  E474 = Constants.E474;
  E475 = Constants.E475;
  E476 = Constants.E476;
  E477 = Constants.E477;
  E478 = Constants.E478;
  E479 = Constants.E479;
  E480 = Constants.E480;
  E481 = Constants.E481;
  E482 = Constants.E482;
  E483 = Constants.E483;
  E484 = Constants.E484;
  E485 = Constants.E485;
  E486 = Constants.E486;
  E487 = Constants.E487;
  E488 = Constants.E488;
  E489 = Constants.E489;
  E490 = Constants.E490;
  E491 = Constants.E491;
  E492 = Constants.E492;
  E493 = Constants.E493;
  E494 = Constants.E494;
  E495 = Constants.E495;

  TE00 = Constants.TE00;
  TE01 = Constants.TE01;
  TE02 = Constants.TE02;
  TE03 = Constants.TE03;
  TE04 = Constants.TE04;
  TE05 = Constants.TE05;
  TE06 = Constants.TE06;
  TE07 = Constants.TE07;
  TE08 = Constants.TE08;
  TE09 = Constants.TE09;
  TE10 = Constants.TE10;
  TE11 = Constants.TE11;
  TE12 = Constants.TE12;
  TE13 = Constants.TE13;
  TE14 = Constants.TE14;
  TE15 = Constants.TE15;
  TE16 = Constants.TE16;
  TE17 = Constants.TE17;
  TE18 = Constants.TE18;
  TE19 = Constants.TE19;
  TE20 = Constants.TE20;
  TE21 = Constants.TE21;
  TE22 = Constants.TE22;
  TE23 = Constants.TE23;
}

public function initBlankArrays()
{
  _trainerMap  = [[]];
  _trainerSightMap = [[]];
  _characterMap = [[]];
  
  for(mapRow in 0...MAP_HEIGHT)
  {
    _trainerMap[mapRow] = [];
    _trainerSightMap[mapRow] = [];
    _characterMap[mapRow] = [];
  }
  for(mapColumn in 0...MAP_WIDTH)
  {
    for(mapRow in 0...MAP_HEIGHT)
    {
      _trainerMap[mapRow][mapColumn] = -1;
      _trainerSightMap[mapRow][mapColumn] = -1;
      _characterMap[mapRow][mapColumn] = -1;
    }
  }
}
public function LoadTrainerData()
{
  initBlankArrays();
  initializeTrainers();
  initializeCharacters();
  updateTrainerMap();
}

public function LoadMapData()
{
  MAP_COLUMNS = 40;
  MAP_ROWS = 40;
  MAP_WIDTH = 80;
  MAP_HEIGHT = 80;

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
//	01    02   03   04   05   06   07   08   09   10   11   12   13   14   15   16   17  18    19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39   41   42   43   44   45 
/*01*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*02*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*03*/[-100,-100,-100,HUPL,HUPC,HUPR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*04*/[-100,-100,-100,HLOL,-100,HLOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*05*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*06*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*07*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,FEDN,-100,FEDN,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*08*/[-100,-100,-100,-100,-100,HUPL,HUPC,HUPR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,FERT,-100,-100,-100,FELT,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*09*/[-100,-100,-100,-100,-100,HLOL,DOOR,TNHL,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,FERT,TOMB,-100,TOMB,FELT,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*10*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,FERT,-100,-100,-100,FELT,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*11*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,FEUP,FEUP,FEUP,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*12*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*13*/[TREE,TREE,TREE,TREE,FEUP,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,E400,E401,E402,E403,E404,E405,E406,E407,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*14*/[STRM,STRM,STRM,STRM,-100,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,STRM,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,E408,E409,E410,E411,E412,E413,E414,E415,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*15*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,E416,E417,E418,E419,-100,E421,E422,E423,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*16*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,E424,-100,-100,-100,-100,-100,-100,E431,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*17*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,E432,E433,E434,E435,E436,E437,E438,E439,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE],
/*18*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,E440,E441,E442,E443,-100,E445,E446,E447,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
/*19*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,E448,-100,-100,-100,-100,-100,-100,E455,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
/*20*/[TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,E456,E457,E458,E459,E460,E461,E462,E463,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
/*T2*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HBUL,HBUC,HBUR,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,E464,E465,E466,E467,-100,E469,E470,E471,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
/*22*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HBLL,-100,HLTH,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,E472,-100,-100,-100,-100,-100,-100,E479,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,HCUL,HCUC,HCUR,-100,E480,E481,E482,E483,E484,E485,E486,E487,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,BGM1,BGM2,BGM3,BGM4,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,HCLL,-100,MART,-100,E488,E489,E490,E491,E492,E493,E494,E495,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,BGM5,BGM6,-100,BGM8,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HCUL,HCUC,HCUR,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,HBUL,HBUC,HBUR,-100,-100,-100,TREE,-100,LK01,LK02,LK02,LK02,LK02,LK02,LK02,LK03,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HCLL,-100,HLTH,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,HBLL,-100,MART,-100,-100,-100,TREE,-100,LK04,LK05,LK05,LK05,LK05,LK05,LK05,LK06,-100,-100,-100,TREE,TREE,TREE,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
/*30*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,LK04,LK05,LK05,LK05,LK05,LK05,LK05,LK06,-100,-100,-100,TREE,TREE,TREE,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,LK04,LK05,LK05,LK05,LK05,LK05,LK05,LK06,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100,-100],
      [TREE,TREE,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,LK04,LK05,LK05,LK05,LK05,LK05,LK05,LK06,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [TREE,TREE,TREE,-100,-100,TREE,-100,-100,-100,-100,-100,-100,LK07,LK08,LK08,LK08,LK08,LK08,LK08,LK09,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,TREE,-100,TREE,TREE,-100,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,TREE,TREE,-100,TREE,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*40*/[TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE],
/*41*/[TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE],
/*T3*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HUPL,HUPC,HUPR,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HLOL,-100,HLOR,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,HWUL,HWUC,HWUR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,WGM1,WGM2,WGM3,WGM4,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,HWLL,-100,HLTH,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,WGM5,WGM6,-100,WGM8,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,PLNT,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE],
/*61*/[-100,-100,HOUL,HOUC,HOUR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HOUL,HOUC,HOUR,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,HPUL,HPUC,HPUR,-100,-100,-100,-100],
/*62*/[-100,-100,HOLL,-100,MART,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HOLL,ODOR,HOLR,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,HPLL,-100,MART,-100,-100,-100,-100],
/*T4*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,OGM1,OGM2,OGM3,OGM4,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,OGM5,OGM6,-100,OGM8,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,-100,TREE,-100,HPUL,HPUC,HPUR,-100,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,TREE,-100,HPLL,-100,HLTH,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100],
      [-100,-100,HOUL,HOUC,HOUR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HOUL,HOUC,HOUR,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100],
      [-100,-100,HOLL,ODOR,HOLR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,HOLL,-100,HLTH,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,TREE,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,-100,TREE,TREE,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,TREE,-100,TREE,TREE,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,PGM1,PGM2,PGM3,PGM4],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,TREE,-100,PGM5,PGM6,-100,PGM8],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,TREE,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100],
      [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*82*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,TREE,TREE,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TREE,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],

  ];

 _doorsMap = 
	[
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,DOOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,DOOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,E492,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,STRS,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,E492,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,STRS,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*20*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,E492,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*T2*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,BDOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,STRS,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,CDOR,-100,-100,-100,-100,-100,-100,E492,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,BGM7,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,CDOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,BDOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*40*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*41*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*T3*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,DOOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,WDOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,WGM7,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*61*/[-100,-100,-100,ODOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PDOR,-100,-100,-100,-100,-100],
/*62*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*T4*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,OGM7,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PDOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,ODOR,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,PGM7,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*82*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
	];

 _frontMap = 
	[
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TE00,TE01,TE02,TE03,TE04,TE05,TE06,TE07,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TE08,TE09,TE10,TE11,TE12,TE13,TE14,TE15,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*20*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,TE16,TE17,TE18,TE19,TE20,TE21,TE22,TE23,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*40*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*41*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*T3*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*61*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*62*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*T4*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
    [-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
/*82*/[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100,-100],
	];

 _terrainMap = 
	[
//	01   02   03   04   05   06   07   08   09   10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27 
/*01*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*02*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*03*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*04*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*05*/[ROAD,ROAD,ROAD,ROAD,RD1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*06*/[GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*07*/[GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*08*/[GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GGRA,GGRA,GGRA,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*09*/[GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GGRA,GGRA,GGRA,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*10*/[GRAS,GRAS,GRAS,GRAS,RR1O,ROAD,RLRC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GGRA,GGRA,GGRA,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*11*/[GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*12*/[GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*13*/[GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*14*/[GRAS,GRAS,GRAS,GRAS,BRDG,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*15*/[MONT,MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*16*/[MONT,MONT,MONT,MONT,RLLC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,E449,E450,E451,E452,E453,E454,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND,SAND],
/*17*/[MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*18*/[MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*19*/[MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,E449,E450,E451,E452,E453,E454,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*20*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*21*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*22*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,E449,E450,E451,E452,E453,E454,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*23*/[GRAS,GRAS,GRAS,RULC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RD1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RLRC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*24*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*25*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*26*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RLLC,ROAD,ROAD,RLRC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,RULC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RLRC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*27*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*28*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*29*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*30*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*31*/[GRAS,GRAS,GRAS,RR1O,ROAD,RLRC,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*32*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT],
/*33*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT],
/*34*/[GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT],
/*35*/[MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT],
/*36*/[MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT],
/*37*/[MONT,MONT,MONT,RLLC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RU1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT],
/*38*/[MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT],
/*39*/[MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT],
/*40*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*41*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*42*/[MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RLLC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*43*/[MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*44*/[MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*45*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*46*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RULC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RLRC,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*47*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*48*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*49*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RLLC,ROAD,ROAD,RL1O,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,ROUP,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*50*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,RLLC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RD1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RLRC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*51*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*52*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*53*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*54*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*55*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*56*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*57*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*58*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*59*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*60*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*61*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*62*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RULC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,MONT,GRAS,GRAS,MONT,RULC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*63*/[GRAS,GRAS,GRAS,RLLC,ROAD,ROAD,RD1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,R4WY,ROAD,ROAD,RLRC,GRAS,GRAS,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RLLC,ROAD,ROAD,RURC,GRAS,GRAS],
/*64*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS],
/*65*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS],
/*66*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RLLC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,RULC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RLRC,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS],
/*67*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,RULC,ROAD,ROAD,ROAD,ROAD,RU1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RLRC,GRAS,GRAS],
/*68*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*69*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*70*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*71*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RULC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RLRC,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,RLLC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*72*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,RR1O,ROAD,RD1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RD1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,GRAS,GRAS,GRAS,GRAS],
/*73*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,ROUP,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS],
/*74*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,ROUP,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS],
/*75*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RLLC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RURC,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,RULC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RLRC,GRAS,ROUP,GRAS,RLLC,ROAD,RU1O,ROAD,ROAD,ROAD,ROAD,RL1O,GRAS,GRAS,GRAS,GRAS,RULC,ROAD,ROAD,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS],
/*76*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,RULC,ROAD,ROAD,RLRC,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS],
/*77*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,MONT,ROUP,MONT,GRAS,GRAS,MONT,ROUP,MONT,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,ROUP,GRAS,RULC,ROAD,ROAD,ROAD,GRAS,GRAS,GRAS,ROUP,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS],
/*78*/[GRAS,GRAS,GRAS,RLLC,ROAD,ROAD,RU1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RU1O,ROAD,ROAD,RU1O,ROAD,ROAD,ROAD,RURC,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,ROUP,GRAS,MONT,RLLC,ROAD,ROAD,ROAD,ROAD,RLRC,MONT,GRAS,ROUP,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,ROUP,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,RULC,ROAD,RU1O,ROAD,RU1O,ROAD,ROAD,ROAD,ROAD,ROAD,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS],
/*79*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,RLLC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,RLRC,GRAS,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,GRAS,RLLC,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,R4WY,ROAD,RLRC,GRAS,RULC,RURC,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,ROUP,GRAS,GRAS,GRAS,GRAS],
/*80*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,MONT,MONT,MONT,GRAS,GRAS,MONT,MONT,MONT,GRAS,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,MONT,GRAS,RLLC,ROAD,GRAS,GRAS,RLLC,ROAD,ROAD,RU1O,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,ROAD,GRAS,RLLC,ROAD,ROAD,RLRC,GRAS],
/*81*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],
/*82*/[GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS,GRAS],


];
  _gameObjectMap = 
	[
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,MAIN,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],

	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
	    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],

	  ]  ;
  buildItems();
  initializeBuilding();
}


public function initializeCharacters()
{
 
 var tileSheetColumn:Int = 2;
 var tileSheetRow:Int = 9;
 var Row = 45; var Column = 23;
 Nathan = new Character
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
  Nathan.ID = 2;
  //Characters.add(Nathan);
  //_characterMap[Nathan.centerY][Nathan.centerX] = Nathan.ID;
}

public function initializeTrainers()
{
 var ID = 1;
 var tileSheetColumn:Int = 4;
 var tileSheetRow:Int = 7;
 var Row = 15; var Column = 26;
 var TrainerModel = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
 var RandomTrainer1 = new EnemyTrainer(TrainerModel);
 RandomTrainer1.ID = ID;
 RandomTrainer1.AvatarTile = 0202;
 Trainers.add(RandomTrainer1);
 RandomTrainer1.CurrentMonster = new Monster();
 RandomTrainer1.CurrentMonster.Character = "Water Rabbit";
 RandomTrainer1.CurrentMonster.XP = 12;
 RandomTrainer1.CurrentMonster.LevelUp();
 RandomTrainer1.Money = 2000;
 RandomTrainer1.Model.direction = "left";
 RandomTrainer1.addNewMonster(RandomTrainer1.CurrentMonster);
 _trainerMap[RandomTrainer1.Model.centerY][RandomTrainer1.Model.centerX] = RandomTrainer1.ID;
 RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX-1,RandomTrainer1.Model.centerY));
 RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX-1,RandomTrainer1.Model.centerY+1));
 RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX-1,RandomTrainer1.Model.centerY+2));
 RandomTrainer1.SightMap.add(new Point(RandomTrainer1.Model.centerX-1,RandomTrainer1.Model.centerY+3));

 var tileSheetColumn:Int = 3;
 var tileSheetRow:Int = 8;
 var Row = 33; var Column = 4;
 var TrainerModel = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
 var RandomTrainer2 = new EnemyTrainer(TrainerModel);
 RandomTrainer2.ID = 2;
 RandomTrainer2.AvatarTile = 0205;
 Trainers.add(RandomTrainer2);


 RandomTrainer2.CurrentMonster = new Monster();
 RandomTrainer2.CurrentMonster.Character = "Tsunami Cat";
 RandomTrainer2.CurrentMonster.XP = 105;
 RandomTrainer2.CurrentMonster.LevelUp();
 RandomTrainer2.addNewMonster(RandomTrainer2.CurrentMonster);

 var monster = new Monster();
 monster.Character = "Water Jay";
 monster.XP = 120;
 monster.LevelUp();
 RandomTrainer2.addNewMonster(monster);
 RandomTrainer2.Money = 4000;
 RandomTrainer2.Model.direction = "left";

 _trainerMap[RandomTrainer2.Model.centerY][RandomTrainer2.Model.centerX] = RandomTrainer2.ID;
 RandomTrainer2.SightMap.add(new Point(RandomTrainer2.Model.centerX-1,RandomTrainer2.Model.centerY));
 RandomTrainer2.SightMap.add(new Point(RandomTrainer2.Model.centerX,RandomTrainer2.Model.centerY));
 RandomTrainer2.SightMap.add(new Point(RandomTrainer2.Model.centerX,RandomTrainer2.Model.centerY));
 RandomTrainer2.SightMap.add(new Point(RandomTrainer2.Model.centerX,RandomTrainer2.Model.centerY));

 var tileSheetColumn:Int = 2;
 var tileSheetRow:Int = 8;
 var Row = 35; var Column = 26;
 var TrainerModel = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );

 var RandomTrainer4 = new EnemyTrainer(TrainerModel);
 RandomTrainer4.ID = 4;
 RandomTrainer4.AvatarTile = 0203;
 Trainers.add(RandomTrainer4);
 
 RandomTrainer4.CurrentMonster = new Monster();
 RandomTrainer4.CurrentMonster.Character = "Water Rabbit";
 RandomTrainer4.CurrentMonster.XP = 160;
 RandomTrainer4.CurrentMonster.LevelUp();
 RandomTrainer4.addNewMonster(RandomTrainer4.CurrentMonster);


 var monster = new Monster();
 monster.Character = "Water Rabbit";
 monster.XP = 180;
 monster.LevelUp();
 RandomTrainer4.addNewMonster(monster);

 var monster = new Monster();
 monster.Character = "Tsunami Cat";
 monster.XP = 200;
 monster.LevelUp();
 RandomTrainer4.addNewMonster(monster);
 RandomTrainer4.Money = 5000;

 _trainerMap[RandomTrainer4.Model.centerY][RandomTrainer4.Model.centerX] = RandomTrainer4.ID;
 RandomTrainer4.SightMap.add(new Point(RandomTrainer4.Model.centerX,RandomTrainer4.Model.centerY));
 RandomTrainer4.SightMap.add(new Point(RandomTrainer4.Model.centerX,RandomTrainer4.Model.centerY+1));
 RandomTrainer4.SightMap.add(new Point(RandomTrainer4.Model.centerX,RandomTrainer4.Model.centerY+2));
 RandomTrainer4.SightMap.add(new Point(RandomTrainer4.Model.centerX,RandomTrainer4.Model.centerY+3));


 var tileSheetColumn:Int = 4;
 var tileSheetRow:Int = 8;
 var Row = 41; var Column = 24;
 var TrainerModel = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
 var Youngster = new EnemyTrainer(TrainerModel);
 Youngster.ID = 5;
 Youngster.AvatarTile = 0204;
 Trainers.add(Youngster);
 Youngster.CurrentMonster = new Monster();
 Youngster.CurrentMonster.Character = "Tsunami Cat";
 Youngster.CurrentMonster.XP = 15;
 Youngster.CurrentMonster.LevelUp();
 Youngster.addNewMonster(Youngster.CurrentMonster);

  Youngster.Money = 5;
 _trainerMap[Youngster.Model.centerY][Youngster.Model.centerX] = Youngster.ID;
 Youngster.SightMap.add(new Point(Youngster.Model.centerX,Youngster.Model.centerY+1));
 Youngster.SightMap.add(new Point(Youngster.Model.centerX,Youngster.Model.centerY+2));
 Youngster.SightMap.add(new Point(Youngster.Model.centerX,Youngster.Model.centerY+3));
 Youngster.SightMap.add(new Point(Youngster.Model.centerX,Youngster.Model.centerY+4));

 var tileSheetColumn:Int = 5;
 var tileSheetRow:Int = 11;
 var Row = 73; var Column = 25;
 var TrainerModel = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
 var RandomTrainer5 = new EnemyTrainer(TrainerModel);
 RandomTrainer5.ID = 6;
 RandomTrainer5.AvatarTile = 0008;
 Trainers.add(RandomTrainer5);
 
 RandomTrainer5.CurrentMonster = new Monster();
 RandomTrainer5.CurrentMonster.Character = "Vine Cat";
 RandomTrainer5.CurrentMonster.XP = 780;
 RandomTrainer5.CurrentMonster.LevelUp();
 RandomTrainer5.addNewMonster(RandomTrainer5.CurrentMonster);

 var monster = new Monster();
 monster.Character = "Flower";
 monster.XP = 790;
 monster.LevelUp();
 RandomTrainer5.addNewMonster(monster);

 var monster = new Monster();
 monster.Character = "Leaf Sheep";
 monster.XP = 800;
 monster.LevelUp();
 RandomTrainer5.addNewMonster(monster);


 _trainerMap[RandomTrainer5.Model.centerY][RandomTrainer5.Model.centerX] = RandomTrainer5.ID;
 RandomTrainer5.SightMap.add(new Point(RandomTrainer5.Model.centerX,RandomTrainer5.Model.centerY));
 RandomTrainer5.SightMap.add(new Point(RandomTrainer5.Model.centerX,RandomTrainer5.Model.centerY+1));
 RandomTrainer5.SightMap.add(new Point(RandomTrainer5.Model.centerX,RandomTrainer5.Model.centerY+2));
 RandomTrainer5.Money = 10000;

 var tileSheetColumn:Int = 6;
 var tileSheetRow:Int = 11;
 var Row = 60; var Column = 35;
 var TrainerModel = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
 var RandomTrainer6 = new EnemyTrainer(TrainerModel);
 RandomTrainer6.ID = 7;
 RandomTrainer6.AvatarTile = 0108;
 Trainers.add(RandomTrainer6);
 RandomTrainer6.Money = 12000;
 
 RandomTrainer6.CurrentMonster = new Monster();
 RandomTrainer6.CurrentMonster.Character = "Flower";
 RandomTrainer6.CurrentMonster.XP = 800;
 RandomTrainer6.CurrentMonster.LevelUp();
 RandomTrainer6.addNewMonster(RandomTrainer6.CurrentMonster);

 var monster = new Monster();
 monster.Character = "Flower";
 monster.XP = 850;
 monster.LevelUp();
 RandomTrainer6.addNewMonster(monster);

 var monster = new Monster();
 monster.Character = "Flower";
 monster.XP = 900;
 monster.LevelUp();
 RandomTrainer6.addNewMonster(monster);


 _trainerMap[RandomTrainer6.Model.centerY][RandomTrainer6.Model.centerX] = RandomTrainer6.ID;
 RandomTrainer6.SightMap.add(new Point(RandomTrainer6.Model.centerX,RandomTrainer6.Model.centerY));
 RandomTrainer6.SightMap.add(new Point(RandomTrainer6.Model.centerX,RandomTrainer6.Model.centerY+1));
 RandomTrainer6.SightMap.add(new Point(RandomTrainer6.Model.centerX,RandomTrainer6.Model.centerY+2));


var tileSheetColumn:Int = 5;
 var tileSheetRow:Int = 12;
 var Row = 76; var Column = 41;
 var TrainerModel = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
 var RandomTrainer7 = new EnemyTrainer(TrainerModel);
 RandomTrainer7.ID = 8;
 RandomTrainer7.AvatarTile = 0208;
 Trainers.add(RandomTrainer7);
 
RandomTrainer7.Money = 13000;
 RandomTrainer7.CurrentMonster = new Monster();
 RandomTrainer7.CurrentMonster.Character = "Leaf Sheep";
 RandomTrainer7.CurrentMonster.XP = 950;
 RandomTrainer7.CurrentMonster.LevelUp();
 RandomTrainer7.addNewMonster(RandomTrainer7.CurrentMonster);

 var monster = new Monster();
 monster.Character = "Flower";
 monster.XP = 1050;
 monster.LevelUp();
 RandomTrainer7.addNewMonster(monster);

 var monster = new Monster();
 monster.Character = "Ember Bug";
 monster.XP = 1100;
 monster.LevelUp();
 RandomTrainer7.addNewMonster(monster);


 _trainerMap[RandomTrainer7.Model.centerY][RandomTrainer7.Model.centerX] = RandomTrainer7.ID;
 RandomTrainer7.SightMap.add(new Point(RandomTrainer7.Model.centerX,RandomTrainer7.Model.centerY));
 RandomTrainer7.SightMap.add(new Point(RandomTrainer7.Model.centerX,RandomTrainer7.Model.centerY+1));
 RandomTrainer7.SightMap.add(new Point(RandomTrainer7.Model.centerX,RandomTrainer7.Model.centerY+2));

var tileSheetColumn:Int = 6;
 var tileSheetRow:Int = 12;
 var Row = 73; var Column = 54;
 var TrainerModel = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
 var RandomTrainer8 = new EnemyTrainer(TrainerModel);
 RandomTrainer8.ID = 9;
 RandomTrainer8.AvatarTile = 0308;
 Trainers.add(RandomTrainer8);
 RandomTrainer8.Money = 15000;
 RandomTrainer8.CurrentMonster = new Monster();
 RandomTrainer8.CurrentMonster.Character = "Vine Cat";
 RandomTrainer8.CurrentMonster.XP = 1100;
 RandomTrainer8.CurrentMonster.LevelUp();
 RandomTrainer8.addNewMonster(RandomTrainer8.CurrentMonster);

 var monster = new Monster();
 monster.Character = "Lightning Cat";
 monster.XP = 1150;
 monster.LevelUp();
 RandomTrainer8.addNewMonster(monster);

 var monster = new Monster();
 monster.Character = "Rock Dog";
 monster.XP = 1300;
 monster.LevelUp();
 RandomTrainer8.addNewMonster(monster);


 _trainerMap[RandomTrainer8.Model.centerY][RandomTrainer8.Model.centerX] = RandomTrainer8.ID;
 RandomTrainer8.SightMap.add(new Point(RandomTrainer8.Model.centerX,RandomTrainer8.Model.centerY));
 RandomTrainer8.SightMap.add(new Point(RandomTrainer8.Model.centerX,RandomTrainer8.Model.centerY+1));
 RandomTrainer8.SightMap.add(new Point(RandomTrainer8.Model.centerX,RandomTrainer8.Model.centerY+2));

 var tileSheetColumn:Int = 3;
 var tileSheetRow:Int = 13;
 var Row = 42; var Column = 46;
 var TrainerModel = new TileModel
		  (
		    MAX_TILE_SIZE,
		    tileSheetColumn, tileSheetRow, 
		    Row, Column, 
		    MAX_TILE_SIZE, MAX_TILE_SIZE
		  );
 var RandomTrainer9 = new EnemyTrainer(TrainerModel);
 RandomTrainer9.ID = 10;
 RandomTrainer9.AvatarTile = 0408;
 Trainers.add(RandomTrainer9);
 
 RandomTrainer9.CurrentMonster = new Monster();
 RandomTrainer9.CurrentMonster.Character = "Hippo";
 RandomTrainer9.CurrentMonster.XP = 3240;
 RandomTrainer9.CurrentMonster.LevelUp();
 RandomTrainer9.addNewMonster(RandomTrainer9.CurrentMonster);

RandomTrainer9.Money = 25000;

 var monster = new Monster();
 monster.Character = "Storm Dragon";
 monster.XP = 3344;
 monster.LevelUp();
 RandomTrainer9.addNewMonster(monster);

 var monster = new Monster();
 monster.Character = "Unicorn";
 monster.XP = 3540;

 monster.LevelUp();
 RandomTrainer9.addNewMonster(monster);

 _trainerMap[RandomTrainer9.Model.centerY][RandomTrainer9.Model.centerX] = RandomTrainer9.ID;
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX,RandomTrainer9.Model.centerY));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX,RandomTrainer9.Model.centerY+1));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX,RandomTrainer9.Model.centerY+2));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX,RandomTrainer9.Model.centerY+3));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX,RandomTrainer9.Model.centerY+4));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX,RandomTrainer9.Model.centerY+5));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX,RandomTrainer9.Model.centerY+6));

 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX-1,RandomTrainer9.Model.centerY));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX-1,RandomTrainer9.Model.centerY+1));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX-1,RandomTrainer9.Model.centerY+2));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX-1,RandomTrainer9.Model.centerY+3));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX-1,RandomTrainer9.Model.centerY+4));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX-1,RandomTrainer9.Model.centerY+5));
 RandomTrainer9.SightMap.add(new Point(RandomTrainer9.Model.centerX-1,RandomTrainer9.Model.centerY+6));
 
}

public function updateCharacterMap()
{
  for(mapColumn in 0...MAP_WIDTH)
  {
    for(mapRow in 0...MAP_HEIGHT)
    {
      _characterMap[mapRow][mapColumn] = -1;
    }
  }
  for(char in Characters)
  {
    _characterMap[char.centerY][char.centerX] = char.ID;
  }
}

public function updateTrainerMap()
{
  for(mapColumn in 0...MAP_WIDTH)
  {
    for(mapRow in 0...MAP_HEIGHT)
    {
      _trainerMap[mapRow][mapColumn] = -1;
      _trainerSightMap[mapRow][mapColumn] = -1;
    }
  }

  for(trainer in Trainers)
  {
    _trainerMap[trainer.Model.centerY][trainer.Model.centerX] = trainer.ID;
    if(trainer.Battled == false)
    {
      for(point in trainer.SightMap)
      {
	_trainerSightMap[Std.int(point.y)][Std.int(point.x)]= trainer.ID;
      }
    }
  }

}
public function initializeBuilding()
{
  Buildings = null;
  Buildings = new List<Building>();
  Buildings.add(new BuildingHome());
  Buildings.add(new BuildingCityHall());
  Buildings.add(new BuildingHealthCenter1());
  Buildings.add(new BuildingGym1());
  Buildings.add(new BuildingMart1());
  Buildings.add(new BuildingYouthCenter());
  Buildings.add(new BuildingGym2());
  Buildings.add(new BuildingHealthCenter2());
  Buildings.add(new BuildingMart2());
  Buildings.add(new BuildingHealthCenter3());
  Buildings.add(new BuildingGym3());
  Buildings.add(new BuildingMart3());
  Buildings.add(new BuildingHealthCenter4());
  Buildings.add(new BuildingGym4());
  Buildings.add(new BuildingHealthCenter5());
  Buildings.add(new BuildingMart4());
  Buildings.add(new BuildingCastle1());
  Buildings.add(new BuildingCastle2());
  Buildings.add(new BuildingCastle3());
  Buildings.add(new BuildingCastle4());
}
public function loadSavedData()
{

}
public function initializeNewData(?inContinue:Bool=false)
{

  
  currentPlot = new Plot();
  
  MainTrainer = new Trainer();
  if(inContinue)
  {
   try
    {
      var savedData = SharedObject.getLocal("GameData");
      if(savedData.data.MainTrainer != null)
      {
	 MainTrainer = savedData.data.MainTrainer;
	 currentPlot = savedData.data.Plot;
//      _MainCharacterModel.xPos = savedData.data.ModelXPos;
//      _MainCharacterModel.yPos = savedData.data.ModelYPos;
//      _MainCharacterModel.direction = savedData.data.ModelDirection;
	
// 	 MainTrainer.Money = savedData.data.Money;
// 	 MainTrainer.Monsters = savedData.data.Monsters;
// 	 MainTrainer.MonstersArchive = savedData.data.MonstersArchive;
// 	 MainTrainer.CurrentMonster = savedData.data.CurrentMonster;
// 	 Items = savedData.data.CurrentInventory;
// 	 trace(savedData.data.Monsters);
// 	 trace(MainTrainer.Money);
      }
    }
    catch(err:Dynamic)
    {trace(err);}
  }
  else
  {
    MainTrainer.AvatarTile = 0101;
    MainTrainer.Money = 1200;
    MainTrainer.CurrentMonster = new Monster();
    MainTrainer.CurrentMonster.XP = 100;
    MainTrainer.CurrentMonster.LevelUp(); 
    MainTrainer.addNewMonster(MainTrainer.CurrentMonster);
// var item = new Item(new Point(),"Potion");
// MainTrainer.CurrentInventory.add(item);
    for(i in 0...3) 
    {
      var item = new Item();
      item.updateItem(new Point(),"Potion");
      MainTrainer.CurrentInventory.add(item);
    }
  }

  pauseMenu = new PauseMenu(MainTrainer,currentPlot,kongVar);
  pauseMenu.addEventListener("Quit",onQuit);
  pauseMenu.addEventListener("Save",onSave);

  currentBuilding = new BuildingHome();
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
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown );
      stage.removeEventListener(KeyboardEvent.KEY_UP, OnKeyUp );
      flash.Lib.current.removeChild(this);
      //_MainCharacterController = null;


  }

public function Load(inContinue:Bool, inVolume:Bool,inKongVar:CKongregate)
{
//   removeChild(WorldMap);
// WorldMap = new Sprite();
//   addChild(WorldMap);
  kongVar = inKongVar;
  initializeNewData(inContinue);
//   LoadMapData();
//  LoadTrainerData();
// 
//    buildMap(_terrainMap,_terrainBitmapData);
//    buildMap(_backgroundMap,_backgroundBitmapData);
//   buildMap(_frontMap,_frontBitmapData);
//    buildMap(_doorsMap,_doorsBitmapData);
//    drawItems();
// 
//     WorldMap.addChild(_terrainBitmap);
//     WorldMap.addChild(_backgroundBitmap);
//     WorldMap.addChild(_doorsBitmap);
//     WorldMap.addChild(_itemsBitmap);
//     WorldMap.addChild(_foregroundBitmap);
//     WorldMap.addChild(_frontBitmap);
  //addChild(WorldMap);
  checkBackground();
  this.visible =false;
  flash.Lib.current.addChild(this); 
  this.addEventListener(Event.ENTER_FRAME, OnEnter);
  stage.focus = stage;
  volume = inVolume;

  buildMap(_gameObjectMap,_foregroundBitmapData);

// 	_MainCharacterModel.setX = 55*MAX_TILE_SIZE;
// 	_MainCharacterModel.setY = 28*MAX_TILE_SIZE;
  if(inContinue)
  {
    try
    {
      var savedData = SharedObject.getLocal("GameData");
      if(savedData.data.ModelXPos != null)
      {
	_MainCharacterModel.setX = savedData.data.ModelXPos;
	_MainCharacterModel.setY = savedData.data.ModelYPos;
	_MainCharacterModel.direction = savedData.data.ModelDirection;
	_backgroundMap = savedData.data.BackgroundMap;
	_terrainMap = savedData.data.TerrianMap;
	Items = savedData.data.Items;
  
	var savedBuildingList:BuildingDataList = savedData.data.BuildingDataList;
	for(building in Buildings)
	{
	  for(buildingData in savedBuildingList)
	  {
	    if(buildingData.Location.x == building.MapDoorLocation.x 
	      && buildingData.Location.y == building.MapDoorLocation.y)
	    {
	      building._backgroundMap = buildingData.BackgroundMap;
	      building.redraw();
	      for(trainer in building.Trainers)
	      {
		var found = false;
		for(enemyTrainerData in buildingData.Trainers)
		{	    
		  if(trainer.ID == enemyTrainerData.ID)
		  {
		    found = true;
		    trainer.Model.setX = enemyTrainerData.Location.x;
		    trainer.Model.setY = enemyTrainerData.Location.y;
		    trainer.Battled = enemyTrainerData.Battled;
		    break;
		  }
		}
		if(!found)
		{
		    Trainers.remove(trainer);
		}
	      }
	      building.updateTrainerMap();

	    for(char in building.Characters)
	    {
	      var found = false;
	      for(charData in buildingData.Characters)
	      {	    
		if(char.ID == charData.ID)
		{
		  found = true;
		  char.setX = charData.Location.x;
		  char.setY = charData.Location.y;
		  char.TalkedTo = charData.TalkedTo;
		  break;
		}
	      }
	      if(!found)
	      {
		Characters.remove(char);
	      }
	    }
	    building.updateCharacterMap();   
	    }
	  }

	}

	var savedTrainerList:EnemyTrainerDataList = savedData.data.EnemyTrainerDataList;
	for(trainer in Trainers)
	{
	  var found = false;
	  for(enemyTrainerData in savedTrainerList)
	  {	    
	    if(trainer.ID == enemyTrainerData.ID)
	    {
	      found = true;
	      trainer.Model.setX = enemyTrainerData.Location.x;
	      trainer.Model.setY = enemyTrainerData.Location.y;
	      trainer.Battled = enemyTrainerData.Battled;
	      break;
	    }
	  }
	    if(!found)
	    {
	      Trainers.remove(trainer);
	    }
	}
	updateTrainerMap();

	var savedCharactersList:CharactersDataList = savedData.data.CharactersDataList;
	for(char in Characters)
	{
	  var found = false;
	  for(charData in savedCharactersList)
	  {	    
	    if(char.ID == charData.ID)
	    {
	      found = true;
	      char.setX = charData.Location.x;
	      char.setY = charData.Location.y;
	      char.TalkedTo = charData.TalkedTo;
	      break;
	    }
	  }
	  if(!found)
	  {
	    Characters.remove(char);
	  }
	}
	updateCharacterMap();
      }
    }
    catch(err:Dynamic)
    {trace(err);}
  }
  //_MainCharacterModel.setY = 25*MAX_TILE_SIZE;_MainCharacterModel.setX = 25*MAX_TILE_SIZE;
  
  MAP_X = Math.floor((_MainCharacterModel.xPos/MAX_TILE_SIZE)/40)*40;
  MAP_Y = (Math.floor((_MainCharacterModel.yPos/MAX_TILE_SIZE)/40)*40);
  
  updateGymCost();
  redraw();
  
  
  stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown );
  stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp );
  _camera = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
  setCamera();
  frameTurn();
  this.visible =true;

}

public function buildItems()
{
  //Column then Row
  var item = new Item();
  item.updateItem(new Point(0,2),"Potion");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(0,2),"Potion");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(7,6),"3000");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(20,13),"500");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(2,17),"Full Restore");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(0,25),"10 Capture Devices");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(0,38),"Potion");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(0,38),"Potion");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(0,38),"Potion");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(0,38),"Potion Group");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(0,38),"10000");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(11,28),"5000");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(13,34),"Full Heal");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(26,28),"MP Restore");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(25,28),"MP Restore");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(26,29),"500");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(37,44),"1000");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(0,42),"Full Restore Group");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(0,52),"Full Heal Group");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(32,52),"5000");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(38,47),"MP Full Restore");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(25,77),"Potion+");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(33,68),"Potion+");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(24,60),"Potion+ Group");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(0,70),"Potion+ Group");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(38,79),"2500");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(43,79),"MP Restore Group");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(49,60),"MP Full Restore Group");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(46,66),"500");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(55,68),"1000");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(46,75),"10 Capture Devices");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(73,79),"Full Restore Group");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(73,77),"Potion+");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(73,75),"3600");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(41,58),"Full Restore");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(41,58),"Full Restore");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(41,58),"Full Restore");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(42,42),"Potion+");
  Items.add(item);
  var item = new Item();
  item.updateItem(new Point(42,42),"MP Full Restore");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(41,17),"MP Full Restore Group");
  Items.add(item);

  var item = new Item();
  item.updateItem(new Point(77,17),"10000");
  Items.add(item);


}
public function drawItems()
{
  _itemsMap = [[]];
  
  for(mapRow in 0...MAP_HEIGHT)
  {
    _itemsMap[mapRow] = [];
  }
  for(mapColumn in 0...MAP_WIDTH)
  {
    for(mapRow in 0...MAP_HEIGHT)
    {
      _itemsMap[mapRow][mapColumn] = -1;
    }
  }
  for (item in Items)
  {	
      _itemsMap[Std.int(item.LocationY)][Std.int(item.LocationX)] = 0200;
  }
  _itemsBitmapData.fillRect(_itemsBitmapData.rect, 0);
  buildMap(_itemsMap,_itemsBitmapData);
  
}

  //Create tile Models and map them to the
  //correct positions on the tile sheet
  private function buildMap(map:Array<Array<Int>>,mapBitmapData:BitmapData)
  {
    for(mapColumn in (0+MAP_X)...(MAP_COLUMNS+MAP_X))
    {
      for(mapRow in (0+MAP_Y)...(MAP_ROWS+MAP_Y))
      {
// 	trace(mapRow + "," + mapColumn);
// 	trace(map);
	var currentTile:Int = map[mapRow][mapColumn];

	if(currentTile > -1)
	{
	  //Find the tile's column and row position
	  //on the tile sheet
	  var tileSheetColumn:Int = Std.int(currentTile / 100);
	  var tileSheetRow:Int = Std.int(currentTile % 100);
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
public function redraw()
{
   _terrainBitmapData.fillRect(_terrainBitmapData.rect, 0); 
   _backgroundBitmapData.fillRect(_backgroundBitmapData.rect, 0);
   _frontBitmapData.fillRect(_frontBitmapData.rect, 0);
   _doorsBitmapData.fillRect(_doorsBitmapData.rect, 0);
   _foregroundBitmapData.fillRect(_foregroundBitmapData.rect, 0);

   buildMap(_terrainMap,_terrainBitmapData);
   buildMap(_backgroundMap,_backgroundBitmapData);
   buildMap(_doorsMap,_doorsBitmapData);
   buildMap(_frontMap,_frontBitmapData);
   drawItems();
}
function getInsideBuilding(x:Int,y:Int)
{
    
    for(building in Buildings)
    {
      if(building.MapDoorLocation.x == x && building.MapDoorLocation.y == y)
	{
	  currentBuilding = building;
	  currentBuilding.EnterLocation2 = false;
	}
      else if(building.MapDoorLocation2.x == x && building.MapDoorLocation2.y == y)
	{
	  currentBuilding = building;
	  currentBuilding.EnterLocation2 = true;
	}

    }

    if(currentBuilding.Cost < 0)
    {
      removeChild(WorldMap);
      currentBuilding.LoadBuilding(volume,kongVar,MainTrainer,currentPlot);
      addChild(currentBuilding);
      currentBuilding.addEventListener("Exit",onBuildingExit);
      currentBuilding.addEventListener("Save",onSave);
      State = "";
    }
    else
    {
      State = "WaitForPrompt";
      addChild(TextBox);
      Text.htmlText = "<font size='16'>It Costs "+currentBuilding.Cost+" To enter. Enter?</font>";
      TextBox.addChild(PromptYes);
      TextBox.addChild(PromptNo);
    }
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
  
  if(_characterMap[y][x] > 0)
  {
    getCharacterText(_characterMap[y][x]);
  }
  if(_trainerMap[y][x] > 0)
  {
    getTrainerText(_trainerMap[y][x]);
  }
  
}

public function getTrainerText(ID:Int)
{
  for(char in Trainers)
  {
    if(ID ==  char.ID)
    {
      currentTrainer = char;
      break;
    }
  }
  currentTalkingStep = -1;
  if(_MainCharacterModel.centerY < 3)
  {
    TextBox.y = 412;
  }
  else
  {
    TextBox.y = 0;
  }
  WorldMap.addChild(TextBox);
  State = "TrainerDialogWait";
  getTrainerNextLine();  
}

public function getCharacterText(ID:Int)
{
  for(char in Characters)
  {
    if(ID ==  char.ID)
    {
      currentTalkingCharacter = char;
      break;
    }
  }
  currentTalkingStep = -1;
  if(_MainCharacterModel.centerY < 3)
  {
    TextBox.y = 412;
  }
  else
  {
    TextBox.y = 0;
  }
  WorldMap.addChild(TextBox);
  State = "CharacterDialogWait";
  getNextLine();  
}
public function getTrainerNextLine()
{

  currentTalkingStep++;
  if(currentTrainer.ID == 1)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I have peripheral vision!</font>";
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
	  Text.htmlText = "<font size='16'>Peripheral vision is the ability to see out of the corner of your eye.</font>";
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
  else if(currentTrainer.ID == 2)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>Red or Green? Which do you think is better?</font>";
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
	  Text.htmlText = "<font size='16'>I have a hard time making decisions.</font>";
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
  else if(currentTrainer.ID == 4)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>Man, this lake brings back memories.</font>";
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
	  Text.htmlText = "<font size='16'>I vaguely remember a girl who looked a lot like you. When ever I came to the lake I would see her here with her family.</font>";
	}
	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>But then 4 years ago she stop coming.  I wonder what happened.</font>";
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
else if(currentTrainer.ID == 5)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I won't let you get any further.</font>";
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
	  Text.htmlText = "<font size='16'>Youngster: I don't like strange people. They're scary.</font>";
	}
	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>Corliss:...</font>";
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
else if(currentTrainer.ID == 6)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I can barely see anything with hairdo, but  it's totally worth it.</font>";
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
	  Text.htmlText = "<font size='16'>Looks are very important. Wouldn't you agree?</font>";
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
else if(currentTrainer.ID == 7)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I Like Flowers, do you have problem with that!</font>";
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
	  Text.htmlText = "<font size='16'>Please, don't laugh...</font>";
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
else if(currentTrainer.ID == 8)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I won't lose to a girl.</font>";
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
	else
	{
	  WorldMap.removeChild(TextBox);
	  State = "Playing";
	  currentTalkingStep = -1;
	  currentTrainer = null;
	}

    }
  }
else if(currentTrainer.ID == 9)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>Am I near an exit?</font>";
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
	  Text.htmlText = "<font size='16'>I always get lost in this forest.</font>";
	}
      	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>I can never tell which way is away from my house, and which way is towards it.</font>";
	}
      	else if(currentTalkingStep == 2)
	{
	  Text.htmlText = "<font size='16'>Someone should invent a device for that.</font>";
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
else if(currentTrainer.ID == 10)
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I just got my trainer's license a couple months ago. Isn't it exciting! I've been training ever since I was 4, so I'm pretty good at this.</font>";
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
	  Text.htmlText = "<font size='16'>Huh, I lost...</font>";
	}
      	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>I've never lost before...</font>";
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
else
  {
     if(!currentTrainer.Battled)
     {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>I can't think of anything witty to say..</font>";
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
	else
	{
	  WorldMap.removeChild(TextBox);
	  State = "Playing";
	  currentTalkingStep = -1;
	  currentTrainer = null;
	}

    }
  }


// if(currentTrainer.ID == 3)
//   {
//      if(!currentTrainer.Battled)
//      {
// 	if(currentTalkingStep == 0)
// 	{
// 	  Text.htmlText = "<font size='16'>Your Trainer's card says your 13.  Isn't that a little old to start Traiining?</font>";
// 	}
// 	else
// 	{
// 	  WorldMap.removeChild(TextBox);
// 	  State = "BattleFlash1";
// 	  currentTalkingStep = -1;
// 	}
//      }
//     else
//     {
//       	if(currentTalkingStep == 0)
// 	{
// 	  Text.htmlText = "<font size='16'>Congrats. You beat me! But it only get harder from here on out.</font>";
// 	}
// 	else
// 	{
// 	  WorldMap.removeChild(TextBox);
// 	  State = "Playing";
// 	  currentTalkingStep = -1;
// 	  currentTrainer = null;
// 	}
//     }
//    }
}

public function getNextLine()
{
  currentTalkingStep++;
  if(currentTalkingCharacter.ID == 100)
  {
    if(currentTalkingCharacter.TalkedTo == 0)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>Some Guy: Have Some Potions</font>";
      }
      else if(currentTalkingStep == 1)
      {
	Text.htmlText = "<font size='16'>You got 5 Potions!</font>";
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
	Text.htmlText = "<font size='16'>That's it.</font>";
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
    if(currentTalkingCharacter.TalkedTo == 0)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>Corliss: OMG! Nathan is that you?</font>";
      }
      else if(currentTalkingStep == 1)
      {
	Text.htmlText = "<font size='16'>Nathan: Been a while, hasn't it.</font>";
      }
      else if(currentTalkingStep == 2)
      {
	Text.htmlText = "<font size='16'>Corliss: Hugs!</font>";
      }
      else if(currentTalkingStep == 3)
      {
	Text.htmlText = "<font size='16'>*Hugs*</font>";
      }
      else if(currentTalkingStep == 4)
      {
	Text.htmlText = "<font size='16'>Corliss: How Have been?</font>";
      }
      else if(currentTalkingStep == 5)
      {
	Text.htmlText = "<font size='16'>Nathan: Great! I opened a Youth Training Center last year. I teach kids how to train Monsters, about what its like to be a trainer, and help them get their first Monster, when they turn 8 of course.   Mostly 6 or 7 years.  But I have some even younger, you know parents always trying to give they're kids ahead start. </font>";
      }
      else if(currentTalkingStep == 6)
      {
	Text.htmlText = "<font size='16'>Corliss: Nice! Helping out little kids, that is so like you.</font>";
      }
      else if(currentTalkingStep == 7)
      {
	Text.htmlText = "<font size='16'>Nathan: Yeah.</font>";
      }
      else if(currentTalkingStep == 8)
      {
	Text.htmlText = "<font size='16'>Nathan: So, you're a trainer now.  I didn't expect that.</font>";
      }
      else if(currentTalkingStep == 9)
      {
	Text.htmlText = "<font size='16'>Nathan: I mean, I know mom and dad wanted you to, but you never seemed interested.</font>";
      }
      else if(currentTalkingStep == 10)
      {
	Text.htmlText = "<font size='16'>Corliss:...</font>";
      }
      else if(currentTalkingStep == 11)
      {
	Text.htmlText = "<font size='16'>Nathan: Hey, You probably need that plant removed.  It's actually surpising effect in keeping kids from going into town.</font>";
      }
      else if(currentTalkingStep == 12)
      {
	Text.htmlText = "<font size='16'>*Removes Plant*</font>";
	Characters.remove(Nathan);
	_backgroundMap[56][17] = -1;
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
      }
      else if(currentTalkingStep == 13)
      {
	Characters.add(Nathan);
	updateCharacterMap();
	_backgroundMap[56][17] =-1;
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
	Text.htmlText = "<font size='16'>Nathan: Hey, check out my Youth center</font>";
      }
      else
      {
	Characters.remove(Nathan);
	_characterMap[Nathan.centerY][Nathan.centerX] = -1;
	updateCharacterMap();
	currentTalkingStep = -1;
	WorldMap.removeChild(TextBox);
	currentTalkingCharacter.TalkedTo += 1;
	State = "Playing";
	currentPlot.State = "Nathan Inside";
	_MainCharacterModel.setX = 14 * MAX_TILE_SIZE; 
	_MainCharacterModel.setY = 47 * MAX_TILE_SIZE;
      }
    }
    else
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>That's it.</font>";
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
  else if(currentTalkingCharacter.ID == 1)
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
	currentPlot.State = "Step Outside";
	currentTalkingStep = -1;
	WorldMap.removeChild(TextBox);
	currentTalkingCharacter.TalkedTo += 1;
	State = "Playing";
      }
    }
    else if(currentTalkingCharacter.TalkedTo == 1)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>Corliss: Are you ready?</font>";
      }
      else if(currentTalkingStep == 1)
      {
	Text.htmlText = "<font size='16'>Zaki: Ready as I'll ever be.</font>";
      }
      else
      {
	currentTalkingStep = -1;
	WorldMap.removeChild(TextBox);
	currentTalkingCharacter.TalkedTo += 1;
	
	ZakiTrainer = new EnemyTrainer(currentTalkingCharacter);
	ZakiTrainer.AvatarTile = 0102;
	ZakiTrainer.CurrentMonster = new Monster();
	ZakiTrainer.CurrentMonster.XP = 115;
	ZakiTrainer.CurrentMonster.Character = "Lightning Cat";
	ZakiTrainer.CurrentMonster.LevelUp(); 
	ZakiTrainer.addNewMonster(ZakiTrainer.CurrentMonster);

	currentTrainer = ZakiTrainer;
	//init Battle;
	State = "BattleFlash1";
      }
    }
    else if(currentTalkingCharacter.TalkedTo == 2)
    {
      if(currentTalkingStep == 0)
      {
	Text.htmlText = "<font size='16'>Zaki:...</font>";
      }
      else if(currentTalkingStep == 1)
      {
	Text.htmlText = "<font size='16'>Zaki: Do you really have to go?</font>";
      }
      else if(currentTalkingStep == 2)
      {
	Text.htmlText = "<font size='16'>Corliss: Yeah, I think its time.</font>";
      }
      else if(currentTalkingStep == 3)
      {
	Text.htmlText = "<font size='16'>Corliss: You should have enough in the account for a year or so.</font>";
      }
      else if(currentTalkingStep == 4)
      {
	Text.htmlText = "<font size='16'>Corliss: I'll try to send money home when I can.</font>";
      }
      else if(currentTalkingStep == 5)
      {
	Text.htmlText = "<font size='16'>Corliss: Take care of Chris and Paul. You can do it.</font>";
      }
      else if(currentTalkingStep == 6)
      {
	Text.htmlText = "<font size='16'>Zaki:...</font>";
      }
      else if(currentTalkingStep == 7)
      {
	Text.htmlText = "<font size='16'>Corliss: *hugs*.</font>";
      }
      else if(currentTalkingStep == 8)
      {
	Text.htmlText = "<font size='16'>Corliss: Good Luck.</font>";
      }
      else if(currentTalkingStep == 9)
      {
	Text.htmlText = "<font size='16'>Zaki:...</font>";
      }
      else
      {
	Characters.remove(currentTalkingCharacter);
	updateCharacterMap();
	redraw();
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
  else if(currentTalkingCharacter.ID == 4)
  {
    if(currentTalkingCharacter.TalkedTo == 0)
      {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>Corliss: Do you have my badge?</font>";
	}
	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>Mayor: I have one trainer's card for a “Eve Corliss Hamlet”.</font>";
	}
	else if(currentTalkingStep == 2)
	{
	  Text.htmlText = "<font size='16'>You got a Trainer Badge.</font>";
	  currentPlot.HasTrainerBadge = true;
	  currentPlot.BridgeOpen = true;
	}
	else if(currentTalkingStep == 3)
	{
	  Text.htmlText = "<font size='16'>Mayor: Wouldn't it be easier to go by eve?</font>";
	}
	else if(currentTalkingStep == 4)
	{
	  Text.htmlText = "<font size='16'>Corliss: I never liked eve, It's such a horrible name.</font>";
	}
	else if(currentTalkingStep == 5)
	{
	  Text.htmlText = "<font size='16'>Mayor: I see...</font>";
	}
	else if(currentTalkingStep == 5)
	{
	  Text.htmlText = "<font size='16'>Mayor: Anyways, These will help you on your journey.</font>";
	}
	else if(currentTalkingStep == 6)
	{
	  Text.htmlText = "<font size='16'>You got a Monster Wiki.\nYou got 12 Capture Devices;</font>";
	  
	  for(i in 0...12) 
	  {
	    var item = new Item();
	    item.updateItem(new Point(),"Capture Device");
	    MainTrainer.CurrentInventory.add(item);
	  }
	  currentPlot.HasMonsterWiki = true;
	}
	else if(currentTalkingStep == 7)
	{
	  Text.htmlText = "<font size='16'>Mayor: Well, any questions?</font>";
	}
	else if(currentTalkingStep == 8)
	{
	  Text.htmlText = "<font size='16'>Corliss:Can I go?</font>";
	}
	else if(currentTalkingStep == 9)
	{
	  Text.htmlText = "<font size='16'>Mayor:...</font>";
	}
	else if(currentTalkingStep == 10)
	{
	  Text.htmlText = "<font size='16'>Mayor: Take Care.</font>";
	}
	else if(currentTalkingStep == 11)
	{
	  Text.htmlText = "<font size='16'>Corliss: Yeah, whatever.</font>";
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
	  Text.htmlText = "<font size='16'>Sorry, that's all i can give you.</font>";
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
  else if(currentTalkingCharacter.ID == 5)
  {
    if(currentTalkingCharacter.TalkedTo >= 0)
      {
	if(currentTalkingStep == 0)
	{
	  Text.htmlText = "<font size='16'>Nurse: What the point in trying.  All you get is pain.</font>";
	}
	else if(currentTalkingStep == 1)
	{
	  Text.htmlText = "<font size='16'>Corliss:...</font>";
	}
	else if(currentTalkingStep == 2)
	{
	  Text.htmlText = "<font size='16'>Corliss: Just Heal my Monsters.</font>";
	}
	else if(currentTalkingStep == 3)
	{
	  Text.htmlText = "<font size='16'>Healed.</font>";
	  HealMonsters();
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

public function HealMonsters()
{
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
public function getObjectText(y:Int,x:Int)
{
  //trace(x + " " + y);
  if(x == 59 && y == 23)
  {
    Text.htmlText = "<font size='16'>Need 4 badges to enter.</font>";
    State = "addText";
  }
  if(x == 17 && y == 56)
  {
    Text.htmlText = "<font size='16'>It's a small plant.  There is definitely no way around that.</font>";
    State = "addText";
  }
  if(x == 6 && y == 8)
  {
    Text.htmlText = "<font size='16'>Go Home. Say Goodbye.</font>";
    State = "addText";
  }
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
    if(item.LocationX == x && item.LocationY == y)
      {
	TryToPickUpItem(item);
	break;
      }
  }
  drawItems();
}

public function TryToPickUpItem(item:Item)
{
  if(item.ID == "10 Capture Devices")
  {
      Text.htmlText = "<font size='16'>You got "+item.ID+"!<font size='16'>";
      State = "addText";
    for(temp in 0...10)
    {

      var caputureDevice = new Item();
      item.updateItem(new Point(),"Capture Device");
      MainTrainer.CurrentInventory.add(item);
    }
  
  }
  else if(item.ID == "Potion" || item.ID == "Potion Group" || item.ID == "Full Restore" ||
     item.ID == "Capture Device" || item.ID == "Full Heal" || item.ID == "Full Heal Group" ||
     item.ID == "Full Restore Group" || item.ID == "MP Restore" || item.ID == "MP Restore Group" ||
     item.ID == "MP Full Restore" || item.ID == "MP Full Restore Group" || item.ID == "Potion+" ||
     item.ID == "Potion+ Group" ) 
  {
      Text.htmlText = "<font size='16'>You got a "+item.ID+"!<font size='16'>";
      MainTrainer.CurrentInventory.add(item);
      State = "addText";
      Items.remove(item);
  }
  else
  {
      try
      {
	var money = Std.parseInt(item.ID);
	if(money > 0)
	{
	  Text.htmlText = "<font size='16'>Your Money Increased by " + money + "<font size='16'>";
	  State = "addText";
	  MainTrainer.Money += money;
	  Items.remove(item);
	}
	else
	{
	  State = "Playing";
	}
      }
      catch (e:Dynamic)
      {
	State = "Playing";
      }
  }
}
public function checkBackground()
{
  if(currentPlot.BridgeOpen)
  {
    _backgroundMap[12][4] = -1;
    redraw();
	for(char in Characters)
	{
	drawGameObject(char, _foregroundBitmapData);
	}
	for(trainer in Trainers)
	{
	   drawGameObject(trainer.Model, _foregroundBitmapData);
	}
	if(_MainCharacterModel != null)
	{
	  drawGameObject(_MainCharacterModel, _foregroundBitmapData);
	}
  }
  if(currentPlot.BridgeBroken)
  {
    _terrainMap[13][4] = STRM;
    _backgroundMap[13][4] = BRKN;
    redraw();
	for(char in Characters)
	{
	drawGameObject(char, _foregroundBitmapData);
	}
	for(trainer in Trainers)
	{
	   drawGameObject(trainer.Model, _foregroundBitmapData);
	}
	if(_MainCharacterModel != null)
	{
	  drawGameObject(_MainCharacterModel, _foregroundBitmapData);
	}
  }
  else
  {
    _terrainMap[13][4] = BRDG;
    _backgroundMap[13][4] = -1;
    redraw();
	for(char in Characters)
	{
	drawGameObject(char, _foregroundBitmapData);
	}
	for(trainer in Trainers)
	{
	   drawGameObject(trainer.Model, _foregroundBitmapData);
	}
	if(_MainCharacterModel != null)
	{
	  drawGameObject(_MainCharacterModel, _foregroundBitmapData);
	}
  }
  if(currentPlot.JoyBadge && currentPlot.AngerBadge &&
     currentPlot.ConfusionBadge && currentPlot.BlankBadge)
  {
    _backgroundMap[23][59] = -1;
    redraw();
	for(char in Characters)
	{
	drawGameObject(char, _foregroundBitmapData);
	}
	for(trainer in Trainers)
	{
	   drawGameObject(trainer.Model, _foregroundBitmapData);
	}
	if(_MainCharacterModel != null)
	{
	  drawGameObject(_MainCharacterModel, _foregroundBitmapData);
	}
  }
}
public function onBuildingExit(event:Event)
{
    try
    {


      try
      {
	var Badges = 0;
	if(currentPlot.JoyBadge)
	{
	Badges++;
	}
	if(currentPlot.AngerBadge)
	{
	Badges++;
	}
	if(currentPlot.ConfusionBadge)
	{
	Badges++;
	}
	if(currentPlot.BlankBadge)
	{
	Badges++;
	}
	kongVar.SubmitStat("Badges", Badges);
      }

      catch (e:Dynamic)
      {

      }
      
      if(currentPlot.State ==  "Home Talk")
      {
	currentPlot.State = "Won";
      }
      checkBackground();
      updateGymCost();

      if(currentPlot.State == "Step Outside")
      {
	var tileSheetColumn:Int = Std.int(0204 / 100);
	var tileSheetRow:Int = Std.int(0204 % 100);
	var Row = 4; var Column = 5;
	var ZakI = new Character
			  (
			    MAX_TILE_SIZE,
			    tileSheetColumn, tileSheetRow, 
			    Row, Column, 
			    MAX_TILE_SIZE, MAX_TILE_SIZE
			  );
	Characters.add(ZakI);
	ZakI.ID = 1;
	_characterMap[ZakI.centerY][ZakI.centerX] = ZakI.ID;
	currentTalkingCharacter = ZakI;
	ZakI.TalkedTo = 1;
	currentPlot.State = "Steped Outside";
	updateCharacterMap();
	redraw();
	for(char in Characters)
	{
	drawGameObject(char, _foregroundBitmapData);
	}
	for(trainer in Trainers)
	{
	   drawGameObject(trainer.Model, _foregroundBitmapData);
	}

      }
      currentBuilding.removeEventListener("Exit",onBuildingExit);
      if(currentBuilding.ExitLocation.x == 58 &&
      currentBuilding.ExitLocation.y == 12)
      {
	currentPlot.BridgeBroken =false;
	checkBackground();
	if(currentPlot.State == "Beat Game")
	{
	  currentPlot.State = "Go Home End";
	}
	MAP_X = 0;MAP_X = 0;
      _MainCharacterModel.setY = 10 * MAX_TILE_SIZE;
      _MainCharacterModel.setX = 4 * MAX_TILE_SIZE;	
	redraw();
	for(char in Characters)
	{
	drawGameObject(char, _foregroundBitmapData);
	}
	for(trainer in Trainers)
	{
	   drawGameObject(trainer.Model, _foregroundBitmapData);
	}
      }
      else
      {
      _MainCharacterModel.setY = currentBuilding.ExitLocation.y * MAX_TILE_SIZE;
      _MainCharacterModel.setX = currentBuilding.ExitLocation.x * MAX_TILE_SIZE;
      }
      removeChild(currentBuilding);
      
      State = "Playing";
      addChild(WorldMap);
    }
    catch(e:Dynamic)
    {
      trace(e);
    }

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
	  if(event.keyCode ==  80)
	  {
	      if(Pause == "Paused")
                {
                  Pause = "UnPaused";
		  removeChild(pauseMenu);
		  stage.focus = stage;
                }
              else 
                {
                  Pause = "Paused";
		  pauseMenu.redraw(currentPlot.HasMonsterWiki);
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
	else if(State == "CharacterDialogWait")
	{
	  getNextLine();
	}
	else if(State == "TrainerDialogWait")
	{
	  getTrainerNextLine();
	}
	else if(State == "StartTrainerBattleText")
	{
	  WorldMap.removeChild(TextBox);
	  State = "BattleFlash1";
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

public function WaitForXFrames(inFrames:Int)
{
  WaitTime++;
  if(WaitTime > inFrames)
  {
    return true;
  }
  return false;
}
public function setCamera()
{
      _camera.x = (_MainCharacterModel.xPos-(MAP_X*MAX_TILE_SIZE)) - stage.stageHeight * 0.5;
      _camera.y = (_MainCharacterModel.yPos-(MAP_Y*MAX_TILE_SIZE)) - stage.stageHeight * 0.5;
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
      _frontBitmap.scrollRect = _camera;
}
function frameTurn()
{
   try
    {
    if(currentPlot.State == "Won")
    {
      this.removeEventListener(Event.ENTER_FRAME, OnEnter);	
      UnLoad();
       try
      {
	kongVar.SubmitStat("BeatGame",1);
      }
      catch (e:Dynamic)
      {	}
      dispatchEvent(new Event("Won"));
      return;
    }
    if(State == "StartTrainerBattleText")
    {
      
    }
    if(State == "GetNextPlotAction")
    {
      if(currentPlot.State == "Visit Grave")
      {
	if(WaitForXFrames(100))
	  {
	    State = "addText";
	    Text.htmlText = "<font size='16'>I should go...</font>";
	    currentPlot.State = "Visit Brother";
	    WaitTime = 0;
	  }
      }
      else if(currentPlot.State == "Visit Lake")
      {
	if(WaitForXFrames(100))
	  {
	    State = "addText";
	    Text.htmlText = "<font size='16'>...</font>";
	    currentPlot.State = "Visited Lake";
	    WaitTime = 0;
	  }
      }
    }
    if(State == "addText")
    {
      if(_MainCharacterModel.centerY < 3)
      {
	TextBox.y = 412;
      }
      else
      {
	TextBox.y = 0;
      }
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
      if(currentTrainer == null)
      {
	
	var RandomMonster = GetRandomMonster();
	CurrentBattle = new BattleScreen(stage,RandomMonster,MainTrainer,null);
      }
      else
      {
	CurrentBattle = new BattleScreen(stage,null,MainTrainer,currentTrainer);
      }
      CurrentBattle.addEventListener("BattleFinished",onBattleFinished);
      //addnew
      }
    if(State != "Playing")
      {return;}
    if(Pause == "Paused")
      {return;}
    _foregroundBitmapData.fillRect(_foregroundBitmapData.rect, 0); 

    if(currentPlot.State == "Go Home End")
    {
      if((_MainCharacterModel.xPos/MAX_TILE_SIZE) == 4 && (_MainCharacterModel.yPos/MAX_TILE_SIZE) > 3)
	{_MainCharacterController.ManualMovement("up");}
      else
	{
	_MainCharacterController.ManualMovement("");
	currentPlot.State = "Home End";
	}
    }
    if(currentPlot.State == "Steped Outside")
    {
      _MainCharacterController.ManualMovement("right");
      getCharacterText(1);
    }
    if(currentPlot.State == "Battled Brother")
    {
      if((_MainCharacterModel.yPos/MAX_TILE_SIZE) == 36 && (_MainCharacterModel.xPos/MAX_TILE_SIZE) == 12)
      {
	    currentPlot.State = "Visit Lake";	    
	    State = "addText";
	    Text.htmlText = "<font size='16'>!</font>";
      }
    }
    else if(currentPlot.State == "Visit Lake")
    {
      if((_MainCharacterModel.yPos/MAX_TILE_SIZE) == 36 && (_MainCharacterModel.xPos/MAX_TILE_SIZE) < 16)
	{_MainCharacterController.ManualMovement("right");}
      else if((_MainCharacterModel.xPos/MAX_TILE_SIZE)== 16 && (_MainCharacterModel.yPos/MAX_TILE_SIZE) > 34)
	{_MainCharacterController.ManualMovement("up");}
      else
	{_MainCharacterController.ManualMovement("");State="GetNextPlotAction";WaitTime=0;}
    }
    if(currentPlot.JoyBadge && currentPlot.State == "Visited Lake")
    {
      if((_MainCharacterModel.yPos/MAX_TILE_SIZE) == 45 && (_MainCharacterModel.xPos/MAX_TILE_SIZE) == 24)
      {
	 currentPlot.State = "Nathan Appears";
      }
    }
    else if(currentPlot.State == "Nathan Appears")
    {
      Characters.add(Nathan);
      _characterMap[Nathan.centerY][Nathan.centerX] = Nathan.ID;
      updateCharacterMap();
      getCharacterText(Nathan.ID);
      currentPlot.State = "Nathan Talking";
    }
    if(currentPlot.State == "Visit Grave")
    {

      if((_MainCharacterModel.yPos/MAX_TILE_SIZE) == 4 && (_MainCharacterModel.xPos/MAX_TILE_SIZE) < 22)
	{_MainCharacterController.ManualMovement("right");}
      else if((_MainCharacterModel.xPos/MAX_TILE_SIZE)== 22 && (_MainCharacterModel.yPos/MAX_TILE_SIZE) < 7)
	{_MainCharacterController.ManualMovement("down");}
      else if((_MainCharacterModel.yPos/MAX_TILE_SIZE) == 7 &&  (_MainCharacterModel.xPos/MAX_TILE_SIZE)!= 23)
	{_MainCharacterController.ManualMovement("right");}
      else if(_MainCharacterModel.direction != "down")
	{_MainCharacterController.ManualMovement("down");}
      else
	{_MainCharacterController.ManualMovement("");State="GetNextPlotAction";WaitTime=0;}
      
    }
    _MainCharacterModel.update();
      if(_MainCharacterModel.direction == "right")
	{_MainCharacterModel.tileSheetRow = 1;_MainCharacterModel.tileSheetColumn = 1;}
      else if(_MainCharacterModel.direction == "left")
	{_MainCharacterModel.tileSheetRow = 1;_MainCharacterModel.tileSheetColumn = 3;}
      else if(_MainCharacterModel.direction == "up")
	{_MainCharacterModel.tileSheetRow = 1;_MainCharacterModel.tileSheetColumn = 2;}
      else if(_MainCharacterModel.direction == "down")
	{_MainCharacterModel.tileSheetRow = 0;_MainCharacterModel.tileSheetColumn = 1;}
    //trace(_trainerSightMap);
    var ID:Int = _collisionController.platformAnythingNoCollision(_MainCharacterModel,_trainerSightMap, MAX_TILE_SIZE);
    //trace("TRainer");
  for(char in Characters)
  {
   char.update(); 
   drawGameObject(char, _foregroundBitmapData);
  }
    for(trainer in Trainers)
    {
	//trace(trainer);
	trainer.Model.update();
	_trainerMap[trainer.Model.centerY][trainer.Model.centerX] = trainer.ID;	
	if(trainer.ID == ID && _MainCharacterModel.moving <= 1 && !trainer.Battled)
	  {startTrainerBattle(trainer);}
	drawGameObject(trainer.Model, _foregroundBitmapData);

    }

    checkBoundaries();
    _collisionController.platformCollisionAnything(_MainCharacterModel,_trainerMap, MAX_TILE_SIZE);
    _collisionController.platformCollisionAnything(_MainCharacterModel,_characterMap,MAX_TILE_SIZE);

    _collisionController.platformCollisionAnything(_MainCharacterModel, _backgroundMap, MAX_TILE_SIZE);
    _collisionController.platformCollisionAnything(_MainCharacterModel, _itemsMap, MAX_TILE_SIZE);

    if(_doorsMap[_MainCharacterModel.top][_MainCharacterModel.left] > -1 &&  _MainCharacterModel.moving <= 1)
      {getInsideBuilding(_MainCharacterModel.left,_MainCharacterModel.top);return;}
    if(WaitForNextRandomBattle())
    {
      if(_terrainMap[_MainCharacterModel.top][_MainCharacterModel.left] == MONT &&  _MainCharacterModel.moving <= 1)
	{checkRandomEncouter();}
    }

      drawGameObject(_MainCharacterModel, _foregroundBitmapData);
    if(_MainCharacterModel.UpdateIfNotCollied)
    {
      _MainCharacterModel.UpdateIfNotCollied = false;
      if(_MainCharacterModel.vx != 0 || _MainCharacterModel.vy != 0)
	{_MainCharacterModel.updateLastDirection();}
    }
    setCamera();
    }
    catch(err:flash.Error)
    {
      trace(err.message);
    }
}
function OnEnter(e:flash.events.Event)
{
  frameTurn();
}

  public function GetRandomMonster():Monster
  {
    var randomMonster:Monster = null;
    if(_MainCharacterModel.centerY > 13 && _MainCharacterModel.centerY < 19 &&
      _MainCharacterModel.centerX >= 1 && _MainCharacterModel.centerX <= 26)
    {
      randomMonster = new Monster();
      randomMonster.Character = "Water Rabbit";
      randomMonster.XP = 15 + (Std.random(15));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY > 27 && _MainCharacterModel.centerY < 34 &&
      _MainCharacterModel.centerX >= 10 && _MainCharacterModel.centerX <= 20)
    {
      randomMonster = new Monster();
      randomMonster.Character = "Storm Dragon";
      randomMonster.XP = 66 + (Std.random(240));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY > 33 && _MainCharacterModel.centerY < 39 &&
      _MainCharacterModel.centerX >= 0 && _MainCharacterModel.centerX <= 25)
    {
      randomMonster = new Monster();
      var randomMonsterCharacter = Std.random(2);
      if(randomMonsterCharacter == 0)
      {
	randomMonster.Character = "Water Jay";
      }
      if(randomMonsterCharacter == 1)
      {
	randomMonster.Character = "Tsunami Cat";
      }
      randomMonster.XP = 66 + (Std.random(60));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY >= 42&& _MainCharacterModel.centerY <=44  &&
      _MainCharacterModel.centerX >= 26 && _MainCharacterModel.centerX <= 37)
    {
      randomMonster = new Monster();
      randomMonster.Character = "Water Rabbit";
      randomMonster.XP = 240 + (Std.random(60));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY >= 41&& _MainCharacterModel.centerY <=43  &&
      _MainCharacterModel.centerX >= 0 && _MainCharacterModel.centerX <= 16)
    {
      randomMonster = new Monster();
      randomMonster.Character = "Water Rabbit";
      randomMonster.XP = 240 + (Std.random(130));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY >= 47&& _MainCharacterModel.centerY <=58  &&
      _MainCharacterModel.centerX >= 25 && _MainCharacterModel.centerX <= 38)
    {
      //FIRE Monsters TBI.
      randomMonster = new Monster();
      var randomMonsterCharacter = Std.random(2);
      if(randomMonsterCharacter == 0)
      {
      randomMonster.Character = "Pyro Cat";
      }
      else
      {
      randomMonster.Character = "Ember Bug";
      }
  
      randomMonster.XP = 470+ (Std.random(130));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY >= 60 && _MainCharacterModel.centerY <=79  &&
      _MainCharacterModel.centerX >= 24 && _MainCharacterModel.centerX <= 55)
    {
      randomMonster = new Monster();
      var randomMonsterCharacter = Std.random(2);
      if(randomMonsterCharacter == 0)
      {
      randomMonster.Character = "Flower";
      }
      else
      {
      randomMonster.Character = "Leaf Sheep";
      }
  
      randomMonster.XP = 780+ (Std.random(200));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY >= 17 && _MainCharacterModel.centerY <=38  &&
      _MainCharacterModel.centerX >= 41 && _MainCharacterModel.centerX <= 46)
    {
      randomMonster = new Monster();
      var randomMonsterCharacter = Std.random(2);
      if(randomMonsterCharacter == 0)
      {
      randomMonster.Character = "Boulder Bear";
      }
      else
      {
      randomMonster.Character = "Ground Turtle";
      }
  
      randomMonster.XP = 2080 + (Std.random(500));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY >= 32 && _MainCharacterModel.centerY <=38  &&
      _MainCharacterModel.centerX >= 47 && _MainCharacterModel.centerX <= 73)
    {
      randomMonster = new Monster();
      var randomMonsterCharacter = Std.random(2);
      if(randomMonsterCharacter == 0)
      {
      randomMonster.Character = "Hippo";
      }
      else
      {
      randomMonster.Character = "Mini Elephant";
      }
  
      randomMonster.XP = 2480 + (Std.random(800));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY >= 17 && _MainCharacterModel.centerY <=38  &&
      _MainCharacterModel.centerX >= 74 && _MainCharacterModel.centerX <= 79)
    {
      randomMonster = new Monster();
      var randomMonsterCharacter = Std.random(10);
      if(randomMonsterCharacter <= 4)
      {
      randomMonster.Character = "Hippo";
      }
      else if(randomMonsterCharacter <= 8)
      {
      randomMonster.Character = "Mini Elephant";
      }
      else
      {
	randomMonster.Character = "Unicorn";
      }
  
      randomMonster.XP = 3080 + (Std.random(800));
      randomMonster.LevelUp();
    }
    else if(_MainCharacterModel.centerY >= 41 && _MainCharacterModel.centerY <=58  &&
      _MainCharacterModel.centerX >= 41 && _MainCharacterModel.centerX <= 46)
    {
      randomMonster = new Monster();
      var randomMonsterCharacter = Std.random(2);
      if(randomMonsterCharacter == 0)
      {
      randomMonster.Character = "Electric Zebra";
      }
      else
      {
      randomMonster.Character = "Lightning Cat";
      }
  
      randomMonster.XP = 1780 + (Std.random(500));
      randomMonster.LevelUp();
    }
    else
    {
      randomMonster = new Monster();
      randomMonster.Character = "Lightning Cat";
      randomMonster.XP = 15 + (Std.random(15));
      randomMonster.LevelUp();
    }
    return randomMonster;
  }
  public function startTrainerBattle(trainer:EnemyTrainer)
  {
    currentTrainer = trainer;
    ExclamationMark.setX = trainer.Model.xPos;
    ExclamationMark.setY = trainer.Model.yPos;

    //set Left of
    if(trainer.Model.direction == "right")
    {
      trainer.Model.setX = _MainCharacterModel.xPos-MAX_TILE_SIZE;
      trainer.Model.setY = _MainCharacterModel.yPos;
    }
    //set Right of
    else if(trainer.Model.direction == "left")
    {
      trainer.Model.setX = _MainCharacterModel.xPos+MAX_TILE_SIZE;
      trainer.Model.setY = _MainCharacterModel.yPos;
    }
    //set Above
    else if(trainer.Model.direction == "down")
      {
	trainer.Model.setX = _MainCharacterModel.xPos;
	trainer.Model.setY = _MainCharacterModel.yPos-MAX_TILE_SIZE;
      }
      //set Below
      else if(trainer.Model.direction == "up")
      {
	trainer.Model.setX = _MainCharacterModel.xPos;
	trainer.Model.setY = _MainCharacterModel.yPos+MAX_TILE_SIZE;
      }

    else
    {
      //set Left of
      if(trainer.Model.xPos-_MainCharacterModel.xPos <= -1)
      {
	trainer.Model.setX = _MainCharacterModel.xPos-MAX_TILE_SIZE;
	trainer.Model.setY = _MainCharacterModel.yPos;
      }
      //set Right of
      else if(trainer.Model.xPos-_MainCharacterModel.xPos >= 1)
      {
	trainer.Model.setX = _MainCharacterModel.xPos+MAX_TILE_SIZE;
	trainer.Model.setY = _MainCharacterModel.yPos;
      }
      //
      else
      {
	//set Above
	if(trainer.Model.yPos-_MainCharacterModel.yPos <= -1)
	{
	  trainer.Model.setX = _MainCharacterModel.xPos;
	  trainer.Model.setY = _MainCharacterModel.yPos-MAX_TILE_SIZE;
	}
	//set Below
	else if(trainer.Model.yPos-_MainCharacterModel.yPos >= 1)
	{
	  trainer.Model.setX = _MainCharacterModel.xPos;
	  trainer.Model.setY = _MainCharacterModel.yPos+MAX_TILE_SIZE;
	}
	//set Right of
	else
	{
	  trainer.Model.setX = _MainCharacterModel.xPos+MAX_TILE_SIZE;
	  trainer.Model.setY = _MainCharacterModel.yPos;
	}

      }
    }
    if(trainer.Model.xPos == ExclamationMark.xPos)
      {ExclamationMark.setY = ExclamationMark.yPos - MAX_TILE_SIZE;}
    drawGameObject(ExclamationMark, _foregroundBitmapData);
    getTrainerText(trainer.ID);
    updateTrainerMap();
 //   _MainCharacterController.ManualMovement("");
    _MainCharacterModel.vx = 0;_MainCharacterModel.vy = 0;
  }

  public function WaitForNextRandomBattle()
  {
    
     BattleWait++;
     return(BattleWait > 50);

  }
  public function onBattleFinished(e:Event)
  {

    if(currentTrainer != null )
    {
      for(monster in currentTrainer.Monsters)
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
     if(currentTrainer != null && CurrentBattle.Won)
     {
       currentTrainer.Battled = true;
	if(currentPlot.State =="Battled Brother")
	{
	    currentPlot.BridgeBroken = true;
	    checkBackground();
	}
       updateTrainerMap();
     }

     if(currentPlot.State == "Steped Outside")
     {
      CurrentBattle = null;
      BattleWait = 0;
      WorldMap.removeChild(RandomBattleImage);
      State = "Playing";
      HealMonsters();
      currentTrainer = null;
      currentPlot.State = "Battled Brother";
      _backgroundMap[8][6] = -1;
      getCharacterText(1);
     }
     else if(currentPlot.State == "Tristan Talked")
     {
      CurrentBattle = null;
     BattleWait = 0;
     WorldMap.removeChild(RandomBattleImage);
     State = "Playing";
      currentTrainer.Battled = true;
      getTrainerText(currentTrainer.ID);
      currentPlot.State = "Tristan Battled";
     }
     else
     {
      if(currentTrainer != null && !CurrentBattle.Won)
      {
	  _MainCharacterModel.setY = _MainCharacterModel.LastPosition.y;
	  _MainCharacterModel.setX = _MainCharacterModel.LastPosition.x;
      }
      CurrentBattle = null;
     BattleWait = 0;
     WorldMap.removeChild(RandomBattleImage);
     State = "Playing";
      if(currentTrainer != null && currentTrainer.Battled)
      {
	getTrainerText(currentTrainer.ID);
      }
     }
      stage.focus = stage;
     
 




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
     var maxX = ((MAP_COLUMNS+MAP_X) * MAX_TILE_SIZE);
     var minX = ((0+MAP_X) * MAX_TILE_SIZE);
     if (_MainCharacterModel.xPos + (_MainCharacterModel.width) > maxX)
      {
	if(maxX < MAP_WIDTH* MAX_TILE_SIZE)
	{
	  MAP_X += MAP_COLUMNS;
	  _MainCharacterModel.setX = ((0+MAP_X) * MAX_TILE_SIZE);
	  _MainCharacterModel.vx = 0;
	  redraw();
	}
	else
	{
	_MainCharacterModel.setX = maxX - (_MainCharacterModel.width);
	_MainCharacterModel.vx = 0;
	}
      }
      else if (_MainCharacterModel.xPos < minX)
      {
  	if(minX > 0)
	{
	  MAP_X -= MAP_COLUMNS;
	  _MainCharacterModel.setX = ((MAP_COLUMNS+MAP_X-1) * MAX_TILE_SIZE);
	  _MainCharacterModel.vx = 0;
	  redraw();
	}
	else
	{
	  _MainCharacterModel.setX = minX;
	  _MainCharacterModel.vx = 0;
	}
      }
     var maxY = ((MAP_ROWS+MAP_Y) * MAX_TILE_SIZE);
     var minY = (0+MAP_Y)*MAX_TILE_SIZE;
      if (_MainCharacterModel.yPos <= minY)
      {
  	if(minY > 0)
	{
	  MAP_Y -= MAP_ROWS;
	  _MainCharacterModel.setY = ((MAP_ROWS+MAP_Y-2) * MAX_TILE_SIZE);
	  redraw();
	}
	else
	{
	      _MainCharacterModel.setY = 0;
	      _MainCharacterModel.vy = 0;
	}
      }
      else if (_MainCharacterModel.yPos + _MainCharacterModel.height >= maxY)
      {
	if(maxY < MAP_HEIGHT* MAX_TILE_SIZE)
	{
	  MAP_Y += MAP_ROWS;
	  _MainCharacterModel.setY = ((0+MAP_Y+1) * MAX_TILE_SIZE);
	  redraw();
	}
	else
	{
	      _MainCharacterModel.setY = maxY - _MainCharacterModel.height;
	      _MainCharacterModel.vy = 0;
	}
      } ;
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
      tileModel.xPos-(tileModel.ImageXOffset)-(MAP_X*MAX_TILE_SIZE), 
      tileModel.yPos-(tileModel.ImageYOffset)-(MAP_Y*MAX_TILE_SIZE)
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