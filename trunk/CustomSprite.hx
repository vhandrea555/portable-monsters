import flash.display.Sprite;
import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;

class CustomSprite extends Sprite{
public var isFading: Bool; 
public var isFadingBlack: Bool;
private var blackSquare : Sprite;
  public function new()
  {
  super();
  isFading = false;
  isFadingBlack = false;
  blackSquare = new Sprite();
  blackSquare.graphics.beginFill(0x000000,1);
  blackSquare.graphics.drawRect(0,0,width,height);
  blackSquare.graphics.endFill();
  blackSquare.x = 0;
  blackSquare.y = 0;
  blackSquare.alpha = 0;
  addChild(blackSquare);
  }

  public function resize(newWidth:Int , newHeight:Int)
  {
  //var resizedImage:Sprite = this.clone();
  var scaledWidth:Float = (newWidth/width);
  var scaledHeight:Float = (newHeight/height);

  var matrix:Matrix = new Matrix();
  matrix.scale(scaledWidth, scaledHeight);

  newWidth = Std.int(width * scaledWidth);
  newHeight = Std.int(height * scaledHeight);
  
  var smallBMD:BitmapData = new BitmapData(newWidth, newHeight,true, 0x000000);
 
  smallBMD.draw(this, matrix, null, null, null, true);
  this.graphics.clear();
  this.graphics.beginBitmapFill(smallBMD);
  this.graphics.drawRect(0, 0, newWidth, newHeight);
  
  }
  public function fade()
  {
   if(!isFading)
   {
   this.addEventListener(Event.ENTER_FRAME, fadeOut);
   isFading = true;
   }
  }
  public function resetFade()
  {   
  alpha = 1;
  }
  public function resetFadeToBlack()
  {
  removeChild(blackSquare);
  blackSquare.graphics.beginFill(0x000000,1);
  blackSquare.graphics.drawRect(0,0,width,height);
  blackSquare.graphics.endFill();
  blackSquare.alpha = 0;
  addChild(blackSquare);
  }

function fadeOut(e:Event){
	alpha -= 0.05;
        if(alpha < 0){
           isFading = false;
	   removeEventListener(Event.ENTER_FRAME,fadeOut);
       }
  }
  public function fadeToBlack()
  {
   if(!isFadingBlack)
   {
    this.addEventListener(Event.ENTER_FRAME, fadeOutBlack);
    isFadingBlack = true;
    resetFadeToBlack();
   }
  }

function fadeOutBlack(e:Event){
	blackSquare.alpha += 0.05;
        if(blackSquare.alpha > 1){
           isFadingBlack = false;
	   removeEventListener(Event.ENTER_FRAME,fadeOutBlack);
       }
        
  }

}