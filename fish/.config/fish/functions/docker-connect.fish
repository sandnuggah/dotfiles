function docker-connect --description 'connect to a docker machine'
  if count $argv > /dev/null
    eval (docker-machine env $argv)
  else
    eval (docker-machine env -u)
  end
end
