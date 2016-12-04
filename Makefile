.PHONY: clean default pandoc server

default:
	"$(shell npm bin)/gulp"

install:
	npm install
	"$(shell npm bin)/bower" install
	stack init

server:
	@if [ ! -f pug/en/posts ]; \
	then \
		mkdir -p pug/en/posts; \
	fi
	@if [ ! -f pug/ja/posts ]; \
	then \
		mkdir -p pug/ja/posts; \
	fi
	stack build
	stack exec site
	python populate-pugs.py
	"$(shell npm bin)/gulp" server

clean:
	@rm -f pug/en/posts/*
	@rm -f pug/ja/posts/*
	@rm -rf dist
