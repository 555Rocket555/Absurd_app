import 'package:flutter/material.dart';

import '../../features/lobby/data/mock_lobby_controller.dart';
import '../constants/app_colors.dart';
import '../constants/diagnosis_catalog.dart';
import 'brutalist_card.dart';

class PlayersLobbyCard extends StatelessWidget {
  final List<MockPlayer> players;
  final int minPlayers;

  const PlayersLobbyCard({
    super.key,
    required this.players,
    this.minPlayers = 3,
  });

  @override
  Widget build(BuildContext context) {
    final int missingSlots = players.length < minPlayers
        ? (minPlayers - players.length)
        : 0;

    return BrutalistCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'JUGADORES EN SALA',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: players.length >= minPlayers
                      ? AppColors.obsidian
                      : AppColors.lavender,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.obsidian, width: 2),
                ),
                child: Text(
                  '${players.length} / $minPlayers mín.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: players.length >= minPlayers
                        ? AppColors.cream
                        : AppColors.obsidian,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...players.map(
            (player) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _PlayerPill(player: player),
            ),
          ),
          ...List.generate(
            missingSlots,
            (_) => const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: _EmptyPlayerSlot(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerPill extends StatelessWidget {
  final MockPlayer player;

  const _PlayerPill({required this.player});

  @override
  Widget build(BuildContext context) {
    final archetype = DiagnosisCatalog.getById(player.avatarId);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lavender.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.obsidian, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.cream,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.obsidian, width: 2),
            ),
            child: Image.asset(archetype.assetPath, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              player.alias,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.obsidian,
              ),
            ),
          ),
          if (player.esHost)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.obsidian,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.workspace_premium,
                    color: AppColors.cream,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'HOST',
                    style: TextStyle(
                      color: AppColors.cream,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyPlayerSlot extends StatelessWidget {
  const _EmptyPlayerSlot();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(
              Icons.person_outline,
              size: 22,
              color: AppColors.obsidian.withValues(alpha: 0.45),
            ),
            const SizedBox(width: 12),
            Text(
              'Esperando...',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: AppColors.obsidian.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.obsidian.withValues(alpha: 0.45)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(12),
    );
    final path = Path()..addRRect(rrect);

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
