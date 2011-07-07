import TileModel;
import VectorModel;

class TileCollisionController
{
  
  public function new()
  {
  }

  public function squareCollision
	(
	  gameObject:TileModel, 
	  gameObject2:TileModel
	):Bool
   { 
      var collided = false;			
      //Vector between rectangles
      var squareVector = new VectorModel();
      squareVector.update(gameObject.xPos, gameObject.yPos, gameObject2.xPos, gameObject2.yPos); 
      
      //Check whether the projection on the 
      //x axis (in this case the v0's vx) 
      //is less than the combined half widths
      if(squareVector.vx > -gameObject2.width && squareVector.vx <= 0 ||
	 squareVector.vx < gameObject.width && squareVector.vx >= 0)
      {
	//A collision might be occurring! Check the other 
	//projection on the y axis (v0's vy)
	if(squareVector.vy > -gameObject2.height && squareVector.vy <= 0 ||
	 squareVector.vy < gameObject.height && squareVector.vy >= 0)
	{
	  //A collision has ocurred.
	  collided = true;
	}
      }
      return collided;
	  
   } 

  public function tileModelCollision
	(
	  gameObject:TileModel, 
	  gameObject2:TileModel,
	  maxTileSize:Int,
	  bounceY:Float = 0,
	  bounceX:Float = 0,
	  offsetY:Float = 0,
	  offsetX:Float = 0
	)
   { 
      gameObject.jumping = true;
      //Variables needed to figure out by how much the object
      //is overlapping the tile on the x and y axis
      //The axis with the most overlap is the axis on which
      //the collision is occurring. This is an inverted SAT system
      var overlapX:Float;
      var overlapY:Float;
      //If the object's top left corner is overlapping the tile
      //on its upper left side...
      if(gameObject.top == gameObject2.centerY && gameObject.left ==  gameObject2.centerX)
      {
        //Figure out by how much the object's top left corner
        //point is overlapping the tile on both the x and y
        //axes. 

        overlapX = gameObject.xPos % maxTileSize;
        overlapY = gameObject.yPos % maxTileSize;
	

        if(overlapY >= overlapX)
        {

          if(gameObject.vy < 0
          && (gameObject.bottom != gameObject2.centerY &&
	      gameObject.left !=  gameObject2.centerX))
          {
            //Collision on top side of the object
            //Position the object to the bottom 
            //edge of the platform tile
            //which it is overlapping and set its vy to zero
            gameObject.setY = (gameObject.mapRow * maxTileSize);

	    gameObject.vy = -gameObject.vy * bounceY;
	  }
  
        }
        else
        {
          //Collision on left side of the object
          //Position the object to the right 
          //edge of the platform tile and set its vx to zero
          gameObject.setX 
            = gameObject.mapColumn * maxTileSize;
          if(gameObject.vx < 0){gameObject.vx = -gameObject.vx * bounceX;}
        }
	  gameObject.setY = gameObject.yPos+offsetY;
          gameObject.setX = gameObject.xPos+offsetX;
      }
      
      //If the object's bottom left corner is overlapping the tile
      //on its lower left side...

      if(gameObject.bottom == gameObject2.centerY &&
	      gameObject.left ==  gameObject2.centerX)
      {

        overlapX = gameObject.xPos % maxTileSize;     
        //Measure the y overlap from far left side of the tile
        //and compensate for the object's height
        overlapY 
          = maxTileSize 
          - ((gameObject.yPos + gameObject.height) % maxTileSize);
        if(overlapY + gameObject.gravity_Vy >= overlapX)
        {
          if(gameObject.vy > 0
          && (gameObject.top != gameObject2.centerY &&
	      gameObject.left !=  gameObject2.centerX))
          {
            //Collision on bottom
            gameObject.setY
              = (gameObject.mapRow * maxTileSize)
              + (maxTileSize - gameObject.height);
  		      gameObject.vy = -gameObject.vy * bounceY;
    		    gameObject.jumping = false;
		      }
        }
        else
        {
          //Collision on left
          gameObject.setX 
            = gameObject.mapColumn * maxTileSize;
	  if(gameObject.vx < 0){gameObject.vx = -gameObject.vx * bounceX;}
        }
	  gameObject.setY = gameObject.yPos-offsetY;
	  gameObject.setX = gameObject.xPos+offsetX;
      }
      
      //If the object's bottom right corner is overlapping the tile
      //on its lower right side...
      if( gameObject.bottom == gameObject2.centerY &&
	      gameObject.right ==  gameObject2.centerX)
      {
        //Measure the x and y overlap from the far right and bottom
        //side of the tile and compensate for the object's
        //height and width
        overlapX 
          = maxTileSize 
          - ((gameObject.xPos + gameObject.width) % maxTileSize);
        overlapY 
          = maxTileSize 
          - ((gameObject.yPos + gameObject.height) % maxTileSize);
        
        if(overlapY >= overlapX)
        {
          if(gameObject.vy > 0
          && (gameObject.top != gameObject2.centerY &&
	      gameObject.right !=  gameObject2.centerX))
          {
            //Collision on bottom
            gameObject.setY 
              = (gameObject.mapRow * maxTileSize)
              + (maxTileSize - gameObject.height);
  		      gameObject.vy = -gameObject.vy * bounceY;
    		    gameObject.jumping = false;
	  }
        }
        else
        {
          //Collision on right
          gameObject.setX 
            = (gameObject.mapColumn * maxTileSize)
            + ((maxTileSize - gameObject.width) - 1);
	  if(gameObject.vx > 0){ gameObject.vx = -gameObject.vx * bounceX;}
        }
	  gameObject.setX = gameObject.xPos-offsetX;
          gameObject.setY = gameObject.yPos-offsetY;
      }
      //If the object's top right corner is overlapping the tile
      //on its upper right side...
      if(      gameObject.top == gameObject2.centerY &&
	      gameObject.right ==  gameObject2.centerX)
      { 
        //Measure the x overlap from the far right side of the
        //tile and compensate for the object's width
        overlapX 
          = maxTileSize 
          - ((gameObject.xPos + gameObject.width) % maxTileSize);
        overlapY = gameObject.yPos % maxTileSize;
        
        if(overlapY >= overlapX)
        {
          if(gameObject.vy < 0
          &&
          gameObject.bottom != gameObject2.centerY &&
	      gameObject.right !=  gameObject2.centerX)
          {
            gameObject.setY = (gameObject.mapRow * maxTileSize);
	    gameObject.vy = -gameObject.vy * bounceY;
	  }
        }
        else
        {
          //Collision on right
          gameObject.setX 
            = (gameObject.mapColumn * maxTileSize)
            + ((maxTileSize - gameObject.width) - 1);
	  if(gameObject.vx > 0){gameObject.vx = -gameObject.vx * bounceX;}
        }
	  gameObject.setY = gameObject.yPos+offsetY;
          gameObject.setX = gameObject.xPos-offsetX;
      }
    } 



