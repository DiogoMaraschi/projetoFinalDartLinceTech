import 'controller/clima_controller.dart';
import 'package:yaansi/yaansi.dart';

Future<void> main() async {
  final controller = ClimaController();

  print(red("teste vermelho"));
  print(green('teste verde'));

  await controller.iniciar();
}
