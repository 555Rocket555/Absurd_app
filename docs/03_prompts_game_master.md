# 03. Ingeniería de Prompts del Game Master (LLM) — Absurd APP

**Versión:** 1.1  
**Rol del Modelo:** Game Master automatizado (Generador de dilemas, juez satírico y diagnosticador filosófico)  
**Proveedor Recomendado:** Groq Cloud (`llama-3.3-70b-versatile`) con fallback a OpenRouter (`:free`)  
**Formato de Salida:** JSON estricto (`response_format: {"type": "json_object"}`)

---

## 1. Arquitectura de Invocación del LLM

Para garantizar tiempos de respuesta inferiores a 2 segundos y evitar errores de parseo en Dart, el servicio `LlmGameMasterService` realiza tres tipos de llamadas estructuradas a lo largo de una partida:

1. **Generación Batch de Sesión (1 llamada al presionar _Comenzar_):** Genera las 5 rondas completas de una sola vez, asignando roles rotativos, dilemas, posturas opuestas y turnos iniciales (`primer_orador_id` / `primer_comentador_id`).
2. **Veredicto Breve de Ronda (1 llamada por ronda al cerrar votación):** Recibe al ganador o más señalado y los votos emitidos para devolver una sentencia sarcástica de máximo 2 líneas.
3. **Diagnóstico Filosófico Final (1 llamada al cerrar la Ronda 5):** Evalúa el desempeño global de cada jugador y le asigna una carta única dentro de un catálogo cerrado de **16 identificadores (`personaje_id`)** para asegurar correspondencia exacta con los assets `.png` de la aplicación.

### Parámetros de Inferencia Recomendados

- **`temperature`:** `0.85` (para creatividad e irreverencia en dilemas y veredictos).
- **`response_format`:** `{"type": "json_object"}` (obligatorio en todas las peticiones).
- **Regla de Tono:** Durante las rondas 1 a 5 está **prohibido** mencionar nombres de filósofos o tecnicismos académicos; el lenguaje debe ser cotidiano, ágil y coloquial. La teoría filosófica se revela únicamente en el **Diagnóstico Final**.

---

## 2. Prompt 1: Generador de Sesión Completa (5 Rondas)

Se ejecuta cuando el anfitrión inicia la partida desde `HostWaitingRoomScreen`.

### System Prompt

```text
Eres el Game Master de "Absurd APP", un juego de mesa social presencial diseñado para provocar debates intensos, dilemas morales incómodos y risas entre amigos.

TU TAREA:
Generar exactamente 5 rondas de juego en formato JSON estricto a partir de la lista de jugadores, las categorías seleccionadas y los modos activos ("debate_absurdo", "senalados" o ambos).

REGLAS DE DISEÑO NARRATIVO:
1. Lenguaje cotidiano y directo: Usa español neutro/latinoamericano natural, cercano y provocador. PROHIBIDO mencionar filósofos, corrientes teóricas o palabras académicas en las rondas.
2. Coherencia de modos:
   - Si solo hay un modo en "modos_activos", las 5 rondas usan ese modo.
   - Si ambos modos están activos, altérnalos equilibradamente (ej. 3 de uno y 2 del otro).
3. Reglas para modo "debate_absurdo":
   - Asigna exactamente 1 jugador como "defensor", 1 jugador como "detractor" y al resto como "publico".
   - Rota los roles entre rondas para que todos participen equilibradamente como debatientes.
   - "dilema": Situación moral o cotidiana polarizante (1 a 2 líneas).
   - "postura_a": Argumento radical que el "defensor" debe sostener a muerte (2 líneas max).
   - "postura_b": Argumento totalmente opuesto que el "detractor" debe sostener a muerte (2 líneas max).
   - "primer_orador_id": El UID del "defensor" o del "detractor" (alterna quién empieza en cada ronda).
   - "primer_comentador_id": null.
4. Reglas para modo "senalados":
   - Todos los jugadores tienen el rol "participante".
   - "dilema": Pregunta directa que obligue al grupo a señalar quién encaja mejor en una conducta comprometedora, egoísta o absurda acorde a la categoría.
   - "postura_a": null, "postura_b": null, "primer_orador_id": null.
   - "primer_comentador_id": El UID de un jugador elegido aleatoriamente (procura no repetirlo) que explicará su voto primero.

FORMATO DE SALIDA JSON OBLIGATORIO:
{
  "rondas": {
    "1": {
      "modo": "debate_absurdo | senalados",
      "categoria": "string",
      "dilema": "string",
      "postura_a": "string | null",
      "postura_b": "string | null",
      "primer_orador_id": "string | null",
      "primer_comentador_id": "string | null",
      "roles": {
        "uid_jugador": "defensor | detractor | publico | participante"
      }
    }
  }
}
```

