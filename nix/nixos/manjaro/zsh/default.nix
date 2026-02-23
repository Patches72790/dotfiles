{ lib, pkgs, ... }:
{
  config = {
    programs.zsh = {
      sessionVariables = {
        JAVA_HOME = builtins.toString pkgs.jdk25_headless.outPath;
      };
      enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        nv = "nvim";
        lsd = "ls -lah";
        l = "lsd";
        nixflkup = "nix flake update --flake $HOME/dotfiles/nix/nixos";
        nixhsw = "home-manager switch --impure --flake .";
        nixsw = "sudo nixos-rebuild switch --flake $HOME/dotfiles/nix/nixos#orpheus";
        nixdsw = "sudo darwin-rebuild switch --flake $HOME/dotfiles/nix/nixos#DOIT-X3PG99RC-X";
        gpf = "git push --force";
        egig = "echo_git_ignore";
        gdec = "git log --decorate=full --oneline --graph";
        glg = "git log --oneline --graph";
        grf = "git reflog";
        gl = "git pull";
        ga = "git add";
        gp = "git push";
        gpsup = "git push -u";
        gfa = "git fetch -a -p";
        gb = "git branch";
        gst = "git status";
        gd = "git diff";
        gc = "git commit";
        gcam = "gc -am";
        gcb = "git checkout -b";
        grb = "git rebase";
        gco = "git checkout";
        grs = "git reset";
        gbav = "gb -av";
        gbdc = "gbav | egrep '(\[gone\])' | egrep -v '(master|main)' | awk '{ print \$1 }'";
        gbda = "gbdc | xargs git branch -D";
      };
      #autosuggestions.enable = true;
      #history.size = 100000;
      enableCompletion = true;
      historySubstringSearch.enable = true;

      plugins = [ ];

      initContent = ''
        	# Prompt
            export EDITOR="nvim"
        	function git_branch_cmd() {
        	    echo "$(git branch 2>/dev/null | grep '*' | colrm 1 2)"
        	}
        	setopt PROMPT_SUBST
        	export PS1='%{%F{109}%}%n %{%F{106}%}$(git_branch_cmd) %{%F{72}%}%1~ %{%F{96}%}λ %{%f%}'

            # Enable vi keybindings
            bindkey -v

            # Kill input from the current point to the end of line with Ctrl-k
            bindkey '^k' kill-line
            # Search the history incremantally with Ctrl-r
            bindkey '^r' history-incremental-search-backward
            # Insert and go through the "last words" of previous commands with Meta-.
            # (or Escape-. for that matter).
            bindkey '^[.' insert-last-word
            # Show the man-page or other helpful infos with Meta-h
            bindkey '^[h' run-help
      '';
    };
  };
}
