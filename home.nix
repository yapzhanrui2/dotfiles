{ config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bat
    fd
    gh
    jq
    lazygit
    ripgrep
    stylua
    uv
    zellij
  ];

  programs.zsh = {
    enable = true;

    shellAliases = {
      go-server = "ssh ray@ray-homelab-ubuntu";
      zj = "zellij";
    };

    initContent = ''
      # Zim framework
      ZIM_HOME="''${ZDOTDIR:-$HOME}/.zim"

      if [[ ! "$ZIM_HOME/init.zsh" -nt "''${ZIM_CONFIG_FILE:-''${ZDOTDIR:-$HOME}/.zimrc}" ]]; then
        source /opt/homebrew/opt/zimfw/share/zimfw.zsh init
      fi

      source "$ZIM_HOME/init.zsh"

      # Ghostty shell integration
      if [[ -n "$GHOSTTY_RESOURCES_DIR" ]] &&
         [[ -r "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration" ]]; then
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
      fi

      unsetopt extended_glob
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
