define(
  ['lodash', 'jquery', 'backbone', 'models/Login-model'],
function(_, $, Backbone, LoginModel) {
  'use strict';

  beforeEach(function () {
    this.login = new LoginModel();
  });

  describe('Login Dependencies', function () {

    it('should have _, $, Backbone libraries', function () {
      expect(_).to.be.ok;
      expect($).to.be.ok;
      expect(Backbone).to.be.ok;
    });

    describe('Login Model', function () {

      it('should have LoginModel constructor', function () {
        expect(this.login).to.be.ok;
      });

      it('should have default attributes, email, password', function () {
        expect(this.login.get('email')).to.equal('');
        expect(this.login.get('password')).to.equal('');
      });

      it('should use /api/login as the url to post for credentials', function () {
        expect(this.login.url).to.equal('/api/login');
      });

    });

  });

  describe('Login Model - Server Resource', function () {

    beforeEach(function() {
      this.server = sinon.fakeServer.create();
      this.spy = sinon.spy($, 'ajax');
      this.callback = sinon.spy();
    });

    afterEach(function() {
      this.server.restore();
      $.ajax.restore();
      this.callback = null;
    });

    it('should successfully login given correct email and password', function (done) {
      var login = this.login, 
          server = this.server, 
          callback = this.callback,
          spy = this.spy,
          promise,
          success;

      server.respondWith(
        'POST',
        '/api/login',
        [
          201, // status code
          {
            'Content-Type': 'application/json'
          }, // header
          JSON.stringify({'success': true}) // response text
        ]
      );

      login.bind('sync', callback);

      login.set({
        email: 'pixelhandler@gmail.com',
        password: '123456'
      });

      success = function (data, textStatus, jqXHR) {
        expect(server.requests.length).to.equal(1);
        expect(server.requests[0].method).to.equal('POST');
        expect(server.requests[0].url).to.equal('/api/login');
        expect(textStatus).to.equal('success');
        expect(data).to.deep.equal({'success': true});
        expect(login.get('success')).to.be.true;
        expect(callback.called).to.be.ok;
        sinon.assert.calledOnce(spy);
        expect(spy.getCall(0).args[0].url).to.equal('/api/login');
        expect(callback.getCall(0).args[1]).to.deep.equal({success: true});
        // Async, now run Mocha reports
        done();
      };

      promise = login.save();
      promise.done(success);

      setTimeout(function () { server.respond(); }, 100);
    });

    it('should fail login given incorrect email and password', function (done) {
      var login = this.login,
          server = this.server,
          callback = this.callback,
          spy = this.spy,
          promise,
          error;

      server.respondWith(
        'POST',
        '/api/login',
        [
          400, // status code
          {
            'Content-Type': 'application/json'
          }, // header
          JSON.stringify({'success': false, 'error': 'failed login'}) // response text
        ]
      );

      login.bind('sync', callback);

      login.set({
        email: 'pixelhandler@gmail.com',
        password: 'Z'
      });

      error = function (jqXHR, textStatus, errorThrown) {
        expect(server.requests.length).to.equal(1);
        expect(server.requests[0].method).to.equal('POST');
        expect(server.requests[0].url).to.equal('/api/login');
        expect(textStatus).to.equal('error');
        expect(errorThrown).to.equal('Bad Request');
        expect(jqXHR.status).to.equal(400);
        expect(jqXHR.responseText).to.equal('{"success":false,"error":"failed login"}');
        expect(login.has('success')).to.not.be.ok;
        sinon.assert.notCalled(callback);
        sinon.assert.calledOnce(spy);
        expect(spy.getCall(0).args[0].url).to.equal('/api/login');
        // Async, now run Mocha reports
        done();
      };

      promise = login.save();
      promise.fail(error);

      setTimeout(function () { server.respond(); }, 100);
    });

  });

});