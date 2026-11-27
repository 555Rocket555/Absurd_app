# ABSURD APP

**Tecnología convivencial, fricción moral y autopsia filosófica.**

**Absurd APP** Funciona como un árbitro incómodo que obliga a quienes comparten una habitación a dejar el dispositivo unos momentos sobre la mesa, mirarse a los ojos y defender en voz alta posturas moralmente indefendibles.

La idea surge con la intención de disminuir el impacto negativo de la tecnología en las interacciones humanas. Es evidente para la mayoría de las personas que las formas de interacción en los eventos sociales han cambiado a lo largo de los años. Con la adopción de los dispositivos móviles como accesorios multifuncionales indispensables en el día a día, resulta difícil pedirle a una persona que ignore las notificaciones para prestar atención al momento presente.

Los temas de conversación, que antes eran variados y capaces de fortalecer lazos y acercar a las personas, han sido reemplazados casi en su totalidad por tendencias que cambian semana tras semana; como resultado, se empobrece y homogeneiza la diversidad y la cultura de la población. Esto deja de lado la profundización en los temas, el pensamiento crítico, las relaciones interpersonales y las cuestiones y sentimientos que nos hacen humanos.

Absurd App busca que las personas se cuestionen, miren a su alrededor y conversen sobre cuestiones inherentemente humanas; que se quiten por un momento la máscara y el velo de las tendencias actuales y que, de forma absurda, disfruten un momento más de tantos.

El sistema opera como un laboratorio social de cinco rondas. Mientras los participantes discuten, negocian lealtades y se traicionan mutuamente, un modelo de lenguaje actúa como un maquina de juegos automatizada. Sin mencionar tecnicismos ni palabras sofisticadas durante la partida, el motor evalúa las decisiones del grupo a través de diversos marcos teóricos.

Al concluir la sesión, la aplicación abandona toda cortesía y entrega a cada jugador una tarjeta con el diagnóstico satírico de su verdadera arquitectura moral (Parodia de resultado de "test de personalidad").

---

Alternativa corta:
Absurd App nace para contrarrestar el efecto de la tecnología sobre las interacciones humanas. En los eventos sociales, los móviles y las notificaciones nos sacan del presente; las conversaciones se vuelven tendencias efímeras que empobrecen la diversidad cultural y dejan fuera la profundidad, el pensamiento crítico, los vínculos y lo que nos hace humanos. La app propone lo contrario: un momento absurdo para mirar alrededor, cuestionarnos y conversar sobre lo inherentemente humano; quitarnos por un rato la máscara y el velo de lo popular para disfrutar más de los demás.

---

---

## Arquitectura y Stack Tecnológico

- **Cliente Móvil (Frontend):** Desarrollado en **Flutter (Dart)**

- **Sincronización de Estado (Backend):** **Firebase Realtime Database**.

- **Motor Narrativo (LLM):** Integración con API de Modelos de Lenguaje (LLM) con validación estricta de esquema JSON para generar dilemas contextuales, emitir veredictos de ronda y clasificar a cada jugador dentro de un catálogo cerrado de 16 arquetipos filosóficos.

---

## Mecánicas de Interacción

1. **Modo A — Debate Absurdo (Flujo Bifurcado):** El sistema divide a la sala en _Defensor_, _Detractor_ y _Público_. Los debatientes reciben posturas radicalmente opuestas que deben sostener a muerte.
   Durante la discusión oral, la pantalla entra en modo de bloqueo cromático (_Obsidian_) con una capa interactiva _Hold-to-Reveal_ que oculta las instrucciones a simple vista y solo las revela mientras el propietario mantiene el dedo presionado sobre su dispositivo.
2. **Modo B — Señalados (Flujo Lineal):** Todo el grupo enfrenta simultáneamente un dilema relacional o ético. Cada jugador emite primero un voto ciego para señalar al integrante de la mesa que mejor encaja en la premisa, seguido del revelado de resultados y la discusión presencial.
3. **Cierre y Diagnóstico:** Al completar las cinco rondas, el sistema cruza el historial de victorias argumentativas contra los señalamientos recibidos para asignar un arquetipo satírico exportable en formato de imagen.

---

## Estructura del Proyecto

La arquitectura del repositorio separa la documentación, los recursos gráficos y el código fuente organizado por responsabilidades funcionales:

