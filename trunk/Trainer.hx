import flash.geom.Point;

import CustomList;

class Trainer
{
  public var LastMonsterID:Int;
  public var Monsters:MonsterList;
  public var MonstersArchive:MonsterList;
  public var CurrentMonster:Monster;
  public var CurrentInventory:ItemList;
  public var AvatarTile:Int;
  public var Money:Int;
  public var MoneySentHome:Int;

  public function new()
  {
    haxe.remoting.AMFConnection.registerClassAlias("TrainerAlias",Trainer);
    haxe.remoting.AMFConnection.registerClassAlias("MonsterAlias",Monster); 
    haxe.remoting.AMFConnection.registerClassAlias("ItemAlias",Item); 
    haxe.remoting.AMFConnection.registerClassAlias("MoveAlias",  Move);

    haxe.remoting.AMFConnection.registerClassAlias("MonsterListAlias",MonsterList);
    haxe.remoting.AMFConnection.registerClassAlias("ItemListAlias",ItemList);
    haxe.remoting.AMFConnection.registerClassAlias("MoveListAlias",MoveList);

    LastMonsterID = 0;
    Monsters = new MonsterList();
    MonstersArchive = new MonsterList();
    CurrentInventory = new ItemList();
    Money = 0;
    MoneySentHome = 0;
  }

  public function addNewMonster(inMonster:Monster)
  {
    inMonster.ID = LastMonsterID;
    LastMonsterID++;
    var MonsterCount = 0;
    for(monsters in Monsters)
    {
      MonsterCount++;
    }
    if(MonsterCount  < 3)
    {
      Monsters.add(inMonster);  
    }
    else
    {
      MonstersArchive.add(inMonster);
    }
  }

}