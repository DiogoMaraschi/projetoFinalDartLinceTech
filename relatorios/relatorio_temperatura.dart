import '../calculadoras/calculadora_temperatura.dart';
import '../model/estado.dart';
import '../model/leitura_clima.dart';
import '../utils/conversor.dart';
import 'relatorio.dart';

class RelatorioTemperatura extends Relatorio {
  final CalculadoraTemperatura calculadora = CalculadoraTemperatura();
  final Conversor conversor = Conversor();

  @override
  String gerar(List<LeituraClima> leituras) {
    // Armazena o texto do relatório
    final buffer = StringBuffer();

    buffer.writeln('===== RELATÓRIO DE TEMPERATURA =====');
    buffer.writeln();

    // Gera o relatório para cada estado
    _adicionarDadosEstado(buffer, leituras, Estado.saoPaulo);
    _adicionarDadosEstado(buffer, leituras, Estado.santaCatarina);

    return buffer.toString();
  }

  // Adiciona os dados de um estado ao relatório
  void _adicionarDadosEstado(
    StringBuffer buffer,
    List<LeituraClima> leituras,
    Estado estado,
  ) {
    final media = calculadora.mediaPorEstado(leituras, estado);
    final maxima = calculadora.maximaPorEstado(leituras, estado);
    final minima = calculadora.minimaPorEstado(leituras, estado);

    buffer.writeln('Estado: ${estado.nome}');
    buffer.writeln();

    buffer.writeln('Média anual:');
    _adicionarTemperaturas(buffer, media);

    buffer.writeln('Máxima anual:');
    _adicionarTemperaturas(buffer, maxima);

    buffer.writeln('Mínima anual:');
    _adicionarTemperaturas(buffer, minima);

    buffer.writeln('Médias por horário:');

    final mediasPorHora = calculadora.mediaPorHora(leituras, estado);

    // Exibe a média de cada hora
    for (final entry in mediasPorHora.entries) {
      final hora = entry.key;
      final mediaHora = entry.value;

      buffer.write('${hora}h -> ');
      buffer.writeln('${mediaHora.toStringAsFixed(2)} °C');
    }

    buffer.writeln();
  }

  // Adiciona a temperatura nas três unidades
  void _adicionarTemperaturas(StringBuffer buffer, double celsius) {
    final fahrenheit = conversor.celsiusParaFahrenheit(celsius);
    final kelvin = conversor.celsiusParaKelvin(celsius);

    buffer.writeln('${celsius.toStringAsFixed(2)} °C');
    buffer.writeln('${fahrenheit.toStringAsFixed(2)} °F');
    buffer.writeln('${kelvin.toStringAsFixed(2)} K');
    buffer.writeln();
  }
}
