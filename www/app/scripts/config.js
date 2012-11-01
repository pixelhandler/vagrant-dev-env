// Set the require.js configuration for your application.
require.config({
  baseUrl: "../",
  paths: {
    // JavaScript folders.
    libs: "./scripts/libs",

    // Libraries.
    jquery: "./scripts/libs/jquery",
    lodash: "./scripts/libs/lodash",
    backbone: "./scripts/libs/backbone",

    app: "./scripts/app",
    models: "./scripts/models"
  },

  shim: {
    // Backbone library depends on lodash and jQuery.
    backbone: {
      deps: ["lodash", "jquery"],
      exports: "Backbone"
    }
  }

});