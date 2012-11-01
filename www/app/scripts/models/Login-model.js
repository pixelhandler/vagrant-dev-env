// 'LoginModel'
define(['lodash', 'jquery', 'backbone'], function (_, $, Backbone) {
    return Backbone.Model.extend({
        defaults: {
            email: '',
            password: ''
        },
        url: '/api/login'
    });
});