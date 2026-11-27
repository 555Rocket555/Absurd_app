# 02. Esquema de Datos en Firebase y Máquina de Estados (FSM) — Absurd APP

**Versión:** 1.1  
**Base de Datos:** Firebase Realtime Database (NoSQL JSON Tree)  
**Sincronización:** `StreamBuilder` reactivo por sala (`/salas/{pin}`)

---

## 1. Arquitectura de Datos en Tiempo Real

**Absurd APP** prescinde de un servidor backend tradicional. La coordinación entre dispositivos Android/iOS se resuelve mediante **Firebase Realtime Database**, utilizando una arquitectura orientada a eventos donde cada sala opera como un árbol JSON aislado identificado por un PIN numérico de 4 dígitos.

### 1.1. Principios de Diseño NoSQL Aplicados

- **Acceso directo en tiempo $O(1)$:** El nodo raíz `/salas` utiliza el PIN de 4 dígitos como llave primaria. Al unirse un invitado, la app consulta directamente `/salas/{pin}` sin ejecutar búsquedas ni filtros costosos.
- **Precarga de sesión (Batch Write):** Cuando el anfitrión presiona _Comenzar_, la app solicita al servicio de IA las **5 rondas completas** y las escribe en una sola operación dentro de `/rondas/{1..5}`. Esto elimina pantallas de carga y latencia entre rondas.
- **Sincronización de reloj por Marca de Tiempo (Timestamp):** Para evitar saturar Firebase escribiendo cada segundo, el anfitrión registra únicamente la hora exacta de inicio (`tiempo_inicio_fase` en milisegundos Unix). Cada teléfono calcula su cuenta regresiva localmente:
  $$\text{Segundos Restantes} = \text{tiempo\_debate\_seg} - \left\lfloor \frac{\text{Timestamp Actual} - \text{tiempo\_inicio\_fase}}{1000} \right\rfloor$$
- **Aislamiento de escritura en votación ciega:** Cada jugador escribe su voto exclusivamente dentro de `/rondas/{ronda}/votos/{su_propio_uid}`, evitando condiciones de carrera (_race conditions_) cuando todos confirman al mismo instante.

---

## 2. Esquema JSON Completo (`/salas/{pin}`)

```json
{
  "salas": {
    "4827": {
      "config": {
        "nombre_sala": "Noche de Viernes",
        "host_id": "uid_lucia_01",
        "creada_en": 1795577040000,
        "categorias": ["Dilemas de Alta Prioridad", "Cyber-Paranoia"],
        "modos_activos": ["debate_absurdo", "senalados"],
        "tiempo_debate_seg": 120
      },
      "estado": {
        "fase_actual": "debate",
        "ronda_actual": 2,
        "modo_ronda_actual": "debate_absurdo",
        "tiempo_inicio_fase": 1795577180000
      },
      "jugadores": {
        "uid_lucia_01": {
          "alias": "Lucía",
          "es_host": true,
          "avatar_id": "kant",
          "conectado": true,
          "listo_ronda": true,
          "victorias": 1,
          "senalamientos": 0
        },
        "uid_mateo_02": {
          "alias": "Mateo",
          "es_host": false,
          "avatar_id": "nietzsche",
          "conectado": true,
          "listo_ronda": true,
          "victorias": 0,
          "senalamientos": 1
        },
        "uid_sofi_03": {
          "alias": "Sofi",
          "es_host": false,
          "avatar_id": "beauvoir",
          "conectado": true,
          "listo_ronda": true,
          "victorias": 0,
          "senalamientos": 0
        }
      },
      "rondas": {
        "1": {
          "modo": "senalados",
          "categoria": "Cyber-Paranoia",
          "dilema": "¿Quién de este grupo vendería los datos privados de sus amigos por un descuento del 15% en una app de comida?",
          "postura_a": null,
          "postura_b": null,
          "primer_orador_id": null,
          "primer_comentador_id": "uid_sofi_03",
          "roles": {
            "uid_lucia_01": "participante",
            "uid_mateo_02": "participante",
            "uid_sofi_03": "participante"
          },
          "votos": {
            "uid_lucia_01": "uid_mateo_02",
            "uid_mateo_02": "uid_sofi_03",
            "uid_sofi_03": "uid_mateo_02"
          },
          "resultado": {
            "ganador_id": "uid_mateo_02",
            "conteo": {
              "uid_lucia_01": 0,
              "uid_mateo_02": 2,
              "uid_sofi_03": 1
            },
            "veredicto_ia": "Mateo fue entregado al algoritmo sin piedad. Su historial de aceptar términos y condiciones sin leer lo condenó."
          }
        },
        "2": {
          "modo": "debate_absurdo",
          "categoria": "Dilemas de Alta Prioridad",
          "dilema": "Mentirle a tu mejor amigo sobre su terrible corte de cabello antes de una cita importante.",
          "postura_a": "La mentira piadosa es un deber moral: destruir su autoestima cinco minutos antes de su cita es crueldad innecesaria.",
          "postura_b": "La verdad radical es obligatoria: dejar que salga en ridículo te convierte en cómplice de su humillación pública.",
          "primer_orador_id": "uid_lucia_01",
          "primer_comentador_id": null,
          "roles": {
            "uid_lucia_01": "defensor",
            "uid_mateo_02": "detractor",
            "uid_sofi_03": "publico"
          },
          "votos": {},
          "resultado": null
        }
      },
      "diagnosticos": {
        "uid_lucia_01": {
          "numero_carta": "042",
          "rareza": "RARO",
          "personaje_id": "abogado_diablo",
          "titulo": "EL ABOGADO DEL DIABLO",
          "filosofo": "SARTRE",
          "analisis": "Sartre diría que estás condenado a ser libre y usaste esa libertad para defender lo indefendible. Kant ya presentó una queja formal contra tu flexibilidad moral."
        }
      }
    }
  }
}
```
