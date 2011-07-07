
import CustomList;

class Monster
{
  //
  public var ID:Int;
  public var Moves:MoveList;

  public var MaxHealth:Int;
  public var BaseHealth:Float;
  public var Level:Int;
  public var BaseAttack:Float;
  public var BaseDefense:Float;
  public var BaseSpeed:Float;
  public var BaseAccuracy:Float;
  public var Attack:Float;
  public var Defense:Float;
  public var Speed:Float;
  public var Accuracy:Float;
  public var Character:String;
  public var XP:Float;


  public var Seeded:Bool;
  public var Poisoned:Bool;
  public var Burned:Bool;
  public var Protect:Int;
  public var Encase:Int;
  public var Charged:Int;
  public var Captured:Bool;
  public var enemiesAttacked:List<Int>;

  private var _health:Int;  
  public var Health(getHealth,setHealth):Int;
  public function getHealth():Int
  {
    return _health;
  }
  public function setHealth(inHealth:Int):Int
  {
    inHealth = Std.int(Math.max(0,inHealth));
    inHealth = Std.int(Math.min(inHealth,MaxHealth));
    _health = inHealth;
    return _health;
  }
  
  public function clearEnemyMonster()
  {
    for(monsterID in enemiesAttacked)
    {
      enemiesAttacked.remove(monsterID);
    }
  }
  public function Fought(inMonsterID:Int):Bool
  {
    var found = false;
    for(monsterID in enemiesAttacked)
    {
      if(monsterID ==  inMonsterID)
      {
	found = true;
	break;
      }
    }
    return found;
  }
  public function addEnemyAttacked(inMonsterID:Int)
  {
    var found = false;
    for(monsterID in enemiesAttacked)
    {
      if(monsterID ==  inMonsterID)
      {
	found = true;
	break;
      }
    }
    if(!found)
    {
      enemiesAttacked.add(inMonsterID);
    }
  }

  public function new()
  {

      enemiesAttacked = new List<Int>();
      Moves = new MoveList();
      var attack = new Move();
      attack.Name = "Attack";	
      attack.MP = 25;
      attack.TotalMP = -1;
      Moves.add(attack);
      
      BaseAttack = 5; 
      BaseDefense = 5;
      BaseSpeed = 5;
      BaseAccuracy = 5;
      BaseHealth = 5;
      
      Seeded = false;
      Poisoned = false;
      Burned = false;
      Encase = 0;
      Protect = 0;
      Charged = 0;

      Attack = 5;
      Defense = 3;
      Accuracy = 5;
      Speed = 5;
      MaxHealth = 15;
      Health = 15;
      Level = 1;
      XP = 0;

      Character = "Fairy";

      Captured = false;
  }

  public function getMonsterType():String
  {
    //Duck
    //Sheep
    //Turtle
    //Unicorn
    //Liger
    //Baby Elephant
    var MonsterType = "";
    if(Character == "Fairy")
    {
      MonsterType = "Water";
    }
    if(Character == "Flower" ||
       Character == "Vine Cat" ||
       Character == "Leaf Sheep")
    {
      MonsterType = "Plant";
    }
    if(Character == "Electric Zebra" ||
      Character == "Jelly Fish" ||
      Character == "Lightning Cat" ||
      Character == "Electric Eel" )
    {
      MonsterType = "Electric";
    }
    if(Character == "Water Jay" ||
      Character == "Water Rabbit" ||
      Character == "Tsunami Cat" ||
      Character == "Storm Dragon" )
    {
      MonsterType = "Water";
    }
    if(Character == "Pyro Cat" || 
       Character == "Flame Fox" ||
       Character == "Fire Bat" ||
       Character == "Ember Bug" )
    {
      MonsterType = "Flame";
    }
    if(Character == "Rock Dog"||
       Character == "Boulder Bear"||
       Character == "Ground Turtle")
    {
      MonsterType = "Earth";
    }
    if(Character == "Mini Elephant"||
       Character == "Hippo"||
       Character == "Liger"||
       Character == "Sad Panda"||
       Character == "Unicorn")
    {
      MonsterType = "Generic";
    }
    return MonsterType;
  }

