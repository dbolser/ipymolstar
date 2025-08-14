# AGENTS Guidelines

This repository contains the `ipymolstar` widgets used to embed Mol* viewers in Python notebooks and apps.

## Development workflow
- Place Python sources in `src/ipymolstar/` and keep modules importable.
- JavaScript assets live in `src/ipymolstar/static/`; run `npm run dev` while developing JS to rebuild bundles.
- Follow standard PEP 8 style and include type hints.
- Prefer `rg` (ripgrep) for searching the code base.

## Testing
- Run the Python tests before committing:
  ```bash
  pytest
  ```

## Project notes
- `PDBeMolstar` exposes methods such as `color`, `focus`, and `clear_selection` to control the viewer【F:src/ipymolstar/pdbemolstar.py†L178-L214】.
- Query parameters for selections support fields like chain IDs, residue ranges, and representations【F:src/ipymolstar/pdbemolstar.py†L27-L57】.
