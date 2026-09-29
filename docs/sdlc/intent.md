# Intent — Repository Modernization

> Stage 1 of the spec-driven workflow: **Intent → [Spec](spec.md) → [Plan](plan.md)**.
> This document says *why* the change exists and what counts as success. It does not describe how.

## Context

This repository holds a small MATLAB script, `Inverse Dinamics.m`, written by Omar Baruch Morón López. Its header is dated `09/11/2019`. The script computes the joint trajectories and joint torques of a two-link planar robot arm (inverse dynamics). The code was uploaded to GitHub on 2021-02-20 with no README, no documentation and no explanation of its context.

## Problem

Someone visiting the repository today cannot tell:

- what the script does or what physical system it models;
- where the project came from (coursework, personal study, etc.);
- how to run it or what it produces;
- which parts of the implementation are known to be questionable.

The folder and file names (`InverseDinamics/Inverse Dinamics.m`) are the only context available.

## Intent

Turn the repository into a clear, navigable, **historical** portfolio entry that explains the original project, while keeping the original implementation exactly as it is.

**Principle: modernize the repository, not the project.**

## Goals

1. Recover and document the project's context, separating **Confirmed**, **Inferred** and **Unknown** information.
2. Explain the mathematical model and the code's execution flow, so readers do not have to reverse-engineer the script.
3. Give the repository a simple, conventional layout.
4. Record observed defects and possible improvements in a separate document, without applying any of them.
5. Leave a lightweight spec-driven trail (intent, spec, plan) and contributor guardrails (`AGENTS.md`) for future work.

## Non-Goals

- Changing, fixing, reformatting or modernizing the MATLAB source code in any way, including its CRLF line endings.
- Renaming the source file. The misspelling "Dinamics" is part of the original.
- Adding build, CI/CD, containers, test frameworks, linters or package managers.
- Inventing context (university, course, assignment text) that the repository does not support.
- Generating and committing new "historical" outputs. The original repository contains none.

## Success Criteria

- The source file is byte-identical to the original: SHA-256 `9728214d2dddd1091d19fff74a798ea450ca8d22d727c8a01fe7e62896818350`.
- A reader can understand the project's purpose, model, inputs and outputs from `README.md` alone.
- Every claim about origin is labelled Confirmed, Inferred or Unknown.
- All Markdown links are relative and resolve.
- The whole change goes through a pull request on a dedicated branch.

## Stakeholders

- **Owner / author:** Baruch López (repository owner, original author of the script).
- **Audience:** technical reviewers and recruiters browsing the portfolio, and the author as a future reader.
