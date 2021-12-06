# stlsc.nix
a sacrificial tls certificate packaged as a nix flake

## usage
Recommended: stlsc.nix is available as a Flake, which you can wire up to your
build system. If, however, you just need a one-off cert, you can download one
(and all other associated information) from the most recent build artifacts.

### usage as an expression
`stlsc.nix/flake.nix` contains two primary outputs: `defaultPackage.$system`,
and `customCert.$system`. Using the latter looks like this:
```nix
stlsc.customCert.x86_64-linux {
  country = "US";
  state   = "NA";
  city    = "NA";
  org     = "help i'm trapped in a TLS cert factory";
  orgunit = "help";
  fqdn    = "example.com";
  email   = "help.im.trapped@tls.cert.factory";
  pass    = "hunter2";
}
```

Note that this requires supplying the password in plain text. If this bothers
you, you probably shouldn't be using a *sacrificial* TLS cert. The
defaultPackage output does exactly the same thing, but with slightly different
default options (see all of them in `flake.nix`.

## security
no :). this is sacrifcial for a reason, and is just for spinning up quick
development environments for, e.g., gemini, where a tls certificate is a
requirement but a good one is not.

## todos
- [ ] set up automated updating
- [ ] docs:
  - [x] put an example here
  - [ ] document the output files in result/

In the mean time, just read the tiny derivation for documentation.
