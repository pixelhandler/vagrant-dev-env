define('game', function () {
    var Game = function () {
        this._currentRoll = 0;
        this._rolls = [];
        this._spares = [];
    };

    Game.prototype.roll = function (pins) {
        if (typeof pins !== 'number') {
            throw new Error('Game.role() expects `pins` argument to be a number');
        }
        this._rolls[this._currentRoll++] = pins;
    };

    Game.prototype.score = function () {
        var score = 0, frameIdx = 0;

        for (frameIdx; frameIdx < this._rolls.length; frameIdx++) {
            if (this._isSpare(frameIdx)) {
                score += 10 + this._rolls[frameIdx + 2];
                frameIdx ++;
            } else {
                score += this._rolls[frameIdx];
            }
        }

        return score;
    };

    Game.prototype._isSpare = function (frameIdx) {
        var isSpare = (this._rolls[frameIdx] + this._rolls[frameIdx + 1] === 10),
            isLastRollSpare,
            i = 0;

        if (isSpare) {
            if (this._rolls.length) {
                for (i; i < this._spares.length; i++) {
                    if (this._spares[i] === frameIdx - 1) {
                        isLastRollSpare = true;
                    }
                }
            }
            if (!isLastRollSpare) {
                this._spares.push(frameIdx);
            } else {
                isSpare = false;
            }
        }

        return isSpare;
    };

    return Game;
});
