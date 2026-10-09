# sops-file

Generate `.sops.yaml` from Nix.

## Use

```nix
{
  imports = [ inputs.sops-file.flakeModules.default ];

  "sops-file" = {
    keys.alice = "age1...";

    creation_rules = [
      {
        path_regex = ./secrets.yaml;
        key_groups = [
          { age = [ "alice" ]; }
        ];
      }
    ];
  };
}
```

`age` entries are resolved through `keys`; unknown entries are kept as raw recipients.
