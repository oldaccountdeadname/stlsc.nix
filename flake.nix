{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/21.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        country = "NA";
        state   = "SomeStateThatDefinitelyExists";
        city    = "SomeCityThatDefinitelyExists";
        org     = "SomeRealOrganization";
        orgunit = "SomeRealOrganizationalUnit";
        fqdn    = "a.real.fqdn";
        email   = "anemail@thatis.real";
        pass    = "iamcommitingcrimes";
      in {
        defaultPackage = pkgs.stdenv.mkDerivation {
          name = "stlsc";
          version = "0.1.0";
          src = ./.;

          buildPhase = ''
            cat <<EOF | openssl req -x509 -newkey rsa:4096 -sha256 \
                                -passout 'pass:${pass}'            \
                                -keyout  privkey.pem               \
                                -out     tlscert.pem
            ${country}
            ${state}
            ${city}
            ${org}
            ${orgunit}
            ${fqdn}
            ${email}
            EOF

            openssl pkcs12 -export -in tlscert.pem -inkey privkey.pem \
                    -password 'pass:${pass}' \
                    -passin   'pass:${pass}' \
                    -passout  'pass:${pass}' \
                    -out tlscert.pfx
          '';

          installPhase = ''
            mkdir $out
            echo ${pass} > $out/pass
            cp privkey.pem $out
            cp tlscert.pem $out
            cp tlscert.pfx $out
          '';

          nativeBuildInputs = [ pkgs.openssl ];
        };
      }
    );
}
