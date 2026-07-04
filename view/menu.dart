import 'dart:io';

class Menu {
  int mostrar() {
    print('\n=== MENU ===');
    print('1 - Temperatura');
    print('2 - Umidade');
    print('3 - Direção do Vento');
    print('0 - Sair');

    stdout.write('Escolha uma opção: ');
    final entrada = stdin.readLineSync();

    return int.tryParse(entrada ?? '') ?? -1;
  }
}
