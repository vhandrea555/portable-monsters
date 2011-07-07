import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import flash.geom.Point;
import flash.geom.Rectangle;



import Images;
import MnstrWikiMenu;
import MonsterMenu;
import ItemMenu;
class StatusMenuEvent extends Event{
 
	public function new(customEventString:String){
	super(customEventString, true, false);

    }
}

class StatusMenu extends Sprite
{
  private var Text:TextField;
  private var Name:TextField;
  private var Age:TextField;
  private var Money:TextField;
  private var background:Sprite;
  private var currentTrainer:Trainer;
  private var Avatar:Sprite;
  private var JoyBadge:Sprite;
  private var AngerBadge:Sprite;
  private var ConfusionBadge:Sprite;
  private var BlankBadge:Sprite;
  private var TrainerBadge:Sprite;
  private var currentPlot:Plot;
  public function redraw()
  {
    if(currentPlot.JoyBadge && currentPlot.AngerBadge &&
      currentPlot.ConfusionBadge && currentPlot.BlankBadge)
    {
      Age.htmlText = "Age:\n14";
    }
    else
    {
      Age.htmlText = "Age:\n13";
    }
    if(currentPlot.JoyBadge)
    {
      JoyBadge.visible = true;
    }
    else
    {
      JoyBadge.visible = false;
    }
    if(currentPlot.AngerBadge)
    {
      AngerBadge.visible = true;
    }
    else
    {
      AngerBadge.visible = false;
    }
    if(currentPlot.ConfusionBadge)
    {
      ConfusionBadge.visible = true;
    }
    else
    {
      ConfusionBadge.visible = false;
    }
    if(currentPlot.BlankBadge)
    {
      BlankBadge.visible = true;
    }
    else
    {
      BlankBadge.visible = false;
    }
    Money.htmlText = "Money:\n" + currentTrainer.Money;
    
  }
  public function new(inTrainer:Trainer,inPlot:Plot)
  {
      currentTrainer = inTrainer;
      currentPlot = inPlot;
      Text = new TextField();

      Text.x = 20; Text.y = 20;
      Text.width = 450; Text.height = 40;
      Text.multiline = true;
      Text.wordWrap = true;
      Text.selectable = false;
      var myFormat:TextFormat = new TextFormat();
      myFormat.size = 28;
      myFormat.align = TextFormatAlign.CENTER;
      Text.defaultTextFormat = myFormat;
      Text.htmlText = "Trainer Card";

      Name = new TextField();

      Name.x = 20; Name.y = 60;
      Name.width = 450; Name.height = 30;
      Name.multiline = true;
      Name.wordWrap = true;
      Name.selectable = false;
      var myFormat:TextFormat = new TextFormat();
      myFormat.size = 16;
      myFormat.align = TextFormatAlign.CENTER;
      Name.defaultTextFormat = myFormat;
      Name.htmlText = "Eve Corliss Hamlet";

      Age = new TextField();

      Age.x = 20; Age.y = 150;
      Age.width = 75; Age.height = 60;
      Age.multiline = true;
      Age.wordWrap = true;
      Age.selectable = false;
      var myFormat:TextFormat = new TextFormat();
      myFormat.size = 16;
      myFormat.align = TextFormatAlign.CENTER;
      Age.defaultTextFormat = myFormat;
      Age.htmlText = "Age:\n13";


      Money = new TextField();

      Money.x = 222; Money.y = 90;
      Money.width = 450-222; Money.height = 148;
      Money.multiline = true;
      Money.wordWrap = true;
      Money.selectable = false;
      var myFormat:TextFormat = new TextFormat();
      myFormat.size = 16;
      myFormat.align = TextFormatAlign.CENTER;
      Money.defaultTextFormat = myFormat;
      Money.htmlText = "Money:\n" + currentTrainer.Money;
      super();

    background = new Sprite();
    background.graphics.lineStyle(1);
    background.graphics.beginFill(0xFFFFFF);
    background.graphics.drawRect(0, 0,640-150,Constants.flashHeight);
    background.graphics.endFill();
    background.x = 0 ; background.y = 0;
    //End Resize
    addChild(background);


    TrainerBadge = new Sprite();
    TrainerBadge.graphics.lineStyle(1);
    TrainerBadge.graphics.beginFill(0xFFFFFF);
    //TrainerBadge.graphics.drawRect(0, 0,620-150,472);
    TrainerBadge.graphics.drawRect(0, 0,450,40);
    TrainerBadge.graphics.drawRect(74, 40,450-74,30);
    TrainerBadge.graphics.drawRect(0, 40,74,74);
    TrainerBadge.graphics.drawRect(0, 114,74,104);
    TrainerBadge.graphics.drawRect(74, 70,74,74);
    TrainerBadge.graphics.drawRect(148, 70,74,74);
    TrainerBadge.graphics.drawRect(74, 144,74,74);
    TrainerBadge.graphics.drawRect(148, 144,74,74);
    TrainerBadge.graphics.drawRect(222, 70,450-222,148);
    //TrainerBadge.graphics.drawRect(0, 0,620-150,492);
TrainerBadge.x=20;
TrainerBadge.y=20;

    TrainerBadge.graphics.endFill();
  background.addChild(TrainerBadge);
    background.addChild(Text);
    background.addChild(Name);
    background.addChild(Money);
    background.addChild(Age);
    //Player 
Avatar = new CustomSprite();
  Avatar.graphics.drawRect(0,0,64,64);
  Avatar.graphics.endFill(); 
  var tileSheetColumn:Int = 1;
  var tileSheetRow:Int = 1;
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
  var resizeBitmapData = HelperMethods.resize(64,64,modelBitmapData);
  var modelBitmap = new Bitmap(resizeBitmapData);
  Avatar.addChild(modelBitmap);
  background.addChild(Avatar);
  Avatar.x = 25;
  Avatar.y = 62;
  //Age
  //

    //Badges
  JoyBadge = new CustomSprite();
  JoyBadge.graphics.drawRect(0,0,64,64);
  JoyBadge.graphics.endFill(); 
  var tileSheetColumn:Int = 5;
  var tileSheetRow:Int = 9;
  var sourceRectangle:Rectangle = new Rectangle
  (tileSheetColumn * 32, tileSheetRow * 32, 32,32);
		    
  var destinationPoint:Point = new Point(0, 0);
  var modelBitmapData = new BitmapData(32, 32, true, 0);
    modelBitmapData.copyPixels
    (
      new TileSheet(), 
      sourceRectangle, 
      destinationPoint,
      null, null, true
    );
  var resizeBitmapData = HelperMethods.resize(64,64,modelBitmapData);
  var modelBitmap = new Bitmap(resizeBitmapData);
  JoyBadge.addChild(modelBitmap);
  background.addChild(JoyBadge);
  JoyBadge.x = 100;
  JoyBadge.y = 92;

AngerBadge= new CustomSprite();
  AngerBadge.graphics.drawRect(0,0,64,64);
  AngerBadge.graphics.endFill(); 
  var tileSheetColumn:Int = 6;
  var tileSheetRow:Int = 9;
  var sourceRectangle:Rectangle = new Rectangle
  (tileSheetColumn * 32, tileSheetRow * 32, 32,32);
		    
  var destinationPoint:Point = new Point(0, 0);
  var modelBitmapData = new BitmapData(32, 32, true, 0);
    modelBitmapData.copyPixels
    (
      new TileSheet(), 
      sourceRectangle, 
      destinationPoint,
      null, null, true
    );
  var resizeBitmapData = HelperMethods.resize(64,64,modelBitmapData);
  var modelBitmap = new Bitmap(resizeBitmapData);
  AngerBadge.addChild(modelBitmap);
  background.addChild(AngerBadge);
  AngerBadge.x = 175;
  AngerBadge.y = 92;

  ConfusionBadge = new CustomSprite();
  ConfusionBadge.graphics.drawRect(0,0,64,64);
  ConfusionBadge.graphics.endFill(); 
  var tileSheetColumn:Int = 5;
  var tileSheetRow:Int = 10;
  var sourceRectangle:Rectangle = new Rectangle
  (tileSheetColumn * 32, tileSheetRow * 32, 32,32);
		    
  var destinationPoint:Point = new Point(0, 0);
  var modelBitmapData = new BitmapData(32, 32, true, 0);
    modelBitmapData.copyPixels
    (
      new TileSheet(), 
      sourceRectangle, 
      destinationPoint,
      null, null, true
    );
  var resizeBitmapData = HelperMethods.resize(64,64,modelBitmapData);
  var modelBitmap = new Bitmap(resizeBitmapData);
  ConfusionBadge.addChild(modelBitmap);
  background.addChild(ConfusionBadge);
  ConfusionBadge.x = 100;
  ConfusionBadge.y = 177;

BlankBadge= new CustomSprite();
  BlankBadge.graphics.drawRect(0,0,64,64);
  BlankBadge.graphics.endFill(); 
  var tileSheetColumn:Int = 6;
  var tileSheetRow:Int = 10;
  var sourceRectangle:Rectangle = new Rectangle
  (tileSheetColumn * 32, tileSheetRow * 32, 32,32);
		    
  var destinationPoint:Point = new Point(0, 0);
  var modelBitmapData = new BitmapData(32, 32, true, 0);
    modelBitmapData.copyPixels
    (
      new TileSheet(), 
      sourceRectangle, 
      destinationPoint,
      null, null, true
    );
  var resizeBitmapData = HelperMethods.resize(64,64,modelBitmapData);
  var modelBitmap = new Bitmap(resizeBitmapData);
  BlankBadge.addChild(modelBitmap);
  background.addChild(BlankBadge);
  BlankBadge.x = 175;
  BlankBadge.y = 177;


    //Money
  }
}