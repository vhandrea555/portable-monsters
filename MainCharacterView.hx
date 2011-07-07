import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.events.MouseEvent;
import TileModel;
import MainCharacterController;
import flash.display.Shape;

import Images;

class MainCharacterView extends Sprite
{
  private var _model:TileModel;
  private var _controller:MainCharacterController;
  private var _stage:Dynamic;
  
  public function new
  (
    model:TileModel, 
    controller:MainCharacterController, 
    stage:Dynamic
  )
  {
    super();
    this._model = model;
    this._controller = controller;
    this._stage = stage;

   _model.addEventListener(Event.CHANGE, changeHandler);
    _stage.addEventListener
      (KeyboardEvent.KEY_DOWN,keyDownHandler);
    _stage.addEventListener
      (KeyboardEvent.KEY_UP,keyUpHandler);
     
//     _model.addEventListener
//       ("update", updateHandler);
    _stage.addEventListener
      (MouseEvent.MOUSE_DOWN, mouseDownHandler);
    _stage.addEventListener
      (MouseEvent.MOUSE_UP, mouseUpHandler);
      
  }
  
  private function keyDownHandler(event:KeyboardEvent)
  {
    _controller.processKeyDown(event);
  }
  private function keyUpHandler(event:KeyboardEvent)
  {
    _controller.processKeyUp(event);
  }  
  
  private function mouseUpHandler(event:MouseEvent)
  {
    _controller.processMouseUp(event);
  }
  private function mouseDownHandler(event:MouseEvent)
  {
    _controller.processMouseDown(event);
  }
  private function updateHandler(event:Event)
  {
    _controller.processUpdate(_stage);
  }

  private function changeHandler(event:Event)
  {


    if (_model.xPos + (_model.width) > stage.stageWidth)
	    {
	    _model.setX = stage.stageWidth - Std.int(_model.width);
	    _model.vx = 0;
	    }
	    else if (_model.xPos < 0)
	    {
		    _model.setX = 0 ;
		    _model.vx = 0;
	    }
	    if (_model.yPos < 0)
	    {
		    _model.setY = 0;
		    _model.vy = 0;
	    }
	    else if (_model.yPos + (_model.height) > 400)
	    {
		    _model.setY = 400 - Std.int(_model.height);
		    _model.vy = 0;
		    _model.jumping = false;
	    }
  }
}