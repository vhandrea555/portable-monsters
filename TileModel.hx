import flash.events.Event;
import flash.events.EventDispatcher;
import flash.display.DisplayObject;
import flash.geom.Point;
//import haxe.Math;

class TileModel extends AVerletModel
{
  public var tileSheetRow:Int;
  public var tileSheetColumn:Int;
  public var ImageWidth:Int;
  public var ImageHeight:Int;
  public var ImageX:Int;
  public var ImageY:Int;
  public var ImageXOffset:Int;
  public var ImageYOffset:Int;
  public var moving:Int;
  public var movingDirection:String;
  public var LastPosition:Point;
  public var TempLastPosition:Point;
  public var UpdateIfNotCollied:Bool;
  
  public var Shot:Bool;
  public var cooldown:Int;
  public var invincble:Int;
  public var CharacterType:String;
  
  private var _mapRow:Int;
  private var _mapColumn:Int;
  private var _currentTile:Int;
  private var _maxTileSize:Int;

  //Optional properties for platform
  //game characters
  public var jumping:Bool;
  public var health:Int;
  public var MaxHealth:Int;
  public var Clockwise:Bool;
  public var Teleport:Int;

  public var coordinateSpace:DisplayObject;
    
    //Set which direction the character is moving
  public var direction:String;
  public var changeDirection:String;
    
  public function new
    (
      maxTileSize:Int = 64,
      tileSheetColumn:Int = 0,
      tileSheetRow:Int = 0,
      mapRow:Int = 0, 
      mapColumn:Int = 0, 
      width:Int = 0, 
      height:Int = 0,
      ImageIsSprite:Bool = true,
      ImageHeight = 0,
      ImageWidth = 0,
      ImageX = 0,
      ImageY = 0
    ) 
  {
    super();
    jumping = false;
    cooldown = 0;
    direction = "down";
    moving = 0;
    movingDirection = "";
    this._maxTileSize = maxTileSize;
    this.tileSheetColumn = tileSheetColumn;
    this.tileSheetRow = tileSheetRow;
    this._mapRow = mapRow;
    this._mapColumn = mapColumn;
    this.width = width;
    this.height = height;
    this.setX = mapColumn * maxTileSize;
    this.setY = mapRow * maxTileSize;
    ImageXOffset = 0;ImageYOffset=0;
    Clockwise = false;
    Teleport = 200;
    if(ImageIsSprite)
    {
      this.ImageWidth = width;
      this.ImageHeight = height;
      this.ImageX = 0;
      this.ImageY = 0;
    }
    else
    {
      this.ImageWidth = ImageWidth;
      this.ImageHeight = ImageHeight;
      this.ImageX = ImageX;
      this.ImageY = ImageY;
    }
    health = 10;
    MaxHealth = 10;
    LastPosition = new Point(0,0);
    TempLastPosition = new Point(0,0);
    UpdateIfNotCollied = false;
  }

  public override function update()
  {
    if(moving == 1)
      {setVelocity();}
    super.update();
    if(moving > 0)
    {
      moving++;
    }
    if(moving >= 5)
    {
      moving = 1;
      setVelocity();   
    }

  }
  public function updateLastDirection()
  {
    LastPosition.x = TempLastPosition.x;LastPosition.y = TempLastPosition.y;
  }
  public function setVelocity()
  {
      if(movingDirection != "")
	{ TempLastPosition.x = xPos;TempLastPosition.y = yPos;UpdateIfNotCollied = true;}
      var speed = 8;
      if(movingDirection == "right")
	{direction="right"; vx = speed;vy = 0;}
      else if(movingDirection == "left")
	{direction="left";vx = -speed;vy = 0;}
      else if(movingDirection == "up")
	{direction="up"; vy = -speed;vx = 0;}
      else if(movingDirection == "down")
	{direction="down";vy = speed;vx = 0;}
      else
	{vx = 0; vy = 0;moving =0;}
  }


  public function hit()
  {
  if(invincble <= 0)
     {health--;  invincble = 10;}
  }
  //Rows and column that the object occupies
  public var mapColumn(get_mapColumn,set_mapColumn):Int;
  public function get_mapColumn():Int
  {
     _mapColumn = Math.floor((xPos + width * 0.5) / _maxTileSize);
     return _mapColumn;
  }
  public function set_mapColumn(value:Int):Int
  {
     _mapColumn = value;
     return _mapColumn;
  }

  public var mapRow(get_mapRow,set_mapRow):Int;
  public function get_mapRow():Int
  {
     _mapRow = Math.floor((yPos + height * 0.5) / _maxTileSize);
     return _mapRow;
  }
  public function set_mapRow(value:Int):Int
  {
     _mapRow = value;
     return _mapRow;
  }
  //Quick access to the tile's ID Float if you need it
  public var id(get_id,null):Int;
  public function get_id():Int
  {
    var id:Int = tileSheetColumn * 10 + tileSheetRow;
    return id;
  }
  //Top, bottom, left and right sides
  public var top(get_top,null):Int;
  public function get_top():Int
  {
     var top:Int = Math.floor(yPos / _maxTileSize);
     return top;
  }
  public var bottom(get_bottom,null):Int;
  public function get_bottom():Int
  {
     var bottom:Int = Math.floor((yPos + height) / _maxTileSize);
     return bottom;
  }
  public var left(get_left,null):Int;
  public function get_left():Int
  {
    
     var left:Int = Math.floor(xPos / _maxTileSize);
     return left;
  }
  public var right(get_right,null):Int;
  public function get_right():Int
  {
     var right:Int = Math.floor((xPos + width) / _maxTileSize);
     return right;
  }
  public var centerX(get_centerX,null):Int;
  public function get_centerX():Int
  {
     var centerX:Int = Math.floor((xPos + width * 0.5) / _maxTileSize);
     return centerX;
  }
  public var centerY(get_centerY,null):Int;
  public function get_centerY():Int
  {
     var centerY:Int = Math.floor((yPos + height * 0.5) / _maxTileSize);
     return centerY;
  }
}