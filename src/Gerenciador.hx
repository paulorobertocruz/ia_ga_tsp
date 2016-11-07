package;

import de.polygonal.ds.ArrayList;

class Gerenciador{

  static var cidades:ArrayList<Cidade> = new ArrayList<Cidade>();

  static public function add(c:Cidade):Void{
    cidades.add(c);
  }

  static public function get(i:Int):Cidade{
    return cidades.get(i);
  }

  static public function quantidade():Int{
    return cidades.size;
  }

  static public function trace():String{
    var s:String = "";
    for (c in cidades){
      s += "> x:"+ c.get_x() +" y:"+ c.get_y() +"<";
    }
    return s;
  }

}
