class Conversor {
  double celsiusParaFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  double celsiusParaKelvin(double celsius) {
    return celsius + 273.15;
  }

  double metrosPorSegundoParaKmh(double velocidade) {
    return velocidade * 3.6;
  }

  double metrosPorSegundoParaMph(double velocidade) {
    return velocidade * 2.23694;
  }

  double grausParaRadianos(double graus) {
    return graus * 3.141592653589793 / 180;
  }
}
