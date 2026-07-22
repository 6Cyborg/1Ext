#!/usr/bin/env fish

if not set -q __log_start
    # set -g __log_start (date +%s)
    set -gx __log_start (date +%s)
end

## Logging :

function __perform_log
    argparse "e/exit=" "c/color=" "l/level=" -- $argv

    set -l level (echo "$(set_color --bold)$_flag_color$_flag_level" | 
        string pad -r -c ' ' -w 6)

    set -l registry (echo "$(set_color --reset)$(set_color "#9E9E9E")@$log_registry" |
        string pad -r -c ' ' -w 15)

    set -l elapsed_secs (math (date +%s) - $__log_start)
    set -l elapsed (echo "$(set_color "#546E7A")+$elapsed_secs$(set_color --reset)" |
        string pad -r -c ' ' -w 7)

    printf "$elapsed $level $registry $(set_color --reset)%s\n" "$argv" >&2
    
    if test -n "$_flag_e"
        return $_flag_e
    else
        return 0
    end
end

# NOTE : pas de `--` pour supporté `-e`
alias llerr "__perform_log -c (set_color EF5350) -l 'Error 💥'"
alias llwar "__perform_log -c (set_color FFA726) -l 'Warn ⚡'"
alias llinf "__perform_log -c (set_color 66BB6A) -l 'Info 📍'"
alias llwait "__perform_log -c (set_color 26C6DA) -l 'Wait ⏳'"

## Formattage customisé :

function __perform_fmt
    argparse "c/color=" -- $argv; or return 2
    printf "%s%s%s\n" $_flag_color "$argv" $(set_color --reset)
end

alias llcode="__perform_fmt -c (set_color -b444 brwhite) --"

function llslug -d "helper : ` Tutoriel : le cœur de naïtou ` est transformé en `Tutoriel-le-coeur-de-naitou`"
    argparse -N1 -X1 -- $argv; or return 2
    
    # Exemples :
    # - `Tutoriel : le cœur de naïtou` => `Tutoriel-le-coeur-de-naitou`
    
    echo $argv[1] |
        iconv -f UTF-8 -t ASCII//TRANSLIT |
        string replace -ra '[^a-zA-Z0-9]+' '-' |
        string trim -c -

    # retour zero forcé car `string trim` retourne non-zero qd il agit pas
    return 0
end

