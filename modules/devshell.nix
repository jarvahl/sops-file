{ ... }:
{
  perSystem = { config, pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        deadnix
        just
        mdsh
        sops
      ];

      shellHook = ''
        ${config.pre-commit.shellHook}
      '';
    };
  };
}
