{ config, pkgs, ... }: 
let
  aliasCommand = alias: code: "!cd -- \"\${GIT_PREFIX:-.}\"; ${pkgs.writeScript "git-alias-${alias}" code}";
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Isaac Elliott";
    extraConfig = {
      core = {
        editor = "hx";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      alias = {
        a = aliasCommand "a" ''
          #! /usr/bin/env bash

          git add "$@"
          git st
        '';

        amend = aliasCommand "amend" ''
          #! /usr/bin/env bash
          set -euo pipefail

          if [ $# -eq 0 ]
          then
            basePrefix=$(
              git -c color.ui=always l | \
              ${pkgs.fzf}/bin/fzf --ansi --layout=reverse-list --height=~100% | \
              cut -d " " -f 1
            )
          elif [ $# -eq 1 ]
          then
            basePrefix="$1"
          else
            echo "error: expected 0 or 1 argument"
            exit 1
          fi

          commits=$(git rev-list --all | ${pkgs.ripgrep}/bin/rg "^$basePrefix")
          if [ "$(wc -l <<<"$commits")" == 1 ]
          then
            base="$commits"
          else
            base="$(
              xargs \
                git \
                  -c color.ui=always \
                  log \
                  --pretty=format:'%C(yellow)%H%Creset - %s %Cgreen(%cr)%C(bold blue)%d%Creset' \
                  --abbrev-commit \
                  --no-walk \
                  <<<"$commits" | \
              ${pkgs.fzf}/bin/fzf --ansi --layout=reverse-list --height=~100% | \
              cut -d " " -f 1
            )"
          fi

          git commit -q -m "fixup! $base"
          git -c core.editor=true rebase -i --autosquash "$base~1"

          echo ""

          git l
        '';

        ap = aliasCommand "ap" ''
          git add -p "$@"
          git st
        '';

        au = aliasCommand "au" ''
          git add -u "$@"
          git st
        '';

        br = aliasCommand "br" ''
          #! /usr/bin/env bash

          if [ $# -eq 0 ]; then git branch --show-current; else git branch "$@"; fi
        '';

        co = aliasCommand "co" ''
          #! /usr/bin/env bash
          set -e

          committed=$(git -c color.ui=always commit --short --dry-run)

          git commit -q "$@"

          git st
          echo ""
          echo "Committed:"
          echo "$committed"
        '';

        com = "co -m";

        ch = aliasCommand "ch" ''
          #! /usr/bin/env bash
          set -euo pipefail

          if [ $# -eq 0 ]
          then
            selection=$(git branch --color --list --all | \
              nix shell nixpkgs#fzf -c \
                fzf --ansi --layout=reverse-list --height=~100% --prompt="Select branch: " | \
              sed "s/^\*\? *//"
            )

            if [[ "$selection" =~ ^remotes/(.*)$ ]]
            then
              remoteBranch="''${BASH_REMATCH[1]}"
              if [[ "$remoteBranch" =~ ^([^/]+)/(.*)$ ]]
              then
                remote="''${BASH_REMATCH[1]}"
                branch="''${BASH_REMATCH[2]}"
                git checkout -b "$branch" --track "$remote/$branch"
              else
                echo "error: invalid branch selection: $selection"
                exit 1
              fi
            else
              git checkout "$selection"
            fi
          else
            git checkout "$@"
          fi

          echo ""
          git st
        '';

        d = "diff";

        ds = "diff --cached";

        l = aliasCommand "l" ''
          #! /usr/bin/env bash

          if [ $# -eq 0 ]
          then
            DEFAULT_LIMIT=20
            git log \
              --pretty=format:'%C(yellow)%h%Creset - %s %Cgreen(%cr)%C(bold blue)%d%Creset' \
              --abbrev-commit \
              -n "$DEFAULT_LIMIT"
            echo "($(git rev-list HEAD --count --max-count "$DEFAULT_LIMIT") of $(git rev-list HEAD --count) commits shown)"
          else
            git log \
              --pretty=format:'%C(yellow)%h%Creset - %s %Cgreen(%cr)%C(bold blue)%d%Creset' \
              --abbrev-commit \
              "$@"
          fi
        '';

        f = "fetch";

        lg = aliasCommand "lg" ''
          #! /usr/bin/env bash

          if [ $# -eq 0 ]
          then
            DEFAULT_LIMIT=20
            git log \
              --graph \
              --pretty=format:'%C(yellow)%h%Creset - %s %Cgreen(%cr)%C(bold blue)%d%Creset' \
              --abbrev-commit \
              -n "$DEFAULT_LIMIT"
            echo "($(git rev-list HEAD --count --max-count "$DEFAULT_LIMIT") of $(git rev-list HEAD --count) commits shown)"
          else
            git log \
              --graph \
              --pretty=format:'%C(yellow)%h%Creset - %s %Cgreen(%cr)%C(bold blue)%d%Creset' \
              --abbrev-commit \
              "$@"
          fi
        '';

        nch = "checkout -b";

        nco = aliasCommand "nco" ''
          #! /usr/bin/env bash
          set -e

          git commit -q --allow-empty "$@"
          git st
        '';

        p = "push";

        pf = "push -f";

        r = aliasCommand "r" ''
          #! /usr/bin/env bash
          set -e

          git restore --staged "$@"
          git st
        '';

        re = aliasCommand "re" ''
          #! /usr/bin/env bash
          set -e

          git rebase "$@"

          echo ""
          git l
        '';

        rei = aliasCommand "rei" ''
          #! /usr/bin/env bash
          set -euo pipefail

          if [ $# -eq 0 ]
          then
            DEFAULT_LIMIT=20

            base=$(git log \
              --color \
              --pretty=format:'%C(yellow)%h%Creset - %s %Cgreen(%cr)%C(bold blue)%d%Creset' \
              --abbrev-commit \
              -n "$DEFAULT_LIMIT" \
              | ${pkgs.fzf}/bin/fzf --ansi --layout=reverse-list --height=~100% --prompt="Base commit: " \
              | ${pkgs.coreutils}/bin/cut -d " " -f 1 -
            )

            git rebase -i "$base"
          else
            git rebase -i "$@"
          fi

          echo ""
          git l
        '';

        st = aliasCommand "st" ''
          #! /usr/bin/env bash

          changes=$(git -c color.ui=always status -s "$@")
          if [ "$changes" = "" ]
          then
            echo "No changes."
          else
            echo "Changes:"
            echo "$changes"
          fi

          echo ""

          unpushed=$(git l "@{u}.." --color)
          if [ "$unpushed" = "" ]
          then
            echo "All commits pushed."
          else
            echo "Unpushed commits:"
            echo "$unpushed"
          fi
        '';

        spop = aliasCommand "spop" ''
          #! /usr/bin/env bash

          git stash pop -q && git st
        '';

        spush = aliasCommand "spush" ''
          #! /usr/bin/env bash

          git stash push -q && git st
        '';

        undo = aliasCommand "undo" ''
          #! /usr/bin/env bash
          set -e

          git reset --soft HEAD~1
          git st
        '';
      };
    };
  };
}
