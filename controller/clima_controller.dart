import '../relatorios/relatorio_temperatura.dart';
import '../relatorios/relatorio_umidade.dart';
import '../relatorios/relatorio_vento.dart';
import '../view/menu.dart';
import 'leitor_csv.dart';

class ClimaController {
  final Menu menu = Menu();
  final LeitorCsv leitorCsv = LeitorCsv();

  final relatorioTemperatura = RelatorioTemperatura();

  final relatorioUmidade = RelatorioUmidade();

  final relatorioVento = RelatorioVento();

  Future<void> iniciar() async {
    final leituras = await leitorCsv.lerArquivosCsv();

    bool executando = true;

    while (executando) {
      final opcao = menu.mostrar();

      switch (opcao) {
        case 1:
          print(relatorioTemperatura.gerar(leituras));
          break;

        case 2:
          print(relatorioUmidade.gerar(leituras));
          break;

        case 3:
          print(relatorioVento.gerar(leituras));
          break;

        case 0:
          print('Encerrando programa...');
          executando = false;
          break;

        default:
          print('Opção inválida.');
      }
    }
  }
}
