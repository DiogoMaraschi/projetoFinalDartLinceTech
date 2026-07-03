import '../model/leitura_clima.dart';

abstract class Relatorio {
  String gerar(List<LeituraClima> leituras);
}
