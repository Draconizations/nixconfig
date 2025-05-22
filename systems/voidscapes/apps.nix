{ ... }:
{
  fxlmine.laravelApps = [
    { name = "critterworld"; url = "critter.quest"; schedule = false; }
    { name = "palsworld"; url = "world.pals.gay"; schedule = false; }    
    { name = "lkfulmen"; url = "fulmenite.net"; schedule = true; }
  ];

  fxlmine.nodeApps = [
    { name = "urlcutter"; url = "url.pals.gay"; path = "urlcutter/build/index.js"; port = "3001"; cwd = "./"; }
    { name = "pkxyz"; url = "pluralkit.xyz"; path = "pkxyz/build/index.js"; port = "3002"; }
  ];
}
