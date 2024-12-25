{
  description = "A remote flake providing a Home Manager module for setting wallpapers";

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    homeManagerModules.wallpaper = {
      config,
      lib,
      pkgs,
      ...
    }: {
      home.activation.installWallpapers = lib.hm.dag.entryAfter ["writeBoundary"] ''
        # "wallpapers" folder is local to THIS flake repo
        ${pkgs.rsync}/bin/rsync \
          -avz \
          --chmod=D2755,F744 \
          ${./wallpapers}/ \
          ${config.xdg.dataHome}/wallpapers/
      '';
    };
  };
}
