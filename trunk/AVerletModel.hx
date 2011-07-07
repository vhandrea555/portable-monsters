import flash.events.Event;
import flash.events.EventDispatcher;

//ABSTRACT CLASS - Do not instantiate
class AVerletModel extends EventDispatcher
{
    //Properties that don't require validation
  public var previousX:Float;
  public var previousY:Float;
  public var temporaryX:Float;
  public var temporaryY:Float;
  public var rotationSpeed:Float;
  public var acceleration_X:Float;
  public var acceleration_Y:Float;
  public var acceleration:Float;
  static public var frictionConstant:Float = 0.96; //Global friction
  public var friction:Float;
  public var friction_Vx:Float;
  public var friction_Vy:Float;
  public var width:Int;
  public var height:Int;
  public var gravity_Vx:Float;
  public var gravity_Vy:Float;
  public var color:Int;
  
  //Properties that require validation
  //by getters and setters
  private var _xPos:Float;
  private var _yPos:Float;
  private var _angle:Float;
  private var _visible:Bool;
  private var _rotationValue:Float;

  public function new() 
  {
super();
previousX = 0;
previousY = 0;
temporaryX = 0;
temporaryY = 0;
rotationSpeed = 0;
acceleration_X = 0;
acceleration_Y = 0;
acceleration = 0;
friction = frictionConstant;
friction_Vx = 0;
friction_Vy = 0;
width = 1;
height = 1;
gravity_Vx = 0;
gravity_Vy = 0;
color = 0x999999;
  
  //Properties that require validation
  //by getters and setters
_xPos = 0;
_yPos = 0;
_angle = 0;
_visible = true;
_rotationValue = 0;
  }
  public function update()
  {

    temporaryX = xPos;
    temporaryY = yPos;
    
    vx += acceleration_X;
    vy += acceleration_Y;
    
    vx *= friction;
    vy *= friction;
    
    //Optional: speed trap
    /*
    if((Math.abs(vx) < 0.05) && (Math.abs(vy) < 0.05))
    {
      _acceleration_X = 0;
      _acceleration_Y = 0;
    }
    */
      
    xPos += vx + friction_Vx + gravity_Vx;
    yPos += vy + friction_Vy + gravity_Vy;
    
    previousX = temporaryX;
    previousY = temporaryY;
    
    //Listen for optional "update" events if you need to
    //syncrchonize any code with this object's frame updates
    dispatchEvent(new Event("update"));
  }

  public function destory()
  {
    dispatchEvent(new Event("destory"));
  }
  
  //angle
  public var angle(getangle,setangle):Float;
  public function getangle():Float
  {
    return _angle;
  }
  public function setangle(value:Float):Float
  {
    _angle = value;
    dispatchEvent(new Event(Event.CHANGE));
    return _angle;
  }
  
  //vx
  public var vx(getVx,setVx):Float;
  public function getVx():Float
  {
    return _xPos - previousX;
  }
  public function setVx(value:Float)
  {
    previousX = _xPos - value;
    return previousX;
  }
  
  //vy
  public var vy(getVy,setVy):Float;
  public function getVy():Float
  {
    return _yPos - previousY;
  }
  public function setVy(value:Float):Float
  {
    previousY = _yPos - value;
    return previousY;
  }
  
  //xPos
  public var xPos(getxPos,setxPos):Float;
  public function getxPos():Float
  {
    return _xPos;
  }
  public function setxPos(value:Float):Float
  {
    _xPos = value;
    dispatchEvent(new Event(Event.CHANGE));
    return _xPos;
  }
  
  //yPos
  public var yPos(getyPos,setyPos):Float;
  public function getyPos():Float
  {
    return _yPos;
  }
  public function setyPos(value:Float):Float
  {
    _yPos = value;
    dispatchEvent(new Event(Event.CHANGE));
    return _yPos;
  }
  
  //setX
  public var setX(null,setsetX):Float;
  public function setsetX(value:Float):Float
  {
    previousX = value - vx;
    xPos = value;
    return xPos;
  }
  
  //setY
  public var setY(null,setsetY):Float;
  public function setsetY(value:Float):Float
  {
    previousY = value - vy;
    yPos = value;
    return yPos;
  }
  
  //visible
  public var visible(getVisible,setVisible):Bool;
  public function getVisible():Bool
  {
    return _visible;
  }
  public function setVisible(value:Bool):Bool
  {
    _visible = value;
    dispatchEvent(new Event(Event.CHANGE));
    return _visible;
  }
  
  //rotationValue
  public var rotationValue(getrotationValue,setrotationValue):Float;
  public function getrotationValue():Float
  {
    return _rotationValue;
  }
  public function setrotationValue(value:Float):Float
  {
    _rotationValue = value;
    if(_rotationValue > 360)
    {
      _rotationValue = 0;
    }
    return _rotationValue;
  }
}
