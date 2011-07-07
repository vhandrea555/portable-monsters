import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;

import Images;
class InstructionPageEvent extends Event{
 
	public function new(customEventString:String){

	super(customEventString, true, false);

    }
}

class InstructionPage extends Sprite
{
private var BackButton:Sprite;
private var CurrentBackground: Bitmap;
private var Text:TextField;

  public function new()
  {
  super();

  //Resize Image
  var textBackgroundImage:TextBackground = new TextBackground();
  var scaledWidth:Float = (640/textBackgroundImage.width);
  var scaledHeight:Float = (420/textBackgroundImage.height);

  var matrix:Matrix = new Matrix();
  matrix.scale(scaledWidth, scaledHeight);

  var smallBMD:BitmapData = new BitmapData(Std.int(textBackgroundImage.width * scaledWidth), Std.int(textBackgroundImage.height * scaledHeight),true, 0x000000);

  smallBMD.draw(textBackgroundImage, matrix, null, null, null, true);

  CurrentBackground = new Bitmap(smallBMD);//, PixelSnapping.NEVER, true);
  //End Resize
  addChild(CurrentBackground);


  Text = new TextField();
    
  Text.x = 50; Text.y = 50;
  Text.width = 440; Text.height = 420;
  addChild(Text);
  Text.multiline = true;
  var myFormat:TextFormat = new TextFormat();
  myFormat.size = 25;
  //myFormat.align = TextFormatAlign.CENTER;
  Text.defaultTextFormat = myFormat;
  
  Text.htmlText = "Find a job, invest, help some people. you know the game don't you?";
  //Text.y = ((150 - Text.height)/2);
  Text.wordWrap = true;

  BackButton  = new Sprite();
  BackButton.graphics.beginBitmapFill(new BackImage());
  BackButton.graphics.drawRect(0, 0, 125,48);
  BackButton.x = 515;
  BackButton.y = 370;
  BackButton.buttonMode = true;
  BackButton.addEventListener(MouseEvent.CLICK, onBackButtonClick);
  addChild(BackButton);



}

private function onBackButtonClick(event:MouseEvent) {
    Back();
}

  public function Back()
  {
  dispatchEvent(new InstructionPageEvent("Back"));
  }
}