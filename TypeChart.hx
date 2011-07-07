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
class TypeChartEvent extends Event{
 
	public function new(customEventString:String){
	super(customEventString, true, false);

    }
}

class TypeChart extends Sprite
{
  private var Text:TextField;
  private var Strong:TextField;
  private var Weak:TextField;
  private var Defence:TextField;
  private var Attack:TextField;
  private var Age:TextField;
  private var Money:TextField;
  private var background:Sprite;
  private var Grid:Sprite;
  public var ExitMenu:Sprite;

  public function new()
  {
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
      Text.htmlText = "<u>Attacker vs Defender</u>";


      Strong = new TextField();

      Strong.x = 145; Strong.y = 390;
      Strong.width = 120; Strong.height = 40;
      Strong.multiline = true;
      Strong.wordWrap = true;
      Strong.selectable = false;
      var myFormat:TextFormat = new TextFormat();
      myFormat.size = 20;
      myFormat.align = TextFormatAlign.CENTER;
      Strong.defaultTextFormat = myFormat;
      Strong.htmlText = "= Strong";


      Weak = new TextField();

      Weak.x = 341; Weak.y = 390;
      Weak.width = 120; Weak.height = 40;
      Weak.multiline = true;
      Weak.wordWrap = true;
      Weak.selectable = false;
      var myFormat:TextFormat = new TextFormat();
      myFormat.size = 20;
      myFormat.align = TextFormatAlign.CENTER;
      Weak.defaultTextFormat = myFormat;
      Weak.htmlText = "= Weak";

      Defence = new TextField();

      Defence.x = 93; Defence.y = 60;
      Defence.width = 450; Defence.height = 40;
      Defence.multiline = true;
      Defence.wordWrap = true;
      Defence.selectable = false;
      var myFormat:TextFormat = new TextFormat();
      myFormat.size = 16;
      myFormat.align = TextFormatAlign.LEFT;
      Defence.defaultTextFormat = myFormat;
      Defence.htmlText = "Water       Flame        Plant       Earth      Electric    Generic";

      Attack = new TextField();

      Attack.x = 25; Attack.y = 107;
      Attack.width = 450; Attack.height = 450;
      Attack.multiline = true;
      Attack.wordWrap = true;
      Attack.selectable = false;
      var myFormat:TextFormat = new TextFormat();
      myFormat.size = 16;
      myFormat.align = TextFormatAlign.LEFT;
      Attack.defaultTextFormat = myFormat;
      Attack.htmlText = "Water\n\nFlame\n\nPlant\n\nEarth\n\nElectric\n\nGeneric";


      super();

    background = new Sprite();
    background.graphics.lineStyle(1);
    background.graphics.beginFill(0xFFFFFF);
    background.graphics.drawRect(0, 0,640-150,Constants.flashHeight);
    background.graphics.endFill();
    background.x = 0 ; background.y = 0;
    //End Resize
    addChild(background);


    Grid = new Sprite();
    Grid.graphics.lineStyle(1);
    Grid.graphics.beginFill(0xFFFFFF);
    //Grid.graphics.drawRect(0, 0,620-150,472);
    Grid.graphics.drawRect(0, 0,450,40);
    Grid.graphics.drawRect(0, 40,65,40);
    Grid.graphics.drawRect(65, 40,64,40);
    Grid.graphics.drawRect(129, 40,64,40);
    Grid.graphics.drawRect(193, 40,64,40);
    Grid.graphics.drawRect(257, 40,64,40);
    Grid.graphics.drawRect(321, 40,64,40);
    Grid.graphics.drawRect(385, 40,65,40);
    Grid.graphics.drawRect(0, 80,65,40);
    Grid.graphics.drawRect(65, 80,64,40);
    Grid.graphics.drawRect(385, 80,65,40);
    Grid.graphics.drawRect(0, 120,65,40);
    Grid.graphics.drawRect(129, 120,64,40);
    
    Grid.graphics.drawRect(257, 120,64,40);
    Grid.graphics.drawRect(321, 120,64,40);
    Grid.graphics.drawRect(385, 120,65,40);

    Grid.graphics.drawRect(0, 160,65,40);
    Grid.graphics.drawRect(193, 160,64,40);
    Grid.graphics.drawRect(257, 160,64,40);
    Grid.graphics.drawRect(321, 160,64,40);
    Grid.graphics.drawRect(385, 160,65,40);
    Grid.graphics.drawRect(0, 200,65,40);

    Grid.graphics.drawRect(129, 200,64,40);
    Grid.graphics.drawRect(193, 200,64,40);
    Grid.graphics.drawRect(257, 200,64,40);

    Grid.graphics.drawRect(385, 200,65,40);
    Grid.graphics.drawRect(0, 240,65,40);
    Grid.graphics.drawRect(129, 240,64,40);
    Grid.graphics.drawRect(193, 240,64,40);
    Grid.graphics.drawRect(257, 240,64,40);
    Grid.graphics.drawRect(385, 240,65,40);
    Grid.graphics.drawRect(0, 280,65,40);
    Grid.graphics.drawRect(65, 280,64,40);
    Grid.graphics.drawRect(129, 280,64,40);
    Grid.graphics.drawRect(193, 280,64,40);
    Grid.graphics.drawRect(257, 280,64,40);
    Grid.graphics.drawRect(321, 280,64,40);
    Grid.graphics.drawRect(385, 280,65,40);


//Strong 1b077f
    Grid.graphics.beginFill(0x1b077f);
    Grid.graphics.drawRect(129, 80,64,40);
    Grid.graphics.drawRect(257, 80,64,40);
    Grid.graphics.drawRect(193, 120,64,40);
    Grid.graphics.drawRect(65, 160,64,40);
    Grid.graphics.drawRect(321, 200,64,40);
    Grid.graphics.drawRect(65, 240,64,40);

    Grid.graphics.drawRect(65, 360,64,40);


    
//Weak ed4c0d
    Grid.graphics.beginFill(0x5f9ff6);
    Grid.graphics.drawRect(321, 80,64,40);
    Grid.graphics.drawRect(193, 80,64,40);
    Grid.graphics.drawRect(65, 120,64,40);
    Grid.graphics.drawRect(129, 160,64,40);
    Grid.graphics.drawRect(65, 200,64,40);
    Grid.graphics.drawRect(321, 240,64,40);

    Grid.graphics.drawRect(257, 360,64,40);

//     Grid.graphics.drawRect(0, 40,74,74);
//     Grid.graphics.drawRect(0, 114,74,104);
//     Grid.graphics.drawRect(74, 70,74,74);
//     Grid.graphics.drawRect(148, 70,74,74);
//     Grid.graphics.drawRect(74, 144,74,74);
//     Grid.graphics.drawRect(148, 144,74,74);
//     Grid.graphics.drawRect(222, 70,450-222,148);
    //TrainerBadge.graphics.drawRect(0, 0,620-150,492);
Grid.x=20;
Grid.y=20;

    Grid.graphics.endFill();
    background.addChild(Grid);
    background.addChild(Text);
    background.addChild(Defence);
    background.addChild(Attack);
    background.addChild(Strong);
    background.addChild(Weak);
  ExitMenu  = new Sprite();
  ExitMenu.graphics.beginFill(0xFFFFFF);
  ExitMenu.graphics.lineStyle(1);
  ExitMenu.graphics.drawRect(0,0,25,25);
  ExitMenu.graphics.beginBitmapFill(new XButton());
  ExitMenu.graphics.drawRect(0, 0, 25, 25);
  ExitMenu.graphics.endFill();
  ExitMenu.x=background.width-95;
  ExitMenu.y = 10;
  ExitMenu.buttonMode = true;
  ExitMenu.addEventListener(MouseEvent.CLICK, onExitMenuClick);
  addChild(ExitMenu);
    //Money
  }

  private function onExitMenuClick(event:MouseEvent) {
      dispatchEvent(new Event("Back"));
  }
}
