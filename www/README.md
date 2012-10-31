# Bowling Game Kata using Mocha (BDD) Test framework and Yeoman

## About this Tutorial…

This tutorial was created in an effort to learn more about using new tools like Yeoman and the Mocha test framework using [Node.js][nodejs] that can be executed in a headless browser environment ([phantomjs][phantomjs]), and to assist other engineers in learning the practice of behavior driven development. Basically, this article is a result of following the ['kata' by Uncle Bob][TheBowlingGameKata] to author a simple program in JavaScript that scores a [game of ten-pin bowling][TenPinBowlingGame].

Covered in this tutorial:

1.  Using the [Mocha test framework][mochasite] with behavior-driven development ([BDD][BDD])  
2.  [Uncle Bob's "Bowling Game" kata][TheBowlingGameKata] in JavaScript
3.  Quickly setting up your development environment with [Vagrant, VirtualBox][vagrant-dev-box] and [Yeoman][yeomansite] 
3.  First, writing [tests][chaibdd] to describe the expected behaviors which fail  
4.  Next, writing application code which passes the tests  
5.  The result: a program that [scores a game of bowling][scoringbasics], and better BDD skills

Inspired my Robert Martin's 'Bowling Game Kata' (a programmer's exercise) I followed Uncle Bob's presentation of the test-driven development exercise to write a program that scores a bowling game and documented the code written in JavaScript. This tutorial content is not my own but rather an exercise of making the Bowling Game Kata my own practice, so I've borrowed the kata from Uncle Bob along with his class diagrams and ten-pin bowling graphic. The headings in this tutorial from the 'Quick Design Session' through the 'Fifth Test' make up the essence of Uncle Bob's presentation. Thank you [Uncle Bob][unclebob] for putting together an excellent exercise!

Note: The code examples in this tutorial will use `git diff` style indicators, lines with the first character `+`/`-` show an action to add(+) or remove(-) a line of code.

### Test-driven development (TDD)

A software development process that relies on the repetition of a very short development cycle: **first** the developer writes a **failing automated test case** that defines a desired improvement or new function, **then** produces **code to pass that test** and finally refactors the new code to acceptable standards.

