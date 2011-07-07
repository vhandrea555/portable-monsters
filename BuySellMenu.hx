import flash.events.Event;
import flash.events.FocusEvent;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Point;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import MonsterButton;
import ItemButton;
import BuyItemButton;
import MonsterMenu;
import Images;
class BuySellMenuEvent extends Event{
 
	public function new(customEventString:String){
	super(customEventString, true, false);

    }
}

class BuySellMenu extends Sprite
{
  public var currentMonsterMenu:MonsterMenu;
  public var currentTrainer:Trainer;
  public var Text:TextField;
  public var BuyItemMenu:Sprite;
  public var BuyItemPage:Int;
  public var PrevBuyItemPage:Sprite;
  public var NextBuyItemPage:Sprite;

  public var ItemsLayer:Sprite;
  public var ItemMenu:Sprite;
  public var ItemPage:Int;
  public var PrevItemPage:Sprite;
  public var NextItemPage:Sprite;
  public var currentItem:String;
  public var ItemState:String;
  public var ItemConfirmBackground:Sprite;
  public var ItemNumber:TextField;
  public var ItemYes:Sprite;
  public var ItemNo:Sprite;
  public var ItemConfirm:TextField;
  public var BuyableItems:List<Item>;

  private var tableExit:Sprite;
// public var volume:Bool;
// public var sound:Bool;

