// Bowling Game specs
require(['game'], function (Game) {

describe("Bowling Game Kata", function () {

    function rollMany(rolls, pins) {
        var i;

        for (i = 0; i < rolls; i++) {
            this.roll(pins);
        }
    }

    beforeEach(function () {
        this.game = new Game();
    });

    describe("Gutter Game", function () {

        it("should score zero", function () {
            rollMany.call(this.game, 20, 0);
            expect(this.game.score()).to.equal(0);
        });

    });

    describe("Game with every roll only hitting one pin", function () {

        it("should score 20 given each roll hits 1 pin", function () {
            rollMany.call(this.game, 20, 1);
            expect(this.game.score()).to.equal(20);
        });

    });

});

});

