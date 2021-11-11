Npm.nix
=======

Npm.nix is a project that organizes JavaScript packages with the
[Nix](https://nixos.org/nix/) package manager.

There was [npm2nix](https://github.com/NixOS/npm2nix), then
[node2nix](https://github.com/svanderburg/node2nix).  Both of them designed
to work with the [NPM package registry](https://www.npmjs.com/), and
leave you a little freedom and control. The gravest downside is that NPM
is not a repository of _source code_. Yes, some of the packages are plain
human-written JavaScript, but the others are derived from TypeScript,
Dart, and whatnot. Some require native extensions for the Node.js
runtime, which are usually precompiled and downloaded at _install_ time
(for example [node-sass](https://www.npmjs.com/package/node-sass) and
[fibers](https://www.npmjs.com/package/fibers)).

Npm.nix fuses together the power of Nix and [the Debian Free Software
Guideline](https://www.debian.org/doc/debian-policy/).  We build every
JavaScript package from its source code, we can apply any patches, we can
control what is installed.

To help adding and updaing packages there is the
[npm4nix](https://github.com/ip1981/npm4nix) utility.


To be (maybe) done
==================

* Something like `nodeWithPackages`.
* Bundles. For example, a closed set of tarballs, so that NPM can install
them and resolve depenednecies offline. Or simply a bundle with `node_modules`
without symbolic links, deduplicated, etc.


Structure
=========

Entry point in the [npmPackages](./npmPackages) directory. It can be used
in command line as `nix build -f ./npmPackages PACKAGE` or `nix-build ./npmPackages -A PACKAGE`.
It can be used in top-level Nix expressions like this:

```nix
{
#...
  node12Packages = import ./npmPackages { nodejs = nodejs-12_x; };
#...
}
```

Each NPM package is placed in separate directory with at least one file -
`default.nix`.  Scoped packages are placed into corresponding subdirectories.

For the purpose of Nix expressions, names of the packages are modified:

  * all slashes are replaced by dashes (`/` -> `-`);
  * all dots are replaced by dashes (`.` -> `-`);
  * the at symbol (`@`) is removed.

For example, some imaginary package `@babel/core` would be located under
`./npmPackages/@babel/core/default.nix` and available in Nix expressions as
`babel-core`.


How it works
============

Npm.nix basically replicates setup for Haskell or Python in
[Nixpkgs](https://nixos.org/nixpkgs). There is a predefined set of NPM
packages. The set can be extended. Each package in the set can be modified
or overriden for any particular use case.

When building an NPM package we:

  1. Upack its source code.
  2. Modify its `package.json` so that all dependencies were resolved to Nix store.
  3. Invoke `npm install` to populate the `node_modules` directory.
  4. Build the package.
  5. Strip `package.json`, e. g. remove `devDependencies` which are not longer needed.
  6. Pack the package and install it as a Nix derivation (unpacked, ready to use as is).
  7. Invoke `npm install` again to populate `node_modules` with runtime dependencies only.
  8. Strip `package.json` even more.

When the package is built, its runtime dependencies are tracked by Nix through
symbolic links under its `node_modules`. Its `package.json` does not refer
any packages.  A little surprise, that this approach is in line with
[Node.js recommendations](https://nodejs.org/api/modules.html).

For example:

```
$ nix-build ./npmPackages/ -A _color-convert -o color-convert
these derivations will be built:
  /nix/store/s30w2nskd2vk3mwylyja19bzmbwjr70v-color-name-4536ce5.drv
  /nix/store/l5bkr89n5kr23fmnfgcsp05dvhl8n015-nodejs-10.16.3-color-name-1.1.4.drv
  /nix/store/vk82xx042l1pf99ih4cj8yyna7vipamp-chalk-2.4.2-dummy.drv
  /nix/store/wsxc4vgjwm0slq2i7zx0czzxg47y7wgy-xo-0.25.3-dummy.drv
  /nix/store/zasx83qzd3dk5d9cfi5kifai3xg9vh8w-2.0.1.tar.gz.drv
  /nix/store/q8rr2cgw74z2qdyhxqc12q7dxjzwa16c-nodejs-10.16.3-color-convert-2.0.1.drv
...
nodejs-10.16.3-color-convert-2.0.1 notice === Tarball Contents ===
nodejs-10.16.3-color-convert-2.0.1 notice 782B   package.json
nodejs-10.16.3-color-convert-2.0.1 notice 1.4kB  CHANGELOG.md
nodejs-10.16.3-color-convert-2.0.1 notice 17.0kB conversions.js
nodejs-10.16.3-color-convert-2.0.1 notice 1.7kB  index.js
nodejs-10.16.3-color-convert-2.0.1 notice 1.1kB  LICENSE
nodejs-10.16.3-color-convert-2.0.1 notice 2.9kB  README.md
nodejs-10.16.3-color-convert-2.0.1 notice 2.3kB  route.js
...
shrinking RPATHs of ELF executables and libraries in /nix/store/wz943yq79k76khaglrdlafpy0f3ahiyf-nodejs-10.16.3-color-convert-2.0.1
strip is /nix/store/sc8xmj2am32c8zvc4f7572g8r5cyxw91-binutils-2.31.1/bin/strip
patching script interpreter paths in /nix/store/wz943yq79k76khaglrdlafpy0f3ahiyf-nodejs-10.16.3-color-convert-2.0.1
checking for references to /tmp/nix-build-nodejs-10.16.3-color-convert-2.0.1.drv-0/ in /nix/store/wz943yq79k76khaglrdlafpy0f3ahiyf-nodejs-10.16.3-color-convert-2.0.1...
/nix/store/wz943yq79k76khaglrdlafpy0f3ahiyf-nodejs-10.16.3-color-convert-2.0.1

$ cat color-convert/package.json
{
  "name": "color-convert",
  "description": "Plain color conversion functions",
  "version": "2.0.1",
  "author": "Heather Arthur <fayearthur@gmail.com>",
  "license": "MIT",
  "repository": "Qix-/color-convert",
  "files": [
    "index.js",
    "conversions.js",
    "route.js"
  ]
  "dependencies": {
    "color-name": "file:/nix/store/2k0qqdcf64mdv80hnnakpxrvkjwi99fr-nodejs-14.17.3-color-name-1.1.4"
  }
}

$ ls -lh color-convert/node_modules/
total 4,0K
lrwxrwxrwx 1 pashev pashev 70 ene  1  1970 color-name -> ../../jbdpbcsfam331mqgylbhixsdydcsg7wd-nodejs-10.16.3-color-name-1.1.4

$ node
> var convert = require('./color-convert');
undefined
> convert.keyword.rgb('blue');
[ 0, 0, 255 ]

$ npm i ./color-convert
...
+ color-convert@2.0.1
added 1 package from 1 contributor in 0.838s

$ node
> var convert = require('color-convert');
undefined
> convert.keyword.rgb('blue');
[ 0, 0, 255 ]

```

