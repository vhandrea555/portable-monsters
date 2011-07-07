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
import TimelineContainer;
import Constants;

class Logo extends TimelineContainer {
public var backgroundTimeline:Timeline;
public var textTimeline:Timeline;
public var TotalFrames:Int;
  public function new()
  {
  TotalFrames = 200;
  backgroundTimeline = new Timeline(0,TotalFrames,1);
  textTimeline = new Timeline(25,190,2);

  var inBackground:BitmapData = new Background();
  backgroundTimeline.graphics.beginFill(0x000000,1);
  backgroundTimeline.graphics.drawRect(0, 0, Constants.flashWidth,Constants.flashHeight);
  backgroundTimeline.x = 0; backgroundTimeline.y = 0;

  var text = new TextField();
  text.htmlText= "<font color='#FFFFFF' size='24'>"+"ZeroCreativity1"+"</font>";
  text.x = 230; text.y = 200;
  text.width = Constants.flashWidth-text.x;
  textTimeline.addChild(text);


    super(backgroundTimeline,TotalFrames);
    add(textTimeline);
    start();

  }
      public override function actions()
      { 
        if(frame < 25)
          {textTimeline.alpha = 0;}
        if(frame >= 25 && frame <= 50)
          {textTimeline.alpha += 0.04;}
        if(frame > 50 && frame < 165)
          {textTimeline.alpha = 1;}
        if(frame >= 165 && frame <=190)
          {textTimeline.alpha -= 0.04;}
          
      }
  
 }

