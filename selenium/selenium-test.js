const { Builder, By, Key, until } = require('selenium-webdriver');
const fs = require('fs');

// Create a new WebDriver instance
const driver = new Builder().forBrowser('chrome').build();

// Navigate to your webpage
driver.get('http://your-webpage-url');

// Wait for the page to load completely
driver.wait(until.urlContains('your-webpage-url'));

// Get the current URL
driver.getCurrentUrl().then(async function(currentUrl) {
    // Execute JavaScript to get the status code
    let statusCode = await driver.executeScript(function() {
        var xhr = new XMLHttpRequest();
        xhr.open('HEAD', arguments[0], false);
        xhr.send();
        return xhr.status;
    }, currentUrl);

    // Write the status code to a file
    fs.writeFileSync('status.txt', `HTTP status code: ${statusCode}`);
});

// Close the WebDriver instance
driver.quit();
