({
    appDir: "test",
    baseUrl: ".",
    dir: "build",
    mainConfigFile: 'app/scripts/main.js',
    optimize: "none",
    paths: {
        spec: 'spec',
        gameSpec: 'spec/game.spec',
        game: 'scripts/Game',
        runner: 'runner/mocha'
    },
    name: 'spec',
    exclude: [
        'game'
    ]
})
