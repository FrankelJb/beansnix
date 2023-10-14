{ config
, lib
, pkgs
, ...
}:
let
  inherit (lib) types mkEnableOption mkIf getExe';
  inherit (lib.internal) mkOpt mkBoolOpt enabled;
  inherit (config.beansnix) user;

  cfg = config.beansnix.tools.git;
  cfg = config.khanelinix.tools.git;

  aliases = import ./aliases.nix;
in
{
  options.beansnix.tools.git = {
    enable = mkEnableOption "Git";
    includes = mkOpt (types.listOf types.attrs) [ ] "Git includeIf paths and conditions.";
    signByDefault = mkOpt types.bool true "Whether to sign commits by default.";
    signingKey =
      mkOpt types.str "${config.home.homeDirectory}/.ssh/id_ed25519" "The key ID to sign commits with.";
      mkOpt types.str "${config.home.homeDirectory}/.ssh/id_ed25519" "The key ID to sign commits with.";
    userName = mkOpt types.str user.fullName "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
    wslAgentBridge = mkBoolOpt false "Whether to enable the wsl agent bridge.";
    _1password = mkBoolOpt false "Whether to enable 1Password integration.";
    wslAgentBridge = mkBoolOpt false "Whether to enable the wsl agent bridge.";
    _1password = mkBoolOpt false "Whether to enable 1Password integration.";
  };

  config = mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
        inherit (cfg) userName userEmail;
        inherit (aliases) aliases;
        lfs = enabled;

        delta = {
          enable = true;

          options = {
            syntax-theme = mkIf config.khanelinix.tools.bat.enable "catppuccin-macchiato";
          };
        };

          extraConfig = {
            core = {
              whitespace = "trailing-space,space-before-tab";
            };

            # credential = {
            #   helper = mkIf cfg.wslAgentBridge ''/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe'';
            #   useHttpPath = true;
            # };

            fetch = {
              prune = true;
            };

            # gpg.format = "ssh";
            # "gpg \"ssh\"".program =
            #   ''''
            #   + ''${lib.optionalString pkgs.stdenv.isLinux (getExe' pkgs._1password-gui "op-ssh-sign")}''
            #   + ''${lib.optionalString pkgs.stdenv.isDarwin "${pkgs._1password-gui}/Applications/1Password.app/Contents/MacOS/op-ssh-sign"}'';

            init = {
              defaultBranch = "main";
            };

            pull = {
              rebase = true;
            };

            push = {
              autoSetupRemote = true;
            };

            safe = {
              directory = "${user.home}/work/config";
            };
          };

          inherit (cfg) includes;

          ignores = [
            ".DS_Store"
            "Desktop.ini"

            # Thumbnail cache files
            "._*"
            "Thumbs.db"

            # Files that might appear on external disks
            ".Spotlight-V100"
            ".Trashes"

            # Compiled Python files
            "*.pyc"

            # Compiled C++ files
            "*.out"

            # Application specific files
            "venv"
            "node_modules"
            ".sass-cache"

            ".idea*"
          ];

          # signing = {
          #   key = cfg.signingKey;
          #   inherit (cfg) signByDefault;
          # };
        };

        # gh = {
        #   enable = true;
        #   gitCredentialHelper = {
        #     enable = true;
        #     hosts = [
        #       "https://github.com"
        #       "https://gist.github.com"
        #     ];
        #   };
        # };

        # zsh = {
        #   initExtra = mkIf cfg.wslAgentBridge ''
        #     $HOME/.agent-bridge.sh
        #   '';
        # };
      };

    home = {
      inherit (aliases) shellAliases;
    };
  };
}