  public function new(inTrainer:Trainer,inBuyableItems:List<Item>)
  {
    super();
    //Resize Image
    currentTrainer = inTrainer;
    BuyableItems = inBuyableItems;
    var background = new Sprite();
    background.graphics.lineStyle(1);
    background.graphics.beginFill(0xFFFFFF);
    background.graphics.drawRect(0, 0,640,Constants.flashHeight);
    background.graphics.endFill();
    background.x = 0 ; background.y = 0;
    //End Resize
    addChild(background);
    

    Text = new TextField();  



  Text.x = 160; Text.y = 0;
  Text.width = 330; Text.height = 55;
  addChild(Text);
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
this.addChild(PrevItemPageText);
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

  //Text.htmlText = "Items";
  ItemsLayer = new Sprite();
  addChild(ItemsLayer);
  ItemMenu = new Sprite();
  ItemsLayer.addChild(ItemMenu);
  drawItemMenu(ItemPage);


  this.addEventListener("BuyItem",onBuyItemSelected);
  
  BuyItemPage = 1;
  PrevBuyItemPage = new Sprite();
  var PrevBuyItemPageText = new TextField();
  PrevBuyItemPageText.htmlText = "<font size='14'>Prev</font>";
//
this.addChild(PrevBuyItemPageText);
PrevBuyItemPageText.width = 70;
PrevBuyItemPageText.autoSize = TextFieldAutoSize.CENTER;
PrevBuyItemPageText.selectable = false;
PrevBuyItemPageText.mouseEnabled = false;
PrevBuyItemPage.buttonMode = true;
PrevBuyItemPage.addChild(PrevBuyItemPageText);
PrevBuyItemPage.addEventListener(MouseEvent.CLICK, onPrevBuyItemPageClick);
PrevBuyItemPage.graphics.beginFill(0xFFFFFF);
PrevBuyItemPage.graphics.lineStyle(1);
PrevBuyItemPage.graphics.drawRect(0,0,70,32);
PrevBuyItemPage.graphics.endFill();
PrevBuyItemPage.y = 480;
PrevBuyItemPage.x = 165;

  NextBuyItemPage = new Sprite();
  var NextBuyItemPageText = new TextField();
  NextBuyItemPageText.htmlText = "<font size='14'>Next</font>";
//
  NextBuyItemPage.addChild(NextBuyItemPageText);
  NextBuyItemPageText.width = 70;
  NextBuyItemPageText.autoSize = TextFieldAutoSize.CENTER;
  NextBuyItemPageText.selectable = false;
  NextBuyItemPageText.mouseEnabled = false;
  NextBuyItemPage.buttonMode = true;
  NextBuyItemPage.addChild(NextBuyItemPageText);
  NextBuyItemPage.addEventListener(MouseEvent.CLICK, onNextBuyItemPageClick);
  NextBuyItemPage.graphics.beginFill(0xFFFFFF);
  NextBuyItemPage.graphics.lineStyle(1);
  NextBuyItemPage.graphics.drawRect(0,0,70,32);
  NextBuyItemPage.graphics.endFill();
  NextBuyItemPage.y = 480; NextBuyItemPage.x = 245;
  BuyItemMenu = new Sprite();
  ItemsLayer.addChild(BuyItemMenu);

  drawBuyItemMenu(BuyItemPage);

  currentMonsterMenu = new MonsterMenu(currentTrainer);

  tableExit  = new CustomSprite();
  tableExit.graphics.beginFill(0xFFFFFF);
  tableExit.graphics.lineStyle(1);
  tableExit.graphics.drawRect(0,0,25,25);
  tableExit.graphics.beginBitmapFill(new XButton());
  tableExit.graphics.drawRect(0, 0, 25, 25);
  tableExit.graphics.endFill();
  tableExit.x=background.width-35;
  tableExit.y = 10;
  tableExit.buttonMode = true;
  tableExit.addEventListener(MouseEvent.CLICK, ontableExitClick);
  addChild(tableExit);

  ItemConfirmBackground = new Sprite();
  //ItemConfirmBackground.y = (Math.max(512-(31+((buttonPosition)*35)),0))/2;
  ItemConfirmBackground.graphics.beginFill(0xFFFFFF);
  ItemConfirmBackground.graphics.lineStyle(1);
  ItemConfirmBackground.graphics.drawRect(0,0,6440,512);
  ItemConfirmBackground.graphics.endFill();
  ItemConfirmBackground.alpha = 0.5;

  ItemNumber = new TextField();
  ItemNumber.type = TextFieldType.INPUT;
  ItemNumber.border = true;
  ItemNumber.x = 225;
  ItemNumber.y = 175;
  ItemNumber.width = 35;
  ItemNumber.height = 35;
  ItemNumber.multiline = true;
  ItemNumber.wordWrap = true;
  ItemNumber.addEventListener(FocusEvent.FOCUS_OUT,ItemNumberOut);

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
  ItemYes.y = 215;
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
  ItemNo.y = 215;ItemNo.x = 250;
  //addChild(QuitButton);
  }
public function redraw()
{
    drawItemMenu();
    drawBuyItemMenu();
}

private function ItemNumberOut(event:FocusEvent) {
    try
    {
    
      var count = currentTrainer.CurrentInventory.getItemsByName(currentItem);
      var number = Std.parseInt(ItemNumber.text);
      var input =  Std.string(number);
      if(ItemState == "Buy")
      {

	var BuyItem =  new Item();
	BuyItem.updateItem(new Point(),currentItem);
	if(BuyItem.getValue() == 0)
	  {count = 100;}
	else
	  {count = Std.int(currentTrainer.Money/BuyItem.getValue());}
      }
      if(input == "" || input == null || input == "null")
      {
	ItemNumber.text  = "0";
      }
      else
      {
	if(number < 0)
	{
	  number = 0;
	}
	else if(number > count)
	{
	  number = count;
	}
	ItemNumber.text = Std.string(number);
      }
    }
    catch (e:Dynamic)
    {
      ItemNumber.text = "0";
    }
}
private function onItemSelected (event:ItemButtonEvent) {
var count = 0;
 currentItem = event.Name;
 ItemState = "Sell";
 count = currentTrainer.CurrentInventory.getItemsByName(currentItem);
 //add child Confirm Dialog.
 addChild(ItemConfirmBackground);
  ItemConfirm.htmlText = "<font size='14'>Sell "+currentItem + "? (Max "+count+")</font>";
  //ItemConfirm.width = (490 - ItemConfirm.width/2);
  addChild(ItemConfirm);
  ItemNumber.text  = "0";
  addChild(ItemNumber);
  addChild(ItemYes); 
  addChild(ItemNo); 


}

private function onBuyItemSelected (event:BuyItemButtonEvent) {
  var count = 0;
 currentItem = event.Name;
  var buyItem = new Item();
  buyItem.updateItem(new Point(),currentItem);
 ItemState = "Buy";
 //add child Confirm Dialog.
 addChild(ItemConfirmBackground);
 ItemConfirm.htmlText = "<font size='14'>Buy "+currentItem + "? (Cost "+buyItem.getValue()+")</font>";
  //ItemConfirm.width = (490 - ItemConfirm.width/2);
 addChild(ItemConfirm);
 ItemNumber.text  = "0";
 addChild(ItemNumber);
 addChild(ItemYes); 
 addChild(ItemNo);

}

private function onMonsterItemCancel(event:Event)
{
  currentMonsterMenu.removeEventListener("Cancel",onMonsterItemCancel);   
  currentItem = "";
  ItemState = "";
  removeChild(currentMonsterMenu);
  currentMonsterMenu.CurrentState = "";
  currentMonsterMenu.StatusText.htmlText = "<font size='16'></font>";
  currentMonsterMenu.removeChild(currentMonsterMenu.ItemConfirmBackground);
  currentMonsterMenu.removeChild(currentMonsterMenu.ItemConfirm);
  currentMonsterMenu.removeChild(currentMonsterMenu.ItemNo); 
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
private function onPrevBuyItemPageClick(event:MouseEvent)
{
  BuyItemPage--;
  drawBuyItemMenu(BuyItemPage);
}
private function onNextBuyItemPageClick(event:MouseEvent)
{
  BuyItemPage++;
  drawBuyItemMenu(BuyItemPage);
}

private function drawBuyItemMenu(?Page:Int=1)
{
  ItemsLayer.removeChild(BuyItemMenu);
  BuyItemMenu = new Sprite();
  BuyItemMenu.x = 0;
  var start = 26*(Page-1);
  var finish = 26*Page;
  var buttonPosition = 0;
    var Title = new TextField();
    Title.selectable = false;
    Title.htmlText = "<u><font size = '16'>Buy</font></u>";
    Title.width = 320;
    Title.autoSize = TextFieldAutoSize.CENTER;
    BuyItemMenu.addChild(Title);
  var countedItems = new List<String>();
  for(item in BuyableItems)
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
    
    if(buttonPosition < start || buttonPosition >=finish)
    {
      if(buttonPosition == 0)
	{
	  BuyItemMenu.addChild(PrevBuyItemPage);
	}
      if(buttonPosition == finish+1)
	{
	  BuyItemMenu.addChild(NextBuyItemPage);
	}
      buttonPosition++;
      continue;
    }
    countedItems.add(item.ID);
    var BuyItem = new BuyItemButton(item.ID,1);

    var pagePosition = (buttonPosition-((Page-1)*26));
    var column = 0;
    column = Math.floor(pagePosition / 13);
    BuyItem.x = 5+155*column;BuyItem.y=26+(((pagePosition-(column*13))*35));


    BuyItemMenu.addChild(BuyItem);
    buttonPosition++;
  }
  var menuSize = ((buttonPosition-((Page-1)*13))*35);
      BuyItemMenu.x = 0;
      BuyItemMenu.y = 0;
      BuyItemMenu.graphics.beginFill(0xFFFFFF);
      BuyItemMenu.graphics.lineStyle(1);
      BuyItemMenu.graphics.drawRect(0,0,320,512);
      BuyItemMenu.graphics.endFill();
  ItemsLayer.addChild(BuyItemMenu);
//   removeChild(tableExit);
//   addChild(tableExit);



}

private function drawItemMenu(?Page:Int=1)
{
  ItemsLayer.removeChild(ItemMenu);
  ItemMenu = new Sprite();
  ItemMenu.x = 0;
  var start = 26*(Page-1);
  var finish = 26*Page;
  var buttonPosition = 0;
    var Title = new TextField();
    Title.selectable = false;
    Title.htmlText = "<font size = '16'><u>Sell</u></font>";
    Title.width = 320;
    Title.autoSize = TextFieldAutoSize.CENTER;
    ItemMenu.addChild(Title);

    var MoneyText = new TextField();
    MoneyText.selectable = false;
    MoneyText.htmlText = "<font size = '14'> Money: "+currentTrainer.Money+"</font>";
    MoneyText.width = 320;
    MoneyText.y = 480;
    MoneyText.autoSize = TextFieldAutoSize.LEFT;
    ItemMenu.addChild(MoneyText);
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
    var Item = new ItemButton(item.ID,count);

    var pagePosition = (buttonPosition-((Page-1)*26));
    var column = 0;
    column = Math.floor(pagePosition / 13);
    Item.x = 5+155*column;Item.y=26+(((pagePosition-(column*13))*35));


    ItemMenu.addChild(Item);
    buttonPosition++;
  }
  var menuSize = ((buttonPosition-((Page-1)*13))*35);
      ItemMenu.x = 320;
      ItemMenu.y = 0;
      ItemMenu.graphics.beginFill(0xFFFFFF);
      ItemMenu.graphics.lineStyle(1);
      ItemMenu.graphics.drawRect(0,0,320,512);
      ItemMenu.graphics.endFill();
 ItemsLayer.addChild(ItemMenu);
//   removeChild(tableExit);
//   addChild(tableExit);


  
}


private function onItemYesClick(event:MouseEvent)
{
  //State = "Finish";

    var number = Std.parseInt(ItemNumber.text);
    if(ItemState == "Sell")
    {
      currentTrainer.CurrentInventory.sellItem(currentItem,number,currentTrainer);
    }
    else if(ItemState == "Buy")
    {
      currentTrainer.CurrentInventory.buyItem(currentItem,number,currentTrainer);
    }
    
    removeChild(ItemConfirmBackground);
    removeChild(ItemConfirm);
    removeChild(ItemNo);
    //addChild Confirm Menu
    removeChild(ItemYes);
    removeChild(ItemNumber);
    drawItemMenu(ItemPage);
    currentItem ="";
    ItemState = "";
}
private function onItemNoClick(event:MouseEvent)
{
  //State = "Finish";
  removeChild(ItemConfirmBackground);

  removeChild(ItemConfirm);
  removeChild(ItemNo);
  removeChild(ItemYes);
  removeChild(ItemNumber);
  currentItem ="";
  ItemState = "";
}

private function ontableExitClick(event:MouseEvent) {
    dispatchEvent(new Event("Back"));
}


}