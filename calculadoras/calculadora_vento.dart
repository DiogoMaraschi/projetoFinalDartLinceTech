import '../model/estado.dart';
import '../model/leitura_clima.dart';

class CalculadoraVento {
  double frequenciaEstadoAno(
    List<LeituraClima> leituras,
    Estado estado,
    int ano,
  ) {
    Map<double, int> frequenciaDirecao = {};

    for (final leitura in leituras) {
      if (leitura.dataHora.year != ano || leitura.estado != estado) {
        continue; // Próximo termo caso não cumprir requisitos
      }
      final direcao = leitura.direcaoDoVento;

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
    Map<double, int> frequenciaDirecao = {};

    for (final leitura in leituras) {
      if (leitura.dataHora.year != mes || leitura.estado != estado) {
        continue; // Próximo termo caso não cumprir requisitos
      }
      final direcao = leitura.direcaoDoVento;

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
}
