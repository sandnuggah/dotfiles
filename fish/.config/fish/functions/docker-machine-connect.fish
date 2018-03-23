function docker-machine-connect --description 'connect to a docker machine'
  docker-machine env $argv > /dev/null

  if test $status -eq 0
    eval (docker-machine env $argv)
  end
end
