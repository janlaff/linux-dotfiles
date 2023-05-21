{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jan";
  home.homeDirectory = "/home/jan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gcc
    fd
    bat
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  fonts.fontconfig.enable = true;

  # Configure git
  programs.git = {
    enable = true;
    userName = "Jan Lafferton";
    userEmail = "jan@lafferton.de";
  };

  # Configure fish shell
  programs.fish = {
    enable = true;
    shellInit = "
      fish_hybrid_key_bindings
      source $HOME/.nix-profile/etc/profile.d/nix.fish
    ";
  };

  # Configure Alacritty terminal emulator
  programs.alacritty = {
    enable = true;
    settings = {
       env.TERM = "xterm-256-color";
       shell.program = "fish";
       font = {
         size = 18;
	 normal.family = "JetBrainsMono Nerd Font";
       };
    };
  };

  # Configure tmux
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    escapeTime = 10;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-s";
    terminal = "tmux-256color";
    extraConfig = "set -ag terminal-overrides \",xterm-256color:RGB\"";
    sensibleOnTop = false;
  };

  # Configure neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      fzf
      ripgrep
    ];
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/nvim".source = ./generated/nvim;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jan/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
