import '../calculadoras/calculadora_umidade.dart';
import '../model/estado.dart';
import '../model/leitura_clima.dart';
import 'relatorio.dart';

class RelatorioUmidade extends Relatorio {
  final CalculadoraUmidade calculadora = CalculadoraUmidade();

  @override
  String gerar(List<LeituraClima> leituras) {
    // Armazena o texto do relatório
    final buffer = StringBuffer();

    buffer.writeln('===== RELATÓRIO DE UMIDADE =====');
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

    buffer.writeln('Média anual: ${media.toStringAsFixed(6)} kg/kg');
    buffer.writeln('Máxima anual: ${maxima.toStringAsFixed(6)} kg/kg');
    buffer.writeln('Mínima anual: ${minima.toStringAsFixed(6)} kg/kg');
    buffer.writeln();

    _adicionarDadosMensais(buffer, leituras, estado);

    buffer.writeln('--------------------------------');
    buffer.writeln();
  }

  // Adiciona média, máxima e mínima por mês
  void _adicionarDadosMensais(
    StringBuffer buffer,
    List<LeituraClima> leituras,
    Estado estado,
  ) {
    buffer.writeln('Dados por mês:');

    for (var mes = 1; mes <= 12; mes++) {
      final media = calculadora.mediaPorEstadoMes(leituras, estado, mes);
      final maxima = calculadora.maximaPorEstadoMes(leituras, estado, mes);
      final minima = calculadora.minimaPorEstadoMes(leituras, estado, mes);

      if (media == 0 &&
          maxima == double.negativeInfinity &&
          minima == double.infinity) {
        continue;
      }

      buffer.writeln('Mês $mes:');
      buffer.writeln('Média: ${media.toStringAsFixed(6)} kg/kg');
      buffer.writeln('Máxima: ${maxima.toStringAsFixed(6)} kg/kg');
      buffer.writeln('Mínima: ${minima.toStringAsFixed(6)} kg/kg');
      buffer.writeln();
    }
  }
}
