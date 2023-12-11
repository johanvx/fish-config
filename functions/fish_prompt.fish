function fish_prompt -d '[HH:MM] User@Hostname:Cwd (GitPrompt) [LastPipeStatus] CmdDuration $'
    set -l last_pipestatus $pipestatus[-1]
    set -l current_time (date "+%H:%M")
    set -l cwd (basename (pwd | string replace $HOME "~"))
    set -l cmd_duration (math -s0 "$CMD_DURATION / 1000")

    # git prompt settings
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showupstream 'informative'
    set -g __fish_git_prompt_describe_style 'branch'

    # git prompt clean state
    set -g __fish_git_prompt_char_cleanstate ''
    set -g __fish_git_prompt_color_cleanstate green

    # git prompt dirty states
    set -g __fish_git_prompt_char_dirtystate '?'
    set -g __fish_git_prompt_char_invalidstate '*'
    set -g __fish_git_prompt_char_stagedstate '+'
    set -g __fish_git_prompt_color_dirtystate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_stagedstate green

    # git prompt untracked
    set -g __fish_git_prompt_char_untrackedfiles '!'
    set -g __fish_git_prompt_color_untrackedfiles magenta

    # git prompt colors
    set -g __fish_git_prompt_color white
    set -g __fish_git_prompt_color_branch brcyan
    set -g __fish_git_prompt_color_branch_detached magenta
    set -g __fish_git_prompt_color_branch_dirty yellow
    set -g __fish_git_prompt_color_branch_staged green

    # current time
    set_color brblack
    printf "[%s] " $current_time

    # username
    set_color magenta
    echo -n $USER

    # @ sep
    set_color brblack
    echo -n '@'

    # hostname
    set_color blue
    echo -n $hostname

    # : sep
    set_color brblack
    echo -n ':'

    # cwd
    set_color cyan
    echo -n $cwd

    # git branch
    set_color white
    printf '%s ' (fish_git_prompt)

    # last pipestatus
    if test ! $last_pipestatus = "0"
        set_color red
        printf '[%s] ' $last_pipestatus
    end

    # cmd duration
    if test ! $cmd_duration = "0"
        set_color white
        set -l year (math -s0 "$cmd_duration / (60 * 60 * 24 * 30 * 12)")
        set -l month (math -s0 "$cmd_duration / (60 * 60 * 24 * 30) % 12")
        set -l day (math -s0 "$cmd_duration / (60 * 60 * 24) % 30")
        set -l hour (math -s0 "$cmd_duration / (60 * 60) % 24")
        set -l minute (math -s0 "$cmd_duration / 60 % 60")
        set -l second (math -s0 "$cmd_duration % 60")
        function print_non_zero
            if ! test $argv[1] = '0'
                printf '%s%s' $argv[1] $argv[2]
            end
        end
        print_non_zero $year 'yr'
        print_non_zero $month 'mo'
        print_non_zero $day 'd'
        print_non_zero $hour 'hr'
        print_non_zero $minute 'min'
        print_non_zero $second 's'
        echo -n ' '
    end

    # $ indicator
    set_color green
    echo -n '$ '
    set_color normal
end
