import 'dart:io';

import 'model/estado.dart';
import 'model/leitura_clima.dart';

void main() async {
  final leitor = LeitorCsv();

  await leitor.lerArquivosCsv();
}

class LeitorCsv {
  // Configura local do diretório
  final diretorio = Directory(
    '/Users/diogomaraschi/VSCODE/projetoFinalDartLinceTech/sensores',
  );

  Future<void> lerArquivosCsv() async {
    // Verifica se a pasta existe
    if (await diretorio.exists()) {
      // Lista todos os itens da pasta
      final arquivos = diretorio.list();

      // Percorre cada item encontrado
      await for (var item in arquivos) {
        // Processa apenas arquivos CSV
        if (item is File && item.path.endsWith('.csv')) {
          // Lê todas as linhas do arquivo
          final linhas = await item.readAsLines();

          // Obtém o estado pelo nome do arquivo
          final estado = converterEstado(item.path);

          // Obtém o ano pelo nome do arquivo
          final ano = converterAno(item.path);

          // Converte as linhas em objetos
          final leituras = converterLinhas(linhas, estado, ano);

          // Apenas para teste
          print('Arquivo: ${item.path}');
          print('Leituras: ${leituras.length}');
        }
      }
    } else {
      print('Diretório não encontrado.');
    }
  }

  List<LeituraClima> converterLinhas(
    List<String> linhas,
    Estado estado,
    int ano,
  ) {
    // Lista que armazenará as leituras convertidas
    final listaFormatada = <LeituraClima>[];

    // Começa em 1 para ignorar o cabeçalho do CSV
    for (int i = 1; i < linhas.length; i++) {
      // Separa as colunas da linha
      final colunas = linhas[i].split(',');

      // Dados da data e hora
      final mes = int.parse(colunas[0]);
      final dia = int.parse(colunas[1]);
      final hora = int.parse(colunas[2]);

      // Monta um DateTime com ano, mês, dia e hora
      final dataHora = DateTime(ano, mes, dia, hora);

      // Converte os demais dados para double
      final temperatura = double.parse(colunas[3]);
      final umidade = double.parse(colunas[4]);
      final densidadeDoAr = double.parse(colunas[5]);
      final velocidadeDoVento = double.parse(colunas[6]);
      final direcaoDoVento = double.parse(colunas[7]);

      // Cria um objeto LeituraClima e adiciona na lista
      listaFormatada.add(
        LeituraClima(
          estado: estado,
          dataHora: dataHora,
          temperatura: temperatura,
          umidade: umidade,
          densidadeDoAr: densidadeDoAr,
          velocidadeDoVento: velocidadeDoVento,
          direcaoDoVento: direcaoDoVento,
        ),
      );
    }

    // Retorna todas as leituras convertidas
    return listaFormatada;
  }

  Estado converterEstado(String caminhoArquivo) {
    final nomeArquivo = caminhoArquivo.split('/').last;
    final sigla = nomeArquivo.split('_').first;

    switch (sigla) {
      case 'SC':
        return Estado.santaCatarina;

      case 'SP':
        return Estado.saoPaulo;

      default:
        throw Exception('Estado inválido.');
    }
  }

  int converterAno(String caminhoArquivo) {
    final nomeArquivo = caminhoArquivo.split('/').last;
    final partes = nomeArquivo.split('_');
    return int.parse(partes[1]);
  }
}
