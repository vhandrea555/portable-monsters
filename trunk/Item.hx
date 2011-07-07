import flash.geom.Point;

class Item
{
  public var LocationX:Int;
  public var LocationY:Int;
  public var ID:String;
  public var Removed:Bool;
  public function new()
  {
  }
  public function updateItem(inLocation:Point,inID:String)
  {
    LocationX = Std.int(inLocation.x);
    LocationY = Std.int(inLocation.y);
    ID = inID;
  }

  public function getValue():Int
  {
      var value = 0;
      if(ID == "Potion")
      {
	value = 100;
      }
      if(ID == "Potion Group")
      {
	value = 300;
      }
      if(ID == "Potion+")
      {
	value = 500;
      }
      if(ID == "Potion+ Group")
      {
	value = 1500;
      }
      if(ID == "Full Heal")
      {
	value = 1500;
      }
      if(ID == "Full Heal Group")
      {
	value = 4500;
      }
      if(ID == "Full Restore")
      {
	value = 2000;
      }
      if(ID == "Full Restore Group")
      {
	value = 6000;
      }
      if(ID == "MP Restore")
      {
	value = 500;
      }
      if(ID == "MP Restore Group")
      {
	value = 1500;
      }
      if(ID == "MP Full Restore")
      {
	value = 1000;
      }
      if(ID == "MP Full Restore Group")
      {
	value = 3000;
      }
      if(ID == "Capture Device")
      {
	value = 10;
      }
      return value;
  }
  public function useInTrainerBattle():Bool
  {
    var retVal = true;
    if(ID == "Capture Device")
    {
      retVal = false;
    }
    return retVal;
  }
  public function useOnMonster():Bool
  {
    var retVal = true;
    if(ID == "Capture Device" || ID == "Potion Group" || ID == "Potion+ Group"
       || ID == "Full Heal Group" || ID == "Full Restore Group" || ID == "MP Full Restore Group"
       || ID == "MP Restore Group") 
    {
      retVal = false;
    }
    return retVal;
  }
  public function useOnMonsterMove():Bool
  {
    var retVal = false;
    return retVal;
  }
  public function useInBattle():Bool
  {
    var retVal = true;
    return retVal;
  }
  public function useOutsideBattle():Bool
  {
    var retVal = true;
    if(ID == "Capture Device")
    {
      retVal = false;
    }
    return retVal;
  }
  
}