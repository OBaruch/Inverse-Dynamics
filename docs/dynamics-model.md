# Dynamics Model

This document writes out the mathematics **as implemented** in [`src/Inverse Dinamics.m`](../src/Inverse%20Dinamics.m). For reference, it also gives the standard textbook form of the same model. Where the two differ, the difference is described here but **not corrected** in the code. See [possible-improvements.md](possible-improvements.md).

## 1. System

A planar, two-link, revolute–revolute (RR) serial manipulator moving in a vertical plane under gravity.

| Symbol | Code | Value | Meaning |
|---|---|---|---|
| l | `l` | 1 | Length of each link (both links equal) |
| m | `m` | 1 | Mass of each link (both links equal) |
| g | `g` | 9.81 | Gravitational acceleration |
| I | `I` | m·l²/12 ≈ 0.0833 | Moment of inertia of each link (slender rod about its centre) |
| T | `T` | 10 | Duration of the motion |
| θ₁, θ₂ | `th1`, `th2` | — | Joint angles. θ₂ is relative to link 1 |

Units are not stated in the code. With g = 9.81 they are presumably SI (m, kg, s, rad, N·m). This is **Inferred**.

Gravity enters through cos θ₁ and cos(θ₁+θ₂). This implies angles are measured from the horizontal axis, with gravity acting along the negative vertical axis. This is **Inferred**.

## 2. Reference trajectory

Each joint moves rest-to-rest from θ₀ to θ_T using a **cycloidal** profile.

| Joint | θ₀ | θ_T |
|---|---|---|
| 1 | 0 | π |
| 2 | 0 | π/2 |

The standard cycloidal profile is:

$$
\theta(t) = \theta_0 + \frac{\theta_T-\theta_0}{T}\left(t - \frac{T}{2\pi}\sin\frac{2\pi t}{T}\right)
$$

$$
\dot\theta(t) = \frac{\theta_T-\theta_0}{T}\left(1-\cos\frac{2\pi t}{T}\right),\qquad
\ddot\theta(t) = \frac{\theta_T-\theta_0}{T}\cdot\frac{2\pi}{T}\sin\frac{2\pi t}{T}
$$

The velocity (`thd1`, `thd2`) and acceleration (`thdd1`, `thdd2`) lines implement these formulas exactly.

**As implemented, the position line differs.** The code writes `(T/2*pi)`. MATLAB evaluates this left to right as (T/2)·π = 5π ≈ 15.71, not T/(2π) ≈ 1.59. The implemented position is therefore:

$$
\theta_{\text{code}}(t) = \theta_0 + \frac{\theta_T-\theta_0}{T}\left(t - \frac{T\pi}{2}\sin\frac{2\pi t}{T}\right)
$$

It still starts and ends at the right values, because the sine term vanishes at t = 0 and t = T. In between, though, it swings well outside [θ₀, θ_T], and it is no longer the integral of the implemented velocity. The position is only plotted: the dynamics use θ₂ inside the trigonometric terms, so the torques are affected too.

Time is sampled at 51 points, t_i = (i−1)·T/50 for i = 1…51 (Δt = 0.2).

## 3. Equations of motion

The Euler–Lagrange form used by the code:

$$
\tau_k = \sum_j d_{kj}(q)\,\ddot q_j + \sum_{i,j} c_{ijk}(q)\,\dot q_i \dot q_j + g_k(q)
$$

### 3.1 Terms as implemented

| Term | Code expression | Mathematical form |
|---|---|---|
| d₁₁ | `I+I+m*l^2+(m*(l^2+l^2+(2*l)*l*cos(th2)))` | 2I + ml² + m(2l² + 2l² cos θ₂) |
| d₁₂ | `I+(l^2+(l^2*cos(th2)))` | I + l² + l² cos θ₂ (no m factor) |
| d₂₁ | `I+(m*((l^2)+(l*l*cos(th2))))` | I + m(l² + l² cos θ₂) |
| d₂₂ | `I+(m*(l^2))` | I + ml² |
| c₁₂₁ = c₂₁₁ = c₂₂₁ | `-m*l*l*sin(th2)` | −ml² sin θ₂ |
| c₁₁₂ | `m*l*l*sin(th2)` | ml² sin θ₂ |
| g₁ | `m*l + m*l*g*cos(th1) + m*l*g*cos(th1+th2)` | ml + mlg cos θ₁ + mlg cos(θ₁+θ₂) |
| g₂ | `m*l*g*cos(th1+th2)` | mlg cos(θ₁+θ₂) |

Torques:

