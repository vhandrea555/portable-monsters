import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.events.MouseEvent;
import flash.events.Event;
import AVerletModel;
import TileModel;

class MainCharacterController 
{
  static private var EASING:Float = .2;
  static private var JUMP_FORCE:Float = -25;
  static private var SPEED_LIMIT:Float = 100;
  private var _model:TileModel;
  private var _stage:Dynamic;
  private var _mouse_Vx:Float;
  private var _mouse_Vy:Float;
  private var mKeyDown:Array<Bool>;

  public function new(model:TileModel)
  {
    _model = model;
    _mouse_Vx =0;_mouse_Vy = 0;
    mKeyDown = [];
  }
  public function processKeyDown(event:KeyboardEvent)
  {
    mKeyDown[event.keyCode] = true;
    //var speed = 64;
    _model.friction = 1;
    if(_model.moving == 0)
      {
	_model.moving = 1;
      }
    getMovement();

  }
  
  public function ManualMovement(Direction:String)
  {
    _model.friction = 1;
    if(_model.moving == 0)
      {
	_model.moving = 1;
      }
    _model.movingDirection = Direction;

  }

  public function getMovement()
  {
    if(mKeyDown[Keyboard.LEFT])
    {
      _model.movingDirection = "left";
      //_model.vx -= 1;
    }
    else if(mKeyDown[Keyboard.RIGHT])
    {
      _model.movingDirection = "right";
      //_model.vx += 1;
    }
    else if(mKeyDown[Keyboard.UP])
    {
      _model.movingDirection = "up";
    }
    else if(mKeyDown[Keyboard.DOWN])
    {
      _model.movingDirection = "down";
    }
    else
    {
      _model.movingDirection = "";
    }
  }
  
  public function processKeyUp(event:KeyboardEvent)
  {
    mKeyDown[event.keyCode] = false;
    getMovement();
  }
  
  public function processUpdate
    (stage:Dynamic)
  {
    var vx:Float;
    
    if(_model.coordinateSpace == null)
    {
      vx
        = stage.mouseX
        - (_model.xPos + _model.width * 0.5);
    }
    else
    {
      vx
        = _model.coordinateSpace.mouseX
        - (_model.xPos + _model.width * 0.5);
    }
  
    if(vx < -SPEED_LIMIT)
    {  
      vx = -SPEED_LIMIT;
    }
    if(vx > SPEED_LIMIT)
    {  
      vx = SPEED_LIMIT;
    }
    _model.vx = vx * EASING;
  }
  
  public function processMouseDown
    (event:MouseEvent)
  {
    // trace("y = " + m + "x +" + b);
  }

  public function processMouseUp
    (event:MouseEvent)
  {
    // trace("y = " + m + "x +" + b);
  }
  
  public function jump()
  {
    if(!_model.jumping)
    {
      _model.jumping = true;
      _model.vy += JUMP_FORCE;
    }
  }
}