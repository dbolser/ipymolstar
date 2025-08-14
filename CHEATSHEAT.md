# ipymolstar Cheat Sheet

`ipymolstar` exposes the [PDBe Mol*](https://github.com/molstar/pdbe-molstar) viewer and the MolViewSpec renderer as Jupyter widgets.
Below is a quick reference for common tasks.

## Loading Structures
```python
from ipymolstar import PDBeMolstar

# Load by PDB id
view = PDBeMolstar(molecule_id="1qyn")

# Load a local file
custom = {"data": Path("structure.bcif").read_bytes(), "format": "cif", "binary": True}
view = PDBeMolstar(custom_data=custom)
```

## Filtering, Selecting and Focusing
Selections are specified with dictionaries known as *query parameters*. They can target chains, residues, atoms and more[*](src/ipymolstar/pdbemolstar.py#L27-L57).
Use the `color` method (an alias for Mol*'s `select`) to change representation or hide parts of the model, and `focus` to center the camera on a region [F:src/ipymolstar/pdbemolstar.py†L178-L214].

### Hide chain B and focus on chain A
```python
# hide chain B
view.color([{"struct_asym_id": "B", "representation": "hide"}])

# center and rotate around chain A
view.focus([{"struct_asym_id": "A"}])
```

### Highlight residues with space‑fill
```python
residues = [10, 25, 40]
view.color([
    {"auth_asym_id": "A", "residue_number": r,
     "representation": "spacefill", "color": {"r":255,"g":0,"b":0}}
    for r in residues
])
```

### Ligand and surrounding interactions
```python
# show ligand in ball and stick and its neighbours
view.color([
    {"label_comp_id": "LIG", "surroundings": True,
     "representation": "ball-and-stick", "focus": True}
])

# display hydrogen bonds around the ligand
view.update({"interactions": {"data": [{"label_comp_id": "LIG"}],
                             "types": ["hydrogen-bonds"]}})

# hydrogen bonds for highlighted residues
view.update({"interactions": {"data": [{"auth_asym_id": "A",
                                          "residue_number": r} for r in residues],
                             "types": ["hydrogen-bonds"]}})
```

## Aligning Multiple Structures
```python
# align two structures on whole chains
params = {
    "structures": [
        {"pdbId": "1abc", "auth_asym_id": "A"},
        {"pdbId": "2def", "auth_asym_id": "A"},
    ]
}
view = PDBeMolstar(superposition=True, superposition_params=params)

# align on specific residue ranges
params = {
    "structures": [
        {"pdbId": "1abc", "auth_asym_id": "A",
         "start_residue_number": 10, "end_residue_number": 40},
        {"pdbId": "2def", "auth_asym_id": "A",
         "start_residue_number": 12, "end_residue_number": 42},
    ]
}
view.update({"superposition": True, "superpositionParams": params})
```

## Saving and Jumping Between Views
```python
# capture current camera
snap = view._update  # Python-side trait updated by JS

# store snapshots and restore with buttons
view.update({"camera": snap["camera"]})  # apply stored view
```
Use ipywidgets buttons to call `view.update` with different stored camera snapshots for quick navigation.

