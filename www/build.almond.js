({
    baseUrl: '.',
    name: 'app/components/almond/almond',
    include: ['test/build/Game', 'test/build/spec'],
    insertRequire: ['test/build/spec'],
    out: 'test/build/almond.js',
    wrap: {
        startFile: ['test/lib/mocha/mocha.js', 'test/lib/chai.js', 'test/runner/begin.frag.js'],
        endFile: ['test/runner/middle.frag.js', 'test/runner/mocha.js', 'test/runner/end.frag.js']
    }
})
