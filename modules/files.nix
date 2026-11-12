{ inputs, ... }:
{
  flake-file.inputs.files.url = "github:mightyiam/files";

  imports = [
    "${inputs.files.outPath}/flake-module.nix"
  ];
}