  public function getMonsterDesc():String
  {
    var MonsterDesc = "";
    if(Character == "Fairy")
    {
      MonsterDesc = "Known for it healing ability.  As it grows, it becomes better able to take care of itself and its companions.  Even if it doesn't want to.";
    }
    if(Character == "Liger")
    {
      MonsterDesc = "It is not found in the wild.  It's spends most of it time hiding, so it can hone its skills.  It is said only two have every been caught.";
    }
    if(Character == "Flower")
    {
      MonsterDesc = "It blends into the scenery, but unlike other flowers, its able to move and attack.";
    }
    if(Character == "Sad Panda")
    {
      MonsterDesc = "Its sadness stems from a deep regret.  It spends most of its time awake, thinking about the past.";
    }
    if(Character == "Lightning Cat")
    {
      MonsterDesc = "Known for its intelligence and agility. However, it prefers solitude over companionship.";
    }
    if(Character == "Storm Dragon")
    {
      MonsterDesc = "Known for destroying ships.  It's habitat is unknown, but some theorize it can jump from one body of water to another by will.";
    }
    if(Character == "Rock Dog")
    {
      MonsterDesc = "Known for its friendly behavior. It's perfectly content to hang out with its companions rather than achieve praise or status.";
    }
    if(Character == "Vine Cat")
    {
      MonsterDesc = "It uses vines to hide itself. Perhaps it's hiding from something, or perhaps its spying on someone.";
    }
    if(Character == "Mini Elephant")
    {
      MonsterDesc = "Legend has it that there once was a elephant that was over two tons.  Which is why this Elephant is called Mini.";
    }
    if(Character == "Unicorn")
    {
      MonsterDesc = "Once said to be extinct, now hunted for sport.  Overpopulation has become a major concern.";
    }
     
    if(Character == "Hippo")
    {
      MonsterDesc = "Known for lying around and eating all day.  Not much else to note.";
    }
    if(Character == "Boulder Bear")
    {
      MonsterDesc = "It's known for scrounging through campsites looking for food.";
    }
    if(Character == "Ground Turtle")
    {
      MonsterDesc = "It uses its hard shell to provide extra protection.";
    }
    if(Character == "Flame Fox")
    {
      MonsterDesc = "Abandoned by its parents at a young age, the flame fox searches the world for companionship.";
    }
    if(Character == "Pyro Cat")
    {
      MonsterDesc = "Most People know it has the power to start fires, but it also has the power to put them out.";
    }
    if(Character == "Fire Bat")
    {
      MonsterDesc = "Its flames are bright enough to help travelers and miners see through caves.  Not the friendliest though,  when upset, it often injures the ones around them.";
    }
    if(Character == "Ember Bug")
    {
      MonsterDesc = "It's found in forests near dead trees.  It uses its fire to help decompose tree."; 
    }
    if(Character == "Leaf Sheep")
    {
      MonsterDesc = "It Wool is varies from sheep to sheep. It can be anything from cotton to battle armor.";
    }
    if(Character == "Electric Zebra")
    {
      MonsterDesc = "It leads a carefree existence, but only when food sources are plentiful.";
    }
    if(Character == "Jelly Fish")
    {
      MonsterDesc = "Despite being able to live it water, its still only uses electric moves.  It is said some can learn water type moves, but this has never been confirmed.";
    }
    if(Character == "Electric Eel" )
    {
      MonsterDesc = "When Placed in jar of water, it can be used to power electric devices.";
    }
    if(Character == "Water Jay")
    {
      MonsterDesc = "It's often used to fly overhead and spot nearby water sources.";
    }
    if(Character == "Water Rabbit")
    {
      MonsterDesc =  "It known for its speed and agility. However, its a very slow breeder.";
    }
    if(Character == "Tsunami Cat")
    {
      MonsterDesc = "It can create huge Tsunamis, or fill up water bottles.";
    }
    return MonsterDesc;

  }

