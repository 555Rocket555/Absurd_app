absurd_app/
├── docs/                                # Documentación viva del proyecto (HCI + Arquitectura)
│   ├── 01_especificacion_pantallas.md   # Documento consolidado de los 4 grupos de UI
│   ├── 02_esquema_firebase_fsm.md       # Esquema JSON y Máquina de Estados
│   ├── 03_prompts_game_master.md        # System prompts y esquemas de salida de la IA
│   └── 04_justificacion_hci.md          # Marco teórico (Tecnología Convivencial y Phubbing)
├── assets/
│   ├── icons/                           # Íconos vectoriales (.svg): candado, corona, copiar, check
│   └── images/                          # Ilustraciones PNG (3x) / WebP con fondo transparente
│       ├── personajes/                  # 16 cartas del diagnóstico (abogado_diablo.png, etc.)
│       └── ui/                          # Mascota header y Sísifo (sisifo_timer.png)
├── lib/
│   ├── main.dart                        # Inicialización de Firebase, ThemeData y punto de entrada
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart          # Paleta estricta: Lavender (#BCBDF0), Obsidian (#1D1D1F), Cream (#FAF5F0)
│   │   │   ├── game_categories.dart     # Catálogo de 6 categorías temáticas y reglas
│   │   │   └── diagnosis_catalog.dart   # Mapeo de los 16 personaje_id a assets y marcas de agua
│   │   ├── theme/
│   │   │   └── app_theme.dart           # Tipografía editorial, bordes gruesos y estilos globales
│   │   └── widgets/                     # Componentes neobrutalistas reutilizables
│   │       ├── brutalist_card.dart      # Contenedor Cream/Obsidian con borde 2.5px y hard shadow
│   │       ├── brutalist_button.dart    # Botón tipo píldora (primario Obsidian / secundario Cream)
│   │       ├── segmented_round_bar.dart # Barra superior de 5 bloques + píldora de modo
│   │       ├── hold_to_reveal_card.dart # Capa oscura interactiva (GestureDetector + Listener)
│   │       └── exit_confirm_dialog.dart # Modales estandarizados para PopScope y cierre de sala
│   ├── models/                          # Modelos de datos serializables (fromJson / toJson)
│   │   ├── room_model.dart              # Modelo completo de /salas/{pin} y estado
│   │   ├── player_model.dart            # Modelo de jugador, roles y métricas
│   │   ├── round_model.dart             # Modelo de ronda, posturas, votos y resultado
│   │   └── diagnosis_model.dart         # Modelo de tarjeta coleccionable de diagnóstico
│   ├── services/                        # Lógica de negocio, red y estado
│   │   ├── firebase_room_service.dart   # CRUD en Realtime Database, PINs, votos y limpieza
│   │   ├── llm_game_master_service.dart # Conexión con API Gemini/OpenAI y parseo JSON
│   │   └── share_card_service.dart      # Captura de widget a PNG y hoja nativa de compartir
│   └── features/                        # Pantallas agrupadas por módulo funcional
│       ├── game_router/
│       │   └── room_state_router.dart   # StreamBuilder maestro que sincroniza pantallas por fase
│       ├── lobby/                       # Grupo 1: Entrada y Configuración
│       │   ├── home_screen.dart
│       │   ├── host_setup_screen.dart
│       │   ├── host_waiting_room_screen.dart
│       │   ├── player_join_screen.dart
│       │   └── player_waiting_room_screen.dart
│       ├── debate/                      # Grupo 2: Modo Debate Absurdo
│       │   ├── debate_intro_screen.dart
│       │   ├── debate_role_screen.dart
│       │   ├── debate_timer_screen.dart
│       │   └── debate_decision_screen.dart
│       ├── senalados/                   # Grupo 3: Modo Señalados
│       │   ├── senalados_intro_screen.dart
│       │   ├── senalados_situation_screen.dart
│       │   └── senalados_voting_screen.dart
│       ├── shared_round/                # Pantalla compartida entre Grupos 2 y 3
│       │   └── round_results_screen.dart
│       └── diagnosis/                   # Grupo 4: Cierre de Partida
│           ├── final_diagnosis_screen.dart
│           └── widgets/
│               └── trading_card_widget.dart
└── pubspec.yaml
