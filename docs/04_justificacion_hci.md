# 04. Justificación Teórica y Fundamentos de Interacción Humano-Computadora (HCI) — Absurd APP

**Versión:** 1.1  
**Área:** Interacción Humano-Computadora (HCI), Diseño Ético y Psicología Social  
**Aplicación:** Absurd APP (Arquitectura Flutter + Firebase + LLM)

---

## 1. Planteamiento del Problema: El _Phubbing_ y la Captura de Atención

En entornos sociales presenciales, los dispositivos móviles operan frecuentemente como agentes de aislamiento mediante el fenómeno conocido como **_phubbing_** (_phone snubbing_): el acto de ignorar a los interlocutores físicos para atender estímulos en pantalla (Chotpitayasunondh & Douglas, 2016).

La mayoría de los videojuegos móviles multijugador replican modelos de interfaz diseñados para maximizar el tiempo de retención visual (_screen time_), exigiendo atención continua sobre animaciones, controles virtuales complejos y bucles de recompensa infinitos. Como consecuencia, incluso cuando un grupo de personas comparte el mismo espacio físico, la interacción se fragmenta en experiencias individuales mediadas por la pantalla, reduciendo el contacto visual, la lectura del lenguaje no verbal y la conversación espontánea.

**Tesis de diseño de Absurd APP:** Invertir el rol tradicional del teléfono inteligente en reuniones sociales, transformándolo de un sumidero de atención visual en un **catalizador efímero de interacción cara a cara**.

---

## 2. Paradigma Central: Tecnología Convivencial

El diseño de interacción de **Absurd APP** se fundamenta en el concepto de **herramientas convivenciales** propuesto por Ivan Illich (1973), quien distingue entre tecnologías industriales que monopolizan la agencia del usuario y herramientas convivenciales que amplían la autonomía, la creatividad y la relación directa entre personas sin subordinarlas al dispositivo.

En el flujo de **Absurd APP**, el teléfono móvil cumple exclusivamente tres funciones instrumentales de baja fricción:

1. **Distribución de información asimétrica:** Entrega secreta de posturas opuestas (_Defensor_ vs. _Detractor_) o dilemas grupales mediante sincronización en tiempo real.
2. **Arbitraje imparcial de turnos y tiempos:** Selección automatizada de quién inicia el argumento o comentario, junto con cronómetros compartidos que ordenan el debate sin intervención de un moderador humano.
3. **Escrutinio secreto (Voto Ciego):** Recolección privada de juicios individuales para evitar la presión de grupo antes de revelar los resultados.

El procesamiento central del juego —argumentar, persuadir, detectar contradicciones, reír y negociar— ocurre **fuera de la pantalla**, en el espacio físico entre los participantes.

---

## 3. Gestión de Carga Cognitiva y Diseño Neobrutalista

De acuerdo con la **Teoría de la Carga Cognitiva** de John Sweller (1988), la memoria de trabajo humana posee una capacidad limitada; si una interfaz exige esfuerzo para descifrar jerarquías visuales, menús profundos o efectos decorativos, se incrementa la _carga cognitiva extrínseca_ en detrimento de la tarea principal.

### 3.1. Minimalismo Neobrutalista y Paleta Cromática Estricta

La interfaz utiliza un sistema visual **neobrutalista editorial** basado únicamente en tres tokens cromáticos: **Lavender** (`#BCBDF0`), **Obsidian** (`#1D1D1F`) y **Cream** (`#FAF5F0`):

- **Alto contraste tipográfico:** Garantiza legibilidad inmediata a distancia sobre una mesa, permitiendo que los jugadores comprendan un dilema en menos de 3 segundos.
- **Eliminación de ruido visual:** La ausencia de degradados, sombras difusas y micro-animaciones ornamentales reduce la fatiga visual y evita que la pantalla compita por la atención durante el debate.

### 3.2. Divulgación Progresiva y Eliminación de Fricción de Entrada

- **Configuración por selección categórica (`HostSetupScreen`):** En lugar de exigir que los usuarios redacten temas manualmente (alta carga de generación), la selección mediante chips temáticos predefinidos y un PIN de 4 dígitos permite iniciar una partida en menos de 30 segundos.
- **Sustitución de pantallas introductorias por ayuda contextual (`ModeInfoButton`):** Para evitar interrupciones pasivas entre rondas, las reglas se encapsulan en un botón compacto de información (`?`), manteniendo el ritmo dinámico de la sesión.

