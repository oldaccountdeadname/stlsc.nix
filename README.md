# stlsc.nix
a sacrificial tls certificate packaged as a nix flake

## usage
Recommended: stlsc.nix is available as a Flake, which you can wire up to your
build system. If, however, you just need a one-off cert, you can download one
(and all other associated information) from the most recent build artifacts.

## security
no :). this is sacrifcial for a reason, and is just for spinning up quick
development environments for, e.g., gemini, where a tls certificate is a
requirement but a good one is not.

## todos
- [ ] set up automated updating
- [ ] docs:
  - [ ] put an example here
  - [ ] document the output files in result/

In the mean time, just read the tiny derivation for documentation.
