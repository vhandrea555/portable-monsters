import flash.events.Event;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;

import Images;
class CutSceneEvent extends Event{
 
	public function new(customEventString:String){

	super(customEventString, true, false);

    }
}
class CutScene extends MovieClip{
  public var frame:Int;
  public var lastFrame:Int;
  public var playing:Bool;
  public function new(inLastFrame:Int)
  {
  super();
  lastFrame = inLastFrame;
  frame = 0;
  playing = false;
  this.addEventListener(Event.ENTER_FRAME, OnEnter);
  }

   function OnEnter(e:flash.events.Event)
   {
      if(playing)
      {
      frame++;
      if(frame >=lastFrame)
         { stop(); } 
      }
   
   }

	public override function play() {
		playing = true;
                frame = 1;
		super.play();
	}
	
	public override function stop() {
		playing = false;
		super.stop();
	}
 }