  public function getTileNumber(normal:Bool):Int
  {
    if(Character == "Fairy")
    {
      if(normal)
	{return 0000;}
      else
	{return 0001;}
    }
    if(Character == "Flower")
    {
      if(normal)
	{return 0201;}
      else
	{return 0200;}
    }
    if(Character == "Lightning Cat")
    {
      if(normal)
	{return 0501;}
      else
	{return 0500;}
    }
    if(Character == "Jelly Fish")
    {
      return 0301;
    }
    if(Character ==  "Electric Zebra")
    {
      if(normal)
	{return 0601;}
      else
	{return 0600;}
    }
    if(Character ==  "Electric Eel")
    {
      if(normal)
	{return 0701;}
      else
	{return 0700;}
    }

    if(Character == "Water Jay")
    {
      if(normal)
	{return 0503;}
      else
	{return 0502;}
    }

    if(Character == "Water Rabbit")
    {
      if(normal)
	{return 0403;}
      else
	{return 0402;}
    }

    if(Character == "Tsunami Cat")
    {
      if(normal)
	{return 0303;}
      else
	{return 0302;}
    }
    if(Character == "Storm Dragon")
    {
      if(normal)
	{return 0603;}
      else
	{return 0602;}
    }
    if(Character == "Pyro Cat")
    {
      if(normal)
	{return 0305;}
      else
	{return 0304;}
    }
    if(Character == "Flame Fox")
    {
      if(normal)
	{return 0405;}
      else
	{return 0404;}
    }
    if(Character == "Fire Bat")
    {
      if(normal)
	{return 0505;}
      else
	{return 0504;}
    }
    if(Character == "Ember Bug")
    {
      if(normal)
	{return 0306;}
      else
	{return 0307;}
    }
    if(Character == "Rock Dog")
    {
      if(normal)
	{return 0705;}
      else
	{return 0704;}
    }
     if(Character == "Boulder Bear")
    {
      if(normal)
	{return 0605;}
      else
	{return 0604;}
    }
     if(Character == "Ground Turtle")
    {
      if(normal)
	{return 0407;}
      else
	{return 0406;}
    }
     if(Character == "Leaf Sheep")
    {
      if(normal)
	{return 0507;}
      else
	{return 0506;}
    }
     if(Character == "Mini Elephant")
    {
      if(normal)
	{return 0607;}
      else
	{return 0606;}
    }
     if(Character == "Vine Cat")
    {
      if(normal)
	{return 0703;}
      else
	{return 0702;}
    }
     if(Character == "Liger")
    {
      if(normal)
	{return 0707;}
      else
	{return 0706;}
    }
     if(Character == "Unicorn")
    {
      if(normal)
	{return 0801;}
      else
	{return 0800;}
    }
     if(Character == "Sad Panda")
    {
      if(normal)
	{return 0803;}
      else
	{return 0802;}
    }
     if(Character == "Hippo")
    {
      if(normal)
	{return 0805;}
      else
	{return 0804;}
    }
    return 0100;
  }

  public function increaseLevel()
  {
    Level++;
    var addHealth = MaxHealth;
    Attack += ((BaseAttack/50)+1) * 2 ;//*Level;
    Defense += ((BaseDefense/50)+1) * 2;// * Level;
    Speed += ((BaseDefense/50)+1) * 1/5 * Level;
    Accuracy += ((BaseAccuracy/50)+1) * 1/5 * Level;
    MaxHealth += Std.int(9*(BaseHealth/3));
    addHealth = (MaxHealth-addHealth);
    Health += addHealth;
    getNewMove();
  }

