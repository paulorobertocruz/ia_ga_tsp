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

  static public function trace():String{
    var s:String = "";
    for (c in cidades){
      s += "> x:"+ c.get_x() +" y:"+ c.get_y() +"<";
    }
    return s;
  }

}

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

class GA {

    static var taxa_mutacao:Float = 0.0325;
    static var tamanho_amostra_rota:Int = 10;
    static var elitismo:Bool = true;

    
    static public function evoluir(pop:Populacao):Populacao {
        var nova_populacao:Populacao = new Populacao(pop.tamanho(), false);
        
        var elitismoOffset:Int = 0;

        if (elitismo){
            nova_populacao.set_rota(0, pop.get_fittest());            
            elitismoOffset = 1;
        }
        
        var i:Int = 0;
        for (i in elitismoOffset...nova_populacao.tamanho()) {
            
            var pai:Rota = seleciona_da_populacao(pop);
            var mae:Rota = seleciona_da_populacao(pop);
            
            var filho = cruzar(pai, mae);
            
            nova_populacao.set_rota(i, filho);
        }

        
        for (i in elitismoOffset...nova_populacao.tamanho()) {
            mutar(nova_populacao.get_rota(i));
        }

        return nova_populacao;
    }

    
    static public function cruzar(pai:Rota, mae:Rota):Rota {
        
        var filho:Rota = new Rota();

        
        var startPos:Int = Std.int( (Math.random() * pai.quantidade_cidades()) );
        var endPos:Int = Std.int( (Math.random() * pai.quantidade_cidades()) );

        
        for (i in 0...filho.quantidade_cidades()) {
            
            if (startPos < endPos && i > startPos && i < endPos) {
                filho.set_cidade(i, pai.get_cidade(i));
            } 
            else if (startPos > endPos) {
                if (!(i < startPos && i > endPos)) {
                    filho.set_cidade(i, pai.get_cidade(i));
                }
            }
        }

        
        for (i in 0...mae.quantidade_cidades()) {
            
            if (!filho.contem_cidade(mae.get_cidade(i))) {
                
                for (ii in 0...filho.quantidade_cidades()) {
                    
                    if (filho.get_cidade(ii) == null) {
                        filho.set_cidade(ii, mae.get_cidade(i));
                        break;
                    }
                }
            }
        }
        return filho;
    }

    
    static private function mutar(rota:Rota):Void {        
        for(i in 0...rota.quantidade_cidades()){            
            if(Math.random() < taxa_mutacao){
                
                var j:Int = Std.int(rota.quantidade_cidades() * Math.random());
                
                var cidade_1:Cidade = rota.get_cidade(i);
                var cidade_2:Cidade = rota.get_cidade(j);

                
                rota.set_cidade(j, cidade_1);
                rota.set_cidade(i, cidade_2);
            }
        }
    }

    
    static private function seleciona_da_populacao(pop:Populacao):Rota {
        
        var sl_pop:Populacao = new Populacao(tamanho_amostra_rota, false);
        
        
        for (i in 0...tamanho_amostra_rota) {
            var randomId:Int = Std.int (Math.random() * pop.tamanho());
            sl_pop.set_rota(i, pop.get_rota(randomId));
        }
        
        var fittest:Rota = sl_pop.get_fittest();
        
        return fittest;
    }
}



class Main{
  static public function main():Void{
      trace("GA TSP");
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

        

        var populacao:Populacao = new Populacao(50);
        var distancia_anterior:Float = populacao.get_fittest().get_distancia();
        trace("Distancia Inicial: " + distancia_anterior);
          
        var melhor_rota:Rota = populacao.get_fittest();
        while(true){
          populacao = GA.evoluir(populacao);
          if(distancia_anterior > populacao.get_fittest().get_distancia()){
            melhor_rota = populacao.get_fittest();
            trace(populacao.get_fittest().get_distancia());
          }
          distancia_anterior = populacao.get_fittest().get_distancia();
        }

        trace("Distancia Final: " + populacao.get_fittest().get_distancia());

  }
}
