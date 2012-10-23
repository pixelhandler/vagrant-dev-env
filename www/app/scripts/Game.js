define('game', function () {
    var Game = function () {};

    Game.prototype.roll = function (pins) {
        if (typeof pins !== 'number') {
            throw new Error('Game.role() expects `pins` argument to be a number');
        }
    };

    Game.prototype.score = function () {
        return -1;
    };

    return Game;
});
