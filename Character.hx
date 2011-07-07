import flash.geom.Point;

//To Be impemented.
class Character extends TileModel
{
  public var ID:Int;
  public var TalkedTo:Int;
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
    super(maxTileSize,tileSheetColumn,tileSheetRow,mapRow,mapColumn,width,height,
	  ImageIsSprite,ImageHeight,ImageWidth,ImageX,ImageY);
    TalkedTo = 0;
  }

}