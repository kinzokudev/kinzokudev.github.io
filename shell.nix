{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nixd
    nixfmt-rfc-style
    nodePackages.nodejs
    bun
    typescript
    nodePackages."@astrojs/language-server"
    emmet-ls
    eslint_d
    nodePackages.prettier
  ];
}
