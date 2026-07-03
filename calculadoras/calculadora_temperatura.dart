import '../model/estado.dart';
import '../model/leitura_clima.dart';

class CalculadoraTemperatura {
  // Calcula a média de temperatura por estado
  double mediaPorEstado(List<LeituraClima> leituras, Estado estado) {
    double soma = 0;
    int contador = 0;

    for (final leitura in leituras) {
      if (leitura.estado == estado) {
        soma += leitura.temperatura;
        contador++;
      }
    }

    if (contador == 0) {
      return 0;
    }

    return soma / contador;
  }

  // Calcula a temperatura máxima por estado
  double maximaPorEstado(List<LeituraClima> leituras, Estado estado) {
    double maximo = double.negativeInfinity;

    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.temperatura > maximo) {
        maximo = leitura.temperatura;
      }
    }

    return maximo;
  }

  // Calcula a temperatura mínima por estado
  double minimaPorEstado(List<LeituraClima> leituras, Estado estado) {
    double minimo = double.infinity;

    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.temperatura < minimo) {
        minimo = leitura.temperatura;
      }
    }

    return minimo;
  }

  // Calcula a média de temperatura por estado e mês
  double mediaPorEstadoMes(
    List<LeituraClima> leituras,
    Estado estado,
    int mes,
  ) {
    double soma = 0;
    int contador = 0;

    for (final leitura in leituras) {
      if (leitura.estado == estado && leitura.dataHora.month == mes) {
        soma += leitura.temperatura;
        contador++;
      }
    }

    if (contador == 0) {
      return 0;
    }

    return soma / contador;
  }

  // Calcula a temperatura máxima por estado e mês
  double maximaPorEstadoMes(
    List<LeituraClima> leituras,
    Estado estado,
    int mes,
  ) {
    double maximo = double.negativeInfinity;

    for (final leitura in leituras) {
      if (leitura.estado == estado &&
          leitura.dataHora.month == mes &&
          leitura.temperatura > maximo) {
        maximo = leitura.temperatura;
      }
    }

    return maximo;
  }

  // Calcula a temperatura mínima por estado e mês
  double minimaPorEstadoMes(
    List<LeituraClima> leituras,
    Estado estado,
    int mes,
  ) {
    double minimo = double.infinity;

    for (final leitura in leituras) {
      if (leitura.estado == estado &&
          leitura.dataHora.month == mes &&
          leitura.temperatura < minimo) {
        minimo = leitura.temperatura;
      }
    }

    return minimo;
  }

  // Calcula a média de temperatura por hora
  Map<int, double> mediaPorHora(List<LeituraClima> leituras, Estado estado) {
    final Map<int, double> mapMediaPorHora = {};

    final Map<int, List<double>> mapHoraValores = {};

    // Agrupa as temperaturas por hora
    for (final leitura in leituras) {
      if (leitura.estado == estado) {
        final hora = leitura.dataHora.hour;

        mapHoraValores.putIfAbsent(hora, () => []);

        mapHoraValores[hora]!.add(leitura.temperatura);
      }
    }

    // Calcula a média de cada hora
    for (final entry in mapHoraValores.entries) {
      final hora = entry.key;
      final temperaturas = entry.value;

      double soma = 0;

      for (final temperatura in temperaturas) {
        soma += temperatura;
      }

      mapMediaPorHora[hora] = soma / temperaturas.length;
    }

    return mapMediaPorHora;
  }
}
