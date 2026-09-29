# Inverse Dynamics of a Two-Link Planar Robot Arm

A MATLAB script from 2019 that computes the **joint torques a two-link (RR) planar robot arm needs to follow a prescribed smooth trajectory**. It uses the Euler–Lagrange formulation of the manipulator dynamics.

> **Original implementation.** This repository preserves the original implementation of the project. The source code has intentionally not been refactored or modernized, in order to retain the historical context and original development approach.

---

## Project Overview

The script defines a two-link arm with equal links (length `l = 1`, mass `m = 1`) moving in a vertical plane under gravity. It then:

1. generates a **cycloidal rest-to-rest trajectory** for each joint over `T = 10` s (joint 1: 0 → π, joint 2: 0 → π/2);
2. evaluates the arm's **inertia matrix, Christoffel symbols (Coriolis/centrifugal terms) and gravity vector** at 51 time samples;
3. computes the **joint torques τ₁(t) and τ₂(t)** (inverse dynamics);
4. plots the trajectories and the torque profiles.

## Project Context

| | |
|---|---|
| **Classification** | Coursework / Assignment. *Inferred, not confirmed* |
| **Author** | Omar Baruch Morón López |
| **Written** | `09/11/2019`, per the script header |
| **Published** | February 2021 |
| **Original language** | Spanish (comments and plot titles) |

The topic, the textbook-style notation (`d_ij`, `c_ijk`, `g_k`), the round-number parameters and the author's header all point to a university robotics exercise. However, the repository contains no assignment statement and names no institution or course, so the origin cannot be confirmed. See [docs/project-context.md](docs/project-context.md) for the evidence and the open questions.

## Problem Statement

Given a desired motion of a robot arm (joint angles, velocities and accelerations over time), find the torques the joint actuators must apply to produce it. This is the **inverse dynamics** problem: τ = D(q)q̈ + C(q, q̇)q̇ + g(q).

## Objective

Implement the closed-form dynamic model of a 2-DOF planar manipulator, apply it to a smooth reference trajectory, and visualize both the motion and the torques it requires.

## Repository Structure

```
.
├── README.md                     # This file
├── AGENTS.md                     # Contribution guardrails (preserve original code)
├── LICENSE                       # MIT
├── src/
│   └── Inverse Dinamics.m        # Original MATLAB script (unchanged)
└── docs/
    ├── project-context.md        # Origin, evidence, Confirmed / Inferred / Unknown
    ├── dynamics-model.md         # Equations as implemented vs textbook form
    ├── code-overview.md          # Walkthrough of the script
    ├── possible-improvements.md  # Observations — not applied
    └── sdlc/
        ├── intent.md             # Why this reorganization exists
        ├── spec.md               # What the reorganized repo must satisfy
        └── plan.md               # How it was carried out
```

The script originally lived at `InverseDinamics/Inverse Dinamics.m`. It was moved to `src/` with its name and content unchanged. The misspelling "Dinamics" is original.

## Original Implementation

The source code represents the original implementation, most likely developed during my university studies. It is kept **byte-for-byte identical** to the version uploaded in 2021, including its Spanish comments, typos, formatting and Windows (CRLF) line endings. A `.gitattributes` rule stops Git from normalizing its line endings.

The script contains several modelling and coding issues, for example an operator-precedence slip in the position trajectory and a velocity term that is not squared. These are documented in [docs/possible-improvements.md](docs/possible-improvements.md) and deliberately **left unfixed**.

## Technologies

- **MATLAB** script (core language only, no toolboxes)

The syntax is also compatible with GNU Octave. This has not been verified.

## How It Works

```
parameters (l, m, g, I, T, boundary angles)
        │
        ▼
for 51 time samples t ∈ [0, 10]:
    θ, θ̇, θ̈ for each joint        ← cycloidal trajectory
    D(q), c_ijk(q), g(q)             ← two-link arm dynamics
    τ₁, τ₂                           ← inverse dynamics
        │
        ▼
4 figures: joint 1 motion, joint 2 motion, τ₁(t), τ₂(t)
```

The equations are written out in full in [docs/dynamics-model.md](docs/dynamics-model.md), and the script is walked through section by section in [docs/code-overview.md](docs/code-overview.md).

## Inputs and Outputs

| | |
|---|---|
| **Inputs** | None at runtime. All parameters are hard-coded at the top of the script |
| **Outputs** | Four MATLAB figures (trajectories of link 1 and link 2; torques of link 1 and link 2). The `tau2` vector is also echoed to the Command Window on every iteration, because of a missing semicolon. Workspace vectors: `ti`, `th1`, `thd1`, `thdd1`, `th2`, `thd2`, `thdd2`, `tau1`, `tau2` |
| **Files written** | None |

No historical output files or plots were included in the original repository.

## Running the Project

The file name contains a space, so run the script by path rather than by name. In MATLAB, from the repository root:

```matlab
run('src/Inverse Dinamics.m')
```

You can also open the file in the MATLAB editor and press **Run**. The script was not re-executed as part of this reorganization.

## Documentation

| Document | Contents |
|---|---|
| [Project context](docs/project-context.md) | Origin, timeline, evidence, open questions |
| [Dynamics model](docs/dynamics-model.md) | Trajectory and Euler–Lagrange equations, comparison with the textbook form, characteristic values |
| [Code overview](docs/code-overview.md) | Section-by-section walkthrough, variables, Spanish glossary |
| [Possible improvements](docs/possible-improvements.md) | Known issues and ideas, **not applied** |
| [Intent](docs/sdlc/intent.md) · [Spec](docs/sdlc/spec.md) · [Plan](docs/sdlc/plan.md) | Spec-driven record of this repository reorganization |

## Historical Note

This repository was later reorganized and documented to improve readability and preserve the historical context of the original project. The original source code remains unchanged.

## License

[MIT](LICENSE) © 2021 Baruch Lopez
