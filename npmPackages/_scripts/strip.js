const process = require('process');

const {
    pipeThrough
} = require('./package.js');


var stripDependencies = false;

const args = process.argv.slice(2);

for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
        case '--strip-dependencies':
            stripDependencies = true;
            break;
        default:
            ;
    }
}

pipeThrough((pkg, done) => {
    delete pkg.devDependencies;
    delete pkg.engines;
    delete pkg.keywords;
    delete pkg.optionalDependencies;
    delete pkg.peerDependencies;
    delete pkg.scripts;
    delete pkg.tap;
    delete pkg.xo;

    if (stripDependencies) {
        delete pkg.dependencies;
    }

    done(pkg);
});
