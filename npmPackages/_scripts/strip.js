const process = require('process');

const {
    pipeThrough
} = require('./package.js');


var phase;

const args = process.argv.slice(2);

for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
        case '--post-configure':
            phase = 'postConfigure';
            break;
        case '--pre-install':
            phase = 'preInstall';
            break;
        case '--post-install':
            phase = 'postInstall';
            break;
        default:
            ;
    }
}

pipeThrough((pkg, done) => {
    switch (phase) {
        case 'postInstall':
            // fall throw

        case 'preInstall':
            delete pkg.engines;
            delete pkg.keywords;
            delete pkg.scripts;
            delete pkg.tap;
            delete pkg.xo;
            // fall throw

        case 'postConfigure':
            delete pkg.devDependencies;
            delete pkg.optionalDependencies;
            delete pkg.peerDependencies;
            if (pkg.scripts) {
                delete pkg.scripts.prepublish;
            }
            break;
        default:
            throw (`Unknown phase: "${phase}"`);
    }

    done(pkg);
});