  public function platformCollision
	(
	  gameObject:TileModel, 
	  platformMap:Array<Array<Int>>, 
	  maxTileSize:Int,
	  platform:Int,
	  bounceY:Float = 0,
	  bounceX:Float = 0,
	  offsetY:Float = 0,
	  offsetX:Float = 0
	)
   { 
      gameObject.jumping = true;
      //Variables needed to figure out by how much the object
      //is overlapping the tile on the x and y axis
      //The axis with the most overlap is the axis on which
      //the collision is occurring. This is an inverted SAT system
      var overlapX:Float;
      var overlapY:Float;
      //If the object's top left corner is overlapping the tile
      //on its upper left side...
      if(platformMap[gameObject.top][gameObject.left] == platform)
      {
        //Figure out by how much the object's top left corner
        //point is overlapping the tile on both the x and y
        //axes. 

        overlapX = gameObject.xPos % maxTileSize;
        overlapY = gameObject.yPos % maxTileSize;
	

        if(overlapY >= overlapX)
        {

          if(gameObject.vy < 0
          && platformMap[gameObject.bottom][gameObject.left] 
          != platform)
          {
            //Collision on top side of the object
            //Position the object to the bottom 
            //edge of the platform tile
            //which it is overlapping and set its vy to zero
            gameObject.setY = (gameObject.mapRow * maxTileSize);

	    gameObject.vy = -gameObject.vy * bounceY;
	  }
  
        }
        else
        {
          //Collision on left side of the object
          //Position the object to the right 
          //edge of the platform tile and set its vx to zero
          gameObject.setX 
            = gameObject.mapColumn * maxTileSize;
          if(gameObject.vx < 0){gameObject.vx = -gameObject.vx * bounceX;}
        }
	  gameObject.setY = gameObject.yPos+offsetY;
          gameObject.setX = gameObject.xPos+offsetX;
      }
      
      //If the object's bottom left corner is overlapping the tile
      //on its lower left side...

      if(platformMap[gameObject.bottom][gameObject.left] == platform)
      {

        overlapX = gameObject.xPos % maxTileSize;     
        //Measure the y overlap from far left side of the tile
        //and compensate for the object's height
        overlapY 
          = maxTileSize 
          - ((gameObject.yPos + gameObject.height) % maxTileSize);
        if(overlapY + gameObject.gravity_Vy >= overlapX)
        {
          if(gameObject.vy > 0
          && platformMap[gameObject.top][gameObject.left] 
          != platform)
          {
            //Collision on bottom
            gameObject.setY
              = (gameObject.mapRow * maxTileSize)
              + (maxTileSize - gameObject.height);
  		      gameObject.vy = -gameObject.vy * bounceY;
    		    gameObject.jumping = false;
		      }
        }
        else
        {
          //Collision on left
          gameObject.setX 
            = gameObject.mapColumn * maxTileSize;
	  if(gameObject.vx < 0){gameObject.vx = -gameObject.vx * bounceX;}
        }
	  gameObject.setY = gameObject.yPos-offsetY;
	  gameObject.setX = gameObject.xPos+offsetX;
      }
      
      //If the object's bottom right corner is overlapping the tile
      //on its lower right side...
      if(platformMap[gameObject.bottom][gameObject.right] 
        == platform)
      {
        //Measure the x and y overlap from the far right and bottom
        //side of the tile and compensate for the object's
        //height and width
        overlapX 
          = maxTileSize 
          - ((gameObject.xPos + gameObject.width) % maxTileSize);
        overlapY 
          = maxTileSize 
          - ((gameObject.yPos + gameObject.height) % maxTileSize);
        
        if(overlapY >= overlapX)
        {
          if(gameObject.vy > 0
          && platformMap[gameObject.top][gameObject.right] 
          != platform)
          {
            //Collision on bottom
            gameObject.setY 
              = (gameObject.mapRow * maxTileSize)
              + (maxTileSize - gameObject.height);
  		      gameObject.vy = -gameObject.vy * bounceY;
    		    gameObject.jumping = false;
	  }
        }
        else
        {
          //Collision on right
          gameObject.setX 
            = (gameObject.mapColumn * maxTileSize)
            + ((maxTileSize - gameObject.width) - 1);
	  if(gameObject.vx > 0){ gameObject.vx = -gameObject.vx * bounceX;}
        }
	  gameObject.setX = gameObject.xPos-offsetX;
          gameObject.setY = gameObject.yPos-offsetY;
      }
      //If the object's top right corner is overlapping the tile
      //on its upper right side...
      if(platformMap[gameObject.top][gameObject.right] 
        == platform)
      { 
        //Measure the x overlap from the far right side of the
        //tile and compensate for the object's width
        overlapX 
          = maxTileSize 
          - ((gameObject.xPos + gameObject.width) % maxTileSize);
        overlapY = gameObject.yPos % maxTileSize;
        
        if(overlapY >= overlapX)
        {
          if(gameObject.vy < 0
          && platformMap[gameObject.bottom][gameObject.right] 
          != platform)
          {
            gameObject.setY = (gameObject.mapRow * maxTileSize);
	    gameObject.vy = -gameObject.vy * bounceY;
	  }
        }
        else
        {
          //Collision on right
          gameObject.setX 
            = (gameObject.mapColumn * maxTileSize)
            + ((maxTileSize - gameObject.width) - 1);
	  if(gameObject.vx > 0){gameObject.vx = -gameObject.vx * bounceX;}
        }
	  gameObject.setY = gameObject.yPos+offsetY;
          gameObject.setX = gameObject.xPos-offsetX;
      }
    } 


//Collision with anything on the map
public function platformCollisionAnything
	(
	  gameObject:TileModel, 
	  platformMap:Array<Array<Int>>, 
	  maxTileSize:Int,
	  bounceY:Float = 0,
	  bounceX:Float = 0,
	  offsetY:Float = 0,
	  offsetX:Float = 0
	)
   { 
      gameObject.jumping = true;
      //Variables needed to figure out by how much the object
      //is overlapping the tile on the x and y axis
      //The axis with the most overlap is the axis on which
      //the collision is occurring. This is an inverted SAT system
      var overlapX:Float;
      var overlapY:Float;
      //If the object's top left corner is overlapping the tile
      //on its upper left side...
      if(platformMap[gameObject.top][gameObject.left] >= 0)
      {
        //Figure out by how much the object's top left corner
        //point is overlapping the tile on both the x and y
        //axes. 
	
        overlapX = gameObject.xPos % maxTileSize;
        overlapY = gameObject.yPos % maxTileSize;
        if(overlapY >= overlapX)
        {
          if(gameObject.vy < 0
          && platformMap[gameObject.bottom][gameObject.left] 
          <= -1)
          {
            //Collision on top side of the object
            //Position the object to the bottom 
            //edge of the platform tile
            //which it is overlapping and set its vy to zero
            gameObject.setY = (gameObject.mapRow * maxTileSize);

	    gameObject.vy = -gameObject.vy * bounceY;
	  }
  
        }
        else
        {
          //Collision on left side of the object
          //Position the object to the right 
          //edge of the platform tile and set its vx to zero
          gameObject.setX 
            = gameObject.mapColumn * maxTileSize;
          if(gameObject.vx < 0){gameObject.vx = -gameObject.vx * bounceX;}
        }
      }
      
      //If the object's bottom left corner is overlapping the tile
      //on its lower left side...

      if(gameObject.bottom < platformMap.length && platformMap[gameObject.bottom][gameObject.left] >= 0)
      {

        overlapX = gameObject.xPos % maxTileSize;     
        //Measure the y overlap from far left side of the tile
        //and compensate for the object's height
        overlapY 
          = maxTileSize 
          - ((gameObject.yPos + maxTileSize) % maxTileSize);
        if(overlapY + gameObject.gravity_Vy >= overlapX)
        {
          if(gameObject.vy > 0
          && platformMap[gameObject.top][gameObject.left] 
          <= -1)
          {
            //Collision on bottom
            gameObject.setY
              = (gameObject.mapRow * maxTileSize)
              + (maxTileSize - maxTileSize);
  		      gameObject.vy = -gameObject.vy * bounceY;
    		    gameObject.jumping = false;
		      }
        }
        else
        {
          //Collision on left
          gameObject.setX 
            = gameObject.mapColumn * maxTileSize;
	  if(gameObject.vx < 0){gameObject.vx = -gameObject.vx * bounceX;}
        }
      }
      
      //If the object's bottom right corner is overlapping the tile
      //on its lower right side...
      if(gameObject.bottom < platformMap.length && platformMap[gameObject.bottom][gameObject.right] 
        >= 0)
      {
        //Measure the x and y overlap from the far right and bottom
        //side of the tile and compensate for the object's
        //height and width
        overlapX 
          = maxTileSize 
          - ((gameObject.xPos + gameObject.width) % maxTileSize);
        overlapY 
          = maxTileSize 
          - ((gameObject.yPos + gameObject.height) % maxTileSize);
        
        if(overlapY >= overlapX)
        {
          if(gameObject.vy > 0
          && platformMap[gameObject.top][gameObject.right] 
          <= -1)
          {
            //Collision on bottom
            gameObject.setY 
              = (gameObject.mapRow * maxTileSize)
              + (maxTileSize - gameObject.height);
  		      gameObject.vy = -gameObject.vy * bounceY;
    		    gameObject.jumping = false;
	  }
        }
        else
        {
          //Collision on right
          gameObject.setX 
            = (gameObject.mapColumn * maxTileSize)
            + ((maxTileSize - gameObject.width));
	  if(gameObject.vx > 0){ gameObject.vx = -gameObject.vx * bounceX;}
        }
      }
      //If the object's top right corner is overlapping the tile
      //on its upper right side...
      if(platformMap[gameObject.top][gameObject.right] 
        >= 0)
      { 
        //Measure the x overlap from the far right side of the
        //tile and compensate for the object's width
        overlapX 
          = maxTileSize 
          - ((gameObject.xPos + gameObject.width) % maxTileSize);
        overlapY = gameObject.yPos % maxTileSize;
        
        if(overlapY >= overlapX)
        {
          if(gameObject.bottom < platformMap.length && gameObject.vy < 0
          && platformMap[gameObject.bottom][gameObject.right] 
          <= -1)
          {
            gameObject.setY = (gameObject.mapRow * maxTileSize);
	    gameObject.vy = -gameObject.vy * bounceY;
	  }
        }
        else
        {
          //Collision on right
          gameObject.setX 
            = (gameObject.mapColumn * maxTileSize)
            + ((maxTileSize - gameObject.width));
	  if(gameObject.vx > 0){gameObject.vx = -gameObject.vx * bounceX;}
        }
      }
    } 




//Collision with anything on the map
public function platformAnythingNoCollision 
	(
	  gameObject:TileModel, 
	  platformMap:Array<Array<Int>>, 
	  maxTileSize:Int
	) : Int
   { 
      var ID:Int = -1;
      if(platformMap[gameObject.centerY][gameObject.centerX] >= 0)
      {
	  ID = platformMap[gameObject.top][gameObject.left];
      }
      return ID;
      
    } 