$$
\tau_1 = d_{11}\ddot\theta_1 + d_{12}\ddot\theta_2 + c_{121}\dot\theta_1\dot\theta_2 + c_{211}\dot\theta_2\dot\theta_1 + c_{221}\,\dot\theta_2 + g_1
$$

$$
\tau_2 = d_{21}\ddot\theta_1 + d_{22}\ddot\theta_2 + c_{112}\,\dot\theta_1^2 + g_2
$$

### 3.2 Textbook reference form

For link masses m₁, m₂, lengths l₁, l₂, centre-of-mass distances l_c1, l_c2 and centroidal inertias I₁, I₂, the textbook form is:

$$
\begin{aligned}
d_{11} &= m_1 l_{c1}^2 + m_2\left(l_1^2 + l_{c2}^2 + 2 l_1 l_{c2}\cos q_2\right) + I_1 + I_2\\
d_{12} = d_{21} &= m_2\left(l_{c2}^2 + l_1 l_{c2}\cos q_2\right) + I_2\\
d_{22} &= m_2 l_{c2}^2 + I_2\\
c_{121} = c_{211} = c_{221} &= -m_2 l_1 l_{c2}\sin q_2,\qquad c_{112} = m_2 l_1 l_{c2}\sin q_2\\
g_1 &= (m_1 l_{c1} + m_2 l_1)\,g\cos q_1 + m_2 l_{c2}\,g\cos(q_1+q_2)\\
g_2 &= m_2 l_{c2}\,g\cos(q_1+q_2)\\
\tau_1 &= d_{11}\ddot q_1 + d_{12}\ddot q_2 + c_{121}\dot q_1\dot q_2 + c_{211}\dot q_2\dot q_1 + c_{221}\dot q_2^{\,2} + g_1\\
\tau_2 &= d_{21}\ddot q_1 + d_{22}\ddot q_2 + c_{112}\dot q_1^{\,2} + g_2
\end{aligned}
$$

### 3.3 Comparison

The implemented d₁₁, d₂₁, d₂₂ and Christoffel symbols match the reference with m₁ = m₂ = m, l₁ = l₂ = l and **l_c1 = l_c2 = l**, which places each link's centre of mass at its tip. Observed differences:

| # | Observation |
|---|---|
| 1 | **Centre of mass vs inertia.** l_c = l treats the mass as sitting at the link tip, while I = ml²/12 is the inertia of a uniform rod about its centre. The two assumptions are not consistent. The author's comment ("…but which one is it??") shows this was an open question at the time. |
| 2 | **d₁₂ ≠ d₂₁ symbolically.** d₁₂ is missing the m factor. The values agree only because m = 1. |
| 3 | **c₂₂₁ term.** It multiplies θ̇₂ rather than θ̇₂². |
| 4 | **g₁.** It contains an extra constant `m*l`, which has no g and no angle dependence and does not have units of torque. With l_c1 = l the reference coefficient on cos θ₁ would be 2ml·g, but the code uses ml·g. |
| 5 | **Trajectory position.** Operator precedence changes the position profile (see §2). |

These are recorded to help readers understand the script's output. They were **not** fixed.

## 4. Characteristic output values

The following values come from a line-by-line re-evaluation of the script's arithmetic outside MATLAB. They were **not** produced by the original program, and no historical outputs exist in the repository.

| Quantity | Start (t=0) | End (t=10) | Min | Max |
|---|---|---|---|---|
| θ₁ [rad] | 0 | π ≈ 3.1416 | ≈ −4.17 | ≈ 7.31 |
| θ̇₁ [rad/s] | 0 | 0 | 0 | ≈ 0.628 |
| θ̈₁ [rad/s²] | 0 | 0 | ≈ −0.197 | ≈ 0.197 |
| θ₂ [rad] | 0 | π/2 ≈ 1.5708 | ≈ −2.09 | ≈ 3.66 |
| θ̇₂ [rad/s] | 0 | 0 | 0 | ≈ 0.314 |
| θ̈₂ [rad/s²] | 0 | 0 | ≈ −0.099 | ≈ 0.099 |
| τ₁ | ≈ 20.62 | ≈ −8.81 | ≈ −15.47 | ≈ 20.62 |
| τ₂ | 9.81 | ≈ 0 | ≈ −9.89 | ≈ 10.00 |

Checks: at t = 0 the arm is horizontal and at rest, so τ₂ = mlg = 9.81 and τ₁ = ml + 2mlg = 1 + 19.62 = 20.62. The extra "+1" comes from observation 4 above.
