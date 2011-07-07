import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;

import flash.events.Event;

import flash.geom.Matrix;

class HelperMethods extends Sprite{
private static var fade:Float = 0.0;
private static var square :Sprite = new Sprite();
public function FadeToBlack()
{
   this.addEventListener(Event.ENTER_FRAME, drawFadeToBlack);
}
public function drawFadeToBlack(e:Event){
      fade += 0.01;
      square.graphics.beginFill(0x000000,fade);
      square.graphics.drawRect(0,0,640,426);
      square.graphics.endFill();
      square.x = 0;
      square.y = 0;
      if(fade >1){
          this.removeEventListener(Event.ENTER_FRAME, drawFadeToBlack);
      }
}
  public static function resize(newWidth:Int, newHeight:Int, inBitmapData:BitmapData):BitmapData
  {
  //var resizedImage:Sprite = this.clone();
  var scaledWidth:Float = (newWidth/inBitmapData.width);
  var scaledHeight:Float = (newHeight/inBitmapData.height);

  var matrix:Matrix = new Matrix();
  matrix.scale(scaledWidth, scaledHeight);

  newWidth = Std.int(inBitmapData.width * scaledWidth);
  newHeight = Std.int(inBitmapData.height * scaledHeight);
  
  var smallBMD:BitmapData = new BitmapData(newWidth, newHeight,true, 0x000000);
 
  smallBMD.draw(inBitmapData, matrix, null, null, null, true);
  return smallBMD;
  }
// public static function format(number:Int,precision:Int,
//  ?decimalDelimiter:String = ".", ?commaDelimiter:String=",",
//  ?prefix:String ="",?suffix:String=""):String
//   {
//     var decimalMultiplier:Int = Std.int(Math.pow(10,precision));
//     var str:String = Std.string(Math.round(number*decimalMultiplier));
// 
//     var leftSide:String; 
//     var rightSide:String;
// if(precision <= 0)
// {
// leftSide = str;
// rightSide = "";
// decimalDelimiter = "";
// }
// else
// {
// leftSide = str.substr(0,-precision);
// rightSide = str.substr(-precision);
// }
// 
//     
// 
//     var newLeftSide:String = "";
//     for(i in 0...leftSide.length)
//     {
//       if(i > 0 && (i % 3 == 0))
//       {
// 	newLeftSide = commaDelimiter + newLeftSide;
//       }
//       newLeftSide = leftSide.substr(-i - 1,1) + newLeftSide;
//     }
// 
//     return prefix + newLeftSide + decimalDelimiter + rightSide + suffix;
// 
//   } 

public static function format(number:Float,precision:Int,
 ?decimalDelimiter:String = ".", ?commaDelimiter:String=",",
 ?prefix:String ="",?suffix:String=""):String
  {
    var decimalMultiplier:Int = Std.int(Math.pow(10,precision));
    var negative = number < 0;
    if(negative){prefix = "-" + prefix;}
    var str:String = Std.string(Math.abs(Math.round(number*decimalMultiplier)));
    
    var leftSide:String; 
    var rightSide:String;
if(precision <= 0)
{
leftSide = str;
rightSide = "";
decimalDelimiter = "";
}
else
{
leftSide = str.substr(0,-precision);
rightSide = str.substr(-precision);
var zeros = precision -rightSide.length;
for(i in 0...zeros)
  {rightSide = "0" + rightSide;}
}

    

    var newLeftSide:String = "";
    for(i in 0...leftSide.length)
    {
      if(i > 0 && (i % 3 == 0))
      {
	newLeftSide = commaDelimiter + newLeftSide;
      }
      newLeftSide = leftSide.substr(-i - 1,1) + newLeftSide;
    }
  
    return prefix + newLeftSide + decimalDelimiter + rightSide + suffix;

  } 


}