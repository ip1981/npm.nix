rec {
  overrideBuild = drv: f: (drv.override (args: args // {
    buildNpmPackage = drv: (args.buildNpmPackage drv).override f;
  })) // {
    overrideScope = scope: overrideBuild (drv.overrideScope scope) f;
  };

  dontCheck = drv: overrideBuild drv (drv: { doCheck = false; });
  jailbreak = drv: overrideBuild drv (drv: { jailbreak = true; });
}
