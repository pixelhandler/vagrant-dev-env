// Bowling Game specs
require(['game'], function (Game) {

describe("Bowling Game Kata", function () {

    describe("Gutter Game", function () {

        it("should score zero", function () {
            var game = new Game(),
                i = 0;

            for (i; i < 20; i ++) {
                game.roll(0);
            }
            expect(game.score()).to.equal(0);
        });

    });

    describe("Game with every roll only hitting one pin", function () {

        it("should score 20 given each roll hits 1 pin", function () {
            var game = new Game(),
                i = 0;

            for (i; i < 20; i ++) {
                game.roll(1);
            }
            expect(game.score()).to.equal(20);
        });

    });

});

});

