package;

class Populacao{
  var rotas:Array<Rota>;

  public function set_rota(i:Int, r:Rota):Void{
    rotas[i] = r;
  }

  public function get_rota(i:Int):Rota{

    return rotas[i];
  }

  public function tamanho():Int{
    return rotas.length;
  }

  public function new(tamanho:Int, init:Bool = true){

    rotas = new Array<Rota>();
    if(init){
      for(i in 0...tamanho){
        var rr:Rota = new Rota();
        rr.gerar_individuo();
        set_rota(i, rr);
      }
    }else{
      for(i in 0...tamanho){
        set_rota(i, null);
      }
    }    

  }

  public function get_fittest():Rota{

    var f:Rota = rotas[0];

    for (i in 1...tamanho()) {
        if (f.get_fitness() <= get_rota(i).get_fitness()) {
            f = get_rota(i);
        }

    }
    return f;
  }



}
