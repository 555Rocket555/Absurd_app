class CharacterArchetype {
  final String id;
  final String titulo;
  final String filosofo;
  final String assetPath;
  final String descripcionDemo;

  const CharacterArchetype({
    required this.id,
    required this.titulo,
    required this.filosofo,
    required this.assetPath,
    required this.descripcionDemo,
  });
}

class DiagnosisCatalog {
  DiagnosisCatalog._();

  static const Map<String, CharacterArchetype> characters = {
    'abogado_diablo': CharacterArchetype(
      id: 'abogado_diablo',
      titulo: 'EL ABOGADO DEL DIABLO',
      filosofo: 'SARTRE',
      assetPath: 'assets/images/personajes/abogado_diablo.png',
      descripcionDemo: 'Sartre diría que estás condenado a ser libre y usaste esa libertad para defender lo indefendible sin pestañear.',
    ),
    'policia_moral': CharacterArchetype(
      id: 'policia_moral',
      titulo: 'EL POLICÍA DE LA MORAL',
      filosofo: 'KANT',
      assetPath: 'assets/images/personajes/policia_moral.png',
      descripcionDemo: 'Kant aplaudiría tu rigor absoluto para juzgar a los demás, aunque buscaste tecnicismos cuando te tocó defenderte.',
    ),
    'calculadora_humana': CharacterArchetype(
      id: 'calculadora_humana',
      titulo: 'LA CALCULADORA HUMANA',
      filosofo: 'MILL',
      assetPath: 'assets/images/personajes/calculadora_humana.png',
      descripcionDemo: 'Mill estaría orgulloso: justificaste cada traición asegurando fríamente que era por el bien mayor del grupo.',
    ),
    'martillo_sin_piedad': CharacterArchetype(
      id: 'martillo_sin_piedad',
      titulo: 'EL MARTILLO SIN PIEDAD',
      filosofo: 'NIETZSCHE',
      assetPath: 'assets/images/personajes/martillo_sin_piedad.png',
      descripcionDemo: 'Nietzsche vería en ti pura voluntad de poder: aplastaste argumentos emocionales sin mostrar una pizca de culpa.',
    ),
    'pesimista_profesional': CharacterArchetype(
      id: 'pesimista_profesional',
      titulo: 'EL PESIMISTA PROFESIONAL',
      filosofo: 'SCHOPENHAUER',
      assetPath: 'assets/images/personajes/pesimista_profesional.png',
      descripcionDemo: 'Schopenhauer confirmó su teoría contigo: aceptaste cada señalamiento con resignación filosófica ante la miseria humana.',
    ),
    'amante_liquido': CharacterArchetype(
      id: 'amante_liquido',
      titulo: 'EL AMANTE LÍQUIDO',
      filosofo: 'BAUMAN',
      assetPath: 'assets/images/personajes/amante_liquido.png',
      descripcionDemo: 'Bauman describiría tus alianzas como modernidad líquida: cambiaste de bando en cada ronda sin comprometerte con nadie.',
    ),
    'vigilante_panoptico': CharacterArchetype(
      id: 'vigilante_panoptico',
      titulo: 'EL VIGILANTE DEL PANÓPTICO',
      filosofo: 'FOUCAULT',
      assetPath: 'assets/images/personajes/vigilante_panoptico.png',
      descripcionDemo: 'Foucault notó cómo observaste en silencio desde las sombras para castigar con tu voto a cualquiera que intentara liderar.',
    ),
    'sindicalista_caos': CharacterArchetype(
      id: 'sindicalista_caos',
      titulo: 'EL SINDICALISTA DEL CAOS',
      filosofo: 'MARX',
      assetPath: 'assets/images/personajes/sindicalista_caos.png',
      descripcionDemo: 'Marx aprobaría tu instinto subversivo: organizaste al grupo contra quien iba ganando y culpaste al sistema al perder.',
    ),
    'rebelde_absurdo': CharacterArchetype(
      id: 'rebelde_absurdo',
      titulo: 'EL REBELDE DEL ABSURDO',
      filosofo: 'CAMUS',
      assetPath: 'assets/images/personajes/rebelde_absurdo.png',
      descripcionDemo: 'Camus sonreiría al verte: abrazaste las posturas más ridículas con humor y calma absoluta frente al caos de la mesa.',
    ),
    'detective_excusas': CharacterArchetype(
      id: 'detective_excusas',
      titulo: 'LA DETECTIVE DE EXCUSAS',
      filosofo: 'BEAUVOIR',
      assetPath: 'assets/images/personajes/detective_excusas.png',
      descripcionDemo: 'Simone de Beauvoir celebraría tu lucidez para desmantelar las fachadas morales y excusas baratas de tus amigos.',
    ),
    'operador_tranvias': CharacterArchetype(
      id: 'operador_tranvias',
      titulo: 'EL OPERADOR DE TRANVÍAS',
      filosofo: 'GREENE',
      assetPath: 'assets/images/personajes/operador_tranvias.png',
      descripcionDemo: 'Joshua Greene mediría tu corteza prefrontal: resolviste dilemas extremos en segundos con frialdad quirúrgica.',
    ),
    'tribalista_incondicional': CharacterArchetype(
      id: 'tribalista_incondicional',
      titulo: 'EL TRIBALISTA INCONDICIONAL',
      filosofo: 'HAIDT',
      assetPath: 'assets/images/personajes/tribalista_incondicional.png',
      descripcionDemo: 'Jonathan Haidt lo predijo: votaste por pura intuición emocional y lealtad tribal, inventando excusas lógicas después.',
    ),
    'nino_estrellitas': CharacterArchetype(
      id: 'nino_estrellitas',
      titulo: 'EL NIÑO DE LAS ESTRELLITAS',
      filosofo: 'KOHLBERG',
      assetPath: 'assets/images/personajes/nino_estrellitas.png',
      descripcionDemo: 'Kohlberg te ubicaría buscando aprobación social: evitaste conflictos directos para quedar bien con toda la sala.',
    ),
    'arquitecto_coartadas': CharacterArchetype(
      id: 'arquitecto_coartadas',
      titulo: 'EL ARQUITECTO DE COARTADAS',
      filosofo: 'BANDURA',
      assetPath: 'assets/images/personajes/arquitecto_coartadas.png',
      descripcionDemo: 'Bandura estudiaría tu desconexión moral: fuiste el más señalado, pero siempre culpaste a las circunstancias.',
    ),
    'principe_sombras': CharacterArchetype(
      id: 'principe_sombras',
      titulo: 'EL PRÍNCIPE DE LAS SOMBRAS',
      filosofo: 'MAQUIAVELO',
      assetPath: 'assets/images/personajes/principe_sombras.png',
      descripcionDemo: 'Maquiavelo tomaría notas de ti: manipulaste la conversación previa para desviar los señalamientos hacia otros.',
    ),
    'cinico_barril': CharacterArchetype(
      id: 'cinico_barril',
      titulo: 'EL CÍNICO DEL BARRIL',
      filosofo: 'DIÓGENES',
      assetPath: 'assets/images/personajes/cinico_barril.png',
      descripcionDemo: 'Diógenes te invitaría a su barril: te burlaste de toda solemnidad moral con sarcasmo brutal y aun así convenciste al jurado.',
    ),
  };

  static List<CharacterArchetype> get all => characters.values.toList();

  static CharacterArchetype getById(String id) {
    return characters[id] ?? characters['rebelde_absurdo']!;
  }
}
