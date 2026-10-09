{ inputs, ... }:
{
  flake-file.inputs = {
    files = {
      flake = false;
      url = "github:mightyiam/files";
    };
    flake-file.url = "github:denful/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    import-tree.url = "github:denful/import-tree";
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  imports = with inputs.flake-file.flakeModules; [
    auto-follow
    default
    import-tree
  ];

  systems = inputs.nixpkgs.lib.systems.flakeExposed;
}
