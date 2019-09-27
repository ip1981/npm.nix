const process = require('process');
const path = require('path');

const {
    pipeThrough,
    readPackage
} = require('./package.js');

function pinDependencies(pkg, done) {
    const deps = Object.keys(pkg.dependencies || {});
    const readLocalPkg = (n) => readPackage(path.join('node_modules', n));

    Promise.all(deps.map(readLocalPkg)).then((pkgs) => {
        const pinned = pkgs.reduce((ds, d) => {
            ds[d.info.name] = `^${d.info.version}`;
            return ds;
        }, {});

        pkg.dependencies = pinned;
        done(pkg);
    }).catch((err) => {
        console.error(err);
        process.exit(1);
    });
}

pipeThrough(pinDependencies);