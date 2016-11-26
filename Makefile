.PHONY: clean default pandoc server

default:
	"$(shell npm bin)/gulp"

install:
	npm install
	"$(shell npm bin)/bower" install
	stack init

server:
	"$(shell npm bin)/gulp" server

clean:
	@rm -rf dist
