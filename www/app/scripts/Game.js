//define(function () {

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
        var score = 0, frameIdx = 0, bonusRoll = this._bonusRoll();

        for (frameIdx; frameIdx < this._rolls.length; frameIdx++) {
            if (this._isStrike(frameIdx)) {
                score += this._scoreStrike(frameIdx);
            } else if (this._isSpare(frameIdx)) {
                score += 10 + this._rolls[frameIdx + 2];
                frameIdx ++;
            } else {
                if (!bonusRoll || bonusRoll && frameIdx < bonusRoll) {
                    score += this._rolls[frameIdx];
                }
            }
        }

        return score;
    };

    Game.prototype._isSpare = function (frameIdx) {
        return (this._rolls[frameIdx] + this._rolls[frameIdx + 1] === 10);
    };

    Game.prototype._isStrike = function (frameIdx) {
        return (this._rolls[frameIdx] === 10);
    };

    Game.prototype._scoreStrike = function (frameIdx) {
        var score = 0, i = 1, bonusFrames = 2, bonusRoll = this._bonusRoll();

        score += 10;
        if (!bonusRoll || bonusRoll && frameIdx < bonusRoll - 2) {
            for (i; i <= bonusFrames; i++) {
                if (this._rolls[frameIdx + i]) {
                    score += this._rolls[frameIdx + i];
                }
            }
        }

        return score;
    };

    Game.prototype._bonusRoll = function () {
        var hasBonus = false,
            roll = this._rolls.length - 3;

        if (this._isStrike(roll) || this._isSpare(roll)) {
            hasBonus = true;
            this._bonusRollIdx = roll + 2;
        }

        return (hasBonus) ? this._bonusRollIdx : null;
    }

//    return Game;
//});

    module.exports = Game;
