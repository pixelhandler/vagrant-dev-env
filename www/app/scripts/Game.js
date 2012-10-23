define('game', function () {
    var Game = function () {
        this._score = 0;
    };

    // TODO design is wrong, responsibilities are missplaced...

    // TODO roll should not calculate score
    Game.prototype.roll = function (pins) {
        if (typeof pins !== 'number') {
            throw new Error('Game.role() expects `pins` argument to be a number');
        }
        this._score += pins;
    };

    // TODO score is not actually calculating value
    Game.prototype.score = function () {
        return this._score;
    };

    return Game;
});
