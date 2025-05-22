{ ... }:
{
  fxlmine.laravelApps = [
    { name = "critterworld"; url = "critter.quest"; backup = false; }
    { name = "palsworld"; url = "world.pals.gay"; backup = false; }    
    { name = "lkfulmen"; url = "fulmenite.net"; backup = true; }
  ];

  fxlmine.nodeApps = [
    { name = "urlcutter"; url = "url.pals.gay"; path = "urlcutter/build/index.js"; port = "3001"; cwd = "./"; }
    { name = "pkxyz"; url = "pluralkit.xyz"; path = "pkxyz/build/index.js"; port = "3002"; }
  ];
}
