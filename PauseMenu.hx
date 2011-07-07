import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import Images;
import MnstrWikiMenu;
import MonsterMenu;
import ItemMenu;
import Kongregate;

class PauseMenuEvent extends Event{
 
	public function new(customEventString:String){
	super(customEventString, true, false);

    }
}

class PauseMenu extends Sprite
{
public var CurrentMenu:String;
public var currentTrainer:Trainer;
//mandatory
private var MnstrWiki:Sprite;
public var PauseMnstrWikMenu:MnstrWikiMenu;
private var Monsters:Sprite;
public var PauseMonstersMenu:MonsterMenu;
private var ItemPic:Sprite;
private var PauseItemMenu:ItemMenu;
private var Save:Sprite;
private var Quit:Sprite;
private var StatusPic:Sprite;
private var PauseStatusMenu:StatusMenu;

//optional
private var SendMoneyPic:Sprite;
private var PauseSendMoney:SendMoney;
//private var


private var VolumeButton:Sprite;
private var PrevButton:Sprite;
private var NextButton:Sprite;
private var SoundEffectsButton:Sprite;
private var Text:TextField;
private var currentPlot:Plot;
private var kongVar:CKongregate;
// public var volume:Bool;
// public var sound:Bool;

  public function new(inTrainer:Trainer,inPlot:Plot,inKongVar:CKongregate)
  {
    super();
    //Resize Image
    currentTrainer = inTrainer;
    currentPlot = inPlot;
    kongVar = inKongVar;

    var background = new Sprite();
    background.graphics.lineStyle(1);
    background.graphics.beginFill(0xFFFFFF);
    background.graphics.drawRect(0, 0,150,Constants.flashHeight);
    background.graphics.endFill();
    background.x = 640-150; background.y = 0;
    //End Resize
    addChild(background);

  CurrentMenu = "";

  Text = new TextField();

  PauseMnstrWikMenu = new MnstrWikiMenu();

  PauseMnstrWikMenu.addEventListener("Back",onBack);

  MnstrWiki = new Sprite();
  MnstrWiki.graphics.lineStyle(1);
  MnstrWiki.graphics.beginFill(0xFFFFFF);
  MnstrWiki.graphics.drawRect(0, 0,140,50);
  MnstrWiki.graphics.endFill();  
  MnstrWiki.x = 5; MnstrWiki.y = 55;
  MnstrWiki.buttonMode = true;

  var MnstrWikiText = new TextField();
  MnstrWikiText.htmlText = "<font size ='20'>Monster Wiki</font>";
  MnstrWikiText.x = 10;
  MnstrWikiText.y = 10;
  MnstrWikiText.width = 120;
  MnstrWikiText.height = 40;
  MnstrWikiText.wordWrap = true;
  MnstrWikiText.selectable = false;
  MnstrWikiText.mouseEnabled = false;
  MnstrWiki.addChild(MnstrWikiText);
  MnstrWiki.addEventListener(MouseEvent.CLICK, onMnstrWikiClicked);


  PauseMonstersMenu = new MonsterMenu(currentTrainer);

  Monsters = new Sprite();
  Monsters.graphics.lineStyle(1);
  Monsters.graphics.beginFill(0xFFFFFF);
  Monsters.graphics.drawRect(0, 0,140,50);
  Monsters.graphics.endFill();  
  Monsters.x = 5; Monsters.y = 110;
  Monsters.buttonMode = true;
  PauseMonstersMenu.addEventListener("Back",onBack);

  var MonstersText = new TextField();
  MonstersText.htmlText = "<font size ='20'>Monsters</font>";
  MonstersText.x = 10;
  MonstersText.y = 10;
  MonstersText.width = 120;
  MonstersText.height = 40;
  MonstersText.wordWrap = true;
  MonstersText.selectable = false;
  MonstersText.mouseEnabled = false;
  Monsters.addChild(MonstersText);
  Monsters.addEventListener(MouseEvent.CLICK, onMonstersClicked);


  PauseItemMenu = new ItemMenu(currentTrainer);

  PauseItemMenu.addEventListener("Back",onBack);

  ItemPic = new Sprite();
  ItemPic.graphics.lineStyle(1);
  ItemPic.graphics.beginFill(0xFFFFFF);
  ItemPic.graphics.drawRect(0, 0,140,50);
  ItemPic.graphics.endFill();  
  ItemPic.x = 5; ItemPic.y = 165;
  ItemPic.height = 45;
  ItemPic.buttonMode = true;

  var ItemText = new TextField();
  ItemText.htmlText = "<font size ='20'>Item</font>";
  ItemText.x = 10;
  ItemText.y = 10;
  ItemText.width = 120;
  ItemText.height = 40;
  ItemText.wordWrap = true;
  ItemText.selectable = false;
  ItemText.mouseEnabled = false;
  ItemPic.addChild(ItemText);
  ItemPic.addEventListener(MouseEvent.CLICK, onItemClicked);


PauseStatusMenu = new StatusMenu(currentTrainer,currentPlot);

  PauseStatusMenu.addEventListener("Back",onBack);

  StatusPic = new Sprite();
  StatusPic.graphics.lineStyle(1);
  StatusPic.graphics.beginFill(0xFFFFFF);
  StatusPic.graphics.drawRect(0, 0,140,50);
  StatusPic.graphics.endFill();  
  StatusPic.x = 5; StatusPic.y = 215;
  StatusPic.height = 45;
  StatusPic.buttonMode = true;

  var StatusText = new TextField();
  StatusText.htmlText = "<font size ='20'>Status</font>";
  StatusText.x = 10;
  StatusText.y = 10;
  StatusText.width = 120;
  StatusText.height = 40;
  StatusText.wordWrap = true;
  StatusText.selectable = false;
  StatusText.mouseEnabled = false;
  StatusPic.addChild(StatusText);
  StatusPic.addEventListener(MouseEvent.CLICK, onStatusClicked);


PauseSendMoney = new SendMoney(currentTrainer);

  PauseSendMoney.addEventListener("Back",onBack);

  SendMoneyPic = new Sprite();
  SendMoneyPic.graphics.lineStyle(1);
  SendMoneyPic.graphics.beginFill(0xFFFFFF);
  SendMoneyPic.graphics.drawRect(0, 0,140,50);
  SendMoneyPic.graphics.endFill();  
  SendMoneyPic.x = 5; SendMoneyPic.y = 315;
  SendMoneyPic.height = 45;
  SendMoneyPic.buttonMode = true;

  var SendMoneyText = new TextField();
  SendMoneyText.htmlText = "<font size ='20'>Send Money</font>";
  SendMoneyText.x = 10;
  SendMoneyText.y = 10;
  SendMoneyText.width = 120;
  SendMoneyText.height = 40;
  SendMoneyText.wordWrap = true;
  SendMoneyText.selectable = false;
  SendMoneyText.mouseEnabled = false;
  SendMoneyPic.addChild(SendMoneyText);
  SendMoneyPic.addEventListener(MouseEvent.CLICK, onSendMoneyClicked);

  Save = new Sprite();
  Save.graphics.lineStyle(1);
  Save.graphics.beginFill(0xFFFFFF);
  Save.graphics.drawRect(0, 0,140,50);
  Save.graphics.endFill();  
  Save.x = 5; Save.y = 265;
  Save.height = 45;
  Save.buttonMode = true;

  var SaveText = new TextField();
  SaveText.htmlText = "<font size ='20'>Save</font>";
  SaveText.x = 10;
  SaveText.y = 10;
  SaveText.width = 120;
  SaveText.height = 40;
  SaveText.wordWrap = true;
  SaveText.selectable = false;
  SaveText.mouseEnabled = false;
  Save.addChild(SaveText);
  Save.addEventListener(MouseEvent.CLICK, onSaveClicked);

  Quit = new Sprite();
  Quit.graphics.lineStyle(1);
  Quit.graphics.beginFill(0xFFFFFF);
  Quit.graphics.drawRect(0, 0,140,50);
  Quit.graphics.endFill();  
  Quit.x = 5; Quit.y = 365;
  Quit.height = 45;
  Quit.buttonMode = true;

  var QuitText = new TextField();
  QuitText.htmlText = "<font size ='20'>Quit</font>";
  QuitText.x = 10;
  QuitText.y = 10;
  QuitText.width = 120;
  QuitText.height = 40;
  QuitText.wordWrap = true;
  QuitText.selectable = false;
  QuitText.mouseEnabled = false;
  Quit.addChild(QuitText);
  Quit.addEventListener(MouseEvent.CLICK, onQuitButtonClick);

  Text.x = 640-150; Text.y = 0;
  Text.width = 150; Text.height = 55;
  addChild(Text);
  Text.multiline = true;
  Text.wordWrap = true;
  Text.selectable = false;
  var myFormat:TextFormat = new TextFormat();
  myFormat.size = 16;
  myFormat.align = TextFormatAlign.CENTER;
  Text.defaultTextFormat = myFormat;


  background.addChild(MnstrWiki);
  background.addChild(Monsters);
  background.addChild(ItemPic);
  background.addChild(StatusPic);  
  background.addChild(SendMoneyPic);
  background.addChild(Save);
  background.addChild(Quit);
  
  Text.htmlText = "Pause Menu\n(Press P to UnPause)";

  PrevButton  = new Sprite();
  PrevButton.graphics.beginBitmapFill(new Prev());
  PrevButton.graphics.drawRect(0, 0, 60 ,113);
  PrevButton.x = 195;
  PrevButton.y = 70;
  PrevButton.buttonMode = true;
  PrevButton.addEventListener(MouseEvent.CLICK, onPrevButtonClick);
  //addChild(PrevButton);

  VolumeButton  = new Sprite();
  VolumeButton.graphics.beginBitmapFill(new Volume());
  VolumeButton.graphics.drawRect(0, 0, 113 ,113);
  VolumeButton.x = 270;
  VolumeButton.y = 70;
  VolumeButton.buttonMode = true;
  VolumeButton.addEventListener(MouseEvent.CLICK, onVolumeButtonClick);
  //addChild(VolumeButton);

  NextButton  = new Sprite();
  NextButton.graphics.beginBitmapFill(new Next());
  NextButton.graphics.drawRect(0, 0, 60 ,113);
  NextButton.x = 385;
  NextButton.y = 70;
  NextButton.buttonMode = true;
  NextButton.addEventListener(MouseEvent.CLICK, onNextButtonClick);
  //addChild(NextButton);

  var QuitButton  = new Sprite();
  QuitButton.graphics.lineStyle(1);
  QuitButton.graphics.beginFill(0x0000000);
  QuitButton.graphics.drawCircle(45, 45,48);
  QuitButton.graphics.endFill();
  QuitButton.x = 275;
  QuitButton.y = 190;
  QuitButton.buttonMode = true;
  var QuitText = new TextField();
  QuitText.htmlText = "<font color='#FFFFFF' size='32'>Quit</font>";
  QuitText.x = 13;QuitText.y = 20;
  QuitText.selectable = false;
  QuitButton.addChild(QuitText);
  QuitButton.addEventListener(MouseEvent.CLICK, onQuitButtonClick);
  //addChild(QuitButton);

  }

public function redraw(HasMonsterWiki:Bool)
{
  if(!currentPlot.HasMonsterWiki)
  {
    MnstrWiki.visible = false;
  }
  else
  {
    MnstrWiki.visible = true;
  }
  if(!currentPlot.HasTrainerBadge)
  {
    StatusPic.visible = false;
  }
  else
  {
    StatusPic.visible = true;
  }

  PauseMonstersMenu.redraw();
  PauseItemMenu.redraw();
  PauseStatusMenu.redraw();
//   PauseMnstrWikMenu.redraw();
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
private function removeCurrentMenu(){
  if(CurrentMenu == "Monsters")
  {
    removeChild(PauseMonstersMenu);
  }
  else if(CurrentMenu == "Item")
  {
    removeChild(PauseItemMenu);
  }
  else if(CurrentMenu == "MnstrWiki")
  {
    removeChild(PauseMnstrWikMenu);
  }
  else if(CurrentMenu == "Status")
  {
    removeChild(PauseStatusMenu);
  }
  else if(CurrentMenu == "SendMoney")
  {
    removeChild(PauseSendMoney);
    try
    {
    kongVar.SubmitStat("MoneySentHome", currentTrainer.MoneySentHome);
    }
    catch(e:Dynamic)
    {}
  }
  CurrentMenu = "";
}
private function onBack(event:Event) {
  removeCurrentMenu();
  stage.focus = stage;
}
private function onMonstersClicked(event:MouseEvent) {
  removeCurrentMenu();
  PauseMonstersMenu.redraw();
  addChild(PauseMonstersMenu);
  CurrentMenu = "Monsters";
}
private function onItemClicked(event:MouseEvent) {
  removeCurrentMenu();
  addChild(PauseItemMenu);
  CurrentMenu = "Item";
}
private function onMnstrWikiClicked(event:MouseEvent)  {
  removeCurrentMenu();
  addChild(PauseMnstrWikMenu);
  CurrentMenu = "MnstrWiki";
}
private function onStatusClicked(event:MouseEvent) {
  removeCurrentMenu();
  addChild(PauseStatusMenu);
  CurrentMenu = "Status";
}
private function onSendMoneyClicked(event:MouseEvent) {
  removeCurrentMenu();
  addChild(PauseSendMoney);
  CurrentMenu = "SendMoney";

}
private function onSaveClicked(event:MouseEvent) {
  dispatchEvent(new PauseMenuEvent("Save"));
}

private function onQuitButtonClick(event:MouseEvent)  {
  dispatchEvent(new PauseMenuEvent("Quit"));
}

private function onVolumeButtonClick(event:MouseEvent)  {
  dispatchEvent(new PauseMenuEvent("VolumeToggle"));
}

private function onPrevButtonClick(event:MouseEvent)  {
  dispatchEvent(new PauseMenuEvent("PrevTrack"));
}

private function onNextButtonClick(event:MouseEvent)  {
  dispatchEvent(new PauseMenuEvent("NextTrack"));
}
}