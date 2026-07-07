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

    final diretorio = Directory('relatorios_gerados');

    try {
      if (!await diretorio.exists()) {
        await diretorio.create();
      }

      final arquivo = File('${diretorio.path}/$nomeArquivo');
      await arquivo.writeAsString(conteudo);
      print('Relatório salvo em: ${arquivo.path}');
    } catch (e) {
      print('Não foi possível gerar relatório! Erro: $e');
    }
  }
}
