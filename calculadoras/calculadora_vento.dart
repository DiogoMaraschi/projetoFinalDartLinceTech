import '../model/estado.dart';
import '../model/leitura_clima.dart';

class CalculadoraVento {
  // Calcula a direção com maior frequência
  double _direcaoMaisFrequente(List<LeituraClima> listaFiltrada) {
    Map<double, int> frequenciaDirecao = {};

    // Percorre as leituras filtradas
    for (final item in listaFiltrada) {
      // Ignora leituras sem vento
      if (item.velocidadeDoVento == 0) {
        continue;
      }

      final direcao = item.direcaoDoVento;

      frequenciaDirecao.putIfAbsent(direcao, () => 0); // Cria se nao existe

      frequenciaDirecao.update(
        direcao,
        (valorAtual) => valorAtual + 1,
      ); // Atualiza valor com base no valor atual
    }

    // Verifica se encontrou alguma direção válida
    if (frequenciaDirecao.isEmpty) {
      return 0;
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

  // Filtra por estado e mês
  double frequenciaEstadoMes(
    List<LeituraClima> leituras,
    Estado estado,
    int mes,
  ) {
    List<LeituraClima> filtradas = [];

    // Percorre todas as leituras
    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.dataHora.month == mes) {
        filtradas.add(leitura);
      }
    }

    return _direcaoMaisFrequente(filtradas);
  }

  // Filtra por estado e ano
  double frequenciaEstadoAno(
    List<LeituraClima> leituras,
    Estado estado,
    int ano,
  ) {
    List<LeituraClima> filtradas = [];

    // Percorre todas as leituras
    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.dataHora.year == ano) {
        filtradas.add(leitura);
      }
    }

    return _direcaoMaisFrequente(filtradas);
  }
}
