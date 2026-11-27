import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/brutalist_button.dart';
import '../../core/widgets/brutalist_card.dart';
import '../../core/widgets/exit_confirm_dialog.dart';
import '../../core/widgets/players_lobby_card.dart';
import 'data/mock_lobby_controller.dart';

class HostWaitingRoomScreen extends StatelessWidget {
  final MockLobbyController controller;

  const HostWaitingRoomScreen({super.key, required this.controller});

  Future<void> _confirmCloseRoom(BuildContext context) async {
    final shouldClose = await showBrutalistConfirmDialog(
      context: context,
      title: '¿Cerrar la sala y salir?',
      message: 'Eres el anfitrión. Si regresas a la pantalla principal, la sala se eliminará y todos los jugadores conectados serán desconectados.',
      cancelText: 'Cancelar',
      confirmText: 'Cerrar sala',
    );

    if (shouldClose && context.mounted) {
      controller.reiniciar();
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void _copyPin(BuildContext context) {
    Clipboard.setData(ClipboardData(text: controller.pin));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.obsidian,
        duration: const Duration(seconds: 2),
        content: Text(
          'PIN ${controller.pin} copiado al portapapeles',
          style: const TextStyle(
            color: AppColors.cream,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _confirmCloseRoom(context);
      },
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final bool canStart = controller.jugadores.length >= 3;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 20, 4),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => _confirmCloseRoom(context),
                          icon: const Icon(Icons.close_rounded, size: 28),
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
                            backgroundColor: AppColors.obsidian,
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'PIN DE SALA',
                                      style: TextStyle(
                                        color: AppColors.cream.withValues(
                                          alpha: 0.75,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      controller.pin,
                                      style: const TextStyle(
                                        color: AppColors.cream,
                                        fontSize: 42,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 6.0,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => _copyPin(context),
                                  child: Container(
                                    width: 54,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      color: AppColors.lavender,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const Icon(
                                      Icons.copy_rounded,
                                      color: AppColors.obsidian,
                                      size: 26,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          PlayersLobbyCard(players: controller.jugadores),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: controller.simularJugadorEntrando,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.obsidian,
                              side: const BorderSide(
                                color: AppColors.obsidian,
                                width: 2,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.person_add_alt_1_rounded),
                            label: const Text(
                              'Simular entrada de jugador (Prueba UI)',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    child: BrutalistButton(
                      label: canStart
                          ? 'Comenzar Partida'
                          : 'Esperando jugadores (mín. 3)',
                      onPressed: canStart
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppColors.obsidian,
                                  content: Text(
                                    '¡Lobby verificado! Listo para conectar Grupo 2 (Debate Absurdo).',
                                    style: TextStyle(
                                      color: AppColors.cream,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              );
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
