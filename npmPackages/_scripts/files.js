const process = require('process');

const {
    pipeThrough
} = require('./package.js');

pipeThrough((pkg, done) => {
    pkg.files = process.argv.slice(2);
    done(pkg);
});