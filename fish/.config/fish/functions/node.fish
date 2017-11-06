function node --description 'run node inside of a docker container'
	docker run -it --rm -v $PWD:/usr/src/app -w /usr/src/app node:8.8-slim node $argv;
end
