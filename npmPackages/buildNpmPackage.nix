{stdenv, lib, nodejs, writeText}:

{ pname
, version
, src
, npmInputs ? [] # NPM packages used to resolve dependencies
, buildInputs ? [] # Other build inputs
, nativeBuildInputs ? []
, patches ? []
, files ? [] # override "files" in package.json
, buildPhase ? "npm install"
, checkPhase ? "npm test"
, doCheck ? true
, jailbreak ? false # Ignore version constraints of the dependencies
, meta ? {}
}:

let

  name = "nodejs-${nodejs.version}-${pname}-${version}";

  scripts = "${./_scripts}";

in
stdenv.mkDerivation {
  inherit
    buildInputs buildPhase checkPhase doCheck meta name patches src
    ;

  outputs = [ "out" "pack" ];

  nativeBuildInputs = nativeBuildInputs ++ [ nodejs ];

  configurePhase = ''
    export HOME=$PWD

    cat << 'NPMRC' > $HOME/.npmrc
      audit = false
      heading = ${name}
      loglevel = verbose
      metrics-registry = http://localhost
      nodedir = ${nodejs}
      offline = true
      optional = false
      package-lock = false
      registry = http://localhost
      save = false
      script-shell = ${stdenv.shell}
      send-metrics = false
      update-notifier = false
    NPMRC

    node ${scripts}/resolve.js \
      ${lib.optionalString jailbreak "--jailbreak"} \
      ${toString npmInputs} < package.json > package.json.resolved
    mv package.json.resolved package.json

    rm -f package-lock.json
    npm --ignore-scripts install

    node ${scripts}/strip.js --post-configure < package.json > package.json.stripped
    mv package.json.stripped package.json

  '';

  installPhase = ''
    node ${scripts}/strip.js --pre-install < package.json > package.json.stripped
    mv package.json.stripped package.json

    ${lib.optionalString (files != []) ''
      node ${scripts}/files.js ${lib.concatMapStringsSep " " (f: "'${f}'") files} < package.json > package.json.files
      mv package.json.files package.json
    ''}

    cp package.json package.json.resolved

    node ${scripts}/pindeps.js < package.json > package.json.pinned
    mv package.json.pinned package.json

    npm pack

    mkdir -p $pack
    cp ${pname}-${version}.tgz $pack/

    mkdir -p $out
    tar xf ${pname}-${version}.tgz --strip-components=1 -C $out
    mv package.json.resolved $out/package.json

    # Link runtime depdendencies, if any, to node_modules:
    cd $out
    npm install

    # Finally, strip info about runtime dependencies,
    # so that NPM will not complain about missed or extraneous dependencies:
    node ${scripts}/strip.js --post-install < package.json > package.json.stripped
    mv package.json.stripped package.json
  '';
}
