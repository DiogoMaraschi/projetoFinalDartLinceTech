import '../calculadoras/calculadora_vento.dart';
import '../model/estado.dart';
import '../model/leitura_clima.dart';
import '../utils/conversor.dart';
import 'relatorio.dart';

class RelatorioVento extends Relatorio {
  final CalculadoraVento calculadora = CalculadoraVento();
  final Conversor conversor = Conversor();

  @override
  String gerar(List<LeituraClima> leituras) {
    // Armazena o texto do relatório
    final buffer = StringBuffer();

    buffer.writeln('===== RELATÓRIO DE DIREÇÃO DO VENTO =====');
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
    buffer.writeln('Estado: ${estado.nome}');
    buffer.writeln();

    final anos = _buscarAnos(leituras, estado);

    // Direção mais frequente por ano
    for (final ano in anos) {
      final direcaoAno = calculadora.frequenciaEstadoAno(leituras, estado, ano);

      _adicionarDirecao(buffer, 'Direção mais frequente em $ano', direcaoAno);
    }

    buffer.writeln('Direções mais frequentes por mês:');

    final meses = _buscarMeses(leituras, estado);

    // Direção mais frequente por mês
    for (final mes in meses) {
      final direcaoMes = calculadora.frequenciaEstadoMes(leituras, estado, mes);

      _adicionarDirecao(buffer, 'Mês $mes', direcaoMes);
    }

    buffer.writeln('--------------------------------');
    buffer.writeln();
  }

  // Adiciona direção em graus e radianos
  void _adicionarDirecao(StringBuffer buffer, String titulo, double graus) {
    final radianos = conversor.grausParaRadianos(graus);

    buffer.writeln('$titulo:');
    buffer.writeln('${graus.toStringAsFixed(2)}°');
    buffer.writeln('${radianos.toStringAsFixed(4)} rad');
    buffer.writeln();
  }

  // Busca anos disponíveis para o estado
  List<int> _buscarAnos(List<LeituraClima> leituras, Estado estado) {
    final anos = <int>{};

    for (final leitura in leituras) {
      if (leitura.estado == estado) {
        anos.add(leitura.dataHora.year);
      }
    }

    return anos.toList()..sort();
  }

  // Busca meses disponíveis para o estado
  List<int> _buscarMeses(List<LeituraClima> leituras, Estado estado) {
    final meses = <int>{};

    for (final leitura in leituras) {
      if (leitura.estado == estado) {
        meses.add(leitura.dataHora.month);
      }
    }

    return meses.toList()..sort();
  }
}
