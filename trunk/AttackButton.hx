import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class AttackButtonEvent extends Event{
public var Name:String;
	public function new(customEventString:String,inName:String){
        Name = inName;
	super(customEventString, true, false);

    }
}

class AttackButton extends Sprite
{
  public var AttackMove:Move;
  public function new(inMove:Move){
    super();
    AttackMove = inMove;
    
    if(AttackMove.MP <= 0 && AttackMove.TotalMP > -1)
    {
      this.graphics.beginFill(0x8C8C8C);
      this.graphics.lineStyle(1);
      this.graphics.drawRect(0,0,140,32);
      this.graphics.endFill();
      this.buttonMode = true;
    }
    else
    {
      this.graphics.beginFill(0xFFFFFF);
      this.graphics.lineStyle(1);
      this.graphics.drawRect(0,0,140,32);
      this.graphics.endFill();
      this.buttonMode = true;
    }

    var text = new TextField();
    text.htmlText = "<font size='14'>"+AttackMove.Name+"</font>";
    //
    this.addChild(text);
    text.width = 140;
    text.autoSize = TextFieldAutoSize.LEFT;
    text.selectable = false;
    text.mouseEnabled = false;

    var MoveMP = new TextField();
    if(AttackMove.TotalMP <= -1)
    {
      MoveMP.htmlText = "<font size='12'>Inf.</font>";
    }
    else
    {
      MoveMP.htmlText = "<font size='12'>"+AttackMove.MP+"/" + AttackMove.TotalMP +   "</font>";
    }
    //
    this.addChild(MoveMP);
    MoveMP.width = 140;
    MoveMP.y = 16;
    MoveMP.autoSize = TextFieldAutoSize.RIGHT;
    MoveMP.selectable = false;
    MoveMP.mouseEnabled = false;

    this.addEventListener(MouseEvent.CLICK, onAttackButtonButtonClick);
  }
  
  private function onAttackButtonButtonClick(event:MouseEvent) {
    if(AttackMove.MP > 0 || AttackMove.TotalMP <= -1)
    {
      dispatchEvent(new AttackButtonEvent("Attack",AttackMove.Name));
      
    }
  }

  public function update(){
    if(AttackMove.MP <= 0)
    {
      this.graphics.beginFill(0x8C8C8C);
      this.graphics.lineStyle(1);
      this.graphics.drawRect(0,0,140,32);
      this.graphics.endFill();
      this.buttonMode = true;
    }
    else
    {
      this.graphics.beginFill(0xFFFFFF);
      this.graphics.lineStyle(1);
      this.graphics.drawRect(0,0,140,32);
      this.graphics.endFill();
      this.buttonMode = true;
    }
    //MoveMP.htmlText = "<font size='12'>"+AttackMove.MP+"/" + AttackMove.TotalMP +   "</font>";
  }
}