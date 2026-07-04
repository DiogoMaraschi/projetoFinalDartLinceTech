import 'controller/clima_controller.dart';

Future<void> main() async {
  final controller = ClimaController();

  await controller.iniciar();
}
