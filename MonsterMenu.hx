import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Point;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import MonsterButton;
import Images;
class MonsterMenuEvent extends Event{
public var ID:Int;
	public function new(customEventString:String,inID:Int){
        ID = inID;
	super(customEventString, true, false);

    }
}

class MonsterMenu extends Sprite
{
  private var background:Sprite;
  public var CurrentState:String;
  public var MonsterCurrent:Sprite;
  public var Status:Sprite;
  public var StatusText:TextField;
  public var ItemConfirmBackground:Sprite;
  public var ItemYes:Sprite;
  public var ItemNo:Sprite;
  public var ItemConfirm:TextField;
  

  public var MonsterArchive:Sprite;
  public var currentTrainer:Trainer;
  public var currentMonsterInfo:Monster;

  public var currentMonster:Monster;
  public var currentMonsterArchive:Monster;
  public var PrevMonsterPage:Sprite;
  public var NextMonsterPage:Sprite;
  public var MonsterPage:Int;
  private var Text:TextField;

  private var table:Sprite;
  private var tableAdded:Bool;
  private var MonsterPic:CustomSprite;
  
  private var AttackMenu:Sprite;
  public var AttackPage:Int;
  public var PrevAttackPage:Sprite;
  public var NextAttackPage:Sprite;

  private var currentDesc:TextField;
  private var currentTitle:TextField;
  private var currentType:TextField;
  private var tableExit:Sprite;
  public var ExitMenu:Sprite;

// public var volume:Bool;
// public var sound:Bool;

