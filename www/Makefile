test:
	@r.js -o build.app.js
	@mv ./build/scripts/Game.js ./test/build/Game.js
	@r.js -o build.test.js
	@mv ./build/spec.js ./test/build/spec.js
	@cp ./app/components/almond/almond.js ./build/almond.js
	@r.js -o build.almond.js
	@yeoman test

coverage:
	@jscoverage app app-cov
	@mocha -R html-cov > coverage.html

.PHONY: test
