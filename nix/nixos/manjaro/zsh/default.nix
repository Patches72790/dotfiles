{ lib, pkgs, ... }:
{
  config = {
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        nv = "nvim";
        lsd = "ls -lah";
        l = "lsd";
        hs = "home-manager switch --impure --flake .";
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
      };
      #autosuggestions.enable = true;
      #history.size = 100000;
      enableCompletion = true;
      historySubstringSearch.enable = true;

      # TODO
      plugins = [ ];

      initExtra = ''
        	# Prompt
        	function git_branch_cmd() {
        	    echo "$(git branch 2>/dev/null | grep '*' | colrm 1 2)"
        	}
        	setopt PROMPT_SUBST
        	export PS1='%{%F{109}%}%n %{%F{106}%}$(git_branch_cmd) %{%F{72}%}%1~ %{%F{96}%}λ %{%f%}'
      '';
    };
  };
}
