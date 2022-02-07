# stlsc.nix
a sacrificial tls certificate packaged as a nix flake

## usage
Recommended: stlsc.nix is available as a Flake, which you can wire up to your
build system. If, however, you just need a one-off cert, you can download one
(and all other associated information) from the most recent build artifacts.

For a complete example, see the devShell of systemgmi:

https://github.com/lincolnauster/systemgmi/blob/dev/flake.nix#L29

### usage as an expression
`stlsc.nix/flake.nix` contains two primary outputs: `defaultPackage.$system`,
and `customCert.$system`. Using the latter looks like this:
```nix
{
  out = stlsc.customCert.x86_64-linux {
    country = "US";
    state   = "NA";
    city    = "NA";
    org     = "help i'm trapped in a TLS cert factory";
    orgunit = "help";
    fqdn    = "example.com";
    email   = "help.im.trapped@tls.cert.factory";
    pass    = "hunter2";
  };
}
```

Note that this requires supplying the password in plain text. If this bothers
you, you probably shouldn't be using a *sacrificial* TLS cert. The
defaultPackage output does exactly the same thing, but with slightly different
default options (see all of them in `flake.nix`).

Outputs are as follows:

```
|               path | value                                       |
|--------------------|---------------------------------------------|
| `$out/pass`        | the password you set during creation        |
| `$out/privkey.pem` | the generated private key                   |
| `$out/privkey.pem` | the generated private key                   |
| `$out/tlscert.pem` | the generate self-signed tls cert           |
| `$out/tlscert.pfx` | PKCS#12 export of both the key and the cert |
```

## security
no :). everything, including passwords and private keys, are written in plain
text and world-readable in the nix store. this is called sacrifcial for a
reason, and is just for spinning up quick development environments where a TLS
certificate is a requirement but a good one is not.

## todos
- [x] set up automated updating
- [ ] set up automated testing
- [ ] seeding the generation for determinism?
- [ ] allow creation of certs with no passwords
- [x] docs:
  - [x] put an example here
  - [x] document the output files in result/
