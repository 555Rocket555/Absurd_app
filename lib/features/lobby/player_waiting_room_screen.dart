import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/brutalist_card.dart';
import '../../core/widgets/exit_confirm_dialog.dart';
import '../../core/widgets/players_lobby_card.dart';
import 'data/mock_lobby_controller.dart';

class PlayerWaitingRoomScreen extends StatelessWidget {
  final MockLobbyController controller;

  const PlayerWaitingRoomScreen({super.key, required this.controller});

  Future<void> _confirmLeaveRoom(BuildContext context) async {
    final shouldLeave = await showBrutalistConfirmDialog(
      context: context,
      title: '¿Abandonar la sala?',
      message:
          "Saldrás de la sala '${controller.nombreSala}'. Si deseas volver, tendrás que ingresar el PIN nuevamente.",
      cancelText: 'Quedarme',
      confirmText: 'Abandonar',
    );

    if (shouldLeave && context.mounted) {
      controller.reiniciar();
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  String get _modosTexto {
    final labels = <String>[
      if (controller.modosActivos.contains('debate_absurdo')) 'Debate Absurdo',
      if (controller.modosActivos.contains('senalados')) 'Señalados',
    ];
    return labels.join(' + ');
  }

  String get _tiempoTexto {
    final mins = (controller.tiempoDebateSeg ~/ 60).toString().padLeft(2, '0');
    final secs = (controller.tiempoDebateSeg % 60).toString().padLeft(2, '0');
    return '$mins:$secs min';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _confirmLeaveRoom(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 20, 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => _confirmLeaveRoom(context),
                      icon: const Icon(Icons.arrow_back_rounded, size: 28),
                      color: AppColors.obsidian,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        controller.nombreSala.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BrutalistCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CONFIGURACIÓN DE LA PARTIDA',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _SummaryRow(label: 'Modos:', value: _modosTexto),
                            const SizedBox(height: 6),
                            _SummaryRow(label: 'Debate:', value: _tiempoTexto),
                            const SizedBox(height: 6),
                            _SummaryRow(
                              label: 'Temas:',
                              value: controller.categorias.join(', '),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      PlayersLobbyCard(players: controller.jugadores),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.obsidian,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.cream,
                        ),
                      ),
                      SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          'Esperando a que el anfitrión inicie la partida...',
                          style: TextStyle(
                            color: AppColors.cream,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
