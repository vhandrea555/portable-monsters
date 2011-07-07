import flash.geom.Point;

class EnemyTrainer extends Trainer
{
  public var Battled:Bool;
  public var Model:TileModel;
  public var ID:Int;
  public var SightMap:List<Point>;
  public function new(inModel:TileModel)
  {
    super();
    Battled = false;
    Model = inModel;
    SightMap = new List<Point>();
  }


}