(function() {
    var jasmineEnv = jasmine.getEnv(), 
        htmlReporter, consoleReporter, currentWindowOnload;

    jasmineEnv.updateInterval = 1000;

    htmlReporter = new jasmine.HtmlReporter();
    jasmineEnv.addReporter(htmlReporter);

    consoleReporter = new jasmine.ConsoleReporter();
    jasmineEnv.addReporter(consoleReporter);

    jasmineEnv.specFilter = function(spec) {
        return htmlReporter.specFilter(spec);
    };

    currentWindowOnload = window.onload;

    window.onload = function() {
        if (currentWindowOnload) {
            currentWindowOnload();
        }
        execJasmine();
    };

    function execJasmine() {
        jasmineEnv.execute();
    }

})();