import 'dart:io';
import 'dart:convert';

import '../model/estado.dart';
import '../model/leitura_clima.dart';

class LeitorCsv {
  // Diretório dos arquivos CSV
  final diretorio = Directory('C:/CLIMA/SENSORES');

  // Diretório usado no meu computador para testes:
  // final diretorio = Directory(
  //     '/Users/diogomaraschi/VSCODE/projetoFinalDartLinceTech/sensores');

  Future<List<LeituraClima>> lerArquivosCsv() async {
    List<LeituraClima> listaCompleta = [];

    try {
      // Verifica se a pasta existe
      if (!await diretorio.exists()) {
        throw Exception(
          'Falha ao extrair informações, diretório não encontrado',
        );
      }

      // Lista arquivos do diretório
      final arquivos = diretorio.list();

      await for (final item in arquivos) {
        // Filtra somente arquivos CSV
        if (item is File && item.path.endsWith('.csv')) {
          try {
            // Lê arquivo usando latin1
            final linhas = await item.readAsLines(
              encoding: latin1,
            );

            // Extrai informações pelo nome do arquivo
            final estado = converterEstado(item.path);
            final ano = converterAno(item.path);

            // Converte CSV em objetos
            final leituras = converterLinhas(
              linhas,
              estado,
              ano,
            );

            listaCompleta.addAll(leituras);
          } catch (e) {
            print(
              'Falha na leitura do arquivo: ${item.path}',
            );
          }
        }
      }

      // Verifica se encontrou leituras
      if (listaCompleta.isEmpty) {
        throw Exception(
          'Falha ao extrair informações, nenhum arquivo encontrado',
        );
      }
    } catch (e) {
      print(e);
    }

    return listaCompleta;
  }

  List<LeituraClima> converterLinhas(
    List<String> linhas,
    Estado estado,
    int ano,
  ) {
    // Armazena objetos convertidos
    final listaFormatada = <LeituraClima>[];

    // Ignora cabeçalho do CSV
    for (int i = 1; i < linhas.length; i++) {
      final colunas = linhas[i].split(',');

      // Monta data completa
      final mes = int.parse(colunas[0]);
      final dia = int.parse(colunas[1]);
      final hora = int.parse(colunas[2]);

      final dataHora = DateTime(
        ano,
        mes,
        dia,
        hora,
      );

      // Converte valores numéricos
      final temperatura = double.parse(colunas[3]);
      final umidade = double.parse(colunas[4]);
      final densidadeDoAr = double.parse(colunas[5]);
      final velocidadeDoVento = double.parse(colunas[6]);
      final direcaoDoVento = double.parse(colunas[7]);

      // Cria leitura climática
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

    return listaFormatada;
  }

  // Obtém estado pelo nome do arquivo
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

  // Obtém ano pelo nome do arquivo
  int converterAno(String caminhoArquivo) {
    final nomeArquivo = caminhoArquivo.split('/').last;
    final partes = nomeArquivo.split('_');

    return int.parse(partes[1]);
  }
}
