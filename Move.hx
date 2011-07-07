class Move
{

  public var TotalMP:Int;
  public var MP:Int;
  public var Name:String;
  public var AttackPower:Float;
  public function new()
  {
     TotalMP = 5;
     MP = 5;
     AttackPower  =  .80;
  }

//also Trainer
  public function getAttack(monster:Monster,opponentMonster:Monster,monsters:List<Monster>,opponentMonsters:List<Monster>) : AttackText
  {
    if(monster.Encase > 0)
    {
      monster.Encase--;
    }
    if(monster.Protect > 0)
    {
      monster.Protect--;
    }
    var AttackString = new AttackText();
    var sucess = (80+((monster.Speed/opponentMonster.Accuracy)*20))>Std.random(100);
    var attackModifier = 1;
    if(Name == "Attack")
    {
      var AttackType = "Generic";
      var modifier = 1;
      var modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*.5*modifier*attackModifier),0));

      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = "Attack: -"+Attack;
      }
      else
      {
	AttackString.OpponentText = "Attack: "+"Failed";
      }
      //AttackString.Text = "-"+Attack;
    }
    if(Name == "Heal")
    {
      var AttackType = "Generic";
      var Attack =  100;
      monster.Health =  monster.Health + Attack;
      AttackString.Text = "Heal: "+Attack;
    }
    if(Name == "Status Cure")
    {
      var AttackType = "Generic";
      monster.Burned = false;
      monster.Poisoned = false;
      monster.Seeded = false;
      AttackString.Text = Name+ ": Cured";
    }
    if(Name == "Heal Group")
    {
      var AttackType = "Generic";
      var Attack =  100;
      for(monst in monsters)
      {
	monst.Health =  monst.Health + Attack;
      }
      AttackString.Text = "Heal: "+Attack;
    }
    if(Name == "Heal+ Group")
    {
      var AttackType = "Generic";
      var Attack = 500;
      for(monst in monsters)
      {
	monst.Health =  monst.Health + Attack;
      }
      AttackString.Text = "Heal: "+Attack;
    }
    if(Name == "Heal+")
    {
      var AttackType = "Generic";
      var Attack =  500;
      monster.Health =  monster.Health + Attack;
      AttackString.Text = "Heal+: "+Attack;
    }
    if(Name == "MP Restore")
    {

      for(move in monster.Moves)
      {
	if(!MpRestoreMove(move.Name))
	{
	  move.MP = move.TotalMP;
	}
      }
    }
    if(Name == "MP Restore Group")
    {
      for(monst in monsters)
      {
	for(move in monst.Moves)
	{
	  if(!MpRestoreMove(move.Name))
	  {
	    move.MP = move.TotalMP;
	  }
	}
      }
    }
    if(Name == "Molecular Equil. Distur." || Name == "Lightning Storm" || Name == "Energy Spike" ||
       Name == "Alternating Current" || Name == "Electrocution" || Name == "Energy Spike" ||
       Name == "Electrified Kick")
    {
      var AttackType = "Electric";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
    if(Name == "Charge Attack" )
    {
      var AttackType = "Electric";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
      monster.Charged = 2;
      AttackString.Text = Name +": Charged 1 Turn" ;
    }
    if(Name == "Super Capacitor" )
    {
      var AttackType = "Electric";
      monster.Charged = 4;
      AttackString.Text = Name +": Charged 3 Turns";
    }
    if(Name == "Electrified Water" )
    {
      var AttackType = "Electric";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
    if(Name == "Electric Burn" )
    {
      var AttackType = "Electric";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	opponentMonster.Burned = true;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }

    if(Name == "Water Contamination" || Name == "Venom Flame")
    {
      var AttackType = "Flame";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      var poisoned = Std.random(2) > 0;
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	opponentMonster.Poisoned = poisoned;
	AttackString.OpponentText = Name +": -"+Attack + (poisoned ? " Poisoned": "");
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
    if(Name == "Atmospheric Pollution")
    {
      var AttackType = "Flame";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      var poisoned = true;
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	opponentMonster.Poisoned = poisoned;
	AttackString.OpponentText = Name +": -"+Attack + (poisoned ? " Poisoned": "");
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
    if(Name == "Intense Burn")
    {
      var AttackType = "Flame";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      var burned = true;
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	opponentMonster.Burned = burned;
	AttackString.OpponentText = Name +": -"+Attack + (burned ? " Burned": "");
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }

    if(Name == "Slate Protect")
    {
	monster.Protect = 3;
	AttackString.Text = Name +": 3 Turns";
    }
    if(Name == "Encase")
    {
	monster.Encase = 5;
	AttackString.Text = Name +": 5 Turns";
    }

    if(Name == "Infected bite")
    {
      var AttackType = "Generic";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      var poisoned = Std.random(2) > 0;
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	opponentMonster.Poisoned = poisoned;
	AttackString.OpponentText = Name +": -"+Attack + (poisoned ? " Poisoned": "");
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
//
//
    if(Name == "Energy Bite")
    {
      var AttackType = "Generic";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	AttackString.Text =Name +": +"+Attack;
	monster.Health += Math.ceil(Attack/4);
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
}
    if(Name == "Painful Roar" || Name == "Gnaw" ||Name == "Sadness Attack"
      || Name == "Bashful Swing" || Name == "Squeeze" ||Name == "Pounce"
      || Name == "Bite" || Name == "Regretful Maul" || Name == "Deep Bite"
      || Name == "Insomniac Rage" || Name == "Slash" || Name == "Fatal Strike"
      || Name == "Stampede" || Name =="Deep Bite" || Name == "Trunk Squeeze" 
      || Name == "Kick" || Name =="Squish" || Name == "Stomp" 
      || Name == "Trunk Slap" || Name =="Nibble")
    {
      var AttackType = "Generic";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
    if(Name == "Sandstone Throw" || Name == "Quartzite Dart" ||Name == "Limestone Spikes"
      || Name == "Stalagmite Drop" || Name == "Marble Bullets" ||Name == "Serpentine Smash"
      || Name == "Soapstone Squish" || Name == "Granite Boulders" || Name == "Metal Ores"
      || Name == "Slate Fragements")
    {
      var AttackType = "Earth";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }

    if(Name == "Poison Pollen")
    {
      var AttackType = "Plant";
      if(sucess)
      {
	opponentMonster.Poisoned = true;
	AttackString.OpponentText = Name +": Poisoned";
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
    if(Name == "Super Photosynthesis" || Name == "Full Restore")
    {
      monster.Health = monster.MaxHealth;
      monster.Seeded = false;
      monster.Burned = false;
      monster.Poisoned = false;
      for(move in monster.Moves)
      {
	if(!MpRestoreMove(move.Name))
	{
	  move.MP = move.TotalMP;
	}
      }
    }
    if(Name == "Full Restore Group")
    {
      for(monst in monsters)
      {
	monst.Health = monst.MaxHealth;
	monst.Seeded = false;
	monst.Burned = false;
	monst.Poisoned = false;
	for(move in monst.Moves)
	{
	  if(!MpRestoreMove(move.Name))
	  {
	    move.MP = move.TotalMP;
	  }
	}
      }
    }
    if(Name == "Poison Seed")
    {
      var AttackType = "Plant";
      if(sucess)
      {
	opponentMonster.Poisoned = true;
	opponentMonster.Seeded = true;
	AttackString.OpponentText = Name +": Poisoned Seeded";
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
    if(Name == "Poison Vine" || Name == "Poison Vine Cut")
    {
      var AttackType = "Plant";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/opponentMonster.Defense)*attackModifier*AttackPower*modifier),0));
      var poisoned = true;
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	opponentMonster.Poisoned = poisoned;
	AttackString.OpponentText = Name +": -"+Attack + (poisoned ? " Poisoned": "");
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
    if(Name == "Invasive growth")
    {
      var AttackType = "Plant";
      if(sucess)
      {
	opponentMonster.Seeded = true;
	AttackString.OpponentText = Name +": Seeded";
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }
    if(Name == "Wrap" || Name == "Attract Insects" ||Name == "Pedal Power"
      || Name == "Stamen Wipe")
    {
      var AttackType = "Plant";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * ( monster.Attack/(opponentMonster.Defense) )*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }

    if(Name == "Rapid Oxidation" || Name == "Prepare Growth" ||Name == "Chain Reaction"
      || Name == "Existential Flame" || Name == "Blowtorch" ||Name == "Dazzling White Flame"
      || Name == "Fire Burrow" || Name == "Fire Swipe" || Name == "Destruction")
    {
      var AttackType = "Flame";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * ( monster.Attack/(opponentMonster.Defense) )*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }

    if(Name == "Sprinkler" || Name == "Pressure Washer" ||Name == "Flood Field"
      || Name == "Water Jet" || Name == "Water Intoxication" ||Name == "Tsunami"
      || Name == "Dehydration" || Name == "Tsuami Storm" || Name == "Wave Storm"
      || Name == "Small Wave")
    {
      var AttackType = "Water";
      var modifier = getTypeModifier(AttackType,opponentMonster.getMonsterType());
      modifier = modifier * (opponentMonster.Encase > 0 ? 0:1) * (opponentMonster.Protect > 0 ? 0.5:1);
      modifier = modifier * (monster.Charged > 0 ? 2:1);
      var Attack =  Math.ceil(Math.max((monster.Attack * (monster.Attack/(opponentMonster.Defense))*attackModifier*AttackPower*modifier),0));
      if(sucess)
      {
	opponentMonster.Health =  opponentMonster.Health - Attack;
	AttackString.OpponentText = Name +": -"+Attack;
      }
      else
      {
	AttackString.OpponentText = Name +": Failed";
      }
    }

    
    if(monster.Charged > 0)
    {
      monster.Charged--;
    }
    return AttackString;

  }

  public function MpRestoreMove(inName:String)
  {
    return (inName == "MP Restore" || inName == "MP Restore Group" || inName == "Super Photosynthesis" || inName == "Full Restore" || inName == "Full Restore Group");
  }
  public function getTypeModifier(Type1:String,Type2:String):Float
  {
    var modifier = 1.0;
    switch(Type1)
    {
      case "Generic":
	modifier = 1;
      case "Flame":
	switch(Type2)
	{
	  case "Water":
	    modifier =0.5;
	  case "Plant":
	    modifier = 2;
	}
      case "Water":
	switch(Type2)
	{
	  case "Flame":
	    modifier =2;
	  case "Earth":
	    modifier =2;
	  case "Plant":
	    modifier = 0.5;
	  case "Electric":
	    modifier = 0.5;
	}
      case "Plant":
	switch(Type2)
	{
	  case "Flame":
	    modifier =0.5;
	  case "Water":
	    modifier = 2;
	}
      case "Electric":
	switch(Type2)
	{
	  case "Water":
	    modifier =2;
	  case "Earth":
	    modifier = 0.25;
	}
      case "Earth":
	switch(Type2)
	{
	  case "Electric":
	    modifier = 2;
	  case "Water":
	    modifier = 0.5;
	}
      
      
    }
    return modifier;
  }

}