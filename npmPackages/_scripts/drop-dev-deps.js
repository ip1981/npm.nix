const process = require('process');

const {
    pipeThrough
} = require('./package.js');

pipeThrough((pkg, done) => {
    var notFound = [];
    pkg.devDependencies = pkg.devDependencies || {};

    process.argv.slice(2).forEach((d) => {
        if (pkg.devDependencies[d]) {
            delete pkg.devDependencies[d];
        } else {
            notFound.push(d);
        }
    });

    if (notFound.length > 0) {
        console.error(`** ERROR: these dev. dependencies are not declared: ${notFound}`);
        process.exit(1);
    }

    done(pkg);
});
