{
  description = ''A post-modern, "multi-dimensional" configurable ls/file lister'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-lc-v0_9_0.flake = false;
  inputs.src-lc-v0_9_0.owner = "c-blake";
  inputs.src-lc-v0_9_0.ref   = "refs/tags/v0.9.0";
  inputs.src-lc-v0_9_0.repo  = "lc";
  inputs.src-lc-v0_9_0.type  = "github";
  
  inputs."cligen".dir   = "nimpkgs/c/cligen";
  inputs."cligen".owner = "riinr";
  inputs."cligen".ref   = "flake-pinning";
  inputs."cligen".repo  = "flake-nimble";
  inputs."cligen".type  = "github";
  inputs."cligen".inputs.nixpkgs.follows = "nixpkgs";
  inputs."cligen".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-lc-v0_9_0"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-lc-v0_9_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}