{ inputs, lib, ... }:
assert lib.assertMsg (
  inputs ? files
) "sops-file requires the consuming flake to provide inputs.files.";
{
  options.sops.file = {
    creation_rules = lib.mkOption {
      default = [ ];
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            key_groups = lib.mkOption {
              type = lib.types.listOf (lib.types.attrsOf (lib.types.listOf lib.types.str));
            };

            path_regex = lib.mkOption {
              type = lib.types.oneOf [
                lib.types.path
                lib.types.str
              ];
            };
          };
        }
      );
    };

    default_key = lib.mkOption {
      default = null;
      type = lib.types.nullOr lib.types.str;
    };

    keys = lib.mkOption {
      default = { };
      type = lib.types.attrsOf lib.types.str;
    };

    path = lib.mkOption {
      default = ".sops.yaml";
      type = lib.types.str;
    };
  };
}
