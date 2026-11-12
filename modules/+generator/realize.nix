{
  config,
  lib,
  self,
  ...
}:
let
  cfg = config.sops.file;
  ageKeys = map (key: cfg.keys.${key} or key);
  defaultKeys = lib.optional (cfg.default_key != null) (ageKeys [ cfg.default_key ]);

  pathRegex =
    value:
    if lib.isPath value then
      "${lib.escapeRegex (lib.removePrefix "${self}/" (toString value))}$"
    else
      value;

  keyGroup = lib.mapAttrs (
    name: value: if name == "age" then lib.unique (ageKeys value ++ defaultKeys) else value
  );
in
{
  config.perSystem =
    { pkgs, ... }:
    lib.optionalAttrs (cfg.creation_rules != [ ]) {
      files.file.${cfg.path}.source = pkgs.concatText cfg.path [
        (pkgs.writeText "sops-file-header" ''
          # DO-NOT-EDIT. This file was auto-generated from sops-file config.
          # Edit Nix sources and regenerate it.

        '')
        ((pkgs.formats.yaml { }).generate cfg.path {
          creation_rules = map (
            rule:
            rule
            // {
              key_groups = map keyGroup rule.key_groups;
              path_regex = pathRegex rule.path_regex;
            }
          ) cfg.creation_rules;
        })
      ];
    };
}
