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
      advice.skippedCherryPicks = false;
      core = {
        editor = "hx";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
        ff = "only";
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
          git -c core.editor=true rebase -i --autostash --autosquash "$base~1"

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
          set -eu

          committed=$(git diff --cached --name-only)
          git commit -q "$@"

          git st
          echo ""
          echo "Committed:"
          echo "$committed"
        '';

        coe = aliasCommand "coe" ''
          #! /usr/bin/env bash
          set -e

          git commit -q --allow-empty -m "$@"
          git st
        '';

        com = "co -m";

        ch = aliasCommand "ch" ''
          #! /usr/bin/env bash
          set -euo pipefail
          shopt -s extglob

          if [ $# -eq 0 ]
          then
            selection=$(git branch --color --list --all | \
              ${pkgs.fzf}/bin/fzf --ansi --layout=reverse-list --height=~100% --prompt="Select branch: " | \
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
          elif [ $# -eq 1 ]
          then
            if git checkout "$1" > /dev/null 2>/dev/null
            then
              echo "Switched to branch '$1'"
            else
              echo "Branch '$1' not found. Create? (y/n) (default: y)"
              while true; do
                read yn
                case $yn in
                  ?(y) )
                    git checkout -b "$1"
                    break
                    ;;
                  n ) exit;;
                  * ) echo "Enter 'y' or 'n'";;
                esac
              done
            fi
          else
            git checkout "$@"
          fi

          echo ""
          git st
        '';

        chn = "checkout -b";

        d = "diff";

        ds = "diff --cached";

        l = aliasCommand "l" ''
          #! /usr/bin/env bash
          FORMAT_STRING='%C(yellow)%h%Creset - %<(65,trunc)%s %Cgreen(%cr)%C(bold blue)%<(50,trunc)%d%Creset'

          if [ $# -eq 0 ]
          then
            DEFAULT_LIMIT=20
            git log \
              --pretty=format:"$FORMAT_STRING" \
              --abbrev-commit \
              -n "$DEFAULT_LIMIT"
            echo "($(git rev-list HEAD --count --max-count "$DEFAULT_LIMIT") of $(git rev-list HEAD --count) commits shown)"
          else
            git log \
              --pretty=format:"$FORMAT_STRING" \
              --abbrev-commit \
              "$@"
          fi
        '';

        f = aliasCommand "f" ''
          #! /usr/bin/env bash
          set -e

          git fetch
          git lg @ @{u} -n 20
        '';

        fork = aliasCommand "fork" ''
          #! /usr/bin/env bash
          set -eu

          base=$1
          new=$2

          git checkout -b "$new" "$base" --no-track
        '';

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

        p = aliasCommand "p" ''
          #! /usr/bin/env bash
          set -e

          git push "$@"

          echo ""
          git st
        '';

        pa = aliasCommand "pa" ''
          #! /usr/bin/env bash
          set -e

          git push --all "$@"

          echo ""
          git st
        '';

        pf = aliasCommand "pf" ''
          #! /usr/bin/env bash
          set -e

          git push -f "$@"

          echo ""
          git st
        '';

        r = aliasCommand "r" ''
          #! /usr/bin/env bash
          set -e

          git restore --staged "$@"
          git st
        '';

        re = aliasCommand "re" ''
          #! /usr/bin/env bash
          set -e

          git rebase --autostash "$@"

          echo ""
          git lg @ @{u} -n 20
        '';

        "rec" = aliasCommand "rec" ''
          #! /usr/bin/env bash
          set -e

          git rebase --continue

          echo ""
          git lg @ @{u} -n 20
        '';

        rei = aliasCommand "rei" ''
          #! /usr/bin/env bash
          set -euo pipefail

          limit=20

          while getopts "n:" opt; do
            case "$opt" in
              n)
                limit="$OPTARG"
                ;;
            esac
          done

          base=$(git log \
            --color \
            --pretty=format:'%C(yellow)%h%Creset - %s %Cgreen(%cr)%C(bold blue)%d%Creset' \
            --abbrev-commit \
            -n "$limit" \
            | ${pkgs.fzf}/bin/fzf --ansi --layout=reverse-list --height=~100% --prompt="Base commit: " \
            | ${pkgs.coreutils}/bin/cut -d " " -f 1 -
          )

          git rebase --autostash -i "$base"

          echo ""
          git l
        '';

        reword = aliasCommand "reword" ''
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

          git commit -q --fixup=reword:"$base"
          git -c core.editor=true rebase -i --autostash --autosquash "$base~1"

          echo ""

          git lg @ @{u} -n 20
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

          git stash push -q "$@" && git st
        '';

        undo = aliasCommand "undo" ''
          #! /usr/bin/env bash
          set -e

          git reset --soft HEAD~1
          git st
        '';

        # Open the repository's web view.
        #
        # Guesses a web URL based on the repo's `origin` remote.
        web = aliasCommand "web" ''
          set -euo pipefail

          origin=$(git remote get-url origin)
          case $origin in
            http://*)
              url=$origin
            ;;
            https://*)
              url=$origin
            ;;
            git\@*)
              url="http://"$(
                # remove `git@` prefix
                sed "s/git@//" <<<$origin |

                # replace first `:` with `/`
                sed "s/\([^:]*\):/\1\//" |

                # remove `.git` suffix
                sed 's/\.git$//'
              )
            ;;
          esac

          echo "Opening $url..."
          xdg-open $url
        '';
      };
    };
  };
}
