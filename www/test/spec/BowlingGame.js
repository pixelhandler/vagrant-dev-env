// Bowling Game specs
require(['game'], function (Game) {

describe("Bowling Game Kata", function () {

    function rollMany(rolls, pins) {
        var i;

        for (i = 0; i < rolls; i++) {
            this.roll(pins);
        }
    }

    function rollSpare() {
        this.roll(5);
        this.roll(5);
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

    describe("Game with one spare", function () {

        it("should score 20 given the first 3 rolls hit 5 pins", function () {
            rollSpare.call(this.game)
            this.game.roll(5);
            rollMany.call(this.game, 17, 0);
            expect(this.game.score()).to.equal(20);
        });
        
        it("should score 19 given a spare and 2 following rolls of 3", function () {
            rollSpare.call(this.game)
            this.game.roll(3);
            this.game.roll(3);
            rollMany.call(this.game, 16, 0);
            expect(this.game.score()).to.equal(19);
        });


    });

});

});

