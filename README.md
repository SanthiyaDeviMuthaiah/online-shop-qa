# Online Shop QA Automation Suite

Automated tests for the demo e-commerce site [SauceDemo](https://www.saucedemo.com/).
The project covers login and product page behavior using Selenium, TestNG, and Cucumber (BDD).

## Tech stack

- Java 17
- Maven
- Selenium WebDriver 4.25.0
- TestNG 7.10.2
- Cucumber 7.20.1 (Gherkin feature files)
- Page Object Model

## Project structure


## Test coverage

| Feature | Scenarios | Tags |
|---|---|---|
| Login | Valid login, locked out user, invalid credentials (outline with 4 examples) | `@smoke`, `@negative`, `@regression` |
| Products | Item count, page title, adding a product updates the cart badge | `@smoke`, `@regression` |

## Prerequisites

- JDK 17 or newer
- Maven 3.9 or newer
- Google Chrome (Selenium downloads a matching ChromeDriver automatically)

## How to run

Run all tests:

```bash
mvn clean test
```

Run only smoke tests:

```bash
mvn test -Dcucumber.filter.tags="@smoke"
```

After the run, open `reports/cucumber.html` in a browser to see the results.

## Configuration

Edit `src/test/resources/config.properties` to change the base URL, test users, or timing:

- `slow.millis`: pause before each step, in milliseconds (set to `0` for fast runs)
- `hold.millis`: time the browser stays open after each scenario (set to `0` for fast runs)

## Known notes

- The console shows `CdpVersionFinder` warnings about the Chrome DevTools version. They don't affect results.
- Each full run takes about 2 minutes with the default pause settings.

## AI usage in test design

AI assistants were used to draft and review test ideas during the project. Every generated test case was checked by hand against the SauceDemo site before it was kept.

| Outcome | Example |
|---|---|
| Kept as written | Locked-out user error message (TC-LOGIN-02) |
| Kept, then changed | Invalid credentials outline: the first draft used a generic "invalid login" message; the exact SauceDemo text was substituted after checking the site |
| Rejected | A draft test that expected a confirmation popup after login, which SauceDemo does not show |

**What AI helped with:** drafting the Gherkin scenarios, suggesting boundary and partition cases for the login form, and writing the first version of page object locators.

**What was checked by hand:** every expected error message, every locator (confirmed in Chrome DevTools), and every test data value. AI output was not trusted without verification, since it produced wrong expected values in several drafts.

## API tests

Postman collection in `api-tests/JSONPlaceholder.postman_collection.json`. It covers GET, POST, PUT, and DELETE against the public JSONPlaceholder API, with status code and response body checks. Import the file into Postman and run it with the `baseUrl` environment variable set to `https://jsonplaceholder.typicode.com`.

## Database

`database/Schema.sql` creates and fills test tables for users, products, orders, and order items. `database/queries.sql` contains validation queries that check the data, using joins, aggregates, GROUP BY, HAVING, and a LEFT JOIN. Run the schema first, then the queries, in any SQLite tool. The local `.db` file is excluded from Git.