  public function new(inTrainer:Trainer)
  {
    super();
    tableAdded = false;
    currentTrainer = inTrainer;
    CurrentState = "";
    //Resize Image
    background = new Sprite();
    background.graphics.lineStyle(1);
    background.graphics.beginFill(0xFFFFFF);
    background.graphics.drawRect(0, 0,640-150,Constants.flashHeight);
    background.graphics.endFill();
    background.x = 0 ; background.y = 0;
    //End Resize
    addChild(background);

  ExitMenu  = new CustomSprite();
  ExitMenu.graphics.beginFill(0xFFFFFF);
  ExitMenu.graphics.lineStyle(1);
  ExitMenu.graphics.drawRect(0,0,25,25);
  ExitMenu.graphics.beginBitmapFill(new XButton());
  ExitMenu.graphics.drawRect(0, 0, 25, 25);
  ExitMenu.graphics.endFill();
  ExitMenu.x=background.width-35;
  ExitMenu.y = 10;
  ExitMenu.buttonMode = true;
  ExitMenu.addEventListener(MouseEvent.CLICK, onExitMenuClick);
  addChild(ExitMenu);

  Text = new TextField();

 

 PrevMonsterPage = new Sprite();
  var PrevMonsterPageText = new TextField();
  PrevMonsterPageText.htmlText = "<font size='14'>Prev</font>";
//
  PrevMonsterPage.addChild(PrevMonsterPageText);
  PrevMonsterPageText.width = 70;
  PrevMonsterPageText.autoSize = TextFieldAutoSize.CENTER;
  PrevMonsterPageText.selectable = false;
  PrevMonsterPageText.mouseEnabled = false;
  PrevMonsterPage.buttonMode = true;
  PrevMonsterPage.addChild(PrevMonsterPageText);
  PrevMonsterPage.addEventListener(MouseEvent.CLICK, onPrevMonsterPageClick);
  PrevMonsterPage.graphics.beginFill(0xFFFFFF);
  PrevMonsterPage.graphics.lineStyle(1);
  PrevMonsterPage.graphics.drawRect(0,0,70,32);
  PrevMonsterPage.graphics.endFill();
  PrevMonsterPage.y = 512-45; PrevMonsterPage.x = 80;

  NextMonsterPage = new Sprite();
  var NextMonsterPageText = new TextField();
  NextMonsterPageText.htmlText = "<font size='14'>Next</font>";
//
  NextMonsterPage.addChild(NextMonsterPageText);
  NextMonsterPageText.width = 70;
  NextMonsterPageText.autoSize = TextFieldAutoSize.CENTER;
  NextMonsterPageText.selectable = false;
  NextMonsterPageText.mouseEnabled = false;
  NextMonsterPage.buttonMode = true;
  NextMonsterPage.addChild(NextMonsterPageText);
  NextMonsterPage.addEventListener(MouseEvent.CLICK, onNextMonsterPageClick);
  NextMonsterPage.graphics.beginFill(0xFFFFFF);
  NextMonsterPage.graphics.lineStyle(1);
  NextMonsterPage.graphics.drawRect(0,0,70,32);
  NextMonsterPage.graphics.endFill();
  NextMonsterPage.y = 512-45;NextMonsterPage.x = 165;



  initMonsterArchive();
  initMonsterCurrent();
  

  MonsterPage = 1;

  AttackPage = 1;
   PrevAttackPage = new Sprite();
  var PrevAttackPageText = new TextField();
  PrevAttackPageText.htmlText = "<font size='14'>Prev</font>";
//
this.addChild(PrevAttackPageText);
PrevAttackPageText.width = 70;
PrevAttackPageText.autoSize = TextFieldAutoSize.CENTER;
PrevAttackPageText.selectable = false;
PrevAttackPageText.mouseEnabled = false;
PrevAttackPage.buttonMode = true;
PrevAttackPage.addChild(PrevAttackPageText);
PrevAttackPage.addEventListener(MouseEvent.CLICK, onPrevAttackPageClick);
PrevAttackPage.graphics.beginFill(0xFFFFFF);
PrevAttackPage.graphics.lineStyle(1);
PrevAttackPage.graphics.drawRect(0,0,70,32);
PrevAttackPage.graphics.endFill();
PrevAttackPage.y = 222-40; PrevAttackPage.x = 90;

  NextAttackPage = new Sprite();
  var NextAttackPageText = new TextField();
  NextAttackPageText.htmlText = "<font size='14'>Next</font>";
//
  NextAttackPage.addChild(NextAttackPageText);
  NextAttackPageText.width = 70;
  NextAttackPageText.autoSize = TextFieldAutoSize.CENTER;
  NextAttackPageText.selectable = false;
  NextAttackPageText.mouseEnabled = false;
  NextAttackPage.buttonMode = true;
  NextAttackPage.addChild(NextAttackPageText);
  NextAttackPage.addEventListener(MouseEvent.CLICK, onNextAttackPageClick);
  NextAttackPage.graphics.beginFill(0xFFFFFF);
  NextAttackPage.graphics.lineStyle(1);
  NextAttackPage.graphics.drawRect(0,0,70,32);
  NextAttackPage.graphics.endFill();
  NextAttackPage.y = 222-40;NextAttackPage.x = 165;



  table = new Sprite();
  table.graphics.lineStyle(1);
  table.graphics.beginFill(0xFFFFFF);
  table.graphics.drawRect(0,0,325,50);
  table.graphics.endFill();
  table.graphics.lineStyle(1);
  table.graphics.beginFill(0xFFFFFF);
  table.graphics.drawRect(0,50,325,350);
  table.graphics.endFill();
  table.graphics.lineStyle(1);
  table.graphics.beginFill(0xFFFFFF);
  table.graphics.drawRect(0,50,128,128);
  table.graphics.endFill();
  //   background.addChild(table);
  table.x = 160;table.y=75;

  currentTitle = new TextField();

  currentTitle.x = 5;
  currentTitle.y = 0;
  currentTitle.width = 325;
  // currentTitle.wordWrap = true;
  currentTitle.selectable = false;
  currentTitle.mouseEnabled = false;
  currentTitle.autoSize = TextFieldAutoSize.CENTER;
  table.addChild(currentTitle);  
  tableExit  = new CustomSprite();
  tableExit.graphics.beginFill(0xFFFFFF);
  tableExit.graphics.lineStyle(1);
  tableExit.graphics.drawRect(0,0,25,25);
  tableExit.graphics.beginBitmapFill(new XButton());
  tableExit.graphics.drawRect(0, 0, 25, 25);
  tableExit.graphics.endFill();
  tableExit.x=table.width-35;
  tableExit.y = 10;
  tableExit.buttonMode = true;
  tableExit.addEventListener(MouseEvent.CLICK, ontableExitClick);
  table.addChild(tableExit);

  currentTitle.htmlText = "<font size ='20'>Name</font>";

  currentType = new TextField();

  currentType.x = 133;
  currentType.y = 55;
  currentType.width = 187;
  //currentType.wordWrap = true;
  currentType.selectable = false;
  currentType.mouseEnabled = false;
  currentType.autoSize = TextFieldAutoSize.RIGHT;
  table.addChild(currentType);  
  currentType.htmlText = "<font size ='20'>Type:</font>";

  currentDesc = new TextField();

  currentDesc.x = 5;
  currentDesc.y = 183;
  currentDesc.width = 315;
  currentDesc.wordWrap = true;
  currentDesc.selectable = false;
  currentDesc.mouseEnabled = false;
  currentDesc.autoSize = TextFieldAutoSize.CENTER;
  table.addChild(currentDesc);  

  currentDesc.htmlText = "<font size ='20'>Desc</font>";
  

  Text.x = 160; Text.y = 0;
  Text.width = 330; Text.height = 55;
  background.addChild(Text);
  Text.multiline = true;
  Text.wordWrap = true;
  Text.selectable = false;
  var myFormat:TextFormat = new TextFormat();
  myFormat.size = 16;
  myFormat.align = TextFormatAlign.CENTER;
  Text.defaultTextFormat = myFormat;
  initAttackMenu();
  table.addChild(AttackMenu);
  background.addChild(MonsterArchive);
  background.addChild(MonsterCurrent);
  
  MonsterPic = new CustomSprite();
  table.addChild(MonsterPic);
  this.addEventListener("Monster",onMonsterSelected);
  
  
  //Text.htmlText = "<u>Monsters</u>";
  //addChild(QuitButton);


    drawMonsterArchive(MonsterPage);
    drawMonsterCurrent();

  ItemConfirmBackground = new Sprite();
  //ItemConfirmBackground.y = (Math.max(512-(31+((buttonPosition)*35)),0))/2;
  ItemConfirmBackground.graphics.beginFill(0xFFFFFF);
  //ItemConfirmBackground.graphics.lineStyle(1);
  ItemConfirmBackground.graphics.drawRect(0,0,160,512-150);
  ItemConfirmBackground.y = 195;
  ItemConfirmBackground.graphics.endFill();
  ItemConfirmBackground.alpha = 0.5;

  ItemConfirm = new TextField();
  ItemConfirm.background = true;
  ItemConfirm.backgroundColor = 0xFFFFFF;
  ItemConfirm.htmlText = "<font size='14'>Use Item?</font>";
  ItemConfirm.autoSize = TextFieldAutoSize.CENTER;
  ItemConfirm.width = (160 - ItemConfirm.width/2);
  ItemConfirm.y = 350;
  ItemConfirm.selectable = false;
  ItemConfirm.mouseEnabled = false;
  //ItemConfirm.y = 12;

  ItemYes = new Sprite();
  var ItemYesText = new TextField();
  ItemYesText.htmlText = "<font size='14'>Confirm</font>";

  ItemYes.addChild(ItemYesText);
  ItemYesText.width = 70;
  ItemYesText.autoSize = TextFieldAutoSize.CENTER;
  ItemYesText.selectable = false;
  ItemYesText.mouseEnabled = false;
  ItemYes.buttonMode = true;
  ItemYes.addChild(ItemYesText);
  ItemYes.addEventListener(MouseEvent.CLICK, onItemYesClick);
  ItemYes.graphics.beginFill(0xFFFFFF);
  ItemYes.graphics.lineStyle(1);
  ItemYes.graphics.drawRect(0,0,70,32);
  ItemYes.graphics.endFill();
  ItemYes.y = 370;
  ItemYes.x = 10;


  ItemNo = new Sprite();
  ItemNo.mouseChildren = false;
  var ItemNoText = new TextField();
  ItemNoText.htmlText = "<font size='14'>Cancel</font>";
//
  ItemNo.addChild(ItemNoText);
  ItemNoText.width = 70;
  ItemNoText.autoSize = TextFieldAutoSize.CENTER;
  ItemNoText.selectable = false;
  ItemNoText.mouseEnabled = false;
  ItemNo.buttonMode = true;
  ItemNo.addChild(ItemNoText);
  ItemNo.addEventListener(MouseEvent.CLICK, onItemNoClick);
  ItemNo.graphics.beginFill(0xFFFFFF);
  ItemNo.graphics.lineStyle(1);
  ItemNo.graphics.drawRect(0,0,70,32);
  ItemNo.graphics.endFill();
  ItemNo.y = 370;
  ItemNo.x = 90;

  }


private function onItemYesClick(event:MouseEvent)
{
}
private function onItemNoClick(event:MouseEvent)
{
  dispatchEvent(new Event("Cancel"));
}
private function initAttackMenu()
{
  AttackMenu = new Sprite();

  AttackMenu.y = 178;
  AttackMenu.graphics.beginFill(0xFFFFFF);
  AttackMenu.graphics.lineStyle(1);
  AttackMenu.graphics.drawRect(0,0,325,222);
  AttackMenu.graphics.endFill();
  
}
private function initMonsterCurrent()
{
//   if(MonsterCurrent != null)
//   {
//     while(MonsterCurrent.numChildren != 0)
//     {
//       MonsterCurrent.removeChildAt(0);
//     }
//   }

  MonsterCurrent = new Sprite();
  MonsterCurrent.graphics.lineStyle(1);
  MonsterCurrent.graphics.beginFill(0xFFFFFF);
  MonsterCurrent.graphics.drawRect(0,0,150,Constants.flashHeight-10);
  MonsterCurrent.graphics.endFill();  
  MonsterCurrent.x = 5; MonsterCurrent.y = 5;
  MonsterCurrent.buttonMode = false;


  var MonsterCurrentText = new TextField();
  MonsterCurrentText.htmlText = "<font size ='18'>Team</font>";
  MonsterCurrentText.x = 51;
  MonsterCurrentText.y = 2;
  MonsterCurrentText.width = 120;
  MonsterCurrentText.wordWrap = true;
  MonsterCurrentText.selectable = false;
  MonsterCurrentText.mouseEnabled = false;
  MonsterCurrent.addChild(MonsterCurrentText);
}
private function initMonsterArchive()
{
  if(MonsterArchive != null)
  {
    while(MonsterArchive.numChildren != 0)
    {
      MonsterArchive.removeChildAt(0);
    }
  }
  MonsterArchive = new Sprite();
  MonsterArchive.graphics.lineStyle(1);
  MonsterArchive.graphics.beginFill(0xFFFFFF);
  MonsterArchive.graphics.drawRect(0,0,320,Constants.flashHeight-10);
  MonsterArchive.graphics.endFill();  
  MonsterArchive.x = 163; MonsterArchive.y = 5;
  MonsterArchive.buttonMode = false;

  var MonsterArchiveText = new TextField();
  MonsterArchiveText.htmlText = "<font size ='18'>Archive</font>";
  MonsterArchiveText.x = 80;
  MonsterArchiveText.y = 0;
  MonsterArchiveText.width = 70;
  MonsterArchiveText.height = 70;
  MonsterArchiveText.wordWrap = true;
  MonsterArchiveText.selectable = false;
  MonsterArchiveText.mouseEnabled = false;
  MonsterArchive.addChild(MonsterArchiveText);
}
public function redraw()
{
    drawMonsterArchive(MonsterPage);
    drawMonsterCurrent();
}

private function onExitMenuClick(event:MouseEvent) {
    dispatchEvent(new Event("Back"));
}
private function ontableExitClick(event:MouseEvent) {
    background.removeChild(table);
}

private function onMonsterSelected (event:MonsterButtonEvent) {
  var found = false;
  var teamCount = 0;
  for (monster in currentTrainer.Monsters)
  {
    teamCount++;
  }
  for(monster in currentTrainer.Monsters)
  {
     if(monster.ID == event.ID)
     {
	currentMonsterInfo = monster;
	if(CurrentState == "")
	{
	  background.addChild(table);
	  //drawMonsterCurrent();
	}
	else if(CurrentState == "UseItem")
	{
	  dispatchEvent(new MonsterMenuEvent("Use",monster.ID));
	}
	else if(CurrentState == "Select")
	{
	  currentTrainer.CurrentMonster = monster;
	  CurrentState = "";
	  StatusText.htmlText = "<font size='16'></font>";
	  drawMonsterCurrent();
	}
	else if(CurrentState == "Add")
	{
	  StatusText.htmlText = "<font size='16'>Only Add\nFrom Archive</font>";
	}
	else if(CurrentState == "Archive")
	{
	  if(teamCount <= 1)
	  {
	    StatusText.htmlText = "<font size='16'>Must have at least\none Monster in Team</font>";
	  }
	  else
	  {
	    if(currentTrainer.CurrentMonster.ID == monster.ID)
	    {
	      for (monster2 in currentTrainer.Monsters)
	      {
		if(monster2.ID !=monster.ID)
		  {
		    currentTrainer.CurrentMonster = monster2;
		    break;
		  }
	      }
	    }
	    currentTrainer.MonstersArchive.add(monster);
	    currentTrainer.Monsters.remove(monster);
	    StatusText.htmlText = "<font size='16'></font>";
	    drawMonsterCurrent();
	    drawMonsterArchive(MonsterPage);
	  }
	}
	else if(CurrentState == "Swap")
	{
	    if(currentMonsterArchive != null)
	    {
	      if(currentTrainer.CurrentMonster.ID == monster.ID)
	      {
		for (monster2 in currentTrainer.Monsters)
		{
		  if(monster2.ID !=monster.ID)
		    {
		      currentTrainer.CurrentMonster = monster2;
		      break;
		    }
		}
	      }
	       currentTrainer.Monsters.remove(monster);
	       currentTrainer.MonstersArchive.add(monster);
	       currentTrainer.MonstersArchive.remove(currentMonsterArchive);  
	       currentTrainer.Monsters.add(currentMonsterArchive);
	       currentMonsterArchive = null;
	       currentMonster = null;
	       CurrentState = "";
	       StatusText.htmlText = "<font size='16'></font>";
	      drawMonsterCurrent();
	      drawMonsterArchive(MonsterPage);
	    }
	    else
	    {
	      currentMonster = monster;
	    }
	}
	setupMonster();
	found = true;
	break;
    
     }
    
  }
  
  if(found)
    {return;}
  if(CurrentState == "Select")
	{
	  StatusText.htmlText = "<font size='16'>Must Select Monster\nthat is part of\nthe current team</font>";
	  return;
	}

  for(monster in currentTrainer.MonstersArchive)
  {
     if(monster.ID == event.ID)
     {
	currentMonsterInfo = monster;
	setupMonster();
	if(CurrentState == "")
	{
	  background.addChild(table);
	  //drawMonsterArchive();
	}
	else if(CurrentState == "Select")
	{
	  StatusText.htmlText = "<font size='16'>Select From Team</font>";
	}
	else if(CurrentState == "Add")
	{
	  if(teamCount < 3)
	  {
	    currentTrainer.Monsters.add(monster);
	    currentTrainer.MonstersArchive.remove(monster);
	    StatusText.htmlText = "<font size='16'></font>";
	  }
	  drawMonsterArchive(MonsterPage);
	  drawMonsterCurrent();
	  CurrentState ="";
	}
	else if(CurrentState == "Swap")
	{
	    if(currentMonster != null)
	    {
	      if(currentTrainer.CurrentMonster.ID == currentMonster.ID)
	      {
		for (monster2 in currentTrainer.Monsters)
		{
		  if(monster2.ID !=currentMonster.ID)
		    {
		      currentTrainer.CurrentMonster = monster2;
		      break;
		    }
		}
	      }
	       currentTrainer.MonstersArchive.remove(monster);
	       currentTrainer.Monsters.remove(currentMonster);
	       currentTrainer.MonstersArchive.add(currentMonster);
	       currentTrainer.Monsters.add(monster);
	       currentMonsterArchive = null;
	       currentMonster = null;
	       CurrentState = "";
	       StatusText.htmlText = "<font size='16'></font>";
	      drawMonsterCurrent();
	      drawMonsterArchive(MonsterPage);
	    }
	    else
	    {
	      currentMonsterArchive = monster;
	    }
	}
	break;
	
    
     }
    
  }

}
private function setupMonster()
{
 currentTitle.htmlText = "<font size ='20'>"+currentMonsterInfo.Character+ "\n"+ "Level: " + currentMonsterInfo.Level+  " Health: "+ currentMonsterInfo.Health+"/"+currentMonsterInfo.MaxHealth +"</font>";
 currentDesc.htmlText = "<font size ='20'>"+ currentMonsterInfo.getMonsterDesc() +"</font>"; 
 currentType.htmlText = "<font size ='20'>"+ "Attack: " + HelperMethods.format(currentMonsterInfo.Attack,2) + "\n"
			+ "Defense: " +   HelperMethods.format(currentMonsterInfo.Defense,2) + "\n"
			+ "Speed: " + HelperMethods.format(currentMonsterInfo.Speed,2) + "\n"
			+ "Evasion: " + HelperMethods.format(currentMonsterInfo.Accuracy,2) + "\n"
			+ "XP: " + HelperMethods.format(currentMonsterInfo.XP,1) + "/" + HelperMethods.format(currentMonsterInfo.XpToNextLevel(),1)  + "\n"
			+ "</font>";

  table.removeChild(MonsterPic);
  MonsterPic = new CustomSprite();
  MonsterPic.graphics.drawRect(0,0,128,128);
  MonsterPic.graphics.endFill(); 
  var tileSheetColumn:Int = Std.int(currentMonsterInfo.getTileNumber(false) / 100);
  var tileSheetRow:Int = Std.int(currentMonsterInfo.getTileNumber(false) % 100);
  var sourceRectangle:Rectangle = new Rectangle
    (tileSheetColumn * 64, tileSheetRow * 64, 64,64);
		      
  var destinationPoint:Point = new Point(0, 0);
  var modelBitmapData = new BitmapData(64, 64, true, 0);
      modelBitmapData.copyPixels
      (
	new BattleSprites(), 
	sourceRectangle, 
	destinationPoint,
	null, null, true
      );
  var resizeBitmapData = HelperMethods.resize(128,128,modelBitmapData);
  var modelBitmap = new Bitmap(resizeBitmapData);
    MonsterPic.addChild(modelBitmap);
    table.addChild(MonsterPic);
    MonsterPic.y = 50;

  drawAttackList(AttackPage);

}

private function drawAttackList(?Page:Int=1)
{
  table.removeChild(AttackMenu);
  initAttackMenu(); 
  var start = 10*(Page-1);
  var finish = 10*Page;
  
  var buttonPosition = 0;
    var Title = new TextField();
    Title.selectable = false;
    Title.htmlText = "<u><font size = '16'>Attack</font></u>";
    Title.width = 150;
    Title.autoSize = TextFieldAutoSize.CENTER;
    //AttackMenu.addChild(Title);
  for(move in currentMonsterInfo.Moves)
  {
    
    if(buttonPosition < start || buttonPosition >=finish)
    {
      if(buttonPosition == 0)
	{
	  AttackMenu.addChild(PrevAttackPage);
	}
      if(buttonPosition == finish+1)
	{
	  AttackMenu.addChild(NextAttackPage);
	}
      buttonPosition++;
      continue;
    }
    var Attack = new AttackButton(move);
    var column = 0;
    var pagePosition = (buttonPosition-((Page-1)*5));
    if(pagePosition >= 5)
    {
     column = 1;
    }
    Attack.x = 5+(column*160);Attack.y=5+((pagePosition-(column*5))*35);


    AttackMenu.addChild(Attack);
    buttonPosition++;
  }

  table.addChild(AttackMenu);
}
private function drawMonsterArchive(?Page:Int=1)
{
  background.removeChild(MonsterArchive);
  initMonsterArchive();
  var start = 16*(Page-1);
  var finish = 16*Page;
  var buttonPosition = 0;
  for(monster in currentTrainer.MonstersArchive)
  {
    
    if(buttonPosition < start || buttonPosition >=finish)
    {
      if(buttonPosition == 0)
	{
	  MonsterArchive.addChild(PrevMonsterPage);
	}
      if(buttonPosition == finish+1)
	{
	  MonsterArchive.addChild(NextMonsterPage);
	}
	buttonPosition++;
	continue;
    }
    var MonsterIcon = new MonsterButton(monster,true);
    var pagePosition = (buttonPosition-((Page-1)*16));
    var column = 0;
    if (pagePosition >= 8)
    {
      column = 1;
    }
    MonsterIcon.x = 10+155*column;MonsterIcon.y=26+((pagePosition-(column*8))*55);

    MonsterArchive.addChild(MonsterIcon);
    buttonPosition++;
   }
    background.addChild(MonsterArchive);
}

private function drawMonsterCurrent()
{
  background.removeChild(MonsterCurrent);
  initMonsterCurrent();
  var buttonPosition = 0; 
  var currentImage = new TextField();
  currentImage.htmlText = "<font size ='14'><b>Current</b></font>";
  currentImage.x = 40;
  currentImage.y = -5;
  currentImage.width = 70;
  currentImage.height = 30;
  currentImage.background = false;
  currentImage.backgroundColor = 0xFFFFFF;
  currentImage.wordWrap = true;
  currentImage.selectable = false;
  currentImage.mouseEnabled = false;
  MonsterArchive.addChild(currentImage);
  
  for(monster in currentTrainer.Monsters)
  {
    var MonsterIcon = new MonsterButton(monster,true);
    if(monster.ID == currentTrainer.CurrentMonster.ID)
    {
      MonsterIcon.addChild(currentImage);
    }
    MonsterIcon.x = 5;MonsterIcon.y=26+((buttonPosition)*55);

    MonsterCurrent.addChild(MonsterIcon);
    buttonPosition++;
   }

   var selectMonster = new Sprite();
   selectMonster.graphics.beginFill(0xFFFFFF);
   selectMonster.graphics.lineStyle(1);
   selectMonster.graphics.drawRect(0,0,140,50);
   selectMonster.graphics.endFill();
   selectMonster.buttonMode = true;
   
   var selectMonsterText = new TextField();
    selectMonsterText.htmlText = "<font size='16'>Select Current\nMonster</font>";
    //
    selectMonster.addChild(selectMonsterText);
    selectMonsterText.width = 140;
    selectMonsterText.autoSize = TextFieldAutoSize.LEFT;
    selectMonsterText.selectable = false;
    selectMonsterText.mouseEnabled = false;

    selectMonster.addEventListener(MouseEvent.CLICK, onSelectMonsterClick);

    selectMonster.x = 5;
    selectMonster.y = 26+((3)*55); 
    MonsterCurrent.addChild(selectMonster);
    buttonPosition++;

   var SwapMonster = new Sprite();
   SwapMonster.graphics.beginFill(0xFFFFFF);
   SwapMonster.graphics.lineStyle(1);
   SwapMonster.graphics.drawRect(0,0,140,50);
   SwapMonster.graphics.endFill();
   SwapMonster.buttonMode = true;
   
   var SwapMonsterText = new TextField();
    SwapMonsterText.htmlText = "<font size='16'>Swap Current\nMonster</font>";
    //
    SwapMonster.addChild(SwapMonsterText);
    SwapMonsterText.width = 140;
    SwapMonsterText.autoSize = TextFieldAutoSize.LEFT;
    SwapMonsterText.selectable = false;
    SwapMonsterText.mouseEnabled = false;

    SwapMonster.addEventListener(MouseEvent.CLICK, onSwapMonsterClick);

    SwapMonster.x = 5;
    SwapMonster.y = 26+((4)*55); 
    MonsterCurrent.addChild(SwapMonster);
    buttonPosition++;

   var ArchiveMonster = new Sprite();
   ArchiveMonster.graphics.beginFill(0xFFFFFF);
   ArchiveMonster.graphics.lineStyle(1);
   ArchiveMonster.graphics.drawRect(0,0,140,50);
   ArchiveMonster.graphics.endFill();
   ArchiveMonster.buttonMode = true;
   
   var ArchiveMonsterText = new TextField();
    ArchiveMonsterText.htmlText = "<font size='16'>Archive Current\nMonster</font>";
    //
    ArchiveMonster.addChild(ArchiveMonsterText);
    ArchiveMonsterText.width = 140;
    ArchiveMonsterText.autoSize = TextFieldAutoSize.LEFT;
    ArchiveMonsterText.selectable = false;
    ArchiveMonsterText.mouseEnabled = false;

    ArchiveMonster.addEventListener(MouseEvent.CLICK, onArchiveMonsterClick);

    ArchiveMonster.x = 5;
    ArchiveMonster.y = 26+((5)*55); 
    MonsterCurrent.addChild(ArchiveMonster);
    buttonPosition++;

   var AddMonster = new Sprite();
   AddMonster.graphics.beginFill(0xFFFFFF);
   AddMonster.graphics.lineStyle(1);
   AddMonster.graphics.drawRect(0,0,140,50);
   AddMonster.graphics.endFill();
   AddMonster.buttonMode = true;
   
    var AddMonsterText = new TextField();
    AddMonsterText.htmlText = "<font size='16'>Add Current\nMonster</font>";
    //
    AddMonster.addChild(AddMonsterText);
    AddMonsterText.width = 140;
    AddMonsterText.autoSize = TextFieldAutoSize.LEFT;
    AddMonsterText.selectable = false;
    AddMonsterText.mouseEnabled = false;

    AddMonster.addEventListener(MouseEvent.CLICK, onAddMonsterClick);

    AddMonster.x = 5;
    AddMonster.y = 26+((6)*55); 
    MonsterCurrent.addChild(AddMonster);
    buttonPosition++;
  
    Status = new Sprite();
   Status.graphics.beginFill(0xFFFFFF);
   Status.graphics.lineStyle(1);
   Status.graphics.drawRect(0,0,140,85);
   Status.graphics.endFill();
   Status.buttonMode = false;
   
    StatusText = new TextField();
    StatusText.htmlText = "<font size='16'></font>";
    //
    Status.addChild(StatusText);
    StatusText.width = 140;
    StatusText.autoSize = TextFieldAutoSize.CENTER;
    StatusText.selectable = false;
    StatusText.mouseEnabled = false;


    Status.x = 5;
    Status.y = 26+((7)*55); 
    MonsterCurrent.addChild(Status);
  

    background.addChild(MonsterCurrent);
}

