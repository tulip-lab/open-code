# Documentation Audit

Audit date: 2026-06-29

## Files inspected

| Area | Files |
| --- | --- |
| Root documentation | `README.md`, `CITATION.md`, `LICENSE`, `LICENSE-DOCS.md`, `HUMAN_REVIEW.md` |
| Major project READMEs | `Adam/README.md`, `CTR/README.md`, `DLM/README.md`, `GANBLR/README.md`, `GP-DLM/README.md`, `IK-AHC/README.md`, `PREDICTIVITY/README.md`, `RFM/README.md`, `STL-DADLM/README.md`, `StreaKHC/README.md`, `topograph/README.md` |
| Licence exceptions | `IK-AHC/LICENSE`, project-level README licence notices |

## Root README issues found

| Issue | Status |
| --- | --- |
| Banner placement and README section order needed alignment with the open-data repository. | Fixed |
| Repository scope was implicit rather than a named section. | Fixed |
| Human-review and docs-audit links were missing. | Fixed |

## Subdirectory README issues found

| Issue | Status |
| --- | --- |
| Major project README files did not include the standard TULIP Lab banner. | Fixed with `../assets/tulip-wordmark.png` |
| Some project metadata tables had blank licence cells. | Filled with `MIT License unless otherwise stated` where no project-specific exception was present |
| BSD project notices were present for `IK-AHC`, `GANBLR`, and `StreaKHC`. | Preserved; exact BSD variant for `GANBLR` and `StreaKHC` requires owner confirmation |

## Citation inconsistencies found

| Issue | Status |
| --- | --- |
| Legacy BibTeX spelling was inconsistent. | Standardised to `BibTeX` |
| Citation headings used plural `Citations` in several files. | Standardised to `## Citation` |
| Some BibTeX DOI fields included `https://doi.org/` instead of DOI values. | Fixed where the DOI was already documented |
| Some BibTeX month and page-range fields used non-preferred formatting. | Fixed where metadata was already documented |
| `topograph` has no DOI, BibTeX entry, or separate citation file. | Recorded as optional future enhancement in `HUMAN_REVIEW.md` |

## Licence inconsistencies found

| Issue | Status |
| --- | --- |
| Blank licence cells in MIT-default project READMEs. | Fixed |
| Project-level BSD notices must take precedence over root MIT default. | Preserved and documented |
| Non-code assets remain outside repository-level MIT coverage. | Preserved in `HUMAN_REVIEW.md` |

## Branch-name references found

| Issue | Status |
| --- | --- |
| Documentation links referenced `tree/master`. | Replaced with `tree/main` where they referred to current repository URLs |
| No local or remote `master` branch exists. | Confirmed |
| `origin/HEAD` points to `origin/develop`, not `origin/main`. | Recorded for repository-admin confirmation in `HUMAN_REVIEW.md` |

## Banner coverage

| Area | Status |
| --- | --- |
| Root README | Covered with `assets/tulip-wordmark.png` |
| Major project READMEs | Covered with `../assets/tulip-wordmark.png` |

## Changes applied

- Added standard README banner placement and repository scope section.
- Added standard banner to major project READMEs.
- Standardised branch-name links from `master` to `main`.
- Standardised citation headings and `BibTeX` spelling.
- Filled missing MIT-default licence cells.
- Created this audit report and updated `HUMAN_REVIEW.md`.

## Issues requiring human confirmation

- Confirm exact BSD licence variants for `GANBLR` and `StreaKHC`.
- Confirm whether `open-code` GitHub default branch should be migrated from `develop` to `main`.
- Confirm licence/provenance for retained non-code assets if they are intended for public reuse.

## Recommended next actions

- Repository administrator confirms default branch policy and branch protection rules.
- Owners confirm exact BSD licence variants for subprojects that state BSD without a licence file.
- Add project-level DOI/BibTeX metadata only when confirmed by the project owner.
