# Possible Improvements

> **None of the items below have been applied.**
> The source code in [`src/`](../src/) is intentionally preserved exactly as originally written, so that it keeps its historical context and the original development approach. This list is for reference only.

## A. Correctness observations (model and math)

These are described in detail in [dynamics-model.md §3.3](dynamics-model.md#33-comparison).

| # | Location | Observation | Possible change |
|---|---|---|---|
| A1 | Lines 21, 26: `(T/2*pi)` | Operator precedence gives (T/2)·π instead of T/(2π). The position profile then overshoots, going outside [θ₀, θ_T], and no longer matches the implemented velocity. | `(T/(2*pi))` |
| A2 | Line 7 vs lines 31–34 | The inertia I = ml²/12 is taken about the rod's centre, but the dynamics use l_c = l (centre of mass at the tip). | Pick one model consistently, e.g. l_c = l/2 with I = ml²/12 |
| A3 | Line 32: `d_12` | Missing the `m` factor, so d₁₂ ≠ d₂₁ symbolically. It is hidden because m = 1. | `I + m*(l^2 + l^2*cos(th2(i)))` |
| A4 | Line 46: `c_221*thd2(i)` | The velocity is not squared. | `c_221*thd2(i)^2` |
| A5 | Line 41: `g_1` | Contains a spurious constant `m*l`, and the cos θ₁ coefficient is ml·g instead of (m₁l_c1 + m₂l₁)·g. | Remove `m*l +` and use the full coefficient |

## B. Code quality (MATLAB practice)

| # | Observation | Possible change |
|---|---|---|
| B1 | Line 47 has no semicolon, so the `tau2` vector is printed 51 times. | Add `;` |
| B2 | Arrays grow inside the loop. | Preallocate with `zeros(1,51)` |
| B3 | The loop could be vectorized. | Use `ti = linspace(0,T,51)` and element-wise operators (`.*`, `.^`) |
| B4 | Hard-coded sample count `51` and divisor `50`. | Define `N` once |
| B5 | Duplicated trajectory code for each joint. | Use a local function `cycloidal(th0, thT, T, t)` |
| B6 | No `clear`/`clc`/`close all`, so leftover workspace state can leak in. | Add them at the top of the script, or turn the script into a function |
| B7 | Plots have no axis labels, units or legends. | Add `xlabel`, `ylabel` and `legend` |
| B8 | The file name contains a space and a typo (`Inverse Dinamics.m`), so it cannot be called by name from the MATLAB command line. | Rename to a valid identifier, e.g. `inverse_dynamics.m`. The name was deliberately kept for authenticity |

## C. Possible extensions (outside original scope)

- Check the torques by integrating the forward dynamics with `ode45` and comparing the resulting trajectory.
- Derive the model symbolically (Symbolic Math Toolbox) instead of transcribing it by hand.
- Animate the arm, and add a forward-kinematics plot of the end-effector path.
- Make the parameters (masses, lengths, trajectory) function inputs.
- Port the script to Python (NumPy/Matplotlib) or Julia for comparison.
