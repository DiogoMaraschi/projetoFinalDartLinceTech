import 'dart:math';

class Conversor {
  // Converte Celsius para Fahrenheit
  double celsiusParaFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  // Converte Celsius para Kelvin
  double celsiusParaKelvin(double celsius) {
    return celsius + 273.15;
  }

  // Converte m/s para km/h
  double metrosPorSegundoParaKmh(double velocidade) {
    return velocidade * 3.6;
  }

  // Converte m/s para mph
  double metrosPorSegundoParaMph(double velocidade) {
    return velocidade * 2.23694;
  }

  // Converte graus para radianos
  double grausParaRadianos(double graus) {
    return graus * pi / 180;
  }
}
