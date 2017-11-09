function lein --description 'run lein inside of a docker container'
	docker run -it --rm -v $PWD:/usr/src/app -w /usr/src/app clojure:alpine lein $argv;
end
