import 'estado.dart';

class LeituraClima {
  LeituraClima({
    required this.estado,
    required this.dataHora,
    required this.temperatura,
    required this.umidade,
    required this.densidadeDoAr,
    required this.velocidadeDoVento,
    required this.direcaoDoVento,
  });

  final Estado estado;
  final DateTime dataHora;
  final double temperatura;
  final double umidade;
  final double densidadeDoAr;
  final double velocidadeDoVento;
  final double direcaoDoVento;
}
