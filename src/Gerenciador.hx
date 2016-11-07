package;

class Gerenciador{

  static var cidades:Array<Cidade> = new Array<Cidade>();

  static public function add(c:Cidade):Void{
    cidades.push(c);
  }

  static public function get(i:Int):Cidade{
    return cidades[i];
  }

  static public function quantidade():Int{
    return cidades.length;
  }

  static public function trace():String{
    var s:String = "";
    for (c in cidades){
      s += "> x:"+ c.get_x() +" y:"+ c.get_y() +"<";
    }
    return s;
  }

}
