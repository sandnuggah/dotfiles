function yarn --description 'run yarn inside of a docker container'
	docker run -it --rm -v $PWD:/usr/src/app -w /usr/src/app node:slim yarn $argv;
end
