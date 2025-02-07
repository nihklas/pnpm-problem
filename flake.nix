{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        src = pkgs.lib.cleanSource ./vuetify-project;
      in
        with pkgs; {
          devShells.default = mkShell {
            packages = [
              nodejs_22
              pnpm_10
              vue-language-server
              vscode-langservers-extracted
              typescript-language-server
            ];
          };

          packages.default = stdenv.mkDerivation (finalAttrs: {
            inherit src;

            pname = "test";
            version = "0.0.0";

            nativeBuildInputs = [
              nodejs_22
              pnpm_10.configHook
              dart-sass
            ];
            env.SASS_EMBEDDED_BIN_PATH = "${pkgs.dart-sass}/bin/sass";

            pnpmDeps = pnpm.fetchDeps {
              inherit (finalAttrs) pname version src;
              hash = "sha256-udgeSIQk+sX65AJ21W99G1yv6vSJ+pl8/l0atXNwR3A=";
            };

            installPhase = ''
              pnpm build --outDir $out
            '';
          });
        }
    );
}
