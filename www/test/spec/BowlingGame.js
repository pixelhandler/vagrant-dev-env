// Bowling Game specs

describe("Bowling Game Kata", function () {

    describe("Gutter Game", function () {

        it("should score zero", function () {
            require(['game'], function (Game) {
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
