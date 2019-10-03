#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const process = require('process');

var packages = {};

function normalize(name) {
    return name.replace('/', '-').replace('@', '').replace('.', '-');
}

function findPackages(dir) {
    fs.readdirSync(dir).forEach(function(entry) {
        const p = path.join(dir, entry);
        const name = normalize(dir);
        if (fs.lstatSync(p).isDirectory()) {
            findPackages(p);
        } else if (entry === 'default.nix' && dir !== '.') {
            packages[name] = dir;
        }
    });
}

process.chdir(path.join(path.dirname(process.argv[1]), 'npmPackages'));
findPackages('.');

const names = Object.keys(packages).sort();

const index = fs.createWriteStream('index.nix');
index.once('open', (fd) => {
    fs.writeSync(fd, '# XXX this file is automatically generated.\n');
    fs.writeSync(fd, 'self: super:\n');
    fs.writeSync(fd, 'let\n');
    fs.writeSync(fd, '  inherit (super) callPackage;\n');
    fs.writeSync(fd, 'in {\n');
    for (var i = 0; i < names.length; i++) {
        var path = packages[names[i]];
        if (path[0] === '@') {
            path = `(./. + "${path}")`;
        } else {
            path = `./${path}`;
        }
        fs.writeSync(fd, `  ${names[i]} = callPackage ${path} {};\n`);
    }
    fs.writeSync(fd, '}\n');
    fs.closeSync(fd);
});
