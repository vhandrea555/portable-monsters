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
class SendMoneyEvent extends Event{
 
	public function new(customEventString:String){
	super(customEventString, true, false);

    }
}

class SendMoney extends Sprite
{
    public var MoneyNumber:TextField;
    public var MoneyYes:Sprite;
    public var MoneyNo:Sprite;
    public var MoneyConfirm:TextField;
    public var currentTrainer:Trainer;
    public function new(inTrainer:Trainer)
    {
      super();
      currentTrainer = inTrainer;
      var background = new Sprite();
      background.graphics.lineStyle(1);
      background.graphics.beginFill(0xFFFFFF);
      background.graphics.drawRect(0, 0,640-150,Constants.flashHeight);
      background.graphics.endFill();
      background.x = 0 ; background.y = 0;
      //End Resize
      addChild(background);

        MoneyNumber = new TextField();
	MoneyNumber.type = TextFieldType.INPUT;
	MoneyNumber.border = true;
	MoneyNumber.x = 205;
	MoneyNumber.y = 175;
	MoneyNumber.width = 75;
	MoneyNumber.height = 35;
	MoneyNumber.multiline = true;
	MoneyNumber.wordWrap = true;
	MoneyNumber.addEventListener(FocusEvent.FOCUS_OUT,MoneyNumberOut);

	MoneyConfirm = new TextField();
	MoneyConfirm.background = true;
	MoneyConfirm.backgroundColor = 0xFFFFFF;
	MoneyConfirm.htmlText = "<font size='14'>Send Money Home?</font>";
	MoneyConfirm.autoSize = TextFieldAutoSize.CENTER;
	MoneyConfirm.width = (490 - (MoneyConfirm.width-120)/2);
	MoneyConfirm.y = 150;
	MoneyConfirm.selectable = false;
	MoneyConfirm.mouseEnabled = false;

	 MoneyYes = new Sprite();
	var MoneyYesText = new TextField();
	MoneyYesText.htmlText = "<font size='14'>Confirm</font>";

	MoneyYes.addChild(MoneyYesText);
	MoneyYesText.width = 70;
	MoneyYesText.autoSize = TextFieldAutoSize.CENTER;
	MoneyYesText.selectable = false;
	MoneyYesText.mouseEnabled = false;
	MoneyYes.buttonMode = true;
	MoneyYes.addChild(MoneyYesText);
	MoneyYes.addEventListener(MouseEvent.CLICK, onMoneyYesClick);
	MoneyYes.graphics.beginFill(0xFFFFFF);
	MoneyYes.graphics.lineStyle(1);
	MoneyYes.graphics.drawRect(0,0,70,32);
	MoneyYes.graphics.endFill();
	MoneyYes.y = 215;
	MoneyYes.x = 175;


	MoneyNo = new Sprite();
	MoneyNo.mouseChildren = false;
	var MoneyNoText = new TextField();
	MoneyNoText.htmlText = "<font size='14'>Cancel</font>";
      //
	MoneyNo.addChild(MoneyNoText);
	MoneyNoText.width = 70;
	MoneyNoText.autoSize = TextFieldAutoSize.CENTER;
	MoneyNoText.selectable = false;
	MoneyNoText.mouseEnabled = false;
	MoneyNo.buttonMode = true;
	MoneyNo.addChild(MoneyNoText);
	MoneyNo.addEventListener(MouseEvent.CLICK, onMoneyNoClick);
	MoneyNo.graphics.beginFill(0xFFFFFF);
	MoneyNo.graphics.lineStyle(1);
	MoneyNo.graphics.drawRect(0,0,70,32);
	MoneyNo.graphics.endFill();
	MoneyNo.y = 215;MoneyNo.x = 250;

      background.addChild(MoneyConfirm);
      background.addChild(MoneyYes);
      background.addChild(MoneyNo);
      background.addChild(MoneyNumber);
    }

private function onMoneyYesClick(event:MouseEvent)
{
  var number = Std.parseInt(MoneyNumber.text);
  MoneyNumber.text = "0";
  currentTrainer.Money -= number;
  currentTrainer.MoneySentHome += number;
  dispatchEvent(new Event("Back"));
}
private function onMoneyNoClick(event:MouseEvent)
{
  MoneyNumber.text = "0";
  dispatchEvent(new Event("Back"));
}    
private function MoneyNumberOut(event:FocusEvent) {
    try
    {
    
      var max = currentTrainer.Money;
      max = Std.int(Math.max(max,0));
      var min = 0;
      var number = Std.parseInt(MoneyNumber.text);
      var input =  Std.string(number);
      if(input == "" || input == null || input == "null")
      {
	MoneyNumber.text  = "0";
      }
      else
      {
	if(number < min)
	{
	  number = min;
	}
	else if(number > max)
	{
	  number = max;
	}
	MoneyNumber.text = Std.string(number);
      }
    }
    catch (e:Dynamic)
    {
      MoneyNumber.text = "0";
    }
}
    
}