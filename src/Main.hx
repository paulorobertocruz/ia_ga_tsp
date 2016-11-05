package;

import de.polygonal.ds.ArrayList;

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

}

class Rota{
  var rota:ArrayList<Cidade>;

  var fitness:Float;
  var distancia:Float;


  public function new(){
    rota = new ArrayList<Cidade>();
    fitness = 0;
    distancia = 0;
  }

  public function init_vazio() : Void {
    for(i in 0...Gerenciador.quantidade()){
      rota.add(null);
    }
  }

  public function init_copia(r:ArrayList<Cidade>):Void{
    rota = r;
  }

  public function set_cidade(index:Int, c:Cidade):Void{
    //ficar atento porque isso pode não funcionar
    rota.set(index, c);
  }

  public function get_cidade(i:Int):Cidade{
    return rota.get(i);
  }

  public function gerar_individuo():Void {

       for (index in 0...Gerenciador.quantidade()){
         set_cidade(index, Gerenciador.get(index));
       }
       //ordem ramdomica na rota       
   }

   public function quantidade_cidades():Int{
     return rota.size;
   }

   public function get_distancia():Float{

     if(distancia == 0){
       var d:Float = 0;
       for (c in 0...quantidade_cidades()){

         var ca:Cidade = get_cidade(c);
         var ct:Cidade;

         if(c+1 < quantidade_cidades()){
           ct = get_cidade(c+1);
         }else{
           ct = get_cidade(0);
         }

         d += ca.distanciaPara(ct);

       }

       distancia = d;
     }

     return distancia;
   }

   public function get_fitness():Float{
     if(fitness == 0){
       return 1/get_distancia();
     }
     return fitness;
   }

   public function contem_cidade(c:Cidade):Bool{     
     return rota.contains(c);
   }

   //implementar função de string para verificar o resultado?
   // ou implementar o output visual logo?
}

class Populacao{

}

class GA{

}




class Main{
  static public function main():Void{
      trace("GA TSA");
        var c :Cidade = new Cidade(60, 200);
        Gerenciador.add(c);
        var c2 :Cidade = new Cidade(180, 200);
        Gerenciador.add(c2);
        var c3 :Cidade = new Cidade(80, 180);
        Gerenciador.add(c3);
        var c4 :Cidade = new Cidade(140, 180);
        Gerenciador.add(c4);
        var c5 :Cidade = new Cidade(20, 160);
        Gerenciador.add(c5);
        var c6 :Cidade = new Cidade(100, 160);
        Gerenciador.add(c6);
        var c7 :Cidade = new Cidade(200, 160);
        Gerenciador.add(c7);
        var c8 :Cidade = new Cidade(140, 140);
        Gerenciador.add(c8);
        var c9 :Cidade = new Cidade(40, 120);
        Gerenciador.add(c9);
        var c10:Cidade  = new Cidade(100, 120);
        Gerenciador.add(c10);
        var c11:Cidade  = new Cidade(180, 100);
        Gerenciador.add(c11);
        var c12:Cidade  = new Cidade(60, 80);
        Gerenciador.add(c12);
        var c13:Cidade  = new Cidade(120, 80);
        Gerenciador.add(c13);
        var c14:Cidade  = new Cidade(180, 60);
        Gerenciador.add(c14);
        var c15:Cidade  = new Cidade(20, 40);
        Gerenciador.add(c15);
        var c16:Cidade  = new Cidade(100, 40);
        Gerenciador.add(c16);
        var c17:Cidade  = new Cidade(200, 40);
        Gerenciador.add(c17);
        var c18:Cidade  = new Cidade(20, 20);
        Gerenciador.add(c18);
        var c19:Cidade  = new Cidade(60, 20);
        Gerenciador.add(c19);
        var c20:Cidade  = new Cidade(160, 20);
        Gerenciador.add(c20);



  }
}
