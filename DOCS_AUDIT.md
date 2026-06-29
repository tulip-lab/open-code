# Documentation Audit

Audit date: 2026-06-29

## Files inspected

| Area | Files |
| --- | --- |
| Root documentation | `README.md`, `CITATION.md`, `LICENSE`, `LICENSE-DOCS.md`, `CURATION_NOTES.md` |
| Major project READMEs | `Adam/README.md`, `CTR/README.md`, `DLM/README.md`, `GANBLR/README.md`, `GP-DLM/README.md`, `IK-AHC/README.md`, `PREDICTIVITY/README.md`, `RFM/README.md`, `STL-DADLM/README.md`, `StreaKHC/README.md`, `topograph/README.md` |
| Licence exceptions and notices | `IK-AHC/LICENSE`, project README licence notices, file-level third-party notices where visible |

## README templates applied

Major project README files were standardised toward this structure:

- Banner
- Project title
- Metadata table
- `Overview`
- `Repository location`
- `Installation or environment`
- `Usage`
- `Data`
- `Citation`
- `Licence`
- `Notes`

## Project README files updated

| File | Summary |
| --- | --- |
| `Adam/README.md` | Added standard sections, repository location, data note, fenced BibTeX, licence, and notes. |
| `CTR/README.md` | Added standard sections, manual/sample data notes, fenced BibTeX, licence, and notes. |
| `DLM/README.md` | Added standard sections, related data and preprocessing-artifact notes, fenced BibTeX, licence, and notes. |
| `GP-DLM/README.md` | Added standard sections, related data note, fenced BibTeX, licence, and notes. |
| `STL-DADLM/README.md` | Added standard sections, related data note, fenced BibTeX, licence, and notes. |
| `PREDICTIVITY/README.md` | Added standard sections, data note, fenced BibTeX, licence, and notes. |
| `GANBLR/README.md` | Added standard sections, local dataset note, fenced BibTeX, and confirmed MIT-default licence wording. |
| `IK-AHC/README.md` | Added standard sections and preserved `IK-AHC/LICENSE` as the BSD 3-Clause project-level licence. |
| `StreaKHC/README.md` | Added standard sections, benchmark-data and file-level notice notes, fenced BibTeX, and confirmed MIT-default licence wording. |
| `RFM/README.md` | Added standard sections, package/sample/binary notes, fenced BibTeX, licence, and references. |
| `topograph/README.md` | Added standard sections, import/source repository note, external data notes, licence, and citation-metadata note. |

## Citation issues fixed

| Issue | Status |
| --- | --- |
| README citation sections had inconsistent surrounding structure. | Standardised to `## Citation` in the project template. |
| Indented BibTeX blocks were inconsistent with the preferred fenced form. | Converted known BibTeX entries to fenced `bibtex` blocks. |
| BibTeX page ranges and month fields needed normalisation in several entries. | Normalised where metadata was already documented. |
| Missing or incomplete citation metadata must not be invented. | Preserved as notes or optional future enhancement. |

## Licence wording issues fixed

| Issue | Status |
| --- | --- |
| `GANBLR` and `StreaKHC` README-level BSD wording conflicted with the confirmed repository-default model. | Replaced with `MIT License unless otherwise stated`. |
| `IK-AHC` has a real project-level licence file. | Preserved as BSD 3-Clause and documented as a subproject-level exception. |
| Included datasets, binaries, PDFs, model/preprocessing artifacts, and third-party resources must not be swept into the MIT code licence. | Documented in project README files and `CURATION_NOTES.md`. |

## Branch-name references

| Issue | Status |
| --- | --- |
| Documentation should refer to `main`, not `master`, for current GitHub URLs and branch references. | Checked; no current README `master` links remain. |
| GitHub remote default branch should be `main`. | Confirmed by `git remote show origin`; no branch migration issue remains. |

## Banner coverage

| Area | Status |
| --- | --- |
| Root README | Covered with `assets/tulip-wordmark.png` |
| Major project READMEs | Covered with `../assets/tulip-wordmark.png` |

## Curation notes cleanup

`CURATION_NOTES.md` was reorganised into:

- Blocking before public release
- Requires curator confirmation
- Non-blocking documentation cleanup
- Optional future enhancement
- Resolved / curator-confirmed

## Remaining issues requiring curator confirmation

- Non-code resources and artifacts if reused outside this repository: `CTR` PDF/sample workbook, `DLM` preprocessing artifacts, `GANBLR` Adult dataset files, `RFM` package/sample/binary components, and `StreaKHC` benchmark/sample datasets.
- Dependency and file-level third-party notice review if `StreaKHC` or other subprojects are packaged for formal release.

## Recommended next actions

- Keep project-specific citations current when maintainers publish updates.
- Add missing project-level DOI/BibTeX metadata only when confirmed by project maintainers.
- If a subproject is packaged for release, review non-code artifacts and file-level third-party notices before distribution.
