test:
	@rm -fr ./test/build/*
	@r.js -o build.app.js
	@mv ./build/scripts/Game.js ./test/build/Game.js
	@rm -fr ./build/*
	@r.js -o build.test.js
	@mv ./build/spec.js ./test/build/spec.js
	@rm -fr ./build/*
	@cp ./app/components/almond/almond.js ./build/almond.js
	@r.js -o build.almond.js
	@yeoman test

.PHONY: test
