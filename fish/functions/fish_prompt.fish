function fish_prompt
  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  switch "$USER"
    case root toor
      if not set -q __fish_prompt_cwd
        if set -q fish_color_cwd_root
          set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
          set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end
      end

      set prompt_sign '#'

    case '*'
      if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end

      set prompt_sign '$'
  end

  if set -q RANGER_LEVEL
    set ranger (echo -n -s (set_color cyan) " [ranger]" $__fish_prompt_normal)
  end

  if set -q IN_NIX_SHELL
    set nix_shell_info (echo -n -s (set_color brcyan) " [nix]" $__fish_prompt_normal)
  end

  echo -n -s "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" "$nix_shell_info" "$ranger" " $prompt_sign "
end
