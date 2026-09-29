# Plan — Repository Modernization

> Stage 3: [Intent](intent.md) → [Spec](spec.md) → **Plan**.
> This document says *how* the spec is carried out, as small steps that can each be verified.

## Workflow

The work follows a spec-driven loop: **analyze → specify → plan → execute in small steps → verify against the acceptance checks → review through a pull request.** Every step can be verified on its own, and none of them touches source code content.

## Steps

| # | Step | Output | Verification |
|---|---|---|---|
| 0 | **Discovery.** Inventory every file, read the script, inspect the git history and metadata (author, dates, encoding, line endings). | Baseline table in [spec §1](spec.md#1-baseline-as-found) | Every file in the tree is accounted for |
| 1 | **Context recovery.** Extract evidence from the script header, comments, identifiers, notation, commit metadata and the LICENSE. Classify the origin. | [`project-context.md`](../project-context.md) | Each claim labelled Confirmed / Inferred / Unknown |
| 2 | **Model reconstruction.** Transcribe the trajectory and dynamics equations as implemented. Compare them with the standard two-link planar manipulator model. | [`dynamics-model.md`](../dynamics-model.md) | Equations match the code term by term |
| 3 | **Behavioural check (read-only).** Reproduce the script's arithmetic outside the repository to describe its outputs (value ranges, end points). Nothing generated is committed. | Numbers quoted in the docs, labelled as a reproduction | Figures consistent with a manual reading of the code |
| 4 | **Branching.** Create a dedicated branch (`docs/repository-refactor`) from `main`. | Branch | `git branch --show-current` |
| 5 | **Restructure.** `git mv` the script into `src/`. Keep the file name. Remove the now-empty `InverseDinamics/` folder. | `src/Inverse Dinamics.m` | AC-1, AC-2 in [spec §5](spec.md#5-acceptance-checks) |
| 6 | **Byte-preservation guard.** Add `.gitattributes` (`*.m -text`) and a minimal MATLAB/Octave `.gitignore`. | `.gitattributes`, `.gitignore` | `git check-attr text -- "src/Inverse Dinamics.m"` → `unset` |
| 7 | **Documentation.** Write `code-overview.md` and `possible-improvements.md`, then `README.md` last, so it summarizes finished docs. | `docs/*.md`, `README.md` | Required README sections present (FR-3) |
| 8 | **Guardrails.** Add `AGENTS.md` with the preservation rules and the verification command. | `AGENTS.md` | Rules match the spec |
| 9 | **Verification.** Run the acceptance checks and a relative-link check. | Checks pass | AC-1…AC-4 |
| 10 | **Commit and PR.** Make small, conventional commits authored by the repository owner, push the branch and open a pull request that summarizes the change and the verification. | Pull request | Review by the owner |

## Commit strategy

1. `refactor(repo): move original MATLAB script to src/ without changes`
2. `chore(repo): add .gitattributes and .gitignore to preserve original sources`
3. `docs: add intent, spec and plan for repository modernization`
4. `docs: document project context, dynamics model and code overview`
5. `docs: add README and contributor guardrails`

Keeping the rename in a commit of its own lets reviewers confirm at a glance that the source is untouched (100% similarity).

## Risks and mitigations

| Risk | Mitigation |
|---|---|
| Line endings silently normalized (CRLF → LF) | `.gitattributes` `*.m -text`, plus a SHA-256 check before each commit |
| Documentation overstates the origin (e.g. claiming a specific university) | Confirmed / Inferred / Unknown labels and an explicit open-questions list |
| Readers mistake documented defects for applied fixes | `possible-improvements.md` carries a "not applied" banner, and the README repeats it |
| Over-engineering a single-script repo | The spec lists the folders that were deliberately not created |

## Rollback

Every change is additive except the rename. Reverting the PR, or running `git mv` back, restores the original layout exactly.
