{ pkgs ? import <nixpkgs> { } }:

let py = pkgs.python3Packages;

in pkgs.mkShell {
  buildInputs = [
    pkgs.python3
    py.numpy
    py.pandas
    py.plotly
    py.packaging
    py.matplotlib
    py.scikit-learn
  ];
}

