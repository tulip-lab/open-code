# Human Review

The following licence, citation, provenance, and attribution notes reflect the current owner confirmation and remaining future-review items. No code logic or data values were changed for this documentation update.

## Repository-level licence

- Resolved by owner confirmation: the previous root `LICENSE` file contained the GNU General Public License v3.0 text. It has been intentionally replaced with the MIT License as the root default code licence.
- Source code is licensed under MIT unless otherwise stated. Project-level licence files, subproject README licence notices, and third-party notices take precedence for the relevant subproject or file.
- Existing BSD notices must be preserved where present, including notices in or for `IK-AHC`, `GANBLR`, and `StreaKHC`.
- Requires owner confirmation: `GANBLR` and `StreaKHC` README files state "BSD license", but no separate licence file was found for those subprojects during this audit. Preserve the notices until the exact BSD variant is confirmed.
- Documentation and citation metadata are licensed under CC BY 4.0 unless otherwise stated.

## Citation metadata

- Optional future enhancement: a repository-level DOI, release version, complete repository-level author list, or `CITATION.cff` may be added later if desired. This is not blocking unless a specific paper-code release requires exact citation metadata.
- Project-specific paper citations and DOI links appear in individual project READMEs and should be preserved.

## Included non-code assets

- Included datasets, model artifacts, binaries, checkpoints, and PDFs are not automatically covered by the MIT code licence. They require their own licence/provenance notes if retained for public reuse.
- `CTR/CTR-manual.pdf` is included in the code repository. Future review: confirm its publisher, author, and redistribution licence if intended for public reuse.
- `DLM/preprocess/reframed.pk` and `DLM/preprocess/scaler.pk` are included model/preprocessing artifacts. Future review: confirm their provenance and licence if intended for public reuse.
- `GANBLR/data/original/adult.data`, `GANBLR/data/original/adult.names`, and `GANBLR/data/discretized/discretized_adult.csv` are included dataset files. Future review: confirm original source terms and attribution requirements if intended for public reuse.
- `RFM` includes sample data, package archives, compiled binaries, and third-party-derived components. Future review: confirm the licences and attribution requirements for `fmtools`, `lpSolve`, sample data, and packaged binaries if intended for public reuse.
- `StreaKHC/data/raw` and `StreaKHC/data/runned` include benchmark/sample datasets. Future review: confirm dataset source, provenance, and redistribution terms if intended for public reuse.

## topograph import

- `topograph` was imported from https://github.com/tulip-lab/topograph into `topograph/`. The source MIT `LICENSE`, README, notebook, and source files were preserved.
- The source README includes a TOPOGRAPH paper citation. No DOI, BibTeX entry, or separate citation file was present at import time; complete citation metadata can be added later if needed.
- The source README references external data resources for Synthetic Data, Knot, and IPC. These external resources were not copied into open-code and remain subject to their own source terms.
- No local datasets, pretrained model weights, model checkpoints, or large binary artifacts were present in the imported source repository.
- The source repository did not include requirements or environment files. Dependency licence review can be handled later if this subproject is packaged or prepared for a formal release.

## Branch naming

- No local or remote `master` branch was found during this audit.
- Requires repository-admin confirmation: `origin/HEAD` for `open-code` currently points to `origin/develop`, while the confirmed default branch name decision is `main`. Do not delete or rename branches automatically. Recommended migration procedure: create/push `main` if needed, set the GitHub default branch to `main`, update branch protection rules, then retire old default references only after owner confirmation.

## Papers and external resources

- Published papers, arXiv preprints, publisher PDFs, external datasets, pretrained model weights, third-party checkpoints, and external resources are not relicensed by this repository. Preserve file-level or third-party notices and confirm any exception before redistribution.
