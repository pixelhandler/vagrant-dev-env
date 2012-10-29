// Bowling Game specs
//define(['game'], function (Game) {
var Game = require('../scripts-cov/Game');
var chai = require('chai');
expect = chai.expect;

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

    function rollStrike() {
        this.roll(10);
    }

    beforeEach(function () {
        this.game = new Game();
    });

    describe("Gutter Game", function () {

        it("should throw error given a call to roll() with argument that is not a number", function () {
            this.game.badRoll = function () {
                this.roll('strike');
            };
            expect(this.game.badRoll).to.throw(Error);
        });

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

    describe("Game with one strike", function () {

        it("should score 26 given a strike on the 1st roll and 2 following rolls that hit 4 pins", function () {
            rollStrike.call(this.game);
            rollMany.call(this.game, 2, 4);
            rollMany.call(this.game, 17, 0);
            expect(this.game.score()).to.equal(26);
        });

    });

    describe("Perfect game", function () {

        it("should score 300 for with 12 strikes in a row", function () {
            rollMany.call(this.game, 12, 10);
            expect(this.game.score()).to.equal(300);
        });

    });

    describe("Beginner's Game", function () {

        it("should score 110", function () {
            var game = this.game;

            // frame 1, score: 9
            game.roll(7);
            game.roll(2);
            // frame 2, score: 16
            game.roll(6);
            game.roll(1);
            // frame 3, score: 26 + 3 = 29
            rollSpare.call(game);
            // frame 4, score: 36
            game.roll(3);
            game.roll(4);
            // frame 5, score: 46 + 10 = 56
            rollSpare.call(game);
            // frame 6, score: 66 + 5 + 3 = 74
            rollStrike.call(game);
            // frame 7, score: 82
            game.roll(5);
            game.roll(3);
            // frame 8, score: 87
            game.roll(5);
            game.roll(0);
            // frame 9, score: 95
            game.roll(6);
            game.roll(2);
            // frame 10, score: 105 + 5 = 110
            game.roll(7);
            game.roll(3);
            game.roll(5);
        });

    });

});

//});
