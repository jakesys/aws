SHELL = /bin/bash

NAME = jakesys/aws

ifeq ($(shell /usr/bin/uname),Darwin)
	TAC := tail -r
else
	TAC := tac
endif

default: help

help:
	@echo "Valid make targets..."
	@echo "  version  report the container's last successful version"
	@echo "  latest   tag latest successfully built image as latest"
	@echo "  clean    remove dangilng images and their exited containers"
	@echo "  tidy     only keep the latest and newer images"
	@echo "  build    increment build value by one and try to build container"

version:
	@source .version && \
	    echo "$(NAME) $$VERSION-$$BUILD"

latest:
	@source .version && \
	    echo "Tagging $(NAME):$$VERSION-$$BUILD as latest..." ; \
	    docker tag $(NAME):$$VERSION-$$BUILD $(NAME):latest

clean:
	@echo "Cleaning up any failed $(NAME) builds ..."
	@for i in `docker images -q -f dangling=true`; do \
	    for j in `docker ps -q -f status=exited -f ancestor=$$i`; do \
	        docker rm $$j ; \
	    done ; \
	    docker rmi $$i ; \
	done

tidy:
	@echo "Tidying up any images older than $(NAME):latest ..."
	@LATEST=`docker images -q $(NAME):latest` && \
        [ -n "$$LATEST" ] && \
	        for i in `docker images -q $(NAME) | $(TAC) | uniq`; do \
	            [ $$i = $$LATEST ] && break || docker rmi $$i ; \
	        done

build:
	@source .version && \
	    BUILD=`expr $$BUILD + 1` ; \
	    echo "Building $(NAME) $$VERSION-$$BUILD ..." ; \
	    echo -e "VERSION=$$VERSION\nBUILD=$$BUILD" > root/.version-build && \
	    docker build -t $(NAME):$$VERSION-$$BUILD . && \
	    cp root/.version-build .version
