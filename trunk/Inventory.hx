// import flash.geom.Point;
// import CustomList;
// class Inventory_Bak
// {
//   public function new()
//   {
// 
//     haxe.remoting.AMFConnection.registerClassAlias("InventoryAlias",Inventory);
//     haxe.remoting.AMFConnection.registerClassAlias("ItemAlias",Item);
//     haxe.remoting.AMFConnection.registerClassAlias("MonsterAlias",Monster);
//     haxe.remoting.AMFConnection.registerClassAlias("ItemListAlias",ItemList);
//     haxe.remoting.AMFConnection.registerClassAlias("TrainerAlias",Trainer);
//     haxe.remoting.AMFConnection.registerClassAlias("AttackTextAlias",AttackText);
//     super();
//   }	
// 
//   public function buyItem(inID:String,count:Int,currentTrainer:Trainer)
//   {
//     var cost = Std.int((new Item(new Point(),inID)).getValue());
//     var numItem = 0;
//     for(item in 0...count)
//     {
//       this.add(new Item(new Point(),inID));
//     }
//     currentTrainer.Money -= cost * count;
//   }
// 
//   public function sellItem(inID:String,count:Int,currentTrainer:Trainer)
//   {
//     var cost = Std.int((getItemByName(inID).getValue())/2);
//     var numItem = 0;
//     for(item in this)
//     {
//       if(item.ID == inID)
// 	{
// 	  numItem++;
// 	  this.remove(item);
// 	  if(numItem >= count)
// 	    {
// 	      break;
// 	    }
// 	}
//     }
//     currentTrainer.Money += cost * count;
//   }
//   public function useItem(inID:String,monster:Monster,currentTrainer:Trainer,opponentMonster:Monster):AttackText
//   {
//       var battleInfo = new AttackText();
//       var count = getItemsByName(inID);
//       if(count <= 0)
// 	{return battleInfo;}
//       if(inID == "Capture Device")
//       {
// 	if(opponentMonster == null)
// 	  {return battleInfo;}
// 	var chance = 100-Std.int((opponentMonster.Health/opponentMonster.MaxHealth)*100);
// 	if(Std.random(100) <= chance)
// 	{
// 	  battleInfo.OpponentText = inID + ": Captured";
// 	  currentTrainer.addNewMonster(opponentMonster);
// 	  opponentMonster.Captured = true;
// 	}
// 	else
// 	{
// 	  battleInfo.OpponentText = inID + ": Failed At "+ chance+"%";
// 	}
//       }
//       else if(inID == "Potion")
//       {
// 	monster.Health += 100;
//       }
//       else if(inID == "Potion Group")
//       {
// 	for(monster in currentTrainer.Monsters)
// 	{
// 	  monster.Health += 100;
// 	}
//       }
//       else if(inID == "Potion+")
//       {
// 	monster.Health += 500;
//       }
//       else if(inID == "Potion+ Group")
//       {
// 	for(monster in currentTrainer.Monsters)
// 	{
// 	  monster.Health += 500;
// 	}
//       }
//       else if(inID == "Full Heal")
//       {
// 	monster.Health = monster.MaxHealth;
//       }
//       else if(inID == "Full Heal Group")
//       {
// 	for(monster in currentTrainer.Monsters)
// 	{
// 	  monster.Health = monster.MaxHealth;
// 	}
//       }
//       else if(inID == "MP Restore")
//       {
//       
// 	  for(move in monster.Moves)
// 	  {
// 	      move.MP = Std.int(Math.min(move.MP+ 5, move.TotalMP));
// 	  }
// 
//       }
//       else if(inID == "MP Restore Group")
//       {
//       
// 	for(monst in currentTrainer.Monsters)
// 	{
// 	  for(move in monst.Moves)
// 	  {
// 	      move.MP =  Std.int(Math.min(move.MP+ 5, move.TotalMP));
// 	  }
// 	}
//       }
//       else if(inID == "MP Full Restore")
//       {
//       
// 	  for(move in monster.Moves)
// 	  {
// 	      move.MP = move.TotalMP;
// 	  }
// 
//       }
//       else if(inID == "MP Full Restore Group")
//       {
//       
// 	for(monst in currentTrainer.Monsters)
// 	{
// 	  for(move in monst.Moves)
// 	  {
// 	      move.MP = move.TotalMP;
// 	  }
// 	}
// 
//       }
//       else if(inID == "Full Restore")
//       {
// 	  monster.Health = monster.MaxHealth;
// 	  monster.Seeded = false;
// 	  monster.Burned = false;
// 	  monster.Poisioned = false;
// 	  for(move in monster.Moves)
// 	  {
// 	      move.MP = move.TotalMP;
// 	  }
//       }
//       else if(inID == "Full Restore Group")
//       {
// 	for(monst in currentTrainer.Monsters)
// 	{
// 	  monst.Health = monst.MaxHealth;
// 	  monst.Seeded = false;
// 	  monst.Burned = false;
// 	  monst.Poisioned = false;
// 	  for(move in monst.Moves)
// 	  {
// 	      move.MP = move.TotalMP;
// 	  }
// 	}
//       }
//       else
//       {
// 	return battleInfo;
//       }
// 
//     var numItem = 0;
//     for(item in this)
//     {
//       if(item.ID == inID)
// 	{
// 	  numItem++;
// 	  if(numItem == count)
// 	    {
// 	      this.remove(item);
// 	      break;
// 	    }
// 	}
//     }
//     return battleInfo;
//   }
//   public function getItemByName(inID):Item
//   {
//     var retVal:Item = null;
//     for(item in this)
//     {
//       if(item.ID == inID)
// 	{retVal = item;}
//     }
//     return retVal;
//   }
//   public function getItemsByName(inID):Int
//   {
//     var count = 0;
//     for(item in this)
//     {
//       if(item.ID == inID)
// 	{count++;}
//     }
//     return count;
//   }
// }