pkgs: metadata: pkgs.stdenv.mkDerivation {
  name = "stlsc";
  version = "0.1.1";
  src = ./.;

  buildPhase = ''
    cat <<EOF | openssl req -x509 -newkey rsa:4096 -sha256 \
                        ${if metadata.pass != ""
                          then "-passout 'pass:${metadata.pass}'"
                          else "-nodes"
                        } \
                        -keyout  privkey.pem \
                        -out     tlscert.pem
    ${metadata.country}
    ${metadata.state}
    ${metadata.city}
    ${metadata.org}
    ${metadata.orgunit}
    ${metadata.fqdn}
    ${metadata.email}
    EOF

    openssl pkcs12 -export -in tlscert.pem -inkey privkey.pem \
            -passin   'pass:${metadata.pass}' \
            -passout  'pass:${metadata.pass}' \
            -out tlscert.pfx
  '';

  installPhase = ''
    mkdir $out
    echo ${metadata.pass} > $out/pass
    cp privkey.pem $out
    cp tlscert.pem $out
    cp tlscert.pfx $out
  '';

  nativeBuildInputs = [ pkgs.openssl ];
}