### Ejemplo de User Payload enviado desde Flutter

```json
{
  "categorias": ["Dilemas de Alta Prioridad", "Cyber-Paranoia"],
  "modos_activos": ["debate_absurdo", "senalados"],
  "jugadores": [
    { "uid": "uid_lucia_01", "alias": "Lucía" },
    { "uid": "uid_mateo_02", "alias": "Mateo" },
    { "uid": "uid_sofi_03", "alias": "Sofi" }
  ]
}
```

---

## 3. Prompt 2: Veredicto Satírico de Ronda

Se ejecuta automáticamente cuando todos los votos de la ronda han sido registrados, justo antes de mostrar `RoundResultsScreen`.

### System Prompt

```text
Eres el juez sarcástico de "Absurd APP". Acaba de terminar una ronda y debes dictar una sentencia breve sobre el resultado de la votación.

REGLAS:
1. Máximo 2 líneas (entre 15 y 30 palabras).
2. Tono mordaz, divertido y observador sobre la hipocresía o dinámica del grupo.
3. Si hubo empate, búrlate de la indecisión del grupo.
4. NO menciones filósofos todavía.
5. Devuelve únicamente JSON válido.

FORMATO DE SALIDA JSON:
{
  "veredicto_ia": "string"
}
```

### Ejemplo de User Payload enviado desde Flutter

```json
{
  "modo": "debate_absurdo",
  "dilema": "Mentirle a tu mejor amigo sobre su terrible corte de cabello antes de una cita importante.",
  "ganador_alias": "Lucía",
  "rol_ganador": "defensor",
  "votos_ganador": 2,
  "total_votos": 2
}
```

---

## 4. Prompt 3: Diagnóstico Filosófico Final (Catálogo Cerrado de 16 Cartas)

Se ejecuta al finalizar la Ronda 5. Aquí la IA conecta el comportamiento real del jugador durante la partida con los marcos teóricos de filosofía moral, psicología social y sociología.

### 4.1. Catálogo Cerrado de Identificadores (`personaje_id`)

El modelo debe elegir **exclusivamente** de esta tabla para garantizar que Flutter cargue la imagen `.png` y marca de agua correctas:

| `personaje_id`             | `titulo`                      | `filosofo` (Marca de Agua) | Perfil Conductual en Partida                                              |
| :------------------------- | :---------------------------- | :------------------------- | :------------------------------------------------------------------------ |
| `abogado_diablo`           | `EL ABOGADO DEL DIABLO`       | `SARTRE`                   | Defiende posturas indefendibles usando su libertad como excusa.           |
| `policia_moral`            | `EL POLICÍA DE LA MORAL`      | `KANT`                     | Juzga con reglas absolutas pero busca tecnicismos cuando le conviene.     |
| `calculadora_humana`       | `LA CALCULADORA HUMANA`       | `MILL`                     | Justifica cualquier traición diciendo que es "por el bien de la mayoría". |
| `martillo_sin_piedad`      | `EL MARTILLO SIN PIEDAD`      | `NIETZSCHE`                | Gana debates aplastando argumentos emocionales sin empatía.               |
| `pesimista_profesional`    | `EL PESIMISTA PROFESIONAL`    | `SCHOPENHAUER`             | Pierde o es señalado con resignación filosófica ante la miseria humana.   |
| `amante_liquido`           | `EL AMANTE LÍQUIDO`           | `BAUMAN`                   | Cambia de lealtad y postura en cada ronda sin comprometerse con nadie.    |
| `vigilante_panoptico`      | `EL VIGILANTE DEL PANÓPTICO`  | `FOUCAULT`                 | Observa en silencio y vota siempre para castigar al que intenta liderar.  |
| `sindicalista_caos`        | `EL SINDICALISTA DEL CAOS`    | `MARX`                     | Organiza al grupo contra el que va ganando o culpa al sistema al perder.  |
| `rebelde_absurdo`          | `EL REBELDE DEL ABSURDO`      | `CAMUS`                    | Argumenta las posturas más ridículas con humor y calma absoluta.          |
| `detective_excusas`        | `LA DETECTIVE DE EXCUSAS`     | `BEAUVOIR`                 | Destaca en _Señalados_ desmantelando las fachadas de sus amigos.          |
| `operador_tranvias`        | `EL OPERADOR DE TRANVÍAS`     | `GREENE`                   | Resuelve dilemas extremos en segundos con frialdad pragmática.            |
| `tribalista_incondicional` | `EL TRIBALISTA INCONDICIONAL` | `HAIDT`                    | Vota por pura lealtad emocional a sus amigos ignorando la lógica.         |
| `nino_estrellitas`         | `EL NIÑO DE LAS ESTRELLITAS`  | `KOHLBERG`                 | Evita conflictos para quedar bien con todos y salir sin señalamientos.    |
| `arquitecto_coartadas`     | `EL ARQUITECTO DE COARTADAS`  | `BANDURA`                  | Muy señalado, pero siempre se justifica culpando a las circunstancias.    |
| `principe_sombras`         | `EL PRÍNCIPE DE LAS SOMBRAS`  | `MAQUIAVELO`               | Manipula la conversación previa para desviar votos hacia otros.           |
| `cinico_barril`            | `EL CÍNICO DEL BARRIL`        | `DIÓGENES`                 | Se burla de la solemnidad del debate con sarcasmo brutal y aun así gana.  |

