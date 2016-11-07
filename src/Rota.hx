package;

import de.polygonal.ds.ArrayList;

class Rota{
  var rota:ArrayList<Cidade>;
  var fitness:Float = 0;
  var distancia:Float = 0;

  public function new(r:ArrayList<Cidade> = null){

    fitness = 0;
    distancia = 0;
    if(r == null){
      rota = new ArrayList<Cidade>();
      for(i in 0...Gerenciador.quantidade()){
        rota.add(null);
      }
    }else{
      rota = r;
    }
  }

  public function set_cidade(index:Int, c:Cidade):Void{
    rota.set(index, c);
  }

  public function get_cidade(i:Int):Cidade{
    return rota.get(i);
  }

  public function gerar_individuo():Void {

       for (index in 0...Gerenciador.quantidade()){

         set_cidade(index, Gerenciador.get(index));
       }
       rota.shuffle();

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
       fitness = 1/get_distancia();
     }
     return fitness;
   }

   public function contem_cidade(c:Cidade):Bool{
     return rota.contains(c);
   }



}
