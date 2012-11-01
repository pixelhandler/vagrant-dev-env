define(['scripts/app'], function(module) {
  'use strict';

  describe("setUp/tearDown", function() {
    beforeEach(function() {
      // console.log("Before");
    });

    afterEach(function() {
      // console.log("After");
    });

    it("example", function() {
      // console.log("During");
    });

    describe("setUp/tearDown", function() {
      beforeEach(function() {
        // console.log("Before2");
      });

      afterEach(function() {
        // console.log("After2");
      });

      it("example", function() {
        // console.log("During Nested");
      });
    });
  });

  describe("async", function() {
    it("multiple async", function(done) {
      var semaphore = 2;

      setTimeout(function() {
        expect(true).to.be.true;
        semaphore--;
      }, 500);

      setTimeout(function() {
        expect(true).to.be.true;
        semaphore--;
      }, 500);

      setTimeout(function() {
        expect(semaphore).to.equal(0);
        done();
      }, 600);
    });
  });

});