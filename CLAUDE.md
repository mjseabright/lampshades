# lampshades

OpenSCAD designs for 3D-printed lampshades. Each subdirectory is a standalone design (`.scad` file); shared geometry helpers live in `geometry_functions.scad` at the repo root and are pulled in via `use <../geometry_functions.scad>;`.

## Tools

- OpenSCAD CLI: `/c/Program Files/OpenSCAD (Nightly)/openscad.com`
  - Render/validate a design: `"/c/Program Files/OpenSCAD (Nightly)/openscad.com" -o out.stl <design>/<design>.scad`
  - Fast syntax/module-resolution check without full CSG render: export to `.csg` instead of `.stl`.
  - When exporting a PNG preview, always pass `--viewall --autocenter` so the camera auto-fits the object — otherwise the default camera is often zoomed in on a fragment of the model, not a useful full view.
