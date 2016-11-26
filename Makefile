.PHONY: clean default pandoc server

default:
	"$(shell npm bin)/gulp"

server:
	"$(shell npm bin)/gulp" server

clean:
	@rm -rf dist
