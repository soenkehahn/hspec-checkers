{ pkgs ? import <nixpkgs> { }
, src ?  builtins.filterSource (path: type:
    type != "unknown" &&
    baseNameOf path != ".git" &&
    baseNameOf path != "result" &&
    baseNameOf path != "dist") ./.
}:
let
  # Force old QC for these
  needsOldQC = [
    "hspec"
    "quickcheckIo"
    "quickcheckInstances"
    "enclosedExceptions"
    "interpolate"
  ];

  haskellPackages = pkgs.haskellPackages.override {
    extension = self: super: builtins.listToAttrs (map (name: {
      inherit name;
      value = super.${name}.override {
        QuickCheck = self.QuickCheck_2_6;
      };
    }) needsOldQC);
  };

  hspecCheckers = haskellPackages.buildLocalCabalWithArgs {
    name = "hspec-checkers";
    inherit src;
  };

in

hspecCheckers
