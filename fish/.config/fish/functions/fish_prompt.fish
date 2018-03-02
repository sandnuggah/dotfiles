function fish_prompt --description "Simple prompt"
  set -l color_cwd
  set -l suffix

  switch $USER
    case root toor
      if set -q fish_color_cwd_root
        set color_cwd $fish_color_cwd_root
      else
        set color_cwd $fish_color_cwd
      end
      set suffix '#'
    case '*'
      set color_cwd $fish_color_cwd
      set suffix 'λ'
  end

  echo -n -s\
    "$USER" @ (prompt_hostname)\
    " "\
    (__docker_machine_name)\
    (set_color $color_cwd)\
    (prompt_pwd)\
    (set_color normal)\
    " $suffix "
end

function __docker_machine_name
  if set -q $DOCKER_MACHINE_NAME
    echo ""
  else
    echo (set_color red)"[$DOCKER_MACHINE_NAME] "(set_color normal)
  end
end