### 3.3. Oclusión Táctil e Inversión Cromática (`Hold-to-Reveal`)

En `DebateTimerScreen`, la interfaz aplica una **inversión cromática total** hacia **Obsidian** (`#1D1D1F`) acompañada de la instrucción explícita _"Teléfonos abajo. Debate en curso."_ Para proteger la privacidad de los roles sin obligar al usuario a bloquear su teléfono, la postura secreta queda cubierta por una capa oscura que solo se retira mientras el usuario mantiene presionada físicamente la pantalla (`GestureDetector` / `Listener`). Al soltar el dedo, la información vuelve a ocultarse, reforzando conductualmente el gesto de dejar el dispositivo sobre la mesa.

---

## 4. Diseño Conductual (Modelo de Fogg) y Psicología de Grupos

El flujo de las 5 rondas aplica los tres componentes del **Modelo Conductual de Fogg ($B = MAP$)** (Fogg, 2009) para detonar la participación oral sin incomodidad social:

- **Motivación (_Motivation_):** Se activa mediante dilemas morales cotidianos con alta carga humorística y curiosidad social (_"¿Quién del grupo encaja mejor en esta conducta?"_).
- **Habilidad / Simplicidad (_Ability_):** En reuniones grupales suele existir una barrera inicial de indecisión sobre quién debe hablar primero. **Absurd APP** elimina esa fricción mediante dos mecanismos visuales:
  1. `SpeakerFocusDuel` en _Debate Absurdo_ (alternancia visual de foco que designa automáticamente si inicia el _Defensor_ o el _Detractor_).
  2. `FirstCommentSpotlight` en _Señalados_ (selección aleatoria del participante que comparte el primer comentario tras votar).
- **Detonantes (_Prompts_):**
  - **Señales hápticas no intrusivas:** Al expirar el tiempo de debate (`00:00`), el teléfono emite una vibración intensa (`HapticFeedback.heavyImpact()`), notificando el cambio de fase sin exigir que los jugadores miren constantemente el reloj.
  - **Votación ciega previa a la discusión en _Señalados_:** Al invertir el flujo tradicional (votar primero por instinto en `SenaladosVotingScreen` y debatir después en `SenaladosDiscussionScreen`), se neutraliza el _sesgo de conformidad_ (Asch, 1951), evitando que los jugadores copien el voto de la mayoría antes de expresar su propio criterio.

---

## 5. Ética de Diseño y Ausencia de Patrones Oscuros (_Anti-Dark Patterns_)

A diferencia de las aplicaciones orientadas a la economía de la atención, **Absurd APP** incorpora principios explícitos de diseño ético (Gray et al., 2018):

1. **Sesiones acotadas (Finitud deliberada):** Toda partida consta estrictamente de **5 rondas** (aproximadamente 10 a 15 minutos), ofreciendo un arco narrativo completo con inicio, clímax y cierre, sin mecánicas de desplazamiento infinito (_infinite scroll_) ni penalizaciones por abandono.
2. **Transparencia y control de salida (`PopScope`):** Todas las pantallas de configuración, espera y juego interceptan el gesto/botón de retroceso del sistema operativo mediante diálogos claros sobre el impacto en la sala. Asimismo, a partir de la 3ra ronda se habilita al anfitrión la opción explícita **`Terminar partida`** con confirmación transparente.
3. **Privacidad por diseño y efimeridad:** No requiere registro de cuentas personales, correos electrónicos ni permisos invasivos. Los nodos de sala en Firebase Realtime Database son efímeros y se destruyen al concluir o cerrar la sesión.

---

## 6. Gamificación Reflexiva: De la Intuición Moral al Marco Filosófico

El diseño pedagógico y narrativo del juego se apoya en el **Modelo Intuicionista Social** de Jonathan Haidt (2001) y en la teoría de **proceso dual de la moralidad** de Joshua Greene (2013), quienes demuestran que las personas toman juicios morales rápidos basados en intuiciones emocionales o pragmáticas y posteriormente construyen justificaciones racionales _post hoc_.

