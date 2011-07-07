import flash.geom.Point;
import flash.events.Event;
import flash.events.EventDispatcher;

class VectorModel extends EventDispatcher
{
//Start and end points for the main vector
  private var _a:Point;
  private var _b:Point;
  private var _vx:Float;
  private var _vy:Float;
  
  public function new
    (
      startX:Float = 0, startY:Float = 0, 
      endx:Float = 0, endy:Float = 0,
      newVx:Float = 0, 
      newVy:Float = 0
    )
  {
    super();
    _a = new Point(0, 0);
    _b = new Point(0, 0);
   _vx = 0; _vy= 0;
    update(startX, startY, endx, endy, newVx, newVy);
  }
  public function update
    (
      ?startX:Float = 0, 
      ?startY:Float = 0, 
      ?endx:Float = 0, 
      ?endy:Float = 0,
      ?newVx:Float = 0, 
      ?newVy:Float = 0
    )
  {
    if(newVx == 0 && newVy == 0)
    {
      _a.x = startX;
      _a.y = startY;
      _b.x = endx;
      _b.y = endy;
      dispatchEvent(new Event(Event.CHANGE));
    }
	  else
  {
    _vx = newVx;
      _vy = newVy;
      dispatchEvent(new Event(Event.CHANGE));
  }
  }
  
  //Start point
  public var a(getA,null):Point;
  public function getA():Point
  {
      return _a;
  }
  
  //End point
  public var b(getB,null):Point;
  public function getB():Point
  {
      return _b;
  }


  public var slope(getSlope,null):Float;
  public function getSlope():Float
  {
    return vy/vx;
  }
  
  public var y_intercept(getY_intercept,null):Float;
  public function getY_intercept():Float
  {
   return (_b.y) - slope*(_b.x);
  }
  
  //vx
  public var vx(getVx,null):Float;
  public function getVx():Float
  {
    if(_vx == 0)
    {
      return _b.x - _a.x;
    }
    else
    {
      return _vx;
    }
  }
  
  //vy
  public var vy(getVy,null):Float;
  public function getVy():Float
  {
    if(_vy == 0)
    {
      return _b.y - _a.y;
    }
    else
    {
      return _vy;
    }
  }
  
  //angle (degrees)
  public var angle(getAngle,null):Float;
  public function getAngle():Float
  {
    var angle_Radians:Float = Math.atan2(vy, vx);
    var angle_Degrees:Float = angle_Radians * 180 / Math.PI;
    return angle_Degrees;
  }
  
  //magnitude (length)
  public var m(getM,null):Float;
  public function getM():Float
  {
    if(vx != 0 || vy != 0)
    {
      var magnitude:Float = Math.sqrt(vx * vx + vy * vy);
      return magnitude;
    }
    else
    {
      return 0.001;
    }
  }
  public var ln(get_ln,null):VectorModel;
  //Left normal VectorModel object
  public function get_ln():VectorModel
  {
    
    var leftNormal:VectorModel = new VectorModel();

    if(_vx == 0
    && _vy == 0)
    {
      leftNormal.update
      (
	a.x, a.y, 
      (a.x + this.lx), 
      (a.y + this.ly)
      );
    }
    else
    {
      leftNormal.update(0, 0, 0, 0, vx, vy);
    }  
    
    return leftNormal;                 
  }
  
  //Right normal VectorModel object
  public var rn(get_rn,null):VectorModel;
  public function get_rn():VectorModel
  {
    
    var rightNormal:VectorModel = new VectorModel();
    
    if(_vx == 0
    && _vy == 0)
    {
      rightNormal.update
      (
      a.x, a.y, 
      (a.x + this.rx), 
      (a.y + this.ry)
      );
    }
    else
    {
      rightNormal.update(0, 0, 0, 0, vx, vy);
    }  
    return rightNormal;                 
  }
  
  //Right hand normal x component
  public var rx(get_rx,null):Float;
  public function get_rx():Float
  {
    var rx:Float = -vy;
    return rx;
  }
  
  //Right hand normal y component
  public var ry(get_ry,null):Float;
  public function get_ry():Float
  {
    var ry:Float = vx;
    return ry;
  }
  
  //Left hand normal x component
  public var lx(get_lx,null):Float;
  public function get_lx():Float
  {
    var lx:Float = vy;
    return lx;
  }
  
  //Left hand normal y component
  public var ly(get_ly,null):Float;
  public function get_ly():Float
  {
      var ly:Float = -vx;
      return ly;
  }
  
  //Normalized vector
  //The code needs to make sure that
  //the length value isn't zero to avoid
  //returning NaN
  public var dx(get_dx,null):Float;
  public function get_dx():Float
  {
    if(m != 0)
    {
      var dx:Float = vx / m;
      return dx;
    }
    else
    {
      return 0.001;
    }
  }

  public var dy(get_dy,null):Float;
  public function get_dy():Float
  {
    if(m != 0)
    {
      var dy:Float = vy / m;
      return dy;
    }
    else
    {
      return 0.001;
    }  
  }
}