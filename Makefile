.PHONY: default pandoc server

default:
	"$(shell npm bin)/gulp"

install:
	npm install
	"$(shell npm bin)/bower" install
	stack init

server: dist/pdf.js/web/viewer.html
	@rm -f pug/en/posts/*
	@rm -f pug/ja/posts/*
	@rm -rf dist/en
	@rm -rf dist/ja
	@if [ ! -f pug/en/posts ]; \
	then \
		mkdir -p pug/en/posts; \
	fi
	@if [ ! -f pug/ja/posts ]; \
	then \
		mkdir -p pug/ja/posts; \
	fi
	@rm -rf html
	@rm -rf dist/public/pdf
	@cp -r pdf dist/public/
	stack build
	stack exec site
	python populate-pugs.py
	"$(shell npm bin)/gulp" server

dist/pdf.js/web/viewer.html: pdf.js/build/generic/web/viewer.html
	@rm -rf dist/pdf.js
	@cp -r pdf.js/build/generic/build dist/pdf.js/
	@cp -r pdf.js/build/generic/web dist/pdf.js/

pdf.js/build/generic/web/viewer.html:
	@cd pdf.js; \
		npm install; \
		PATH=$(shell npm bin):${PATH} gulp generic
