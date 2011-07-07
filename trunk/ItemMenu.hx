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
import ItemButton;
import MonsterMenu;
import Images;
class ItemMenuEvent extends Event{
 
	public function new(customEventString:String){
	super(customEventString, true, false);

    }
}

class ItemMenu extends Sprite
{
  public var currentMonsterMenu:MonsterMenu;
  public var currentTrainer:Trainer;
  public var Text:TextField;
  public var ItemMenu:Sprite;
  public var ItemPage:Int;
  public var PrevItemPage:Sprite;
  public var NextItemPage:Sprite;
  public var currentItem:String;
  public var ItemState:String;
  public var ItemConfirmBackground:Sprite;
  public var ItemYes:Sprite;
  public var ItemNo:Sprite;
  public var ItemConfirm:TextField;
  public var ExitMenu:Sprite;
  public var background:Sprite;
// public var volume:Bool;
// public var sound:Bool;

  public function new(inTrainer:Trainer)
  {
    super();
    //Resize Image
    currentTrainer = inTrainer;
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


  this.addEventListener("Item",onItemSelected);
  
  ItemPage = 1;
  PrevItemPage = new Sprite();
  var PrevItemPageText = new TextField();
  PrevItemPageText.htmlText = "<font size='14'>Prev</font>";
//
background.addChild(PrevItemPageText);
PrevItemPageText.width = 70;
PrevItemPageText.autoSize = TextFieldAutoSize.CENTER;
PrevItemPageText.selectable = false;
PrevItemPageText.mouseEnabled = false;
PrevItemPage.buttonMode = true;
PrevItemPage.addChild(PrevItemPageText);
PrevItemPage.addEventListener(MouseEvent.CLICK, onPrevItemPageClick);
PrevItemPage.graphics.beginFill(0xFFFFFF);
PrevItemPage.graphics.lineStyle(1);
PrevItemPage.graphics.drawRect(0,0,70,32);
PrevItemPage.graphics.endFill();
PrevItemPage.y = 480;
PrevItemPage.x = 165;

  NextItemPage = new Sprite();
  var NextItemPageText = new TextField();
  NextItemPageText.htmlText = "<font size='14'>Next</font>";
//
  NextItemPage.addChild(NextItemPageText);
  NextItemPageText.width = 70;
  NextItemPageText.autoSize = TextFieldAutoSize.CENTER;
  NextItemPageText.selectable = false;
  NextItemPageText.mouseEnabled = false;
  NextItemPage.buttonMode = true;
  NextItemPage.addChild(NextItemPageText);
  NextItemPage.addEventListener(MouseEvent.CLICK, onNextItemPageClick);
  NextItemPage.graphics.beginFill(0xFFFFFF);
  NextItemPage.graphics.lineStyle(1);
  NextItemPage.graphics.drawRect(0,0,70,32);
  NextItemPage.graphics.endFill();
  NextItemPage.y = 480; NextItemPage.x = 245;

  Text.htmlText = "Items";
  ItemMenu = new Sprite();
  background.addChild(ItemMenu);
  drawItemMenu(ItemPage);

  currentMonsterMenu = new MonsterMenu(currentTrainer);
  //addChild(QuitButton);
  }
public function redraw()
{
    drawItemMenu();
}

private function onExitMenuClick(event:MouseEvent) {
    dispatchEvent(new Event("Back"));
}

private function onItemSelected (event:ItemButtonEvent) {
var count = 0;
  currentItem = event.Name;
  ItemState = "UseItem";
  var Item = currentTrainer.CurrentInventory.getItemByName(currentItem);
  if(!Item.useOnMonster())
  {
    ItemState ="Confirm";
    //addChild Confirm Menu
    ItemMenu.addChild(ItemConfirmBackground);

    ItemMenu.addChild(ItemConfirm);
    ItemMenu.addChild(ItemNo);
    ItemMenu.addChild(ItemYes);
  }
  else
  {
    ItemState = "FindMonster";
    currentMonsterMenu.redraw();
    background.addChild(currentMonsterMenu);
    currentMonsterMenu.CurrentState = "UseItem";
    currentMonsterMenu.StatusText.htmlText = "<font size='16'>Use Item</font>";
    currentMonsterMenu.addChild(currentMonsterMenu.ItemConfirmBackground);

    currentMonsterMenu.addChild(currentMonsterMenu.ItemConfirm);
    currentMonsterMenu.addChild(currentMonsterMenu.ItemNo);
    currentMonsterMenu.addEventListener("Cancel",onMonsterItemCancel);
    currentMonsterMenu.addEventListener("Use",onMonsterItemUse);
    //currentMonsterMenu.addChild(currentMonsterMenu.ItemYes);
  }
}
private function onMonsterItemCancel(event:Event)
{
  currentMonsterMenu.removeEventListener("Cancel",onMonsterItemCancel);   
  currentItem = "";
  ItemState = "";
  background.removeChild(currentMonsterMenu);
  currentMonsterMenu.CurrentState = "";
  currentMonsterMenu.StatusText.htmlText = "<font size='16'></font>";
  currentMonsterMenu.removeChild(currentMonsterMenu.ItemConfirmBackground);
  currentMonsterMenu.removeChild(currentMonsterMenu.ItemConfirm);
  currentMonsterMenu.removeChild(currentMonsterMenu.ItemNo);
  
}
private function onMonsterItemUse(event:MonsterMenuEvent)
{
  currentMonsterMenu.removeEventListener("Cancel",onMonsterItemCancel);   
  currentMonsterMenu.removeEventListener("Use",onMonsterItemUse);   
  ItemState = "";
  background.removeChild(currentMonsterMenu);
  currentMonsterMenu.CurrentState = "";
  currentMonsterMenu.StatusText.htmlText = "<font size='16'></font>";
  currentMonsterMenu.removeChild(currentMonsterMenu.ItemConfirmBackground);
  currentMonsterMenu.removeChild(currentMonsterMenu.ItemConfirm);
  currentMonsterMenu.removeChild(currentMonsterMenu.ItemNo);
  var itemMonster:Monster = null;
  for(monster in currentTrainer.Monsters)
  {
     if(monster.ID == event.ID)
     {
	itemMonster = monster;
	break;
     }
  }
  for(monster in currentTrainer.MonstersArchive)
  {
     if(monster.ID == event.ID)
     {
	itemMonster = monster;
	break;
     }
  }
  currentTrainer.CurrentInventory.useItem(currentItem,itemMonster,null,null);
  currentItem = "";
  drawItemMenu();
  
}
private function onPrevItemPageClick(event:MouseEvent)
{
  ItemPage--;
  drawItemMenu(ItemPage);
}
private function onNextItemPageClick(event:MouseEvent)
{
  ItemPage++;
  drawItemMenu(ItemPage);
}
private function drawItemMenu(?Page:Int=1)
{
  background.removeChild(ItemMenu);
  ItemMenu = new Sprite();
  ItemMenu.x = 0;
  var start = 39*(Page-1);
  var finish = 39*Page;
  var buttonPosition = 0;
    var Title = new TextField();
    Title.selectable = false;
    Title.htmlText = "<u><font size = '16'>Items</font></u>";
    Title.width = 490;
    Title.autoSize = TextFieldAutoSize.CENTER;
    ItemMenu.addChild(Title);
  var countedItems = new List<String>();
  for(item in currentTrainer.CurrentInventory)
  {
    var skip = false;
    for(name in countedItems)
    {
      if(name == item.ID)
      {
	skip = true;
	break;
      }
    }
    if(skip)
      {continue;}
    
    var count = currentTrainer.CurrentInventory.getItemsByName(item.ID);
    
    if(buttonPosition < start || buttonPosition >=finish)
    {
      if(buttonPosition == 0)
	{
	  ItemMenu.addChild(PrevItemPage);
	}
      if(buttonPosition == finish+1)
	{
	  ItemMenu.addChild(NextItemPage);
	}
      buttonPosition++;
      continue;
    }
    countedItems.add(item.ID);
    var Item = new ItemButton(item.ID,count,!item.useOutsideBattle());

    var pagePosition = (buttonPosition-((Page-1)*39));
    var column = 0;
    column = Math.floor(pagePosition / 13);
    Item.x = 15+155*column;Item.y=26+(((pagePosition-(column*13))*35));


    ItemMenu.addChild(Item);
    buttonPosition++;
  }
  var menuSize = ((buttonPosition-((Page-1)*13))*35);
      ItemMenu.y = 0;
      ItemMenu.graphics.beginFill(0xFFFFFF);
      ItemMenu.graphics.lineStyle(1);
      ItemMenu.graphics.drawRect(0,0,490,512);
      ItemMenu.graphics.endFill();
  background.addChild(ItemMenu);

  ItemConfirmBackground = new Sprite();
  //ItemConfirmBackground.y = (Math.max(512-(31+((buttonPosition)*35)),0))/2;
  ItemConfirmBackground.graphics.beginFill(0xFFFFFF);
  ItemConfirmBackground.graphics.lineStyle(1);
  ItemConfirmBackground.graphics.drawRect(0,0,490,512);
  ItemConfirmBackground.graphics.endFill();
  ItemConfirmBackground.alpha = 0.5;

  ItemConfirm = new TextField();
  ItemConfirm.background = true;
  ItemConfirm.backgroundColor = 0xFFFFFF;
  ItemConfirm.htmlText = "<font size='14'>Use Item?</font>";
  ItemConfirm.autoSize = TextFieldAutoSize.CENTER;
  ItemConfirm.width = (490 - ItemConfirm.width/2);
  ItemConfirm.y = 150;
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
  ItemYes.y = 170;
  ItemYes.x = 175;


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
  ItemNo.y = 170;ItemNo.x = 250;


  
}


private function onItemYesClick(event:MouseEvent)
{
  //State = "Finish";

  var Item = currentTrainer.CurrentInventory.getItemByName(currentItem);
  if(!Item.useOnMonster())
  {
    ItemMenu.removeChild(ItemConfirmBackground);
    ItemMenu.removeChild(ItemConfirm);
    ItemMenu.removeChild(ItemNo);
    //addChild Confirm Menu
    ItemMenu.removeChild(ItemYes);
    currentTrainer.CurrentInventory.useItem(currentItem,null,currentTrainer,null);
    drawItemMenu(ItemPage);
  }
  else
  {
    
  }
  currentItem ="";
  ItemState = "";
}
private function onItemNoClick(event:MouseEvent)
{
  //State = "Finish";
  ItemMenu.removeChild(ItemConfirmBackground);

  ItemMenu.removeChild(ItemConfirm);
  ItemMenu.removeChild(ItemNo);
  var Item = currentTrainer.CurrentInventory.getItemByName(currentItem);
  if(!Item.useOnMonster())
  {
    //addChild Confirm Menu
    ItemMenu.removeChild(ItemYes);
  }
  else
  {
    
  }
  currentItem ="";
  ItemState = "";
}


}