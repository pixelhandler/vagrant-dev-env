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

});

});

