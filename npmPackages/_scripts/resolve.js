const process = require('process');
const fs = require('fs');

const {
    pipeThrough,
    readPackage
} = require('./package.js');

const semver = require('./vendor/semver/semver.js');

var jailbreak = false;
var npmPackages = [];

function resolveDeps(pkgMap, deps, missed, unsatisfied) {
    for (var d in deps) {
        if (d in pkgMap) {
            const actual = pkgMap[d].info.version;
            var required = deps[d];
            if (semver.valid(required)) {
                required = `>=${required}`;
            }
            if (!semver.satisfies(actual, required)) {
                unsatisfied(`want ${d}:"${required}", but "${actual}" provided`);
            }
            deps[d] = `file:${pkgMap[d].path}`;
        } else {
            missed(`${d}:${deps[d]}`);
        }
    }

    return deps;
}

function resolvePackage(pkg, depPkgs) {
    const pkgMap = depPkgs.reduce((pkgs, pkg) => {
        pkgs[pkg.info.name] = pkg;
        return pkgs;
    }, {});

    var unsatisfied = [];
    var missed = [];

    function missedCallback(msg) {
        missed.push(msg);
    }

    function unsatisfiedCallback(msg) {
        unsatisfied.push(msg);
    }

    pkg.dependencies = resolveDeps(pkgMap, pkg.dependencies, missedCallback, unsatisfiedCallback);
    pkg.devDependencies = resolveDeps(pkgMap, pkg.devDependencies, missedCallback, unsatisfiedCallback);

    if (missed.length > 0) {
        console.error(`** ERROR: missing dependencies: ${missed.join('; ')}.`);
    }

    if (unsatisfied.length > 0) {
        console.error(`** ${jailbreak ? 'WARNING' : 'ERROR'}: unsatisfied dependencies: ${unsatisfied.join('; ')}.`);
    }

    if (missed.length > 0) {
        process.exit(1);
    }

    if (unsatisfied.length > 0 && !jailbreak) {
        process.exit(1);
    }

    return pkg;
}

const args = process.argv.slice(2);

for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
        case '--jailbreak':
            jailbreak = true;
            break;
        default:
            npmPackages.push(args[i]);
    }
}

console.error('Building with:', npmPackages);

Promise.all(npmPackages.map(readPackage)).then((pkgs) => {
    pipeThrough((pkg, done) => {
        pkg.dependencies = pkg.dependencies || {};
        pkg.devDependencies = pkg.devDependencies || {};
        done(resolvePackage(pkg, pkgs));
    });
}).catch((err) => {
    console.error(err);
    process.exit(1);
});
