# Project Context

This document recovers what can be established about the project's origin and purpose. Each statement is labelled:

- **Confirmed**: directly supported by a file or by git metadata.
- **Inferred**: a reasonable deduction from the available evidence, not proven.
- **Unknown**: the repository does not provide enough information to determine this.

## Summary

| Aspect | Finding | Status |
|---|---|---|
| Topic | Inverse dynamics of a two-link (2-DOF) planar revolute robot arm | Confirmed (code) |
| Author | Omar Baruch Morón López (script header), published as *Baruch Lopez* | Confirmed |
| Date written | `09/11/2019` (script header) | Confirmed. The day/month order is **Unknown** |
| Date published | 2021-02-20 (git commits, UTC−06:00) | Confirmed |
| Language | MATLAB script syntax | Confirmed |
| Natural language | Spanish (comments, plot titles) | Confirmed |
| Project origin | **Coursework / Assignment**, likely from a university robotics course | Inferred (moderate confidence) |
| Institution / course | — | Unknown |
| Assignment statement | — | Unknown (no PDF/Word/other documents in the repository) |
| License | MIT, © 2021 Baruch Lopez | Confirmed |

## Evidence

### Script header (Confirmed)

```matlab
%% Dinamica inversa
%% Omar Baruch Moron Lopez
%% 09/11/2019
```

"Dinámica inversa" means *inverse dynamics*. A header with the author's full name and a date is typical of academic submissions, but it also appears in personal code.

### Author's inline comment (Confirmed)

```matlab
I=(m*l^2)/(12) ; %los elsavones son iguales tienen, la misma inercia pero cual es??
```

Translation: *"the links are equal, they have the same inertia, but which one is it??"* (`elsavones` is a typo for `eslabones`, "links"). The comment shows the author was unsure which moment-of-inertia expression to use. This reads like a note written while working through an exercise.

### Notation (Inferred)

The variable names follow the notation of the classic Euler–Lagrange treatment of the two-link planar manipulator in robotics textbooks such as Spong, Hutchinson & Vidyasagar, *Robot Modeling and Control*:

- `d_11, d_12, d_21, d_22`: elements of the inertia matrix D(q)
- `c_121, c_211, c_221, c_112`: Christoffel symbols c_ijk
- `g_1, g_2`: gravity terms
- `tau1, tau2`: joint torques

This suggests the work followed a textbook or lecture material. The repository does not name a source.

### Problem parameters (Inferred)

The script uses round numbers (`l = 1`, `m = 1`, `T = 10`, targets π and π/2) and a cycloidal (smooth rest-to-rest) trajectory. Values like these are typical of a textbook-style exercise. It cannot be confirmed whether they were given in a problem statement.

## Classification

**Project origin: Coursework / Assignment (Inferred).**

Supporting evidence: the topic is a standard exercise in undergraduate robotics courses, the header has a name and date, the notation follows a textbook, the parameters are round numbers, and the author left a question to themself in the comments.

What is missing: no university, course, professor, assignment number or problem statement appears anywhere in the repository. If this inference turns out to be wrong, the fallback classification is **Technical Experiment / self-study**.

## Timeline

| Date | Event | Source |
|---|---|---|
| 2019-11-09 *or* 2019-09-11 | Script written | Script header (`09/11/2019`). Day-first order is common in Mexico, which would give 9 November 2019. This is **Inferred** only |
| 2021-02-20 | Repository created; LICENSE added, script uploaded through the GitHub web interface ("Add files via upload") | Git history |
| Later | Repository reorganized and documented (this documentation) | Git history |

## Scope of the original work

**Confirmed from the code:**

- Generates smooth joint trajectories for both joints over 10 s, sampled at 51 points.
- Evaluates the inertia, Coriolis/centrifugal and gravity terms of the two-link arm at each sample.
- Computes the torque each joint needs to follow the trajectory.
- Plots the trajectories and torques (4 figures).

**Not part of the original work:** forward dynamics or simulation, control, kinematics or visualization of the arm, validation against reference results, and any user interface or parameter input.

## Open questions

- Which institution and course, if any, this was written for.
- Whether a problem statement existed and what exactly it asked for.
- Whether the script was run in MATLAB or GNU Octave. The syntax is compatible with both.
- Whether any report or plots were submitted alongside the code. None are in the repository.
