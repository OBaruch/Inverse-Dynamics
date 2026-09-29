# Spec — Repository Modernization

> Stage 2: [Intent](intent.md) → **Spec** → [Plan](plan.md).
> This document says *what* the finished repository must look like, as checkable requirements.

## 1. Baseline (as found)

| Item | Value |
|---|---|
| Commits | `beae925` Initial commit (LICENSE), `0790e2c` "Add files via upload" — both 2021-02-20, author Baruch Lopez |
| Files | `LICENSE` (MIT, © 2021 Baruch Lopez), `InverseDinamics/Inverse Dinamics.m` |
| Source language | MATLAB script (no functions, no toolboxes detected) |
| Source encoding | ASCII, CRLF line endings, 69 lines |
| Source SHA-256 | `9728214d2dddd1091d19fff74a798ea450ca8d22d727c8a01fe7e62896818350` |
| Documents (PDF/Word/PPT) | None |
| Images / diagrams / datasets / outputs | None |
| README / Markdown | None |

## 2. Target structure

```
.
├── README.md                     # Portfolio-level overview
├── AGENTS.md                     # Guardrails for contributors and automated assistants
├── LICENSE                       # Unchanged
├── .gitignore                    # MATLAB/Octave editor + workspace artefacts
├── .gitattributes                # Keeps *.m byte-exact (no EOL normalization)
├── src/
│   └── Inverse Dinamics.m        # Original script, moved only
└── docs/
    ├── project-context.md        # Origin, evidence, Confirmed/Inferred/Unknown
    ├── dynamics-model.md         # Robot, trajectory and dynamics equations as implemented
    ├── code-overview.md          # Line-by-line walkthrough and execution flow
    ├── possible-improvements.md  # Observations, explicitly NOT applied
    └── sdlc/
        ├── intent.md
        ├── spec.md
        └── plan.md
```

Deliberately **not** created, because there is no content to justify them: `data/`, `assets/`, `examples/`, `notebooks/`, `archive/`, `docs/original/`, `docs/assignment.md`, `docs/architecture.md`. The project is a single linear script with no architecture to speak of.

## 3. Functional requirements

| ID | Requirement |
|---|---|
| FR-1 | The original script is relocated to `src/` with `git mv`, so history is kept. Its name is unchanged. |
| FR-2 | The script's content is byte-identical, including its CRLF line endings and trailing whitespace. |
| FR-3 | `README.md` covers: Overview, Project Context, Problem Statement, Objective, Repository Structure, Original Implementation, Technologies, How It Works, Inputs and Outputs, Running the Project, Documentation, Historical Note. |
| FR-4 | `docs/project-context.md` classifies the project's origin with an explicit confidence level and lists the evidence. |
| FR-5 | `docs/dynamics-model.md` writes the implemented equations in mathematical notation and compares them with the standard textbook form. Differences are described, not corrected. |
| FR-6 | `docs/code-overview.md` describes the parameters, the loop, the plots and the console output. |
| FR-7 | `docs/possible-improvements.md` states at the top that none of the items were applied. |
| FR-8 | `.gitattributes` disables text normalization for `*.m`, so future checkouts cannot rewrite the original line endings. |
| FR-9 | `AGENTS.md` states the no-code-modification rule for anyone, human or automated, who works on the repo. |

## 4. Non-functional requirements

| ID | Requirement |
|---|---|
| NFR-1 | All documentation is in English. Original Spanish identifiers and comments are quoted verbatim and translated where helpful. |
| NFR-2 | Claims are labelled **Confirmed**, **Inferred** or **Unknown**. Inferences are never stated as fact. |
| NFR-3 | Run instructions only include what can be verified from the code (plain MATLAB, no toolboxes). Nothing untested is presented as tested. |
| NFR-4 | No new tooling, dependencies or infrastructure. |
| NFR-5 | All commits are authored by the repository owner. The change lands through a pull request from a dedicated branch. |

## 5. Acceptance checks

```bash
# AC-1: source is byte-identical to the original upload
sha256sum "src/Inverse Dinamics.m"
# expected: 9728214d2dddd1091d19fff74a798ea450ca8d22d727c8a01fe7e62896818350

# AC-2: git sees a pure rename (100% similarity)
git diff --find-renames -M100% --stat main...HEAD -- "InverseDinamics/Inverse Dinamics.m" "src/Inverse Dinamics.m"

# AC-3: no other source files were touched
git diff --name-status main...HEAD | grep -v '^A' # only the R100 rename should remain

# AC-4: every relative Markdown link resolves (manual or scripted check)
```

## 6. Open questions (cannot be resolved from the repository)

- Institution, course and assignment statement, if any.
- Whether `09/11/2019` means 9 November or 11 September 2019.
- Whether the author ran the script in MATLAB or GNU Octave.
- Whether the robot parameters (`l = 1`, `m = 1`) came from a given problem statement or were chosen freely.
