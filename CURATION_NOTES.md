# Curation Notes

The following licence, citation, provenance, and attribution notes reflect the current curator confirmation and remaining follow-up items. No code logic or data values were changed for this documentation update.

## Blocking before public release

- None identified for the current documentation review.

## Requires curator confirmation

- `CTR/CTR-manual.pdf` and `CTR/code/sample.xlsx`: confirm publisher, author, redistribution, and sample-data terms if these non-code resources are reused outside this repository.
- `DLM/preprocess/reframed.pk` and `DLM/preprocess/scaler.pk`: confirm provenance and licence if these preprocessing artifacts are reused outside this repository.
- `GANBLR/data/original/adult.data`, `GANBLR/data/original/adult.names`, and `GANBLR/data/discretized/discretized_adult.csv`: confirm original source terms and attribution requirements if these dataset files are reused outside this repository.
- `RFM` sample data, package archives, compiled binaries, and third-party-derived components: confirm licence and attribution requirements for `fmtools`, `lpSolve`, sample data, and packaged binaries if the package is prepared for a formal release.
- `StreaKHC/data/raw` and `StreaKHC/data/runned`: confirm dataset source, provenance, and redistribution terms for the included benchmark/sample datasets if they are reused outside this repository.

## Non-blocking documentation cleanup

- `StreaKHC` contains source files with file-level third-party licence notices. These notices should be preserved and reviewed if the subproject is packaged, but they are not a README-level blocker.
- The imported `topograph` source repository did not include requirements or environment files. Dependency documentation can be added later if the subproject is packaged.

## Optional future enhancement

- Add a repository-level DOI, release version, complete repository-level author list, or `CITATION.cff` if desired.
- Add project-level DOI or BibTeX metadata only when confirmed by the relevant project maintainer.
- Add complete TOPOGRAPH DOI or BibTeX metadata when confirmed.

## Resolved / curator-confirmed

- The previous root GPL text was intentionally replaced with the MIT License as the root default code licence.
- Source code is licensed under MIT unless otherwise stated. Project-level licence files, file-level notices, and third-party notices take precedence where present.
- Documentation, README text, tutorial notes, and citation metadata are licensed under CC BY 4.0 unless otherwise stated.
- `GANBLR` and `StreaKHC` README-level licence wording is confirmed as MIT License unless otherwise stated, consistent with the repository default.
- `IK-AHC` keeps its project-level BSD 3-Clause licence in `IK-AHC/LICENSE`; that subproject-level licence takes precedence for `IK-AHC`.
- GitHub remote default branch is confirmed as `main`; no `master` branch migration issue remains in this audit.
- `topograph` was imported from https://github.com/tulip-lab/topograph into `topograph/`, with source README, notebook, source files, import note, and MIT licence preserved.
- Published papers, arXiv preprints, publisher PDFs, external datasets, pretrained model weights, third-party checkpoints, and external resources are not relicensed by this repository.
