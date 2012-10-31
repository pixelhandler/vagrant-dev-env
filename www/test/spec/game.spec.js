// Bowling game specs

var Game = require('../scripts-cov/Game');
var chai = require('chai');
expect = chai.expect;

describe("Ten-Ping Bowling Kata", function () {

    function rollMany(rolls, pins) {
        var i = 0;
        for (i; i < rolls; i ++) {
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

        it("should score 0 for a gutter game, all rolls are 0", function () {
            rollMany.call(this.game, 20, 0);
            expect(this.game.score()).to.equal(0);
        }); 

    });

    describe("Score game given all rolls hit only one pin", function () {

        it("should score 20", function () {
            rollMany.call(this.game, 20, 1);
            expect(this.game.score()).to.equal(20);
        });

    });

    describe("Score a game with only a spare", function () {

        it("should score 20 given the first 3 rolls hit 5 pins", function () {
            rollMany.call(this.game, 2, 5);
            this.game.roll(5);
            rollMany.call(this.game, 17, 0);
            expect(this.game.score()).to.equal(20);
        });

    });

    describe("Score a game with only one strike", function () {

        it("should score 20 given a strike followed by a two rolls hitting 2 & 3 pins", function () {
            this.game.roll(10);
            this.game.roll(2);
            this.game.roll(3);
            rollMany.call(this.game, 17, 0);
            expect(this.game.score()).to.equal(20);
        });

    });

    describe("Score a perfect game of 300 points", function () {

        it("should score 300 for 12 strikes in a row", function () {
            rollMany.call(this.game, 12, 10);
            expect(this.game.score()).to.equal(300);
        });

    });

    describe("Game with all scoring variations including tenth frame", function () {

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
            expect(this.game.score()).to.equal(110);
        });

    });

});