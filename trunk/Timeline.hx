import flash.events.Event;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;

import Images;
import CutScene;
import CustomSprite;


class Timeline extends CustomSprite{
  public var frameStart:Int;
  public var frameEnd:Int;
  public var layer:Int;
  public var left:Timeline;
  public var right:Timeline;
  public function new(inFrameStart:Int,inFrameEnd:Int,inLayer:Int)
  {
  frameStart = inFrameStart;
  frameEnd = inFrameEnd;
  layer = inLayer;

  left = null; right = null;
  super();
  }
  
 }

