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
import Timeline;


class TimelineContainer extends CustomSprite {
  public var head:Timeline;
  public var frame:Int;
  public var lastFrame:Int;
  public var playing:Bool;
  public var changed:Bool;
  public function new(inHead:Timeline,inLastFrame:Int)
  {
  head = inHead;
  frame = 0;
  lastFrame = inLastFrame;
  playing = false;
  changed = true;
  super();
  }
  public function add(inTimeline:Timeline)
  {
  if(head == null)
     {head = inTimeline;return;}
  var temp:Timeline = head;
  InsertNextNode(head,inTimeline);
 }
  public function InsertNextNode(postion:Timeline,newNode:Timeline)
  {
     if(newNode.layer < postion.layer)
        {
	  if(postion.left == null)
	    {
	    postion.left = newNode;
            }
          else
            {
	    InsertNextNode(postion.left,newNode);
	    }
	}
     else
        {
	  if(postion.right == null)
	    {
	    postion.right = newNode;
            }
          else
            {
	    InsertNextNode(postion.right,newNode);
	    }
	}
  }

  public function detectChange(postion:Timeline)
  {
  if(postion.left != null){detectChange(postion.left);}
  if(postion.frameStart == frame)
     {changed = true; }
  if(postion.frameEnd == frame)
     {removeChild(postion);}
  if(postion.right != null){detectChange(postion.right);}
  }

  public function addFramesToScene(postion:Timeline)
  {
  if(postion.left != null){addFramesToScene(postion.left);}
  if(postion.frameStart <= frame && postion.frameEnd >= frame)
     {this.addChild(postion);}
  if(postion.right != null){addFramesToScene(postion.right);}
  }

  public function removeFramesFromScene()
  {
    while(numChildren > 0)
    { 
      removeChildAt(0);
    }
  }


       public function play():Bool
       {
	  if(frame > lastFrame)
             {playing = false;}
          else
             {playing = true;}
         //Add and remove sprites
          if(playing)
            {
	      detectChange(head);
              if(changed)
              {
	      removeFramesFromScene();
	      addFramesToScene(head);
              changed = false;
              }
              actions();
            }
          frame++; 
	  return playing;
       }

      public function actions()
      {
      
      }
	public function start() {
		playing = true;
                frame = 0;
	}
	
	public function stop() {
		playing = false;
	}
  
  
 }

