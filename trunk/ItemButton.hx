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

class ItemButtonEvent extends Event{
public var Name:String;
	public function new(customEventString:String,inName:String){
        Name = inName;
	super(customEventString, true, false);

    }
}

class ItemButton extends Sprite
{
  public var Name:String;
  public var ItemCount:Int;
  public function new(inName:String,inItemCount:Int,?disabled:Bool = false){
    super();
    Name = inName;
    ItemCount = inItemCount;
    if(disabled)
    {
      this.graphics.beginFill(0x8C8C8C);
      this.graphics.lineStyle(1);
      this.graphics.drawRect(0,0,140,32);
      this.graphics.endFill();
      this.buttonMode = false;
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
    text.htmlText = "<font size='14'>"+Name+"</font>";
    //
    this.addChild(text);
    text.width = 140;
    text.autoSize = TextFieldAutoSize.LEFT;
    text.selectable = false;
    text.mouseEnabled = false;

    var ItemCountText= new TextField();
    ItemCountText.htmlText = "<font size='12'>"+ItemCount +   "</font>";
    //
    this.addChild(ItemCountText);
    ItemCountText.width = 140;
    ItemCountText.y = 16;
    ItemCountText.autoSize = TextFieldAutoSize.RIGHT;
    ItemCountText.selectable = false;
    ItemCountText.mouseEnabled = false;

    if(!disabled)
    {
      this.addEventListener(MouseEvent.CLICK, onItemButtonButtonClick);
    }
  }
  
  private function onItemButtonButtonClick(event:MouseEvent) {
      dispatchEvent(new ItemButtonEvent("Item",Name));
  }

  public function update(){
    //ItemCountText.htmlText = "<font size='12'>"+CurrentItem.MP+"/" + CurrentItem.TotalMP +   "</font>";
  }
}