  private function onSelectMonsterClick(event:MouseEvent)
  {
     CurrentState = "Select";
     StatusText.htmlText = "<font size='16'>Selecting</font>";
  }
  private function onSwapMonsterClick(event:MouseEvent)
  {
     CurrentState = "Swap";
     StatusText.htmlText = "<font size='16'>Swaping</font>";
     currentMonster = null;
     currentMonsterArchive = null;
    
  }
  private function onArchiveMonsterClick(event:MouseEvent)
  {
     CurrentState = "Archive";
     StatusText.htmlText = "<font size='16'>Archiveing</font>";
    var teamCount = 0;
    for (monster in currentTrainer.Monsters)
    {
      teamCount ++;
    }
    if(teamCount <= 1)
    {
      StatusText.htmlText = "<font size='16'>Must have at least\none monster\nin the team</font>";
    }
  }
  private function onAddMonsterClick(event:MouseEvent)
  {
     CurrentState = "Add";
     StatusText.htmlText = "<font size='16'>Adding</font>";
    var teamCount = 0;
    for (monster in currentTrainer.Monsters)
    {
      teamCount++;
    }
    if(teamCount >= 3)
    {
      StatusText.htmlText = "<font size='16'>No more than\nthree Monsters\nin the team</font>";
    }
  }
  private function onPrevMonsterPageClick(event:MouseEvent)
  {
    MonsterPage--;
    drawMonsterArchive(MonsterPage);
  }
  private function onNextMonsterPageClick(event:MouseEvent)
  {
    MonsterPage++;
    drawMonsterArchive(MonsterPage);
  }

  private function onPrevAttackPageClick(event:MouseEvent)
  {
    AttackPage--;
    drawAttackList(AttackPage);
  }
  private function onNextAttackPageClick(event:MouseEvent)
  {
    AttackPage++;
    drawAttackList(AttackPage);
  }
}