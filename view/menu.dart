import 'dart:io';

class Menu {
  bool _executando = true;

  void mostraMenu() {
    do {
      print('\n=== MENU ===');
      print('1 - Temperatura');
      print('2 - Umidade');
      print('3 - Direção do Vento');
      print('0 - Sair');

      stdout.write('Escolha uma opção: ');
      String? entrada = stdin.readLineSync();

      final opcao = int.tryParse(entrada ?? '') ?? -1;

      print(opcao);
    } while (_executando);
  }
}
