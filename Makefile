.PHONY: clean default server

default:
	"$(shell npm bin)/gulp"

server:
	"$(shell npm bin)/gulp" server

clean:
	@rm -rf dist
