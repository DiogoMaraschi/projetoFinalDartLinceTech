import '../relatorios/relatorio_temperatura.dart';
import '../relatorios/relatorio_umidade.dart';
import '../relatorios/relatorio_vento.dart';
import '../utils/gravador_relatorio.dart';
import '../view/menu.dart';
import 'leitor_csv.dart';

class ClimaController {
  final Menu menu = Menu();
  final LeitorCsv leitorCsv = LeitorCsv();

  final relatorioTemperatura = RelatorioTemperatura();

  final relatorioUmidade = RelatorioUmidade();

  final relatorioVento = RelatorioVento();

  final gravadorRelatorio = GravadorRelatorio();

  Future<void> iniciar() async {
    final leituras = await leitorCsv.lerArquivosCsv();

    bool executando = true;

    while (executando) {
      final opcao = menu.mostrar();

      switch (opcao) {
        case 1:
          final texto = (relatorioTemperatura.gerar(leituras));
          print(texto);
          await gravadorRelatorio.salvar('CLIMA', texto);
          break;

        case 2:
          final texto = (relatorioUmidade.gerar(leituras));
          print(texto);
          await gravadorRelatorio.salvar('CLIMA', texto);
          break;

        case 3:
          final texto = (relatorioVento.gerar(leituras));
          print(texto);
          await gravadorRelatorio.salvar('CLIMA', texto);
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
