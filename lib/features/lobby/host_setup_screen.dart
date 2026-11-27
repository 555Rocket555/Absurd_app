import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/brutalist_button.dart';
import '../../core/widgets/brutalist_card.dart';
import '../../core/widgets/exit_confirm_dialog.dart';
import 'data/mock_lobby_controller.dart';
import 'host_waiting_room_screen.dart';

class HostSetupScreen extends StatefulWidget {
  final MockLobbyController controller;

  const HostSetupScreen({super.key, required this.controller});

  @override
  State<HostSetupScreen> createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  final _salaController = TextEditingController();
  final _aliasController = TextEditingController();

  final Set<String> _selectedCategories = {'Dilemas de Alta Prioridad'};
  bool _debateAbsurdo = true;
  bool _senalados = true;
  int _tiempoSeg = 120;

  bool get _hasUnsavedChanges {
    return _salaController.text.trim().isNotEmpty ||
        _aliasController.text.trim().isNotEmpty ||
        _selectedCategories.length != 1 ||
        !_selectedCategories.contains('Dilemas de Alta Prioridad') ||
        !_debateAbsurdo ||
        !_senalados ||
        _tiempoSeg != 120;
  }

  String get _formattedTime {
    final mins = (_tiempoSeg ~/ 60).toString().padLeft(2, '0');
    final secs = (_tiempoSeg % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  Future<void> _handleBackNavigation() async {
    if (!_hasUnsavedChanges) {
      if (mounted) Navigator.of(context).pop();
      return;
    }

    final shouldLeave = await showBrutalistConfirmDialog(
      context: context,
      title: '¿Cancelar configuración?',
      message: 'Si regresas a la pantalla principal, perderás los ajustes seleccionados para esta partida.',
      cancelText: 'Seguir editando',
      confirmText: 'Salir',
    );

    if (shouldLeave && mounted) {
      Navigator.of(context).pop();
    }
  }

  void _submitSetup() {
    final sala = _salaController.text.trim();
    final alias = _aliasController.text.trim();

    if (sala.isEmpty || alias.isEmpty) {
      _showError('Escribe un nombre para la sala y tu alias.');
      return;
    }
    if (_selectedCategories.isEmpty) {
      _showError('Selecciona al menos una categoría temática.');
      return;
    }
    if (!_debateAbsurdo && !_senalados) {
      _showError('Activa al menos un modo de juego.');
      return;
    }

    final modos = <String>{
      if (_debateAbsurdo) 'debate_absurdo',
      if (_senalados) 'senalados',
    };

    widget.controller.crearSala(
      sala: sala,
      hostAlias: alias,
      categoriasSeleccionadas: _selectedCategories.toList(),
      modos: modos,
      tiempoSeg: _tiempoSeg,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HostWaitingRoomScreen(controller: widget.controller),
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
    _salaController.dispose();
    _aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleBackNavigation();
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
                      onPressed: _handleBackNavigation,
                      icon: const Icon(Icons.arrow_back_rounded, size: 28),
                      color: AppColors.obsidian,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'CONFIGURAR PARTIDA',
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
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BrutalistCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'DATOS DE LA SESIÓN',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _salaController,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                labelText: 'Nombre de la sala',
                                hintText: 'Ej. Noche de Viernes',
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _aliasController,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                labelText: 'Tu alias (Anfitrión)',
                                hintText: 'Ej. Lucía',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      BrutalistCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CATEGORÍAS TEMÁTICAS',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: MockLobbyController.availableCategories
                                  .map((cat) {
                                    final isSelected = _selectedCategories
                                        .contains(cat);
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            _selectedCategories.remove(cat);
                                          } else {
                                            _selectedCategories.add(cat);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.obsidian
                                              : AppColors.cream,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          border: Border.all(
                                            color: AppColors.obsidian,
                                            width: 2,
                                          ),
                                        ),
                                        child: Text(
                                          cat,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                            color: isSelected
                                                ? AppColors.cream
                                                : AppColors.obsidian,
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      BrutalistCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MODOS ACTIVOS (5 RONDAS)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(height: 6),
                            CheckboxListTile(
                              value: _debateAbsurdo,
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColors.obsidian,
                              checkColor: AppColors.cream,
                              title: const Text(
                                'Debate Absurdo',
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                              subtitle: const Text(
                                '1 vs 1 defendiendo posturas opuestas ante el jurado.',
                                style: TextStyle(fontSize: 12),
                              ),
                              onChanged: (v) =>
                                  setState(() => _debateAbsurdo = v ?? false),
                            ),
                            CheckboxListTile(
                              value: _senalados,
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppColors.obsidian,
                              checkColor: AppColors.cream,
                              title: const Text(
                                'Señalados',
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                              subtitle: const Text(
                                'Voto ciego grupal seguido de explicación cara a cara.',
                                style: TextStyle(fontSize: 12),
                              ),
                              onChanged: (v) =>
                                  setState(() => _senalados = v ?? false),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      BrutalistCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'TIEMPO DE DEBATE',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Duración de la fase oral',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                _StepperButton(
                                  icon: Icons.remove,
                                  onTap: _tiempoSeg > 60
                                      ? () => setState(() => _tiempoSeg -= 30)
                                      : null,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: Text(
                                    _formattedTime,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                _StepperButton(
                                  icon: Icons.add,
                                  onTap: _tiempoSeg < 300
                                      ? () => setState(() => _tiempoSeg += 30)
                                      : null,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      BrutalistButton(
                        label: 'Crear Sala',
                        onPressed: _submitSetup,
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

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepperButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.obsidian
              : AppColors.obsidian.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.cream, size: 20),
      ),
    );
  }
}