  //roundTile collisions
  public function roundTileCollision
    (
      gameObject:TileModel, 
      roundTile_X:Int, 
      roundTile_Y:Int,
      tileRadius:Float
    ):Bool
  {
    var _v0:VectorModel = new VectorModel( gameObject.xPos, gameObject.yPos,roundTile_X,roundTile_Y);
    //Find the voronoi region
    var region:String = "";
    
    //Is the circle above the rectangle's top edge?
    if(roundTile_Y < gameObject.yPos - gameObject.height * 0.5)
    {
      //If it is, we need to check whether it's in the 
      //top left, top center or top right
      if(roundTile_X < gameObject.xPos - gameObject.width * 0.5)
      {
	region = "topLeft";
      }
      else if (roundTile_X > gameObject.xPos + gameObject.width * 0.5)
      {
	region = "topRight";
      }
      else
      {
	region = "topMiddle";
      }
    }
    //The circle isn't above the top edge, so it might be 
    //below the bottom edge
    else if (roundTile_Y > gameObject.yPos + gameObject.height * 0.5)
    {
      //If it is, we need to check whether it's in the 
      //bottom left, bottom center or bottom right
      if(roundTile_X < gameObject.xPos - gameObject.width * 0.5)
      {
	region = "bottomLeft";
      }
      else if (roundTile_X > gameObject.xPos + gameObject.width * 0.5)
      {
	region = "bottomRight";
      }
      else
      {
	region = "bottomMiddle";
      }
    }
    //The circle isn't above the top edge or below the bottom
    //edge so it must be on the left or right side
    else
    {
      if(roundTile_X < gameObject.xPos - gameObject.width * 0.5)
      {
	region = "leftMiddle";
      }
      else
      {
	region = "rightMiddle";
      }
    }
    var collision = false;
    //If the circle is in the topMiddle, 
    //bottomMiddle, leftMiddle or rightMiddle
    //perform the standard check for overlaps as you would
    //with a rectangle
    
      if(region == "topMiddle"
      || region == "bottomMiddle"
      || region == "leftMiddle"
      || region == "rightMiddle")
      {
      //Check whether the projection on 
      //the x axis (in this case the v0's vx) 
      //is less than the combined half widths
      if(Math.abs(_v0.vx) < tileRadius + gameObject.width * 0.5)
      {
	//A collision might be occurring! Check the other 
	//projection on the y axis (v0's vy)
	
	if(Math.abs(_v0.vy) < tileRadius + gameObject.height * 0.5)
	{
	  //A collision has occurred
	  
	  //Find out the size of the overlap on both the X and Y axis
	  var overlap_X:Float 
	    = tileRadius 
	    + gameObject.width * 0.5 
	    - Math.abs(_v0.vx);
	    
	  var overlap_Y:Float
	    = tileRadius
	    + gameObject.height * 0.5 
	    - Math.abs(_v0.vy);
	  
	  //The collision has occurred on the axis with the
	  //*smallest* amount of overlap. Let's figure out which
	  //axis that is
	  
	  if(overlap_X >=  overlap_Y)
	  {
	    collision = true;
	    //The collision is happening on the X axis
	    //But on which side? v0's vy can tell us 
	    if(_v0.vy > 0)
	    {
	      //collisionSide = "Top";
	    }
	    else
	    {
	      //collisionSide = "Bottom";
	    }                                  
	  }
	  else
	  {
	      
	    collision = true;
	    //The collision is happening on the Y axis
	    //But on which side? v0's vx can tell us 
	    if(_v0.vx > 0)
	    {
	      //CollisionSide = "Left";
	    }
	    else
	    {
	      //collisionSide = "Right";
	    }
	  }
	}
	else
	{
	  //"No collision";
	}
      }
      else
      {
	//"No collision";
      }
      
    }

     		//The circle isn't in danger of intersecting 
		//with any of the rectangle's planes,
		//so it has to be closer to one of the four corners
		//The checkCornerCollision method does the 
		//work of the collision detection
		//It takes four arguments:
		//1. The CircleModel object
		//2. The x position of the corner
		//3. The y position of the corner
		//4. The bounce multiplier which 
		//determines the amount of "bouncines"
		
		if(region == "topLeft")
		{
		  var cornerV0 = new VectorModel
		    (
		    roundTile_X,
		    roundTile_Y,
		    gameObject.xPos - gameObject.width * 0.5,
		    gameObject.yPos - gameObject.height * 0.5
		    );

		    if(cornerV0.m < tileRadius)
		    {
		     collision = true;
		    }
		}
		else if(region == "topRight")
		{
		  var cornerV0 = new VectorModel
		    (
		    roundTile_X,
		    roundTile_Y,
		    gameObject.xPos + gameObject.width * 0.5,
		    gameObject.yPos - gameObject.height * 0.5
		    );

		    if(cornerV0.m < tileRadius)
		    {
		      collision = true;
		    }
		}
		else if(region == "bottomLeft")
		{
		  var cornerV0 = new VectorModel
		    (
		    roundTile_X,
		    roundTile_Y,
		    gameObject.xPos - gameObject.width * 0.5,
		    gameObject.yPos +gameObject.height * 0.5
		    );

		    if(cornerV0.m < tileRadius)
		    {
		      collision = true;
		    }
		}
		else if(region == "bottomRight")
		{
		  var cornerV0 = new VectorModel
		    (
		    roundTile_X,
		    roundTile_Y,
		    gameObject.xPos+gameObject.width * 0.5,
		    gameObject.yPos +gameObject.height * 0.5
		    );

		    if(cornerV0.m < tileRadius)
		    {
		      collision = true;
		    }
		}
   return collision;
  }

}