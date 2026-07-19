{ user, ... }:

{
  home.username = user;
  home.homeDirectory = "/Users/${user}";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  # Intentionally empty during migration.
  home.packages = [ ];
}
