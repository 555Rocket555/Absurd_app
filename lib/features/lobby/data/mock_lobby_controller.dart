import 'dart:math';

import 'package:flutter/foundation.dart';

class MockPlayer {
  final String uid;
  final String alias;
  final bool esHost;
  final String avatarId;

  const MockPlayer({
    required this.uid,
    required this.alias,
    required this.esHost,
    required this.avatarId,
  });
}

class MockLobbyController extends ChangeNotifier {
  String pin = '4827';
  String nombreSala = '';
  bool esHost = true;
  List<String> categorias = ['Dilemas de Alta Prioridad'];
  Set<String> modosActivos = {'debate_absurdo', 'senalados'};
  int tiempoDebateSeg = 120;
  List<MockPlayer> jugadores = [];

  static const List<String> availableCategories = [
    'Dilemas de Alta Prioridad',
    'Fricciones Cotidianas',
    'Caos Urbano',
    'Cyber-Paranoia',
    'Defensa de lo Indefendible',
    'Aleatoriedad Absoluta',
  ];

  static const List<MockPlayer> _botPool = [
    MockPlayer(
      uid: 'uid_mateo_02',
      alias: 'Mateo',
      esHost: false,
      avatarId: 'martillo_sin_piedad',
    ),
    MockPlayer(
      uid: 'uid_sofi_03',
      alias: 'Sofi',
      esHost: false,
      avatarId: 'detective_excusas',
    ),
    MockPlayer(
      uid: 'uid_diego_04',
      alias: 'Diego',
      esHost: false,
      avatarId: 'rebelde_absurdo',
    ),
    MockPlayer(
      uid: 'uid_valeria_05',
      alias: 'Valeria',
      esHost: false,
      avatarId: 'principe_sombras',
    ),
  ];

  void crearSala({
    required String sala,
    required String hostAlias,
    required List<String> categoriasSeleccionadas,
    required Set<String> modos,
    required int tiempoSeg,
  }) {
    pin = (1000 + Random().nextInt(9000)).toString();
    nombreSala = sala.trim();
    esHost = true;
    categorias = List.from(categoriasSeleccionadas);
    modosActivos = Set.from(modos);
    tiempoDebateSeg = tiempoSeg;
    jugadores = [
      MockPlayer(
        uid: 'uid_host_01',
        alias: hostAlias.trim(),
        esHost: true,
        avatarId: 'policia_moral',
      ),
    ];
    notifyListeners();
  }

  void unirseASala({
    required String pinIngresado,
    required String playerAlias,
  }) {
    pin = pinIngresado;
    nombreSala = 'Noche de Viernes';
    esHost = false;
    categorias = ['Dilemas de Alta Prioridad', 'Cyber-Paranoia'];
    modosActivos = {'debate_absurdo', 'senalados'};
    tiempoDebateSeg = 120;
    jugadores = [
      const MockPlayer(
        uid: 'uid_lucia_01',
        alias: 'Lucía',
        esHost: true,
        avatarId: 'policia_moral',
      ),
      const MockPlayer(
        uid: 'uid_mateo_02',
        alias: 'Mateo',
        esHost: false,
        avatarId: 'martillo_sin_piedad',
      ),
      MockPlayer(
        uid: 'uid_local_player',
        alias: playerAlias.trim(),
        esHost: false,
        avatarId: 'abogado_diablo',
      ),
    ];
    notifyListeners();
  }

  void simularJugadorEntrando() {
    if (jugadores.length >= 6) return;
    final nextIndex = (jugadores.length - 1) % _botPool.length;
    final candidate = _botPool[nextIndex];
    final aliasFinal = jugadores.any((j) => j.alias == candidate.alias)
        ? '${candidate.alias} ${jugadores.length}'
        : candidate.alias;

    jugadores = [
      ...jugadores,
      MockPlayer(
        uid: 'uid_sim_${jugadores.length + 1}',
        alias: aliasFinal,
        esHost: false,
        avatarId: candidate.avatarId,
      ),
    ];
    notifyListeners();
  }

  void reiniciar() {
    jugadores = [];
    notifyListeners();
  }
}
