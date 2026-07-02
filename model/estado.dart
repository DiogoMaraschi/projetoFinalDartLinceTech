enum Estado {
  saoPaulo,
  santaCatarina;

  String get sigla {
    switch (this) {
      case Estado.saoPaulo:
        return 'SP';
      case Estado.santaCatarina:
        return 'SC';
    }
  }

  String get nome {
    switch (this) {
      case Estado.saoPaulo:
        return 'São Paulo';
      case Estado.santaCatarina:
        return 'Santa Catarina';
    }
  }
}