- **Durante las Rondas 1 a 5 (Inmersión natural):** El sistema prohíbe explícitamente términos académicos o nombres de autores. Esto evita intimidar al usuario y permite que cada jugador argumente o señale con espontaneidad.
- **En el Cierre (`FinalDiagnosisScreen` — Metacognición lúdica):** Al concluir la quinta ronda, el motor de IA sintetiza el historial de victorias, derrotas y señalamientos de cada participante y lo traduce en una de **16 cartas coleccionables** asociadas a pensadores reales (Sartre, Kant, Mill, Nietzsche, Schopenhauer, Bauman, Foucault, Marx, Camus, Simone de Beauvoir, Greene, Haidt, Kohlberg, Bandura, Maquiavelo y Diógenes). De este modo, el diagnóstico funciona como un espejo satírico que transforma conductas cotidianas en aprendizaje reflexivo y conversación posterior al cierre de la app.

---

## 7. Matriz de Trazabilidad: Teoría HCI $\rightarrow$ Implementación en Absurd APP

| Principio / Marco Teórico                                 | Problema que Resuelve                                          | Decisión de Diseño en Absurd APP                                                                                  |
| :-------------------------------------------------------- | :------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| **Tecnología Convivencial** (Illich, 1973)                | Aislamiento social por uso de pantallas en grupo (_phubbing_). | Teléfono usado solo para roles secretos y votos; debate 100% oral y presencial.                                   |
| **Carga Cognitiva** (Sweller, 1988)                       | Distracción y fatiga visual por interfaces sobrecargadas.      | Paleta estricta de 3 colores (`#BCBDF0`, `#1D1D1F`, `#FAF5F0`), bordes limpios y ayuda bajo demanda (`?`).        |
| **Oclusión Táctil y Affordance** (Norman, 2013)           | Miradas constantes al teléfono durante la conversación.        | Lienzo oscuro **Obsidian** en `DebateTimerScreen` con mecánica _Hold-to-Reveal_ y vibración háptica al finalizar. |
| **Modelo Conductual B=MAP** (Fogg, 2009)                  | Silencios incómodos al iniciar turnos de palabra.              | Animación `SpeakerFocusDuel` y asignación `FirstCommentSpotlight` para detonar la discusión.                      |
| **Sesgo de Conformidad** (Asch, 1951)                     | Influencia grupal que distorsiona la votación inicial.         | Votación ciega obligatoria antes de abrir la discusión en el modo _Señalados_.                                    |
| **Intuicionismo Social** (Haidt, 2001)                    | Barrera académica si se presenta teoría antes de jugar.        | Lenguaje coloquial en rondas 1–5; revelación filosófica satírica únicamente en las cartas de cierre.              |
| **Diseño Ético / Anti-Dark Patterns** (Gray et al., 2018) | Retención compulsiva y retención opaca de datos.               | Partidas finitas de 5 rondas, cierre anticipado tras ronda 3 y eliminación inmediata de salas en Firebase.        |

---

## 8. Referencias Bibliográficas (APA 7)

- Asch, S. E. (1951). Effects of group pressure upon the modification and distortion of judgments. En H. Guetzkow (Ed.), _Groups, leadership and men_ (pp. 177–190). Carnegie Press.
- Chotpitayasunondh, V., & Douglas, K. M. (2016). How "phubbing" becomes the norm: The antecedents and consequences of snubbing via smartphone. _Computers in Human Behavior_, 63, 9–18. https://doi.org/10.1016/j.chb.2016.05.018
- Fogg, B. J. (2009). A behavior model for persuasive design. _Proceedings of the 4th International Conference on Persuasive Technology_, 1–7. https://doi.org/10.1145/1541948.1541999
- Gray, C. M., Kou, Y., Battles, B., Hoggatt, J., & Toombs, A. L. (2018). The dark (patterns) side of UX design. _Proceedings of the 2018 CHI Conference on Human Factors in Computing Systems_, 1–14. https://doi.org/10.1145/3173574.3174108
- Greene, J. D. (2013). _Moral tribes: Emotion, reason, and the gap between us and them_. Penguin Press.
- Haidt, J. (2001). The emotional dog and its rational tail: A social intuitionist approach to moral judgment. _Psychological Review_, 108(4), 814–834. https://doi.org/10.1037/0033-295X.108.4.814
- Illich, I. (1973). _Tools for conviviality_. Harper & Row.
- Norman, D. A. (2013). _The design of everyday things_ (Revised and expanded ed.). Basic Books.
- Sweller, J. (1988). Cognitive load during problem solving: Effects on learning. _Cognitive Science_, 12(2), 257–285. https://doi.org/10.1207/s15516709cog1202_4
