import flash.geom.Point;

class Plot
{
  public var State:String;
  public var HasMonsterWiki:Bool;
  public var HasTrainerBadge:Bool;
  public var BridgeOpen:Bool;
  public var BridgeBroken:Bool;
  public var JoyBadge:Bool;
  public var AngerBadge:Bool;
  public var ConfusionBadge:Bool;
  public var BlankBadge:Bool;
  public var VisitedLake:Bool;
  public var TristanHome:Bool;
  public function new()
  {
    State = "Visit Grave";
    HasTrainerBadge = false;
    HasMonsterWiki = false;
    BridgeOpen=false;
    BridgeBroken = false;
    //JoyBadge = false;
    JoyBadge = false;
    AngerBadge = false;
    ConfusionBadge = false;
    BlankBadge = false;
    TristanHome = false;
  }
  
}