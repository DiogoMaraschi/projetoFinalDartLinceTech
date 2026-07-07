import 'dart:io';

class GravadorRelatorio {
  Future<void> salvar(String prefixo, String conteudo) async {
    final agora = DateTime.now();

    // Coloca no formato '2026-07-07'
    final data =
        '${agora.year}-${agora.month.toString().padLeft(2, '0')}-${agora.day.toString().padLeft(2, '0')}';

    // Coloca no formato '14-16'
    final hora =
        '${agora.hour.toString().padLeft(2, '0')}-${agora.minute.toString().padLeft(2, '0')}';

    final nomeArquivo = '${prefixo}_${data}_$hora.txt';

    final arquivo = File(nomeArquivo);

    try {
      await arquivo.writeAsString(conteudo);
      print('Relatório salvo em: $nomeArquivo');
    } catch (e) {
      print(e);
    }
  }
}
