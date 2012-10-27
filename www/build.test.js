({
    appDir: "./test",
    baseUrl: "./spec",
    dir: "./build",
    mainConfigFile: './app/scripts/main.js',
    optimize: "none",
    paths: {
        spec: '../spec',
        gameSpec: 'game.spec',
        game: '../../app/scripts/Game'
    },
    name: 'spec',
    exclude: [
        'game'
    ]
})
