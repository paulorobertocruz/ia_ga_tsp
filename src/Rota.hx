package;

class Rota{

  var rota:Array<Cidade> = new Array<Cidade>();

  var fitness:Float = 0;

  var distancia:Float = 0;

  public function new(){

    for(i in 0...Gerenciador.quantidade()){
      rota.push(null);
    }
    // trace("new Rota");
    // trace("Cidades: " + rota.length);
    // trace(rota);
  }

  public function set_cidade(index:Int, c:Cidade):Void{
    rota[index] = c;
  }

  public function get_cidade(i:Int):Cidade{
    // trace("tamanho_rota: " + quantidade_cidades());
    return rota[i];
  }

  public function gerar_individuo():Void {

       for (index in 0...Gerenciador.quantidade()){
         set_cidade(index, Gerenciador.get(index));
       }
       rota = RandomArrayTools.shuffle(rota);
      //  trace("new Rota");
      //  trace("Cidades: " + rota.length);
      //  for( i in 0...rota.length){
      //    trace(rota[i]);
      //  }
   }

   public function quantidade_cidades():Int{
     return rota.length;
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
     return rota.indexOf(c) > 0;
   }

   public function toString():String{
     var str:String = "{";
     for (i in 0...rota.length){
       str += "["+i+":"+ rota[i]+"]";
     }
     return str;
   }

}
