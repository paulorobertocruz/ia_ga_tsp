package;

class Main{
  static public function main():Void{
      trace("ALGORITMO GENETICO TSP");
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
          populacao = AlgoritmoGenetico.evoluir(populacao);
          if(distancia_anterior > populacao.get_fittest().get_distancia()){
            melhor_rota = populacao.get_fittest();
            trace(populacao.get_fittest().get_distancia());
          }
          distancia_anterior = populacao.get_fittest().get_distancia();
        }

        trace("Distancia Final: " + populacao.get_fittest().get_distancia());

  }
}
