{ ... }:
{
  fxlmine.laravelApps = [
    { name = "critterworld"; url = "critter.quest"; }
    { name = "palsworld"; url = "world.pals.gay";}    
    { name = "lkfulmen"; url = "fulmenite.net";}
  ];

  fxlmine.nodeApps = [
    { name = "urlcutter"; url = "url.pals.gay"; path = "urlcutter/build/index.js"; port = "3001"; cwd = "./"; }
    { name = "pkxyz"; url = "pluralkit.xyz"; path = "pkxyz/build/index.js"; port = "3002"; }
  ];
}
