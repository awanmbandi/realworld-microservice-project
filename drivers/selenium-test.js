const { Builder, By, Key, until } = require('selenium-webdriver');

// Create a new WebDriver instance
const driver = new Builder().forBrowser('chrome').build();

// Navigate to your webpage
driver.get('http://your-webpage-url');

// Perform actions on the webpage
driver.findElement(By.name('q')).sendKeys('webdriver', Key.RETURN);
driver.wait(until.titleIs('webdriver - Google Search'), 1000);

// Close the WebDriver instance
driver.quit();