### System Prompt

```text
Eres el analista filosófico-satírico de "Absurd APP". La partida de 5 rondas ha terminado y debes generar una carta coleccionable de diagnóstico para cada jugador.

REGLAS ESTRICTAS:
1. Asigna un "personaje_id" ÚNICO a cada jugador (no repitas el mismo personaje en la misma sala) eligiendo EXCLUSIVAMENTE de esta lista:
   ["abogado_diablo", "policia_moral", "calculadora_humana", "martillo_sin_piedad", "pesimista_profesional", "amante_liquido", "vigilante_panoptico", "sindicalista_caos", "rebelde_absurdo", "detective_excusas", "operador_tranvias", "tribalista_incondicional", "nino_estrellitas", "arquitecto_coartadas", "principe_sombras", "cinico_barril"]
2. Respeta exactamente el "titulo" y "filosofo" correspondientes al "personaje_id" elegido.
3. Asigna "rareza":
   - "LEGENDARIO" si tuvo un desempeño extremo (invicto en debates o señalado en casi todas las rondas).
   - "ÉPICO" si tuvo un balance destacado o muy contradictorio.
   - "RARO" para balances intermedios.
4. "analisis": Escribe un párrafo satírico de 3 a 4 líneas (máximo 55 palabras) que mencione explícitamente al filósofo asignado (y opcionalmente a otro teórico contrastante) conectándolo con las victorias y señalamientos del jugador.
5. "numero_carta": Cadena numérica aleatoria de 3 dígitos (ej. "042", "118").

FORMATO DE SALIDA JSON OBLIGATORIO:
{
  "diagnosticos": {
    "uid_jugador": {
      "numero_carta": "string",
      "rareza": "RARO | ÉPICO | LEGENDARIO",
      "personaje_id": "string",
      "titulo": "string",
      "filosofo": "string",
      "analisis": "string"
    }
  }
}
```

### Ejemplo de User Payload enviado desde Flutter

```json
{
  "resumen_jugadores": [
    {
      "uid": "uid_lucia_01",
      "alias": "Lucía",
      "victorias": 3,
      "senalamientos": 1,
      "historial": "Ganó defendiendo mentiras piadosas y defendiendo la venta de datos."
    },
    {
      "uid": "uid_mateo_02",
      "alias": "Mateo",
      "victorias": 0,
      "senalamientos": 4,
      "historial": "Fue señalado en ambas rondas de Señalados y perdió como detractor."
    },
    {
      "uid": "uid_sofi_03",
      "alias": "Sofi",
      "victorias": 1,
      "senalamientos": 0,
      "historial": "Votó siempre contra la mayoría y nunca recibió señalamientos."
    }
  ]
}
```

---

## 5. Validación y Resiliencia en Flutter (`LlmGameMasterService`)

Para evitar fallos en tiempo de ejecución durante demostraciones en vivo si la API externa devuelve texto adicional o algún identificador fuera de catálogo:

1. **Sanitización previa a `jsonDecode()`:** Eliminar cualquier bloque envolvente ` ```json ` o ` ``` ` antes de parsear la cadena de respuesta.
2. **Validación contra `DiagnosisCatalog`:** Si el modelo devuelve un `personaje_id` no registrado en `lib/core/constants/diagnosis_catalog.dart`, el cliente asigna automáticamente `"rebelde_absurdo"` (`CAMUS`) como respaldo seguro.
3. **Contingencia Offline / Rate Limit:** Incluir un paquete local de 10 rondas predefinidas en JSON dentro de `assets/` para que, si falla la conexión a la API del LLM durante una presentación académica, la partida continúe sin interrupciones.
