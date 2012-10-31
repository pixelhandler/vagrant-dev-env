// Game module

var Game;

Game = function () {
    this._rolls = [];
    this._currentRoll = 0;
};

Game.prototype.roll = function (pins) {
    if (typeof pins !== 'number') {
        throw new Error("expeced a number");
    }
    this._rolls[this._currentRoll++] = pins;
};

Game.prototype.score = function () {
    var score = 0, i = 0, 
        tenthFrameRoll = this._bonusRoll(),
        rollsToScore = (tenthFrameRoll) ? tenthFrameRoll + 1 : this._rolls.length;

    for (i; i < rollsToScore; i ++) {
        if (this._isStrike(i)) {
            score += 10 + this._rolls[i + 1] + this._rolls[i + 2];
        } else if (this._isSpare(i)) {
            score += 10 + this._rolls[i + 2];
            i ++;
        } else {
            score += this._rolls[i];
        }
    }

    return score;
};

Game.prototype._isSpare = function (rollIdx) {
    return (this._rolls[rollIdx] + this._rolls[rollIdx + 1] === 10);
};

Game.prototype._isStrike = function (rollIdx) {
    return (this._rolls[rollIdx] === 10);
};

Game.prototype._bonusRoll = function () {
    var hasBonusRoll = false, 
        checkRoll = this._rolls.length - 3;

    if (this._isStrike(checkRoll) || this._isSpare(checkRoll)) {
        hasBonusRoll = true;
    }

    return (hasBonusRoll) ? checkRoll : null;
};

module.exports = Game;