import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;

import Images;
class CreditsPageEvent extends Event{
 
	public function new(customEventString:String){

	super(customEventString, true, false);

    }
}

class CreditsPage extends Sprite
{
private var BackButton:Sprite;
private var CurrentBackground: Bitmap;
private var Text:TextField;

  public function new()
  {
  super();
  //Resize Image
  var textBackgroundImage = new Background();
  var scaledWidth:Float = (Constants.flashWidth/textBackgroundImage.width);
  var scaledHeight:Float = (Constants.flashHeight/textBackgroundImage.height);

  var matrix:Matrix = new Matrix();
  matrix.scale(scaledWidth, scaledHeight);

  var smallBMD:BitmapData = new BitmapData(Std.int(textBackgroundImage.width * scaledWidth), Std.int(textBackgroundImage.height * scaledHeight),true, 0x000000);

  smallBMD.draw(textBackgroundImage, matrix, null, null, null, true);

  CurrentBackground = new Bitmap(smallBMD);//, PixelSnapping.NEVER, true);
  //End Resize
  addChild(CurrentBackground);

  Text = new TextField();
    
  Text.x = 50; Text.y = 60;
  Text.width = 540; Text.height = 420;
  addChild(Text);
  Text.multiline = true;
  Text.wordWrap = true;
  var myFormat:TextFormat = new TextFormat();
  myFormat.size = 15;
  //myFormat.align = TextFormatAlign.CENTER;
  Text.defaultTextFormat = myFormat;
  
  Text.htmlText = "Everything by ZeroCreativity1";

  BackButton  = new Sprite();
  BackButton.graphics.beginBitmapFill(new BackImage());
  BackButton.graphics.drawRect(0, 0, 125 ,48);
  BackButton.x = Constants.flashWidth-140;
  BackButton.y = Constants.flashHeight-60;
  BackButton.buttonMode = true;
  BackButton.addEventListener(MouseEvent.CLICK, onBackButtonClick);
  addChild(BackButton);
  }

private function onBackButtonClick(event:MouseEvent) {
    Back();
}

  public function Back()
  {
  dispatchEvent(new CreditsPageEvent("Back"));
  }
}