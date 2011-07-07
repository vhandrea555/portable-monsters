import haxe.FastList;
import haxe.remoting.AMFConnection;
import flash.geom.Point;


class MonsterList extends List<Monster>
{
    public function new()
    {
    haxe.remoting.AMFConnection.registerClassAlias("MonsterAlias",Monster); 
    super();
    }
}

class EnemyTrainerDataList extends List<EnemyTrainerData>
{
    public function new()
    {
    haxe.remoting.AMFConnection.registerClassAlias("EnemyTrainerDataAlias",EnemyTrainerData); 
    super();
    }
}

class CharactersDataList extends List<CharactersData>
{
    public function new()
    {
    haxe.remoting.AMFConnection.registerClassAlias("CharactersDataAlias",CharactersData); 
    super();
    }
}
class BuildingDataList extends List<BuildingData>
{
    public function new()
    {
    haxe.remoting.AMFConnection.registerClassAlias("BuildingDataAlias",BuildingData); 
    super();
    }
}
class ItemLocationList extends List<Item>
{
    public function new()
    {
    //haxe.remoting.AMFConnection.registerClassAlias("ItemAlias",Item); 
    super();
    }
}
class ItemList extends List<Item>
{
    public function new()
    {
    haxe.remoting.AMFConnection.registerClassAlias("ItemAlias",Item); 
    super();
    }
  public function buyItem(inID:String,count:Int,currentTrainer:Trainer)
  {
    var itemInfo = new Item();
    itemInfo.updateItem(new Point(),inID);
    var cost = Std.int(itemInfo.getValue());
    var numItem = 0;
    for(item in 0...count)
    {
      var newItem = new Item();
      newItem.updateItem(new Point(),inID);
      this.add(newItem);
    }
    currentTrainer.Money -= cost * count;
  }

  public function sellItem(inID:String,count:Int,currentTrainer:Trainer)
  {
    var cost = Std.int((getItemByName(inID).getValue())/2);
    var numItem = 0;
    for(item in this)
    {
      if(item.ID == inID)
	{
	  numItem++;
	  this.remove(item);
	  if(numItem >= count)
	    {
	      break;
	    }
	}
    }
    currentTrainer.Money += cost * count;
  }
  public function useItem(inID:String,monster:Monster,currentTrainer:Trainer,opponentMonster:Monster):AttackText
  {
      var battleInfo = new AttackText();
      var count = getItemsByName(inID);
      if(count <= 0)
	{return battleInfo;}
      if(inID == "Capture Device")
      {
	if(opponentMonster == null)
	  {return battleInfo;}
	var chance = 100-Std.int((opponentMonster.Health/opponentMonster.MaxHealth)*100);
	if(Std.random(100) <= chance)
	{
	  battleInfo.OpponentText = inID + ": Captured";
	  currentTrainer.addNewMonster(opponentMonster);
	  opponentMonster.Captured = true;
	}
	else
	{
	  battleInfo.OpponentText = inID + ": Failed At "+ chance+"%";
	}
      }
      else if(inID == "Potion")
      {
	monster.Health += 100;
      }
      else if(inID == "Potion Group")
      {
	for(monster in currentTrainer.Monsters)
	{
	  monster.Health += 100;
	}
      }
      else if(inID == "Potion+")
      {
	monster.Health += 500;
      }
      else if(inID == "Potion+ Group")
      {
	for(monster in currentTrainer.Monsters)
	{
	  monster.Health += 500;
	}
      }
      else if(inID == "Full Heal")
      {
	monster.Health = monster.MaxHealth;
      }
      else if(inID == "Full Heal Group")
      {
	for(monster in currentTrainer.Monsters)
	{
	  monster.Health = monster.MaxHealth;
	}
      }
      else if(inID == "MP Restore")
      {
      
	  for(move in monster.Moves)
	  {
	      move.MP = Std.int(Math.min(move.MP+ 5, move.TotalMP));
	  }

      }
      else if(inID == "MP Restore Group")
      {
      
	for(monst in currentTrainer.Monsters)
	{
	  for(move in monst.Moves)
	  {
	      move.MP =  Std.int(Math.min(move.MP+ 5, move.TotalMP));
	  }
	}
      }
      else if(inID == "MP Full Restore")
      {
      
	  for(move in monster.Moves)
	  {
	      move.MP = move.TotalMP;
	  }

      }
      else if(inID == "MP Full Restore Group")
      {
      
	for(monst in currentTrainer.Monsters)
	{
	  for(move in monst.Moves)
	  {
	      move.MP = move.TotalMP;
	  }
	}

      }
      else if(inID == "Full Restore")
      {
	  monster.Health = monster.MaxHealth;
	  monster.Seeded = false;
	  monster.Burned = false;
	  monster.Poisoned = false;
	  for(move in monster.Moves)
	  {
	      move.MP = move.TotalMP;
	  }
      }
      else if(inID == "Full Restore Group")
      {
	for(monst in currentTrainer.Monsters)
	{
	  monst.Health = monst.MaxHealth;
	  monst.Seeded = false;
	  monst.Burned = false;
	  monst.Poisoned = false;
	  for(move in monst.Moves)
	  {
	      move.MP = move.TotalMP;
	  }
	}
      }
      else
      {
	return battleInfo;
      }

    var numItem = 0;
    for(item in this)
    {
      if(item.ID == inID)
	{
	  numItem++;
	  if(numItem == count)
	    {
	      this.remove(item);
	      break;
	    }
	}
    }
    return battleInfo;
  }
  public function getItemByName(inID):Item
  {
    var retVal:Item = null;
    for(item in this)
    {
      if(item.ID == inID)
	{retVal = item;}
    }
    return retVal;
  }
  public function getItemsByName(inID):Int
  {
    var count = 0;
    for(item in this)
    {
      if(item.ID == inID)
	{count++;}
    }
    return count;
  }
}

class MoveList extends List<Move>
{
    public function new()
    {
    haxe.remoting.AMFConnection.registerClassAlias("MoveAlias",Move); 
    super();
    }
}