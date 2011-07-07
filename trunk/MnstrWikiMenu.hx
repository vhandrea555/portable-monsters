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
class MnstrWikiMenuEvent extends Event{
 
	public function new(customEventString:String){
	super(customEventString, true, false);

    }
}

class MnstrWikiMenu extends Sprite
{
  public var MonsterList:Sprite;
  public var Monsters:List<Monster>;
  public var currentMonsterInfo:Monster;
  public var PrevMonsterPage:Sprite;
  public var NextMonsterPage:Sprite;
  public var MonsterPage:Int;
  private var Text:TextField;
  private var chart:TypeChart;
  private var TypeChartButton:Sprite;

  private var table:Sprite;
  private var MonsterPic:CustomSprite;
  private var currentDesc:TextField;
  private var currentTitle:TextField;
  private var currentType:TextField;

  private var background:Sprite;
  public var ExitMenu:Sprite;
// public var volume:Bool;
// public var sound:Bool;

  public function new()
  {
    super();
    //Resize Image
    background = new Sprite();
    background.graphics.lineStyle(1);
    background.graphics.beginFill(0xFFFFFF);
    background.graphics.drawRect(0, 0,640-150,Constants.flashHeight);
    background.graphics.endFill();
    background.x = 0 ; background.y = 0;
    //End Resize
    addChild(background);

TypeChartButton = new Sprite();
TypeChartButton.mouseChildren = true;
var TypeChartButtonText = new TextField();
TypeChartButtonText.htmlText = "<font size='22'>Type Chart</font>";
TypeChartButtonText.autoSize = TextFieldAutoSize.CENTER;
TypeChartButtonText.width = 150;
TypeChartButtonText.x = 25;
TypeChartButtonText.y = 7;
TypeChartButtonText.selectable = false;
TypeChartButtonText.mouseEnabled = false;
TypeChartButton.addChild(TypeChartButtonText);
TypeChartButton.addEventListener(MouseEvent.CLICK, onTypeChartButtonClick);
TypeChartButton.buttonMode = true;
  TypeChartButton.graphics.beginFill(0xFFFFFF);
  TypeChartButton.graphics.lineStyle(1);
  TypeChartButton.graphics.drawRect(0,0,150,50);
  TypeChartButton.graphics.endFill();
  TypeChartButton.x =160;TypeChartButton.y = 22;

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

 
 MonsterPage = 1;

 PrevMonsterPage = new Sprite();
  var PrevMonsterPageText = new TextField();
  PrevMonsterPageText.htmlText = "<font size='14'>Prev</font>";
//
this.addChild(PrevMonsterPageText);
PrevMonsterPageText.width = 70;
PrevMonsterPageText.autoSize = TextFieldAutoSize.CENTER;
PrevMonsterPageText.selectable = false;
PrevMonsterPageText.mouseEnabled = false;
PrevMonsterPage.buttonMode = true;
PrevMonsterPage.addChild(PrevMonsterPageText);
PrevMonsterPage.addEventListener(MouseEvent.CLICK, onPrevMonsterPageClick);
PrevMonsterPage.graphics.beginFill(0xFFFFFF);
PrevMonsterPage.graphics.lineStyle(1);
PrevMonsterPage.graphics.drawRect(0,0,70,20);
PrevMonsterPage.graphics.endFill();
PrevMonsterPage.y = 482;

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
  NextMonsterPage.graphics.drawRect(0,0,70,20);
  NextMonsterPage.graphics.endFill();
  NextMonsterPage.y = 482;NextMonsterPage.x = 80;

 
  initalizeMonsterListSprite();

  initalizeAllMonsters();
 

  var MonsterListText = new TextField();
  MonsterListText.htmlText = "<font size ='18'>Monster</font>";
  MonsterListText.x = 51;
  MonsterListText.y = 2;
  MonsterListText.width = 120;
  MonsterListText.wordWrap = true;
  MonsterListText.selectable = false;
  MonsterListText.mouseEnabled = false;
  MonsterList.addChild(MonsterListText);

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
  background.addChild(table);
  table.x = 160;table.y=75;

  currentTitle = new TextField();

  currentTitle.x = 5;
  currentTitle.y = 5;
  currentTitle.width = 325;
  // currentTitle.wordWrap = true;
  currentTitle.selectable = false;
  currentTitle.mouseEnabled = false;
  currentTitle.autoSize = TextFieldAutoSize.CENTER;
  table.addChild(currentTitle);  

  currentTitle.htmlText = "<font size ='20'>Name</font>";

  currentType = new TextField();

  currentType.x = 133;
  currentType.y = 105;
  currentType.width = 187;
  //currentType.wordWrap = true;
  currentType.selectable = false;
  currentType.mouseEnabled = false;
  currentType.autoSize = TextFieldAutoSize.CENTER;
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


  background.addChild(MonsterList);
  
  MonsterPic = new CustomSprite();
  table.addChild(MonsterPic);
  this.addEventListener("Monster",onMonsterSelected);
  
  
  Text.htmlText = "Monster Wiki";
  //addChild(QuitButton);


  drawMonsterMenu(MonsterPage);
  chart = new TypeChart();
  chart.addEventListener("Back",onBack);
  addChild(TypeChartButton);
  }

private function onTypeChartButtonClick(event:MouseEvent){
   addChild(chart);
}
private function onBack(event:Event) {
  removeChild(chart);
}

private function onMonsterSelected (event:MonsterButtonEvent) {
  for(monster in Monsters)
  {
     if(monster.ID == event.ID)
     {
	currentMonsterInfo = monster;
	setupMonster();
	break;
    
     }
    
  }

}

private function initalizeMonsterListSprite()
{
  MonsterList = new Sprite();
  MonsterList.graphics.lineStyle(1);
  MonsterList.graphics.beginFill(0xFFFFFF);
  MonsterList.graphics.drawRect(0,0,150,Constants.flashHeight-10);
  MonsterList.graphics.endFill();  
  MonsterList.x = 5; MonsterList.y = 5;
  MonsterList.buttonMode = false;
}
private function setupMonster()
{
currentTitle.htmlText = "<font size ='20'>"+ currentMonsterInfo.Character + "</font>";
 currentDesc.htmlText = "<font size ='20'>"+ currentMonsterInfo.getMonsterDesc() +"</font>"; 
 currentType.htmlText = "<font size ='20'>Type: "+ currentMonsterInfo.getMonsterType()+"</font>";

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

}
private function initalizeAllMonsters(){
 Monsters = new List<Monster>();
 var monster = new Monster();
 monster.ID = 1;
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 2;
 monster.Character = "Flower";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 3;
 monster.Character = "Lightning Cat";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 4;
 monster.Character = "Hippo";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 5;
 monster.Character = "Electric Eel";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 6;
 monster.Character = "Storm Dragon";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 7;
 monster.Character = "Ember Bug";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 8;
 monster.Character = "Water Rabbit";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 9;
 monster.Character = "Flame Fox";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 10;
 monster.Character = "Water Jay";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 11;
 monster.Character = "Storm Dragon";
 Monsters.add(monster);

 var monster = new Monster();
 monster.ID = 12;
 monster.Character = "Jelly Fish";
 Monsters.add(monster);

 var monster = new Monster();
 monster.ID = 13;
 monster.Character = "Boulder Bear";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 14;
 monster.Character = "Sad Panda";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 15;
 monster.Character = "Leaf Sheep";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 16;
 monster.Character = "Fire Bat";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 17;
 monster.Character = "Electric Zebra";
 Monsters.add(monster); 
 var monster = new Monster();
 monster.ID = 18;
 monster.Character = "Pyro Cat";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 19;
 monster.Character = "Rock Dog";
 Monsters.add(monster); var monster = new Monster();
 var monster = new Monster();
 monster.ID = 20;
 monster.Character = "Tsunami Cat";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 21;
 monster.Character = "Vine Cat";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 22;
 monster.Character = "Unicorn";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 23;
 monster.Character = "Liger";
 Monsters.add(monster);
 var monster = new Monster();
 monster.ID = 24;
 monster.Character = "Mini Elephant";
 Monsters.add(monster);

 var monster = new Monster();
 monster.ID = 25;
 monster.Character = "Ground Turtle";
 Monsters.add(monster);
//  monster.ID = 18;
//  monster.Character = "Storm Dragon";
//  Monsters.add(monster); var monster = new Monster();
//  monster.ID = 19;
//  monster.Character = "Storm Dragon";
//  Monsters.add(monster);



}
  public function addNewMonster(inMonster:Monster,inID:Int)
  {
    inMonster.ID = inID;
    Monsters.add(inMonster);  
  }

public function redraw()
{
  drawMonsterMenu(MonsterPage);
}

private function onExitMenuClick(event:MouseEvent) {
    dispatchEvent(new Event("Back"));
}

private function drawMonsterMenu(?Page:Int=1)
{
  
  background.removeChild(MonsterList);
  initalizeMonsterListSprite();
  var start = 9*(Page-1);
  var finish = 9*Page;
  var buttonPosition = 0;
  for(monster in Monsters)
  {
    if(buttonPosition < start || buttonPosition >=finish)
    {
      if(buttonPosition == 0)
	{
	  MonsterList.addChild(PrevMonsterPage);
	}
      if(buttonPosition == finish)
	{
	  MonsterList.addChild(NextMonsterPage);
	}
	buttonPosition++;
	continue;
    }
    var MonsterIcon = new MonsterButton(monster,false);
    MonsterIcon.x = 5;MonsterIcon.y=26+((buttonPosition-((Page-1)*9))*50);

    MonsterList.addChild(MonsterIcon);
    buttonPosition++;
    background.addChild(MonsterList);
   }
}

  private function onPrevMonsterPageClick(event:MouseEvent)
  {
    MonsterPage--;
    drawMonsterMenu(MonsterPage);
  }
  private function onNextMonsterPageClick(event:MouseEvent)
  {
    MonsterPage++;
    drawMonsterMenu(MonsterPage);
  }
}