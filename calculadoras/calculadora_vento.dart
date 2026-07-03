import '../model/estado.dart';
import '../model/leitura_clima.dart';

class CalculadoraVento {
  double _direcaoMaisFrequente(List<LeituraClima> listaFiltrada) {
    Map<double, int> frequenciaDirecao = {};

    for (final item in listaFiltrada) {
      final direcao = item.direcaoDoVento;

      frequenciaDirecao.putIfAbsent(direcao, () => 0); // Cria se nao existe
      frequenciaDirecao.update(
        direcao,
        (valorAtual) => valorAtual + 1,
      ); // Atualiza valor com base no valor atual
    }

    int maiorFrequencia = 0;
    double direcaoMaisFrequente = 0;

    // Verifica a maior frequencia
    for (final entry in frequenciaDirecao.entries) {
      if (entry.value > maiorFrequencia) {
        maiorFrequencia = entry.value;
        direcaoMaisFrequente = entry.key;
      }
    }
    return direcaoMaisFrequente;
  }

  double frequenciaEstadoMes(
    List<LeituraClima> leituras,
    Estado estado,
    int mes,
  ) {
    List<LeituraClima> filtradas = [];

    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.dataHora.month == mes) {
        filtradas.add(leitura);
      }
    }
    return _direcaoMaisFrequente(filtradas);
  }

  double frequenciaEstadoAno(
    List<LeituraClima> leituras,
    Estado estado,
    int ano,
  ) {
    List<LeituraClima> filtradas = [];

    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.dataHora.year == ano) {
        filtradas.add(leitura);
      }
    }
    return _direcaoMaisFrequente(filtradas);
  }
}
