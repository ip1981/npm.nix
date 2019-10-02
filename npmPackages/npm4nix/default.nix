{ fetchgit, buildNpmPackage }:

buildNpmPackage {
  pname = "npm4nix";
  version = "0.1.0";
  src = fetchgit {
    url = "https://github.com/ip1981/npm4nix";
    rev = "d013913ab48a8ee664e84d74daf52211b7c9411d";
    sha256 = "1l52r5lyjwm3bjfkzjsrqqc6ax0xk9cmdl2wm4qjwp7krywfwwk5";
  };

  meta = {
    description = "";
    homepage = "https://github.com/ip1981/npm4nix#readme";
    license = "WTFPL";
  };

  npmInputs = [
    
  ];
}
  
