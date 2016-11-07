package;

class Cidade{

  var x:Int;
  var y:Int;

  public function new(X:Int, Y:Int){
    x = X;
    y = Y;
  }

  public function get_x():Int{
    return x;
  }

  public function get_y():Int{
    return y;
  }

  public function distanciaPara(b:Cidade):Float{
    var dx = Math.abs( x - b.get_x() );
    var dy = Math.abs( y - b.get_y() );
    return Math.sqrt( (dx * dx) + (dy * dy) );
  }

}
