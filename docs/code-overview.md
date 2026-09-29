# Code Overview

The project consists of a single MATLAB script, [`src/Inverse Dinamics.m`](../src/Inverse%20Dinamics.m) (69 lines). It has no functions, classes, inputs or file I/O, and runs top to bottom as one linear procedure.

> The script is preserved exactly as originally written, including its Spanish comments, typos, formatting and CRLF line endings. Line numbers below refer to that file.

## File metadata

| Property | Value |
|---|---|
| Original path | `InverseDinamics/Inverse Dinamics.m` |
| Current path | `src/Inverse Dinamics.m` (moved only; content unchanged) |
| Encoding | ASCII, CRLF (Windows) line endings |
| SHA-256 | `9728214d2dddd1091d19fff74a798ea450ca8d22d727c8a01fe7e62896818350` |
| Dependencies | Core MATLAB only (`sin`, `cos`, `pi`, `figure`, `plot`, `title`). No toolboxes |

## Execution flow

```
Header comments (lines 1–3)
        │
        ▼
Physical parameters: l, m, g, I          (lines 4–7)
        │
        ▼
Trajectory boundary conditions: T, θ₀, θ_T for both joints   (lines 10–15)
        │
        ▼
for i = 1:51                              (lines 17–50)
   ├─ time sample t_i
   ├─ θ₁, θ̇₁, θ̈₁  (cycloidal profile)
   ├─ θ₂, θ̇₂, θ̈₂  (cycloidal profile)
   ├─ inertia terms d_11, d_12, d_21, d_22
   ├─ Christoffel symbols c_121, c_211, c_221, c_112
   ├─ gravity terms g_1, g_2
   └─ joint torques tau1(i), tau2(i)
        │
        ▼
4 figures: trajectories and torques       (lines 51–68)
```

## Section by section

### Header (lines 1–3)

```matlab
%% Dinamica inversa          -> "Inverse dynamics"
%% Omar Baruch Moron Lopez   -> author
%% 09/11/2019                -> date
```

The `%%` markers also make each line a *code section* in the MATLAB editor.

### Parameters (lines 4–7)

| Variable | Value | Meaning |
|---|---|---|
| `l` | `1` | Link length (both links) |
| `m` | `1` | Link mass (both links) |
| `g` | `9.81` | Gravity |
| `I` | `(m*l^2)/(12)` | Link inertia (slender rod about its centre) |

Comment on line 7, translated: *"the links are equal, they have the same inertia, but which one is it??"*

### Boundary conditions (lines 10–15)

| Variable | Value | Meaning |
|---|---|---|
| `T` | `10` | Motion duration |
| `th1_0`, `th1_T` | `0`, `pi` | Joint 1 start and end angle |
| `th2_0`, `th2_T` | `0`, `pi/2` | Joint 2 start and end angle |

### Main loop (lines 17–50)

Iterates `i = 1:51`. Arrays grow on every iteration; they are not preallocated.

- **Time** (line 18): `ti(i) = (i-1)*(T/50)`, so 0 to 10 in steps of 0.2.
- **Trajectories** (lines 20–28), commented `%Trayectoria th1` / `th2` ("trajectory"): cycloidal position (`th*`), velocity (`thd*`) and acceleration (`thdd*`). See [dynamics-model.md §2](dynamics-model.md#2-reference-trajectory).
- **Dynamic terms** (lines 30–42), commented `%Valores para el torque.` ("values for the torque"): the inertia matrix entries `d_ij`, Christoffel symbols `c_ijk` and gravity terms `g_k`. These are scalars, overwritten on each iteration. See [dynamics-model.md §3](dynamics-model.md#3-equations-of-motion).
- **Torques** (lines 45–47), commented `%Torques`: `tau1(i)` and `tau2(i)`. Line 47 (`tau2(i)= ...`) has **no trailing semicolon**, so MATLAB prints the whole `tau2` vector to the Command Window on every iteration (51 times, each time one element longer).

### Plots (lines 51–68)

| Figure | Command | Title (original) | Translation |
|---|---|---|---|
| 1 | `plot(ti,th1,'-',ti,thd1,'.',ti,thdd1,'*')` | *Primer eslabon Posicion, velocidad, aceleracion* | First link: position, velocity, acceleration |
| 2 | `plot(ti,th2,'-',ti,thd2,'.',ti,thdd2,'*')` | *Segundo eslabon Posicion, velocidad, aceleracion* | Second link: position, velocity, acceleration |
| 3 | `plot(ti,tau1)` | *Torques Primer eslabon* | First link torques |
| 4 | `plot(ti,tau2)` | *Torques Segundo eslabon* | Second link torques |

Figures 1 and 2 use line styles (solid, dots, asterisks) to tell position, velocity and acceleration apart. There are no legends or axis labels.

## Workspace variables after execution

| Kind | Variables |
|---|---|
| 1×51 vectors | `ti`, `th1`, `thd1`, `thdd1`, `th2`, `thd2`, `thdd2`, `tau1`, `tau2` |
| Scalars (last iteration) | `d_11`, `d_12`, `d_21`, `d_22`, `c_121`, `c_211`, `c_221`, `c_112`, `g_1`, `g_2`, `i` |
| Parameters | `l`, `m`, `g`, `I`, `T`, `th1_0`, `th1_T`, `th2_0`, `th2_T` |

## Glossary of original Spanish terms

| Spanish | English |
|---|---|
| Dinámica inversa | Inverse dynamics |
| Eslabón (typed `elsavones` once) | Link |
| Trayectoria | Trajectory |
| Posición, velocidad, aceleración | Position, velocity, acceleration |
| Primer / Segundo | First / Second |
| Valores para el torque | Values for the torque |
| Inercia | Inertia |
