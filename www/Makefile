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

coverage:
	@rm -fr app-cov
	@jscoverage app app-cov
	@mocha test/spec/game.spec.js -R html-cov > coverage.html

.PHONY: test
