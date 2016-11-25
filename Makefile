.PHONY: default clean

default:
	"$(shell npm bin)/gulp"

clean:
	@rm -rf html
	@rm -rf css
