var url = 'https://www.dfa.gov.ph/dfa-news/dfa-releasesupdate';
var fs = require('fs');
var page = require('webpage').create();
page.open(url, function(status) {
    if (status === 'success') {
        var html = page.evaluate(function() {
            return document.documentElement.outerHTML;
        });
        try {
            fs.write("data-raw/dfaPressReleases.txt", html, 'w');
        } catch(e) {
            console.log(e);
        }
    }
    phantom.exit();
});
