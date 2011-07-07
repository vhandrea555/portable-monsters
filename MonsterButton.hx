import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import flash.geom.Rectangle;
import flash.geom.Point;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import HelperMethods;
import Images;

class MonsterButtonEvent extends Event{
public var ID:Int;
	public function new(customEventString:String,inID:Int){
        ID = inID;
	super(customEventString, true, false);

    }
}

class MonsterButton extends Sprite
{
  public var currentMonster:Monster;
  public function new(inMonster:Monster,?showStatus:Bool = true){
    super();
    currentMonster = inMonster;
    
    if(currentMonster.Health <= 0)
    {
      this.graphics.beginFill(0x8C8C8C);
      this.graphics.lineStyle(1);
      this.graphics.drawRect(0,0,140,50);
      this.graphics.endFill();
      this.buttonMode = true;
    }
    else
    {
      this.graphics.beginFill(0xFFFFFF);
      this.graphics.lineStyle(1);
      this.graphics.drawRect(0,0,140,50);
      this.graphics.endFill();
      this.buttonMode = true;
    }

    var MonsterPic = new CustomSprite();
    MonsterPic.graphics.drawRect(0,0,64,64);
    MonsterPic.graphics.endFill(); 
    var tileSheetColumn:Int = Std.int(currentMonster.getTileNumber(false) / 100);
    var tileSheetRow:Int = Std.int(currentMonster.getTileNumber(false) % 100);
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
    var resizeBitmapData = HelperMethods.resize(50,50,modelBitmapData);
    var modelBitmap = new Bitmap(resizeBitmapData);
    MonsterPic.addChild(modelBitmap);
    addChild(MonsterPic);
    var text = new TextField();
    text.htmlText = "<font size='14'>"+currentMonster.Character+"</font>";
    //
    this.addChild(text);
    text.width = 140;
    text.autoSize = TextFieldAutoSize.RIGHT;
    text.selectable = false;
    text.mouseEnabled = false;

    var MonsterHealth = new TextField();
    MonsterHealth.htmlText = "<font size='12'>"+currentMonster.Health+"/" + currentMonster.MaxHealth +   "</font>\nLevel "+ currentMonster.Level;
    //
  
    if(showStatus)
    {
      this.addChild(MonsterHealth);
    }
    MonsterHealth.width = 140;
    MonsterHealth.y = 16;
    MonsterHealth.autoSize = TextFieldAutoSize.RIGHT;
    MonsterHealth.selectable = false;
    MonsterHealth.mouseEnabled = false;

    this.addEventListener(MouseEvent.CLICK, onMonsterButtonButtonClick);
  }
  
  private function onMonsterButtonButtonClick(event:MouseEvent) {
      dispatchEvent(new MonsterButtonEvent("Monster",currentMonster.ID));
  }
}