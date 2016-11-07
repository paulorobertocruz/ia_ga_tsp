package;

class AlgoritmoGenetico {

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
