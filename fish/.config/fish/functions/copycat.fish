function copycat --description 'copy file to clipboard'
  /bin/cat $argv | /usr/bin/pbcopy;
end
