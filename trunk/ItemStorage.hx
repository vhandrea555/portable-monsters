

class ItemStorage
{
  public var LocationX:Int;
  public var LocationY:Int;
  public var ID:String;
  public var Removed:Bool;
  public function new()
  {
    LocationX = Std.int(inLocation.x);
    LocationY = Std.int(inLocation.y);
    ID = inID;
  }
}