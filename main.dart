import 'calculadoras/calculadora_temperatura.dart';
import 'utils/conversor.dart';
import 'controller/leitor_csv.dart';
import 'model/estado.dart';

void main() async {
  final leitor = LeitorCsv();

  final leituras = await leitor.lerArquivosCsv();

  final calculadora = CalculadoraTemperatura();

  final mediaSp = calculadora.mediaPorEstado(leituras, Estado.saoPaulo);

  print('Média SP: ${mediaSp.toStringAsFixed(2)} °C');
}
