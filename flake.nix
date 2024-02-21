{
  description = "Adds search naver dictionary context entry for selected word.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      nativeBuildInputs = with pkgs; [
          nodejs_18
          web-ext
      ];
    in
    {
      packages = rec {
        context-menu-naver-dict = pkgs.stdenv.mkDerivation {
          inherit nativeBuildInputs;
          
          name = "context-menu-naver-dict";
          src = ./.;

          preBuild = ''
            npm i
            npm run res:build
          '';
          buildPhase = ''
            web-ext build
            mv web-ext-artifacts $out
          '';
        };
        default = context-menu-naver-dict;
      };
      devShells.default = pkgs.mkShell {
        inherit nativeBuildInputs;
      };
    }
  );
}
