{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        tlsgen = import ./tls.nix;
        metadata = {
          country = "NA";
          state   = "SomeStateThatDefinitelyExists";
          city    = "SomeCityThatDefinitelyExists";
          org     = "SomeRealOrganization";
          orgunit = "SomeRealOrganizationalUnit";
          fqdn    = "a.real.fqdn";
          email   = "anemail@thatis.real";
          pass    = "iamcommitingcrimes";
        };
      in {
        defaultPackage = tlsgen pkgs metadata;
        customCert = tlsgen pkgs;
      }
    );
}
