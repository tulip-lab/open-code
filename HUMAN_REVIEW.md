# Human Review

The following licence, citation, provenance, and attribution items need human confirmation. No code logic or data values were changed for this documentation update.

## Repository-level licence

- The previous root `LICENSE` file contained the GNU General Public License v3.0 text. It has been replaced with the MIT License to match the repository-level licence decision for source code. Confirm that TULIP Lab has authority to relicense all repository-level code under MIT.
- Some subprojects state a BSD licence or include their own licence notice, including `IK-AHC`, `GANBLR`, and `StreaKHC`. Confirm whether those project-specific notices remain authoritative exceptions to the root MIT licence.

## Citation metadata

- No repository-level DOI, release version, or complete repository-level author list was found. `CITATION.md` therefore uses a generic repository citation.
- Project-specific paper citations and DOI links appear in individual project READMEs. Confirm whether a root `CITATION.cff` should be added later with complete repository metadata.

## Included non-code assets

- `CTR/CTR-manual.pdf` is included in the code repository. Confirm its publisher, author, and redistribution licence.
- `DLM/preprocess/reframed.pk` and `DLM/preprocess/scaler.pk` are included model/preprocessing artifacts. Confirm their provenance and licence.
- `GANBLR/data/original/adult.data`, `GANBLR/data/original/adult.names`, and `GANBLR/data/discretized/discretized_adult.csv` are included dataset files. Confirm original source terms and attribution requirements.
- `RFM` includes sample data, package archives, compiled binaries, and third-party-derived components. Confirm the licences and attribution requirements for `fmtools`, `lpSolve`, sample data, and packaged binaries.
- `StreaKHC/data/raw` and `StreaKHC/data/runned` include benchmark/sample datasets. Confirm dataset source, provenance, and redistribution terms.

## Papers and external resources

- Published papers, arXiv preprints, publisher PDFs, external datasets, pretrained model weights, third-party checkpoints, and external resources are not relicensed by this repository. Confirm any file-level exceptions before redistribution.
