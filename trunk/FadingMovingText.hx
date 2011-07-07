
import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;

class FadingMovingText extends TextField {
public var Direction:String;
  public function new()
  {
    super();
    Direction = "UP";
    selectable = false;
    mouseEnabled = false;
autoSize = TextFieldAutoSize.RIGHT;
    //autoSize = TextFieldAutoSize.LEFT;
    alpha = 1;
  }
  public function start()
  {
    flash.Lib.current.addChild(this);
   this.addEventListener(Event.ENTER_FRAME, fadeOut);
  }

function fadeOut(e:Event){
	alpha -= 0.02;
	var speed = 3.5;
	if(Direction == "UP")
	{
	  y = y-speed;
	}
	else
	{
	  y = y+speed;
	}
        if(alpha < 0)
          {flash.Lib.current.removeChild(this);}
  }
}