  public function getNewMove()
  {
    switch(Character)
    {
    case "Electric Zebra":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Molecular Equil. Disturbance";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Electric Burn";
	  attack.AttackPower = 1.2;	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Electrified Kick";
	  attack.AttackPower = 0.9;	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}

	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Energy Spike";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Alternating Current";	
	  attack.AttackPower = 1.4;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Charge Attack";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Electrocution";
	  attack.AttackPower = 1.6;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Super Capacitor";
	  attack.AttackPower = 3;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
    case "Electric Eel":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Molecular Equil. Distur.";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Electric Burn";
	  attack.AttackPower = 1.2;	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Electrified Water";
	  attack.AttackPower = 1.1;	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}

	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Energy Spike";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Alternating Current";	
	  attack.AttackPower = 1.4;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Charge Attack";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Electrocution";
	  attack.AttackPower = 1.6;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Super Capacitor";
	  attack.AttackPower = 3;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
    case "Jelly Fish":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Molecular Equil. Distur.";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Electric Burn";
	  attack.AttackPower = 1.2;	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Electrified Water";
	  attack.AttackPower = 1.1;	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Energy Spike";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Alternating Current";	
	  attack.AttackPower = 1.4;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Charge Attack";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Electrocution";
	  attack.AttackPower = 1.6;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Super Capacitor";
	  attack.AttackPower = 3;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}

      case "Lightning Cat":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Molecular Equil. Distur.";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Electric Burn";	
	  attack.MP = 1;
	  attack.AttackPower = 1.2;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}

	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Energy Spike";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Alternating Current";	
	  attack.AttackPower = 1.4;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Charge Attack";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Electrocution";
	  attack.AttackPower = 1.6;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Super Capacitor";
	  attack.AttackPower = 3;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
      case "Water Rabbit":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Sprinkler";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 5)
	{
	  var attack = new Move();
	  attack.Name = "Pressure Washer";
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Water Jet";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Hop and Stomp";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Water Intoxication";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Dehydration";
	  attack.AttackPower = 1.3;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Tsunami";
	  attack.AttackPower = 1.5;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Heal+";
	  attack.AttackPower = 1.5;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Status Cure";	
	  attack.MP = 15;
	  attack.TotalMP = 15;
	  Moves.add(attack); 
	}
      case "Storm Dragon":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Sprinkler";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 5)
	{
	  var attack = new Move();
	  attack.Name = "Pressure Washer";
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Flood Field";	
	  attack.AttackPower = 1.0;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Water Jet";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Molecular Equil. Distur.";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Water Intoxication";
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Tsunami";
	  attack.AttackPower = 1.5;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Heal+";
	  attack.AttackPower = 1.5;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack); 
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Lightning Storm";	
	  attack.MP = 3;
	  attack.AttackPower = 1.5;
	  attack.TotalMP = 3;
	  Moves.add(attack);
	}

      case "Water Jay":
      	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Sprinkler";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 5)
	{
	  var attack = new Move();
	  attack.Name = "Pressure Washer";
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Water Jet";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Peck";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Water Intoxication";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Dehydration";
	  attack.AttackPower = 1.3;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Tsunami";
	  attack.AttackPower = 1.5;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Heal+";
	  attack.AttackPower = 1.5;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Status Cure";	
	  attack.MP = 15;
	  attack.TotalMP = 15;
	  Moves.add(attack); 
	}
     case "Fire Bat":
      	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Rapid Oxidation";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 5)
	{
	  var attack = new Move();
	  attack.Name = "Water Contamination";
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Destruction";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Atmospheric Pollution";	
	  attack.AttackPower = 1.5;
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Chain Reaction";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 30)
	{
	  var attack = new Move();
	  attack.Name = "Venom Flame";	
	  attack.AttackPower = 1.2;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Blowtorch";
	  attack.AttackPower = 1.3;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Intense Burn";
	  attack.AttackPower = 0.8;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Dazzling White Flame";
	  attack.AttackPower = 1.6;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}

      case "Flame Fox":
      	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Rapid Oxidation";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 5)
	{
	  var attack = new Move();
	  attack.Name = "Water Contamination";
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Prepare Growth";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Atmospheric Pollution";	
	  attack.AttackPower = 1.5;
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Chain Reaction";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 30)
	{
	  var attack = new Move();
	  attack.Name = "Existential Flame";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Blowtorch";
	  attack.AttackPower = 1.3;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Intense Burn";
	  attack.AttackPower = 0.8;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Dazzling White Flame";
	  attack.AttackPower = 1.6;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
      case "Ember Bug":
      	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Rapid Oxidation";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 5)
	{
	  var attack = new Move();
	  attack.Name = "Water Contamination";
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Fire Burrow";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Atmospheric Pollution";	
	  attack.AttackPower = 1.5;
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Chain Reaction";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Blowtorch";
	  attack.AttackPower = 1.3;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Intense Burn";
	  attack.AttackPower = 0.8;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Dazzling White Flame";
	  attack.AttackPower = 1.6;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}

      case "Pyro Cat":
      	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Rapid Oxidation";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 5)
	{
	  var attack = new Move();
	  attack.Name = "Water Contamination";
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Fire Swipe";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Atmospheric Pollution";	
	  attack.AttackPower = 1.5;
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Chain Reaction";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Blowtorch";
	  attack.AttackPower = 1.3;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Intense Burn";
	  attack.AttackPower = 0.8;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Dazzling White Flame";
	  attack.AttackPower = 1.6;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}

      case "Tsunami Cat":
      	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Sprinkler";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 5)
	{
	  var attack = new Move();
	  attack.Name = "Small Wave";
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Water Jet";	
	  attack.AttackPower = 1.1;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Wave Storm";	
	  attack.AttackPower = 1.5;
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Water Intoxication";	
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Dehydration";
	  attack.AttackPower = 1.3;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Tsunami";
	  attack.AttackPower = 1.5;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Tsunami Storm";
	  attack.AttackPower = 1.6;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack); 
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Heal+";
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Status Cure";	
	  attack.MP = 15;
	  attack.TotalMP = 15;
	  Moves.add(attack); 
	}

      case "Leaf Sheep":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Stamen Wipe";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Poison Pollen";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack);
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Pedal Power";	
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Invasive growth";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  attack.AttackPower = 1.2;
	  Moves.add(attack);
	}
	if(Level == 40)
	{
	  var attack = new Move();
	  attack.Name = "Attract Insects";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Wrap";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Super Photosynthesis";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 90)
	{
	  var attack = new Move();
	  attack.Name = "Resource Drain";
	  attack.AttackPower = 0.5;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack);
	}
      case "Vine Cat":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Stamen Wipe";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Poison Pollen";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack);
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Pedal Power";	
	  attack.AttackPower = 0.9;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Invasive growth";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  attack.AttackPower = 1.2;
	  Moves.add(attack);
	}
	if(Level == 40)
	{
	  var attack = new Move();
	  attack.Name = "Attract Insects";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Wrap";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Super Photosynthesis";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 90)
	{
	  var attack = new Move();
	  attack.Name = "Poison Vine Cut";
	  attack.AttackPower = 1.5;
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack);
	}


      
      case "Flower":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Stamen Wipe";	
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Poison Pollen";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack);
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Pedal Power";	
	  attack.AttackPower = 1.0;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Invasive growth";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  Moves.add(attack);
	}
	if(Level == 35)
	{
	  var attack = new Move();
	  attack.Name = "Poison Vine";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 40)
	{
	  var attack = new Move();
	  attack.Name = "Attract Insects";	
	  attack.AttackPower = 1.3;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Wrap";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  attack.AttackPower = 1.6;
	  Moves.add(attack);
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Super Photosynthesis";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Poison Seed";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack);
	}


      case "Fairy":
	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Heal";	
	  attack.MP = 20;
	  attack.TotalMP = 20;
	  Moves.add(attack); 
	}

	if(Level == 3)
	{
	  var attack = new Move();
	  attack.Name = "Pressure Washer";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}

	if(Level == 5)
	{
	  var attack = new Move();
	  attack.Name = "Status Cure";	
	  attack.MP = 15;
	  attack.TotalMP = 15;
	  Moves.add(attack); 
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Heal Group";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Heal+";	
	  attack.MP = 20;
	  attack.TotalMP = 20;
	  Moves.add(attack); 
	}

	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "MP Restore";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack); 
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Heal+ Group";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}

	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Water Intoxication";
	  attack.AttackPower = 1.2;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack); 
	}

	if(Level == 40)
	{
	  var attack = new Move();
	  attack.Name = "Dehydration";	
	  attack.AttackPower = 1.3;
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack); 
	}

	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "MP Restore Group";	
	  attack.MP = 2;
	  attack.TotalMP = 2;
	  Moves.add(attack); 
	}

	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Full Restore";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  Moves.add(attack); 
	}

	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Full Restore Group";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  Moves.add(attack); 
	}

 case "Unicorn":
       	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Molecular Equil. Distur.";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Nibble";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 0.9;
	  Moves.add(attack);
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Sprinkler";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Stomp";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.0;
	  Moves.add(attack);
	}
	if(Level == 30)
	{
	  var attack = new Move();
	  attack.Name = "Squish";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}

	if(Level == 35)
	{
	  var attack = new Move();
	  attack.Name = "Stamen Whip";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 40)
	{
	  var attack = new Move();
	  attack.Name = "Kick";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Rapid Oxidation";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 50)
	{
	  var attack = new Move();
	  attack.Name = "Bite";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Sandstone Throw";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 70)
	{
	  var attack = new Move();
	  attack.Name = "Deep Bite";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Full Restore";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  attack.AttackPower = 1;
	  Moves.add(attack);
	}
 case "Hippo":
       	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Painful Roar";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Nibble";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 0.9;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Stomp";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.0;
	  Moves.add(attack);
	}
	if(Level == 30)
	{
	  var attack = new Move();
	  attack.Name = "Squish";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 40)
	{
	  var attack = new Move();
	  attack.Name = "Kick";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 50)
	{
	  var attack = new Move();
	  attack.Name = "Bite";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Trunk Squeeze";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.4;
	  Moves.add(attack);
	}
	if(Level == 70)
	{
	  var attack = new Move();
	  attack.Name = "Deep Bite";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Sprinkler";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  attack.AttackPower = 0.8;
	  Moves.add(attack);
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Energy Bite";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  attack.AttackPower = 0.8;
	  Moves.add(attack);
	}
 case "Mini Elephant":
       	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Painful Roar";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Trunk Slap";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 0.9;
	  Moves.add(attack);
	}
	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Stomp";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.0;
	  Moves.add(attack);
	}
	if(Level == 30)
	{
	  var attack = new Move();
	  attack.Name = "Squish";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 40)
	{
	  var attack = new Move();
	  attack.Name = "Kick";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 50)
	{
	  var attack = new Move();
	  attack.Name = "Bite";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Trunk Squeeze";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.4;
	  Moves.add(attack);
	}
	if(Level == 70)
	{
	  var attack = new Move();
	  attack.Name = "Deep Bite";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Stampede";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  attack.AttackPower = 1.6;
	  Moves.add(attack);
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Water Jet";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
      case "Sad Panda":
       	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Painful Roar";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Gnaw";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 0.9;
	  Moves.add(attack);
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Sadness Attack";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1;
	  Moves.add(attack);
	}

	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Bashful Swing";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.0;
	  Moves.add(attack);
	}
	if(Level == 30)
	{
	  var attack = new Move();
	  attack.Name = "Squeeze";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 40)
	{
	  var attack = new Move();
	  attack.Name = "Pounce";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 50)
	{
	  var attack = new Move();
	  attack.Name = "Bite";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 60)
	{
	  var attack = new Move();
	  attack.Name = "Regretful Maul";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.4;
	  Moves.add(attack);
	}
	if(Level == 70)
	{
	  var attack = new Move();
	  attack.Name = "Deep Bite";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
	if(Level == 80)
	{
	  var attack = new Move();
	  attack.Name = "Insomniac Rage";	
	  attack.MP = 3;
	  attack.TotalMP = 3;
	  attack.AttackPower = 1.6;
	  Moves.add(attack);
	}

  case "Liger":
       	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Painful Roar";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 10)
	{
	  var attack = new Move();
	  attack.Name = "Gnaw";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 0.9;
	  Moves.add(attack);
	}

	if(Level == 20)
	{
	  var attack = new Move();
	  attack.Name = "Slash";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.0;
	  Moves.add(attack);
	}
	if(Level == 35)
	{
	  var attack = new Move();
	  attack.Name = "Pounce";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 50)
	{
	  var attack = new Move();
	  attack.Name = "Bite";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
	if(Level == 70)
	{
	  var attack = new Move();
	  attack.Name = "Fatal Strike";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.6;
	  Moves.add(attack);
	}
	if(Level == 90)
	{
	  var attack = new Move();
	  attack.Name = "Infected bite";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1;
	  Moves.add(attack);
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Energy Bite";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  attack.AttackPower = 1;
	  Moves.add(attack);
	}

  case "Ground Turtle":
     	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Sandstone Throw";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 3)
	{
	  var attack = new Move();
	  attack.Name = "Quartzite Dart";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 0.9;
	  Moves.add(attack);
	}

	if(Level == 12)
	{
	  var attack = new Move();
	  attack.Name = "Limestone Spikes";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.0;
	  Moves.add(attack);
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Stalagmite Drop";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Marble Bullets";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 35)
	{
	  var attack = new Move();
	  attack.Name = "Serpentine Smash";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.2;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Slate Protect";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 55)
	{
	  var attack = new Move();
	  attack.Name = "Soapstone Squish";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.4;
	  Moves.add(attack);
	}
	if(Level == 70)
	{
	  var attack = new Move();
	  attack.Name = "Granite Boulders";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
	if(Level == 85)
	{
	  var attack = new Move();
	  attack.Name = "Metal Ores";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.6;
	  Moves.add(attack);
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Encase";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}

  case "Boulder Bear":
     	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Sandstone Throw";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 3)
	{
	  var attack = new Move();
	  attack.Name = "Quartzite Dart";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 0.9;
	  Moves.add(attack);
	}

	if(Level == 12)
	{
	  var attack = new Move();
	  attack.Name = "Limestone Spikes";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.0;
	  Moves.add(attack);
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Stalagmite Drop";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Marble Bullets";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 35)
	{
	  var attack = new Move();
	  attack.Name = "Serpentine Smash";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.2;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Slate Fragements";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 55)
	{
	  var attack = new Move();
	  attack.Name = "Soapstone Squish";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.4;
	  Moves.add(attack);
	}
	if(Level == 70)
	{
	  var attack = new Move();
	  attack.Name = "Granite Slash";	
	  attack.MP = 8;
	  attack.TotalMP = 8;
	  attack.AttackPower = 1.6;
	  Moves.add(attack);
	}
	if(Level == 85)
	{
	  var attack = new Move();
	  attack.Name = "Metal Ores";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.7;
	  Moves.add(attack);
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Encase";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
     
  case "Rock Dog":
     	if(Level == 2)
	{
	  var attack = new Move();
	  attack.Name = "Sandstone Throw";
	  attack.AttackPower = 0.8;
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  Moves.add(attack);
	}
	if(Level == 3)
	{
	  var attack = new Move();
	  attack.Name = "Quartzite Dart";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 0.9;
	  Moves.add(attack);
	}

	if(Level == 12)
	{
	  var attack = new Move();
	  attack.Name = "Limestone Spikes";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.0;
	  Moves.add(attack);
	}
	if(Level == 15)
	{
	  var attack = new Move();
	  attack.Name = "Stalagmite Drop";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 25)
	{
	  var attack = new Move();
	  attack.Name = "Marble Bullets";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.1;
	  Moves.add(attack);
	}
	if(Level == 35)
	{
	  var attack = new Move();
	  attack.Name = "Serpentine Smash";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.2;
	  Moves.add(attack);
	}
	if(Level == 45)
	{
	  var attack = new Move();
	  attack.Name = "Slate Fragements";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.3;
	  Moves.add(attack);
	}
	if(Level == 55)
	{
	  var attack = new Move();
	  attack.Name = "Soapstone Squish";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.4;
	  Moves.add(attack);
	}
	if(Level == 70)
	{
	  var attack = new Move();
	  attack.Name = "Granite Boulders";	
	  attack.MP = 10;
	  attack.TotalMP = 10;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}
	if(Level == 85)
	{
	  var attack = new Move();
	  attack.Name = "Metal Ores";	
	  attack.MP = 5;
	  attack.TotalMP = 5;
	  attack.AttackPower = 1.6;
	  Moves.add(attack);
	}
	if(Level == 100)
	{
	  var attack = new Move();
	  attack.Name = "Encase";	
	  attack.MP = 1;
	  attack.TotalMP = 1;
	  attack.AttackPower = 1.5;
	  Moves.add(attack);
	}

      //Next Case
      default:
    }
  }

  public function SetStats()
  {
    //if(Level == 1)
    switch(Character)
    {
    case "Liger":
      BaseAttack = 10;      
    case "Hippo":
      BaseHealth = 7.5;
    case "Lightning Cat":
      BaseAccuracy = 10;
      BaseSpeed = 10;
    case "Tsunami Cat":
      BaseAccuracy = 7;
      BaseSpeed = 7;
    case "Vine Cat":
      BaseAccuracy = 7;
      BaseSpeed = 7;
    case "Pyro Cat":
      BaseAccuracy = 8;
      BaseSpeed = 8;
      BaseAttack = 6;
    case "Rock Dog":
      BaseDefense = 7;
    case "Boulder Bear":
      BaseDefense = 7;
    case "Ground Turtle":
      BaseDefense = 8;
    case "Flame Fox":
      BaseAccuracy = 7;
      BaseSpeed = 7;
      BaseAttack = 6;
    case "Fire Bat":
      BaseAttack = 7;
    case "Ember Bug":
      BaseAttack = 6;
    }
  }
  public function LevelUp()
  {
      while(CheckXpToNextLevel())
      {
	SetStats();
	increaseLevel();
      }
  }
  public function XpToNextLevel()
  {
    return ((Level)*((Level)+1))/2;
  }
  public function XpLeft()
  {
    return XpToNextLevel()-XP;
  }
  public function CheckXpToNextLevel():Bool
  {
    var LevelUp = false;
    if(Level == 100)
    {
      return false;
    }
    //trace("XP " + XP + " , " + XpToNextLevel());
    if(XP >= XpToNextLevel())
      {
	LevelUp = true;
      }
    return LevelUp;
  }
} 