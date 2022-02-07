# This Source Code Form is subject to the terms of the Mozilla Public License,
# v. 2.0. If a copy of the MPL was not distributed with this file, You can
# obtain one at https://mozilla.org/MPL/2.0/.

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
          fqdn    = "localhost";
          email   = "anemail@thatis.real";
          pass    = "";
        };
      in {
        defaultPackage = tlsgen pkgs metadata;
        customCert = tlsgen pkgs;
      }
    );
}
