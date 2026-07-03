import '../model/estado.dart';
import '../model/leitura_clima.dart';

class CalculadoraUmidade {
  // Calcula a média de umidade por estado
  double mediaPorEstado(List<LeituraClima> leituras, Estado estado) {
    double soma = 0;
    int contador = 0;

    for (final leitura in leituras) {
      if (leitura.estado == estado) {
        soma += leitura.umidade;
        contador++;
      }
    }

    if (contador == 0) {
      return 0;
    }

    return soma / contador;
  }

  // Calcula a umidade máxima por estado
  double maximaPorEstado(List<LeituraClima> leituras, Estado estado) {
    double maximo = double.negativeInfinity;

    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.umidade > maximo) {
        maximo = leitura.umidade;
      }
    }

    return maximo;
  }

  // Calcula a umidade mínima por estado
  double minimaPorEstado(List<LeituraClima> leituras, Estado estado) {
    double minimo = double.infinity;

    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.umidade < minimo) {
        minimo = leitura.umidade;
      }
    }

    return minimo;
  }

  // Calcula a média de umidade por estado e mês
  double mediaPorEstadoMes(
    List<LeituraClima> leituras,
    Estado estado,
    int mes,
  ) {
    double soma = 0;
    int contador = 0;

    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.dataHora.month == mes) {
        soma += leitura.umidade;
        contador++;
      }
    }

    if (contador == 0) {
      return 0;
    }

    return soma / contador;
  }

  // Calcula a umidade máxima por estado e mês
  double maximaPorEstadoMes(
    List<LeituraClima> leituras,
    Estado estado,
    int mes,
  ) {
    double maximo = double.negativeInfinity;

    for (final leitura in leituras) {
      if (leitura.estado == estado &&
          leitura.dataHora.month == mes &&
          leitura.umidade > maximo) {
        maximo = leitura.umidade;
      }
    }

    return maximo;
  }

  // Calcula a umidade mínima por estado e mês
  double minimaPorEstadoMes(
    List<LeituraClima> leituras,
    Estado estado,
    int mes,
  ) {
    double minimo = double.infinity;

    for (final leitura in leituras) {
      if (leitura.estado == estado &&
          leitura.dataHora.month == mes &&
          leitura.umidade < minimo) {
        minimo = leitura.umidade;
      }
    }

    return minimo;
  }
}
