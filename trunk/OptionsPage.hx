import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;

import Images;
class OptionsPageEvent extends Event{
 
	public function new(customEventString:String){

	super(customEventString, true, false);

    }
}

class OptionsPage extends Sprite
{
private var BackButton:Sprite;
private var ResetSavedDataButton:Sprite;
private var VolumeButton:Sprite;
private var PrevButton:Sprite;
private var NextButton:Sprite;
private var SoundEffectsButton:Sprite;
private var CurrentBackground: Bitmap;
private var Text:TextField;
private var Cleared:TextField;
// public var volume:Bool;
// public var sound:Bool;

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
    
  Text.x = 275; Text.y = 40;
  Text.width = 540; Text.height = 420;
  addChild(Text);
  Text.multiline = true;
  var myFormat:TextFormat = new TextFormat();
  myFormat.size = 22;
  //myFormat.align = TextFormatAlign.CENTER;
  Text.defaultTextFormat = myFormat;
  
  Text.htmlText = "Options";

  Cleared = new TextField();
    
  Cleared.x = 455; Cleared.y = 115;
  Cleared.width =100; Cleared.height = 420;
  addChild(Cleared);
  Cleared.multiline = true;
  var myFormat:TextFormat = new TextFormat();
  myFormat.size = 15;
  //myFormat.align = TextFormatAlign.CENTER;
  Cleared.defaultTextFormat = myFormat;
  
  Cleared.htmlText = "";

  ResetSavedDataButton  = new Sprite();
  ResetSavedDataButton.graphics.beginBitmapFill(new ResetSavedData());
  ResetSavedDataButton.graphics.drawRect(0, 0, 250 ,48);
  ResetSavedDataButton.x = 195;
  ResetSavedDataButton.y = 100;
  ResetSavedDataButton.buttonMode = true;
  ResetSavedDataButton.addEventListener(MouseEvent.CLICK, onResetSavedDataButtonClick);
  addChild(ResetSavedDataButton);


  PrevButton  = new Sprite();
  PrevButton.graphics.beginBitmapFill(new Prev());
  PrevButton.graphics.drawRect(0, 0, 60 ,113);
  PrevButton.x = 195;
  PrevButton.y = 150;
  PrevButton.buttonMode = true;
  PrevButton.addEventListener(MouseEvent.CLICK, onPrevButtonClick);
  //addChild(PrevButton);

  VolumeButton  = new Sprite();
  VolumeButton.graphics.beginBitmapFill(new Volume());
  VolumeButton.graphics.drawRect(0, 0, 113 ,113);
  VolumeButton.x = 270;
  VolumeButton.y = 150;
  VolumeButton.buttonMode = true;
  VolumeButton.addEventListener(MouseEvent.CLICK, onVolumeButtonClick);
  //addChild(VolumeButton);

  NextButton  = new Sprite();
  NextButton.graphics.beginBitmapFill(new Next());
  NextButton.graphics.drawRect(0, 0, 60 ,113);
  NextButton.x = 385;
  NextButton.y = 150;
  NextButton.buttonMode = true;
  NextButton.addEventListener(MouseEvent.CLICK, onNextButtonClick);
  //addChild(NextButton);

  SoundEffectsButton  = new Sprite();
  SoundEffectsButton.graphics.beginBitmapFill(new SoundEffects());
  SoundEffectsButton.graphics.drawRect(1, 1, 98,62);
  SoundEffectsButton.x = 315;
  SoundEffectsButton.y = 160;
  SoundEffectsButton.buttonMode = true;
  SoundEffectsButton.addEventListener(MouseEvent.CLICK, onSoundEffectsButtonClick);
  //addChild(SoundEffectsButton);

  BackButton  = new Sprite();
  BackButton.graphics.beginBitmapFill(new BackImage());
  BackButton.graphics.drawRect(0, 0, 125 ,48);
  BackButton.x = Constants.flashWidth-140;
  BackButton.y = Constants.flashHeight-60;
  BackButton.buttonMode = true;
  BackButton.addEventListener(MouseEvent.CLICK, onBackButtonClick);
  addChild(BackButton);
  }
public function renderSoundEffects(sound:Bool)
{
  if(sound)
  {
  SoundEffectsButton.graphics.clear();
  SoundEffectsButton.graphics.beginBitmapFill(new SoundEffects());
  SoundEffectsButton.graphics.drawRect(1, 1, 98 ,61);
  }
  else
  {
  SoundEffectsButton.graphics.clear();
  SoundEffectsButton.graphics.beginBitmapFill(new SoundEffectsMuted());
  SoundEffectsButton.graphics.drawRect(1, 1, 98 ,61);
  }

}
public function renderVolume(volume:Bool)
{
  if(volume)
  {
  VolumeButton.graphics.clear();
  VolumeButton.graphics.beginBitmapFill(new Volume());
  VolumeButton.graphics.drawRect(0, 0, 113 ,113);
  }
  else
  {
  VolumeButton.graphics.clear();
  VolumeButton.graphics.beginBitmapFill(new VolumeMuted());
  VolumeButton.graphics.drawRect(0, 0, 113 ,113);
  }

}
private function onBackButtonClick(event:MouseEvent) {
    Back();
}

private function onSoundEffectsButtonClick(event:MouseEvent)  {
  dispatchEvent(new OptionsPageEvent("SoundEffectsToggle"));
}

private function onPrevButtonClick(event:MouseEvent)  {
  dispatchEvent(new OptionsPageEvent("PrevTrack"));
}

private function onNextButtonClick(event:MouseEvent)  {
  dispatchEvent(new OptionsPageEvent("NextTrack"));
}
private function onVolumeButtonClick(event:MouseEvent)  {
  dispatchEvent(new OptionsPageEvent("VolumeToggle"));
}
private function onResetSavedDataButtonClick(event:MouseEvent) {
   dispatchEvent(new OptionsPageEvent("ResetSavedData"));
   Cleared.htmlText = "Cleared";
}
  public function Back()
  {
  dispatchEvent(new OptionsPageEvent("Back"));
  }
}