# Contribution Guardrails

Rules for anyone working on this repository, whether a human contributor or an automated coding assistant.

## Nature of the repository

This is a **historical, preserved** project: an original MATLAB script from 2019 plus modern documentation. The documentation may evolve. The implementation may not.

## Rules

1. **Do not modify anything under `src/`.** No fixes, reformatting, renaming, line-ending changes, comment edits or translations. This holds even for obvious bugs.
2. Record defects and ideas in [`docs/possible-improvements.md`](docs/possible-improvements.md), never in the code.
3. Label every claim about the project's origin **Confirmed**, **Inferred** or **Unknown**. Do not invent institutions, courses or requirements.
4. Keep original documents, outputs and historical artefacts. If something must move, move it; do not delete it.
5. Do not add build tooling, CI, containers, test frameworks or package managers unless the project genuinely needs them.
6. Use relative links between Markdown files.
7. Follow the spec-driven flow for non-trivial changes: update [`docs/sdlc/intent.md`](docs/sdlc/intent.md), [`spec.md`](docs/sdlc/spec.md) and [`plan.md`](docs/sdlc/plan.md) before executing, then open a pull request.

## Verification

Before every commit, confirm the original source is byte-identical:

```bash
sha256sum "src/Inverse Dinamics.m"
# 9728214d2dddd1091d19fff74a798ea450ca8d22d727c8a01fe7e62896818350
```
