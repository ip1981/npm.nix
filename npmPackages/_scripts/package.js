const fs = require('fs');
const path = require('path');
const process = require('process');

process.stdin.setEncoding('utf8');

function readPackage(dir) {
    return new Promise((resolve, reject) => {
        fs.readFile(path.join(dir, 'package.json'), (err, data) => {
            if (err) {
                return reject(err);
            } else {
                resolve({
                    path: path.resolve(dir),
                    info: JSON.parse(data)
                });
            }
        });
    });
}

function pipeThrough(filter) {
    var body = '';

    process.stdin.on('data', (data) => {
        body += data;
    });

    process.stdin.on('end', () => {
        var pkg = JSON.parse(body);
        filter(pkg, (newpkg) => {
            process.stdout.write(JSON.stringify(newpkg, null, 2))
        });
    })
}

module.exports = {
    readPackage,
    pipeThrough
};