```text
absurd_app/
├── docs/                                  # Documentación técnica del proyecto
│   ├── 01_especificacion_pantallas.md       # Idea funcional y visual de las 13 pantallas
│   ├── 02_esquema_firebase_fsm.md           # JSON en Firebase y Máquina de Estados Finitos
│   ├── 03_prompts_game_master.md            # Prompts estructurados y reglas de salida del LLM
│   └── 04_justificacion_hci.md              # Fundamentación teórica (Interacción Humano-Computadora)
│
├── assets/                                # Recursos estáticos declarados en pubspec.yaml
│   ├── icons/                               # Íconos vectoriales simples en formato SVG
│   └── images/                              # Ilustraciones editoriales PNG (3x) con canal alfa
│       ├── personajes/                      # Retratos de los 16 arquetipos del diagnóstico final
│       └── ui/                              # Ilustraciones de interfaz (cabecera, temporizador Sísifo)
│
├── lib/
│   ├── main.dart                          # Punto de entrada, inicialización de Firebase y MaterialApp
│   │
│   ├── core/                              # Núcleo transversal de diseño, constantes y widgets base
│   │   ├── constants/
│   │   │   ├── app_colors.dart            # Paleta oficial (#BCBDF0, #1D1D1F, #FAF5F0)
│   │   │   ├── game_categories.dart       # Catálogo de las 6 categorías temáticas de debate
│   │   │   └── diagnosis_catalog.dart     # Mapeo cerrado de los 16 personaje_id a assets y autores
│   │   ├── theme/
│   │   │   └── app_theme.dart             # Configuración tipográfica y estilos globales de bordes
│   │   └── widgets/                       # Componentes neobrutalistas reutilizables en toda la app
│   │       ├── brutalist_card.dart        # Contenedor estándar con borde grueso y sombra sólida
│   │       ├── brutalist_button.dart      # Botón tipo píldora en variantes Obsidian y Cream
│   │       ├── segmented_round_bar.dart   # Indicador superior de progreso (5 bloques + modo activo)
│   │       ├── hold_to_reveal_card.dart   # Capa de privacidad táctil (GestureDetector + Listener)
│   │       ├── exit_confirm_dialog.dart   # Modales de confirmación para PopScope y cierre de sala
│   │       └── players_lobby_card.dart    # Tarjeta de jugadores conectados y cupos en sala
│   │
│   ├── models/                            # Estructuras de datos tipadas (serialización fromJson/toJson)
│   │   ├── room_model.dart                  # Representación del nodo /salas/{pin}, config y estado
│   │   ├── player_model.dart                # Datos del participante, rol actual y métricas acumuladas
│   │   ├── round_model.dart                 # Estructura de ronda, posturas, votos y veredicto IA
│   │   └── diagnosis_model.dart             # Modelo de carta coleccionable del diagnóstico final
│   │
│   ├── services/                          # Capa de comunicación externa y lógica de negocio
│   │   ├── firebase_room_service.dart       # Gestión de salas, validación de PIN, votos y limpieza
│   │   ├── llm_game_master_service.dart     # Peticiones a la API del LLM y parseo de respuestas JSON
│   │   └── share_card_service.dart          # Renderizado de widget a PNG y hoja nativa de compartir
│   │
│   └── features/                          # Módulos de interfaz divididos por flujo de usuario
│       ├── game_router/
│       │   └── room_state_router.dart     # StreamBuilder raíz que sincroniza pantallas según fase
│       ├── lobby/                         # Grupo 1: Entrada, creación y salas de espera
│       │   ├── data/
│       │   │   └── mock_lobby_controller.dart   # Controlador simulado para pruebas locales de UI
│       │   ├── home_screen.dart           # Pantalla principal (Crear Sala / Unirse a Sala)
│       │   ├── host_setup_screen.dart     # Configuración de sala, categorías, modos y tiempo
│       │   ├── host_waiting_room_screen.dart    # Sala de espera del anfitrión con PIN y control de inicio
│       │   ├── player_join_screen.dart    # Formulario de ingreso mediante PIN de 4 dígitos
│       │   └── player_waiting_room_screen.dart  # Sala de espera del invitado con resumen de reglas
│       ├── debate/                        # Grupo 2: Flujo bifurcado del modo Debate Absurdo
│       │   ├── debate_role_screen.dart    # Lectura privada de postura y duelo de turnos (Defensor/Detractor/Público)
│       │   ├── debate_timer_screen.dart   # Cronómetro regresivo con capa oscura Hold-to-Reveal
│       │   └── debate_decision_screen.dart # Votación del público y pantalla de espera de debatientes
│       ├── senalados/                     # Grupo 3: Flujo lineal del modo Señalados
│       │   ├── senalados_voting_screen.dart     # Exposición del dilema y votación ciega inicial
│       │   └── senalados_discussion_screen.dart # Revelado de señalado, primer comentario y debate grupal
│       ├── shared_round/                  # Vistas compartidas entre ambos modos de juego
│       │   └── round_results_screen.dart  # Conteo de votos, veredicto IA y cierre tras ronda 5
│       └── diagnosis/                     # Grupo 4: Resolución filosófica de la partida
│           ├── final_diagnosis_screen.dart      # Carrusel PageView y controles de exportación
│           └── widgets/
│               └── trading_card_widget.dart     # Anatomía visual de la carta coleccionable
│
└── pubspec.yaml                           # Declaración de dependencias y rutas de assets
```

---

## Requisitos Previos y Ejecución Local

### Requisitos del Entorno

- **Flutter SDK:** Versión 3.19.0 o superior.
- **Dart SDK:** Versión 3.3.0 o superior.
- **Entorno de Ejecución:** Dispositivo físico Android/iOS con depuración USB habilitada, emulador configurado o entorno de escritorio nativo (Linux/macOS/Windows) para pruebas rápidas de interfaz.
- **Credenciales de Servicios:** Archivo de configuración de Firebase (`google-services.json` para Android / `GoogleService-Info.plist` para iOS) y clave de API del proveedor LLM (requeridos una vez integrados los servicios en `lib/services/`).

### Instalación y Despliegue

1. **Clonar el repositorio:**

   ```bash
   git clone [https://github.com/555Rocket555/Absurd_app.git](https://github.com/555Rocket555/Absurd_app.git)
   cd Absurd_app
   ```

2. **Descargar dependencias aisladas del proyecto:**

   ```bash
   flutter pub get
   ```

3. **Verificar dispositivos disponibles:**

   ```bash
   flutter devices
   ```

4. **Compilar y ejecutar en modo desarrollo:**
   ```bash
   flutter run
   ```
