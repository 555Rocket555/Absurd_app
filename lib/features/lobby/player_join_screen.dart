import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/brutalist_button.dart';
import '../../core/widgets/brutalist_card.dart';
import 'data/mock_lobby_controller.dart';
import 'player_waiting_room_screen.dart';

class PlayerJoinScreen extends StatefulWidget {
  final MockLobbyController controller;

  const PlayerJoinScreen({super.key, required this.controller});

  @override
  State<PlayerJoinScreen> createState() => _PlayerJoinScreenState();
}

class _PlayerJoinScreenState extends State<PlayerJoinScreen> {
  final _pinController = TextEditingController();
  final _aliasController = TextEditingController();

  void _joinRoom() {
    final pin = _pinController.text.trim();
    final alias = _aliasController.text.trim();

    if (pin.length != 4) {
      _showError('Ingresa un PIN válido de 4 dígitos.');
      return;
    }
    if (alias.isEmpty) {
      _showError('Escribe tu alias para entrar a la sala.');
      return;
    }

    widget.controller.unirseASala(pinIngresado: pin, playerAlias: alias);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PlayerWaitingRoomScreen(controller: widget.controller),
      ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.obsidian,
        content: Text(
          msg,
          style: const TextStyle(
            color: AppColors.cream,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    _aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 20, 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_rounded, size: 28),
                    color: AppColors.obsidian,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'UNIRSE A SALA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    BrutalistCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'PIN DE 4 DÍGITOS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _pinController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 12,
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              hintText: '0000',
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'TU ALIAS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _aliasController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              hintText: 'Ej. Sofi',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    BrutalistButton(label: 'Unirse', onPressed: _joinRoom),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
