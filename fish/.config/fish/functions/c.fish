complete --command c --exclusive --arguments '(__fish_complete_directories ~/Code/)'

function c --description 'expand ~/Code/'
  cd $argv;
end
