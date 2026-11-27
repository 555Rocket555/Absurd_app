import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/brutalist_button.dart';
import '../../core/widgets/brutalist_card.dart';
import 'data/mock_lobby_controller.dart';
import 'host_setup_screen.dart';
import 'player_join_screen.dart';

class HomeScreen extends StatelessWidget {
  final MockLobbyController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _BackgroundThinkersLayer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  const _BrandHeaderCard(),
                  const Spacer(flex: 3),
                  BrutalistButton(
                    label: 'Crear Sala',
                    isPrimary: true,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              HostSetupScreen(controller: controller),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BrutalistButton(
                    label: 'Unirse a Sala',
                    isPrimary: false,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              PlayerJoinScreen(controller: controller),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandHeaderCard extends StatelessWidget {
  const _BrandHeaderCard();

  @override
  Widget build(BuildContext context) {
    return BrutalistCard(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      shadowOffset: const Offset(6, 6),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'ABSURD',
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w900,
                color: AppColors.obsidian,
                letterSpacing: -1.5,
              ),
            ),
            const SizedBox(width: 10),
            Transform.rotate(
              angle: -0.07,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.obsidian,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'APP',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: AppColors.cream,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundThinkersLayer extends StatelessWidget {
  const _BackgroundThinkersLayer();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          _floatingPortrait(
            asset: 'assets/images/personajes/policia_moral.png',
            top: 24,
            left: -14,
            size: 112,
            angle: -0.18,
          ),
          _floatingPortrait(
            asset: 'assets/images/personajes/martillo_sin_piedad.png',
            top: 40,
            right: -12,
            size: 115,
            angle: 0.2,
          ),
          _floatingPortrait(
            asset: 'assets/images/personajes/abogado_diablo.png',
            top: 170,
            left: 28,
            size: 86,
            angle: 0.12,
          ),
          _floatingPortrait(
            asset: 'assets/images/personajes/detective_excusas.png',
            top: 165,
            right: 26,
            size: 88,
            angle: -0.15,
          ),
          _floatingPortrait(
            asset: 'assets/images/personajes/rebelde_absurdo.png',
            bottom: 185,
            left: -10,
            size: 105,
            angle: 0.16,
          ),
          _floatingPortrait(
            asset: 'assets/images/personajes/vigilante_panoptico.png',
            bottom: 180,
            right: -10,
            size: 105,
            angle: -0.16,
          ),
          _floatingPortrait(
            asset: 'assets/images/personajes/cinico_barril.png',
            bottom: 16,
            left: 18,
            size: 92,
            angle: -0.12,
          ),
          _floatingPortrait(
            asset: 'assets/images/personajes/pesimista_profesional.png',
            bottom: 16,
            right: 18,
            size: 92,
            angle: 0.14,
          ),
        ],
      ),
    );
  }

  Widget _floatingPortrait({
    required String asset,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required double angle,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: angle * math.pi / 2,
        child: Opacity(
          opacity: 0.34,
          child: Image.asset(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