See: [http://en.wikipedia.org/wiki/Test-driven\_development][TDD]

*“Test-driven development constantly repeats the steps of adding test cases that fail, passing them, and refactoring. Receiving the expected test results at each stage reinforces the programmer’s mental model of the code, boosts confidence and increases productivity.”*

#### The TDD Process

1. Add a test
2. Run all tests and see if the new one fails
3. Write some code
4. Run the automated tests and see them succeed
5. Refactor code
6. Repeat

Basically *[Lather, Rinse, Repeat][TDD]*

#### Behavior-driven development (BDD)

See: Introducing BDD : [http://blog.dannorth.net/introducing-bdd/][BDD]

Use language/terminology that everyone on the project understands; using a pattern (e.g. Given, When, Then.) to test expected behavior.

*“Developers discovered it could do at least some of their documentation for them, so they started to write test methods that were real sentences.”*

## Vagrant Development Environment

Vagrant [development environment][vagrant-dev-box] provisioned with shell scripts on a (linux/ubuntu) precise64 box. The first time you execute `vagrant up` the provision scripts will download a linux box "precise64" and install some software needed for a development box. You can edit the provision.sh or scripts in the /bin directory to customize your environment or skip some installations. It may take about 10 minutes to download and install.

```
cd ~/code/
git clone https://github.com/pixelhandler/vagrant-dev-env ./bowlingkata
cd bowlingkata
git submodule init
git submodule update
vagrant up
```

Update your /etc/hosts file, add: `192.168.50.4 precise64` the vagrant/virtual box will use <http://precise64/> or <http://192.168.50.4/> for the www root. You could use any domain you like, the `precise64` apache vhost runs from on the IP address: 192.168.50.4 so `192.168.50.4 precise64.dev` works too, <http://precise64.dev/> may be easier to use in a browser.

## Scoring Bowling

![Complete game][10frames]

The game consists of 10 frames as shown above.  In each frame the player has two opportunities to knock down 10 pins.  The score for the frame is the total number of pins knocked down, plus bonuses for strikes and spares.

A spare is when the player knocks down all 10 pins in two tries.  The bonus for that frame is the number of pins knocked down by the next roll.  So in frame 3 above, the score is 10 (the total number knocked down) plus a bonus of 5 (the number of pins knocked down on the next roll.)

A strike is when the player knocks down all 10 pins on his first try.  The bonus for that frame is the value of the next two balls rolled.

In the tenth frame a player who rolls a spare or strike is allowed to roll the extra balls to complete the frame.  However no more than three balls can be rolled in tenth frame.

For more info see [Ten-pin bowling game Wikipedia article][TenPinBowlingGame] and article for [Instructions on scoring with game examples][scoringinstructions]

[10frames]: https://raw.github.com/pixelhandler/vagrant-dev-env/bowling/www/app/images/ten-pins.jpg "Uncle Bob game"

## The Requirements

	+--------------------+
	| Game               |
	| ------------------ |
	| + roll(pins : int) |
	| + score() : int    |
	+--------------------+

Write a class named “Game” that has two methods:  
* **roll(pins : int)** is called each time the player rolls a ball.  The argument is the number of pins knocked down.  
* **score() : int** is called only at the very end of the game.  It returns the total score for that game.


## Quick Design Session

1. Clearly we need the Game class. ![Game class][des1]
2. A game has 10 frames.  ![Frame class][des2]
3. A frame has 1 or two rolls.  ![Roll class][des3]
4. The tenth frame has two or three rolls. It is different from all the other frames.  ![Tenth frame][des4]
5. The score function must iterate through all the frames, and calculate all their scores.  ![Score method][des5]
6. The score for a spare or a strike depends on the frame’s successor  ![Next frame][des6]

[des1]: https://raw.github.com/pixelhandler/vagrant-dev-env/bowling/www/app/images/game_class.png "Game class"
[des2]: https://raw.github.com/pixelhandler/vagrant-dev-env/bowling/www/app/images/frame_class.png "Frame class"
[des3]: https://raw.github.com/pixelhandler/vagrant-dev-env/bowling/www/app/images/roll_class.png "Roll class"
[des4]: https://raw.github.com/pixelhandler/vagrant-dev-env/bowling/www/app/images/tenth_frame_class.png "Tenth frame"
[des5]: https://raw.github.com/pixelhandler/vagrant-dev-env/bowling/www/app/images/frame_class_score.png "Score method"
[des6]: https://raw.github.com/pixelhandler/vagrant-dev-env/bowling/www/app/images/frame_class_next.png "Next frame"


## Begin

### Create a project in /vagrant/www

Issue some vagrant and yeoman commands to get started

	git checkout -b bowling
	vagrant ssh
	git config --global user.name "Your Name"
	git config --global user.email "me@dom.com"
	cd /vagrant/www
	yeoman init
	# Answer Y/n (make yeoman better), then... n, n, Y (RequireJS), n, N to yeoman.
	git add .
	git commit -m "yeoman init"
	yeoman test
	yeoman server
	# see http://precise64.dev:3501/ 
	# stop yeoman server with control-c, `exit` (vagrant ssh); or stay in bowlingkata and use vimvim

Now you should have /vagrant/www/app and vagrant/www/test directories this is where we will write some code in. 

*Note:* You do not have to use the vagrant development environment to complete this tutorial (kata); you could just open the test file in your browser to execute the tests and view the mocha report. If you are not using the virtual box / vagrant environment then be sure to modify `/vagrant/www/` to the path to your working directory.

Edit app/scripts/main.js add `app: 'app',` and delete a few lines, all you will need is the `paths` object:

	 require.config({
	-  shim: {
	-  },
	-
	   paths: {
	+    app: 'app',
	     jquery: 'vendor/jquery.min'
	   }
	 });
	- 
	-require(['app'], function(app) {
	-  // use app here
	-  console.log(app);
	-});

Create symbolic link for `scripts` in the test directory, to load [require.js][requirejs] and main.js with one script element. I had an issue creating a symbolic link while in the precise64 box (using `vagrant ssh`), so I exited the ssh connection and made the link.

	exit
	cd www/test/
	ln -s ../app/scripts/ ./scripts
	cd ../../ && vagrant ssh
	cd /vagrant/www/

The test runner index.html (see below) will use the directory `www/app/scripts` via the symbolic link (see above) to load the application's RequireJS main configuration file and to load the RequireJS library.

Edit file: /test/index.html - use this markup:

	<!doctype html>
	<head>
	  <meta charset="utf-8">
	  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	  <title>Mocha Spec Runner</title>
	  <link rel="stylesheet" href="lib/mocha/mocha.css">
	</head>
	<body>
	  <div id="mocha"></div>
	
	  <script src="lib/mocha/mocha.js"></script>
	  <script src="lib/chai.js"></script>
	  <script data-main="scripts/main" src="scripts/vendor/require.js"></script>
	
	  <script>
	    mocha.setup({ui: 'bdd', ignoreLeaks: true});
	    expect = chai.expect;
	    require(['../spec/game.spec'], function () {
	      setTimeout(function () {
	        require(['../runner/mocha']);
	      }, 100);
	    });
	  </script>
	
	</body>
	</html>


It will be very helpful to change the lint task in the (yeoman) generated file, Gruntfile.js, e.g. to ignore the vendor directory (and other subdirectories); also to lint the test directory with the command: `yeoman lint`.

	     lint: {
	       files: [
	         'Gruntfile.js',
	-        'app/scripts/**/*.js',
	+        'app/scripts/*.js',
	+        'test/spec/*.js'
	       ]


## First Test, A Gutter Game

### Create a unit test in test/spec/game.spec.js

	cd /vagrant/www/test/spec && touch game.spec.js
	cd /vagrant/www/app/scripts && touch Game.js

### Add a failing test for a gutter game.

Add code to test/spec/game.spec.js

	+// Bowling Game specs
	+
	+describe("Ten-Ping Bowling Kata", function () {
	+
	+    describe("Gutter Game", function () {
	+
	+        it("should score 0 for a gutter game, all rolls are 0", function () {
	+            var game = new Game();
	+        });
	+
	+    });
	+
	+});


### Execute this program and verify that you get an error

	cd /vagrant/www/

#### Run the spec, `yeoman test` should FAIL

	>> Gutter Game - should score 0 for a gutter game, all rolls are 0
	>> Message: Can't find variable: Game

### Pass the failing test, by adding Game constructor

Add code in app/scripts/Game.js

	+define('game', function () {
	+    var Game = function () {};
	+
	+    return Game;
	+});

Add `game: 'Game'` to requirejs config in app/scripts/main.js

	 require.config({
	   paths: {
	     app: 'app',
	+    game: 'Game',
	     jquery: 'vendor/jquery.min'
	   }
	 });

Update spec in test/spec/game.spec.js adding a `require` call for the Game constructor, wrap the entire describe call with...

	+require(['game'], function (Game) {
	+
	 describe("Ten-Ping Bowling Kata", function () {

…

	 });
	+
	+});

#### Run the spec, `yeoman test` should PASS

	>> 1 assertions passed (0.01s)

You can also visit <http://precise64.dev/test/> in your browser; the vagrant provisioning task setup the precise64.dev virtual host for you. The precise64.dev domain renders the files served by apache from the `/vagrant/www` directory, and is accessible to your browser as long as your hosts file has the entry `192.168.50.4 precise64.dev`.

### Continue the specs for a gutter game

#### Add a failing test for a gutter game, and stub roll() and score() methods

Add an assertion to test/spec/game.spec.js

	         it("should score 0 for a gutter game, all rolls are 0", function () {
	-            var game = new Game();
	+            var game = new Game(), i = 0;
	+
	+            for (i; i < 20; i ++) {
	+                game.roll(0);
	+            }
	+            expect(game.score()).to.equal(0);
	         });

Add some stub methods in app/scripts/Game.js

	 define('game', function () {
	     var Game = function () {};
	 
	+    Game.prototype.roll = function (pins) {
	+        if (typeof pins !== 'number') {
    +            throw new Error("expeced a number");
    +   	 }
	+    };
	+
	+    Game.prototype.score = function () {
	+        return -1;
	+    };
	+
	     return Game;
	 });

#### Run the spec, `yeoman test` should FAIL

	>> Gutter Game - should score 0 for a gutter game, all rolls are 0
	>> Message: expected -1 to equal 0
	>> Actual: undefined
	>> Expected: 0

### Pass failing test with code change in app/scripts/Game.js

	 define('game', function () {
	-    var Game = function () {};
	+    var Game = function () {
	+        this._score = 0;
	+    };
	 
	     Game.prototype.roll = function (pins) {
	         if (typeof pins !== 'number') {
	             throw new Error('Game.role() expects `pins` argument to be a number');
	         }
	+        this._score += pins;
	     };
	 
	     Game.prototype.score = function () {
	-        return -1;
	+        return this._score;
	     };
	 
	     return Game;

#### Run the spec, `yeoman test` should PASS

	>> 1 assertions passed (0.01s)

## Second Test, Game With Every Roll Hitting 1 Pin

### Add new test for scoring a game of all 20 rolls only hitting 1 pin

	+    describe("Score game given all rolls hit only one pin", function () {
	+
	+        it("should score 20", function () {
	+            var game = new Game(), i = 0;
	+
	+            for (i; i < 20; i ++) {
	+                game.roll(1);
	+            }
	+            expect(game.score()).to.equal(20);
	+        });
	+
	+    });

#### Run the spec, `yeoman test` should PASS

	>> 2 assertions passed (0.02s)

### Refactor test/spec/game.spec.js to make test more DRY (don't repeat yourself)

Each test instantiates a game object, use a `beforeEach` method; also add a `rollMany` helper function. 

	 describe("Ten-Ping Bowling Kata", function () {
	 
	+    function rollMany(rolls, pins) {
    +        var i = 0;
    +        for (i; i < rolls; i ++) {
    +            this.roll(pins);
    +        }
    +    }
	+
	+    beforeEach(function () {
	+        this.game = new Game();
	+    });
	+
	     describe("Gutter Game", function () {
	 
	         it("should score 0 for a gutter game, all rolls are 0", function () {
	-            var game = new Game(), i = 0;
	-
	-            for (i; i < 20; i ++) {
	-                game.roll(0);
	-            }
	-            expect(game.score()).to.equal(0);
	+            rollMany.call(this.game, 20, 0);
	+            expect(this.game.score()).to.equal(0);
	         });
	 
	     });


	     describe("Score game given all rolls hit only one pin", function () {
	 
	         it("should score 20", function () {
	-            var game = new Game(), i = 0;
	-
	-            for (i; i < 20; i ++) {
	-                game.roll(1);
	-            }
	-            expect(game.score()).to.equal(20);
	+            rollMany.call(this.game, 20, 1);
	+            expect(this.game.score()).to.equal(20);
	         });
	 
	     });

#### Run the spec, `yeoman test` should still PASS

	>> 2 assertions passed (0.02s)

## Third Test, Game With One Spare

### Add failing test for a game with one spare

#### Add helper function for rolling a spare

	+    function rollSpare() {
	+        this.roll(5);
	+        this.roll(5);
	+    }

#### Add test for game with the first frame as a spare

	+    describe("Score a game with only a spare", function () {
    +
    +        it("should score 20 given the first 3 rolls hit 5 pins", function () {
    +            rollSpare.call(this.game);
    +            this.game.roll(5);
    +            rollMany.call(this.game, 17, 0);
    +            expect(this.game.score()).to.equal(20);
    +        });
    +
    +    });

#### Run the spec, `yeoman test` should FAIL

	>> Score a game with only a spare - should score 20 given the first 3 rolls hit 5 pins
	>> Message: expected 15 to equal 20
	>> Actual: undefined
	>> Expected: 20

There is a design error with Game methods: roll() & score() so add some TODOs and *skip* the new test for spare…

### Note incorrect design in app/scripts/Game.js

	+    // TODO design is wrong, responsibilities are missplaced...
	+
	+    // TODO roll should not calculate score
	     Game.prototype.roll = function (pins) {

…
	 
	+    // TODO score is not actually calculating value
	     Game.prototype.score = function () {

### Skip test in test/spec/game.spec.js

	-    describe("Score a game with only a spare", function () {
	+    describe.skip("Score a game with only a spare", function () {

#### Run the spec, `yeoman test` should PASS (new test was skipped)

	>> 3 assertions passed (0.04s)

### Refactor Game methods, roll() and score(), in app/scripts/Game.js

Pass tests for rolling and scoring spares…

	 define('game', function () {
	     var Game = function () {
	-        this._score = 0;
	+        this._currentRoll = 0;
	+        this._rolls = [];
	     };
	 
	-    // TODO design is wrong, responsibilities are missplaced...
	-
	-    // TODO roll should not calculate score
	     Game.prototype.roll = function (pins) {
	         if (typeof pins !== 'number') {
	             throw new Error("expeced a number");
	         }
	-        this._score += pins;
	+        this._rolls[this._currentRoll++] = pins;
	     };
	 
	-    // TODO score is not actually calculating value
	     Game.prototype.score = function () {
	-        return this._score;
    +        var score = 0, i = 0, 
    +            rollsToScore = this._rolls.length;
    +
    +        for (i; i < rollsToScore; i ++) {
    +            if (this._isSpare(i)) {
    +                score += 10 + this._rolls[i + 2];
    +                i ++;
    +            } else {
    +                score += this._rolls[i];
    +            }
    +        }
    +        return score;
    +    };
    +
    +    Game.prototype._isSpare = function (rollIdx) {
    +        return (this._rolls[rollIdx] + this._rolls[rollIdx + 1] === 10);
    +    };
	 
	     return Game;

### Enable the skipped test in test/spec/game.spec.js

	-    describe.skip("Score a game with only a spare", function () {
	+    describe("Score a game with only a spare", function () {

#### Run the spec, `yeoman test` should PASS

	>> 3 assertions passed (0.02s)

## Fourth Test, Game With One Strike

### Add failing test for rolling a strike

Add helper function for testing a strike in test/spec/game.spec.js

	+    function rollStrike() {
	+        this.roll(10);
	+    }

Add test for scoring with one strike and two following rolls each hitting 4 pins

	+    describe("Score a game with only a strike", function () {
	+
	+        it("should score 20 given a strike followed by a two rolls hitting 2 & 3 pins", function () {
	+            rollStrike.call(this.game);
	+            this.game.roll(2);
	+            this.game.roll(3);
	+            rollMany.call(this.game, 17, 0);
	+            expect(this.game.score()).to.equal(20);
	+        });
    +    };

#### Run the spec, `yeoman test` should FAIL

If you get a response like:

	>> 0 assertions passed (0s)

It may be a good idea to lint your code, using `yeoman lint`.

	Linting test/spec/game.spec.js...ERROR
	[L64:C6] Expected ')' and instead saw ';'.

The fix needed at line 64 in game.spec.js is:

    -    };
    +    });

#### Run the spec, `yeoman test` should FAIL

	>> Score a game with only a spare - should score 20 given a strike followed by a two rolls hitting 2 & 3 pins
	>> Message: expected 15 to equal 20
	>> Actual: undefined
	>> Expected: 20

### Pass the failing test with code edits in app/scripts/Game.js

Refactor score method, add code to score a strike  

	     Game.prototype.score = function () {
             var score = 0, i = 0, 
                 rollsToScore = this._rolls.length;
     
             for (i; i < rollsToScore; i ++) {
    -            if (this._isSpare(i)) {
    +            if (this._isStrike(i)) {
    +                score += 10 + this._rolls[i + 1] + this._rolls[i + 2];
    +            } else if (this._isSpare(i)) {
                     score += 10 + this._rolls[i + 2];
                     i ++;
                 } else {
                     score += this._rolls[i];
                 }
             }
     
             return score;
         };

Add method to check if a roll is a strike

	+    Game.prototype._isStrike = function (rollIdx) {
	+        return (this._rolls[rollIdx] === 10);
	+    };

#### Run the spec, `yeoman test` should PASS

	>> 4 assertions passed (0.02s)

## Fifth Test, Perfect Game - All Strikes

### Add test for rolling perfect game of 300 in test/spec/game.spec.js

	+    describe("Score a perfect game of 300 points", function () {
    +
	+        it("should score 300 for 12 strikes in a row", function () {
	+            rollMany.call(this.game, 12, 10);
	+            expect(this.game.score()).to.equal(300);
	+        });
    +
	+    });

#### Run the spec, `yeoman test` should FAIL

	>> Score a perfect game of 300 points - should score 300 for 12 strikes in a row
	>> Message: expected NaN to equal 300
	>> Actual: undefined
	>> Expected: 300

### Refactor Game object to handle scoring the 10th frame

#### Add method for checking if the game has a bonus roll in the 10th frame

    +    Game.prototype._bonusRoll = function () {
    +        var hasBonusRoll = false, 
    +            checkRoll = this._rolls.length - 3;
    +
    +        if (this._isStrike(checkRoll) || this._isSpare(checkRoll)) {
    +            hasBonusRoll = true;
    +        }
    +
    +        return (hasBonusRoll) ? checkRoll : null;
    +    };

#### Update score method to calculate the 10th frame properly

	     Game.prototype.score = function () {
             var score = 0, i = 0, 
    -            rollsToScore = this._rolls.length;
    +            tenthFrameRoll = this._bonusRoll(),
    +            rollsToScore = (tenthFrameRoll) ? tenthFrameRoll + 1 : this._rolls.length;

#### Run the spec, `yeoman test` should PASS

	>> 5 assertions passed (0.03s)

### As a sanity check, Add one more test in test/spec/game.spec.js 

Test a complete game with all kinds of rolls

	+    describe("Game with all scoring variations including tenth frame", function () {
	+
	+        it("should score 110", function () {
	+            var game = this.game;
	+
	+            // frame 1, score: 9
	+            game.roll(7);
	+            game.roll(2);
	+            // frame 2, score: 16
	+            game.roll(6);
	+            game.roll(1);
	+            // frame 3, score: 26 + 3 = 29
	+            rollSpare.call(game);
	+            // frame 4, score: 36
	+            game.roll(3);
	+            game.roll(4);
	+            // frame 5, score: 46 + 10 = 56
	+            rollSpare.call(game);
	+            // frame 6, score: 66 + 5 + 3 = 74
	+            rollStrike.call(game);
	+            // frame 7, score: 82
	+            game.roll(5);
	+            game.roll(3);
	+            // frame 8, score: 87
	+            game.roll(5);
	+            game.roll(0);
	+            // frame 9, score: 95
	+            game.roll(6);
	+            game.roll(2);
	+            // frame 10, score: 105 + 5 = 110
	+            game.roll(7);
	+            game.roll(3);
	+            game.roll(5);
	+            expect(this.game.score()).to.equal(110);
	+        });
	+
	+    });

#### Run the spec, `yeoman test` should PASS

	>> 6 assertions passed (0.03s)

#### Well that's a wrap from red to green over and over until the requirements are met.


## Additional Topics

The finished test/code is on a [bowling branch][vagrant-dev-box-bowling] of my dev repository.

I added a few branches to my [dev repository][vagrant-dev-box] showing examples of:

* [Testing both the development code and the build][vagrant-dev-box-bowling-rjs]  
* [Testing with Jasmine instead of Mocha][vagrant-dev-box-bowling-jasmine]  
* [Reporting code coverage with jscoverage and mocha][vagrant-dev-box-bowling-coverage]

*Note:* See the Makefiles in the above branches (in the www directories) for the commands build, test, report coverage, etc.

## Reference / Links

1. [Uncle Bob's The Bowling Game Kata][TheBowlingGameKata]
2. [Ten-pin bowling game Wikipedia article][TenPinBowlingGame]
3. [Instructions on scoring with game examples][scoringinstructions]
4. [The Basics of Keeping Score][scoringbasics]
5. [Yeoman.io][yeomansource]
6. [Mocha Test Framewor][mochasite]
7. [Chai assertion library][chaibdd]
8. [RequireJS][requirejs]
9. [Vagrant dev box][vagrant-dev-box]
10. [Behavior-Driven Development][BDD]
11. [Test-Driven Development][TDD]

[BDD]: http://blog.dannorth.net/introducing-bdd/ "Behavior-Driven Development"

[chaibdd]: http://chaijs.com/api/bdd/ "Chai BDD Assertion Library"

[mochasite]: http://visionmedia.github.com/mocha/ "Mocha Test Framework"

[nodejs]: http://nodejs.org/ "Node.js"

[phantomjs]: http://phantomjs.org/ "PhantomJS - headless WebKit w/ JavaScript API"

[requirejs]: http://requirejs.org/docs/requirements.html "RequireJS Library for dependency management and build optimization"

[scoringbasics]: http://slocums.homestead.com/gamescore.html "The Basics of Keeping Score"

[scoringinstructions]: http://www.bowlingindex.com/instruction/scoring.htm "Scoring a bowling game"

[TenPinBowlingGame]: http://en.wikipedia.org/wiki/Ten-pin_bowling "Ten pin bowling game Wikipedia article"

[TheBowlingGameKata]: http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata "The Bowling Game Kata"

[TDD]: http://en.wikipedia.org/wiki/Test-driven_development "Test-Driven Development"

[testindex]: https://github.com/pixelhandler/vagrant-dev-env/blob/bowling/www/test/index.html "testing index.html file uses symbolic link in test directory to load app code w/ requirejs"

[unclebob]: https://twitter.com/unclebobmartin "Uncle Bob Martin on Twitter"

[vagrant-dev-box]: https://github.com/pixelhandler/vagrant-dev-env "Vagrant Development Environment"
[vagrant-dev-box-bowling]: https://github.com/pixelhandler/vagrant-dev-env/tree/bowling/www/test "Completed Bowling Game Test using Mocha"
[vagrant-dev-box-bowling-jasmine]: https://github.com/pixelhandler/vagrant-dev-env/tree/bowling-jasmine/www/test "Completed Bowling Game Test using Jasmine"
[vagrant-dev-box-bowling-rjs]: https://github.com/pixelhandler/vagrant-dev-env/tree/bowling-rjs/www/test "Testing a build with r.js (RequireJS optimization tool)"
[vagrant-dev-box-bowling-coverage]: https://github.com/pixelhandler/vagrant-dev-env/blob/bowling-cov/www/Makefile "Code Coverage using Mocha, commands in Makefile"

[yeomansource]: https://github.com/yeoman/yeoman "Yeoman source code"

[yeomansite]: http://yeoman.io/ "Yeoman - set of tools"