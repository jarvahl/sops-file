{ inputs, ... }:
{
  flake-file.inputs = {
    flake-file.url = "github:denful/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  imports =
    with inputs;
    with flake-file.flakeModules;
    [
      auto-follow
      default
      import-tree
      flake-parts.flakeModules.flakeModules
    ];

  systems = inputs.nixpkgs.lib.systems.flakeExposed;

  flake.flakeModules.default = inputs.import-tree ./+generator;
}
