test:
	@mocha test/spec/game.spec.js -R spec

coverage:
	@rm -fr app-cov
	@jscoverage app app-cov
	@mocha test/spec/game.spec.js -R html-cov > coverage.html

.PHONY: test
