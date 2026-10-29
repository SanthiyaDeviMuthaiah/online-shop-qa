# Test Cases: Online Shop (SauceDemo)

Application under test: https://www.saucedemo.com/
Test type: Functional UI testing (manual test design, automated with Selenium + Cucumber)

## Requirements

| ID | Requirement |
|---|---|
| REQ-01 | A valid user can log in and reach the Products page |
| REQ-02 | A locked-out user sees a locked-out error and cannot log in |
| REQ-03 | Invalid or incomplete credentials show the correct error message |
| REQ-04 | The Products page lists six items |
| REQ-05 | Adding a product to the cart updates the cart badge |

## Test cases

### Login

| ID | Title | Precondition | Steps | Expected result | Req | Automated in |
|---|---|---|---|---|---|---|
| TC-LOGIN-01 | Valid login | Login page open | 1. Enter `standard_user`<br>2. Enter `secret_sauce`<br>3. Click Login | Products page is displayed with title "Products" | REQ-01 | login.feature: "Valid user can log in" (@smoke) |
| TC-LOGIN-02 | Locked-out user | Login page open | 1. Enter `locked_out_user`<br>2. Enter `secret_sauce`<br>3. Click Login | Error: "Epic sadface: Sorry, this user has been locked out." | REQ-02 | login.feature: "Locked out user sees an error" (@negative) |
| TC-LOGIN-03 | Wrong password | Login page open | 1. Enter `standard_user`<br>2. Enter `wrong_pass`<br>3. Click Login | Error: "Epic sadface: Username and password do not match any user in this service" | REQ-03 | login.feature: Invalid logins outline, row 1 |
| TC-LOGIN-04 | Username missing | Login page open | 1. Leave username empty<br>2. Enter `secret_sauce`<br>3. Click Login | Error: "Epic sadface: Username is required" | REQ-03 | login.feature: Invalid logins outline, row 2 |
| TC-LOGIN-05 | Password missing | Login page open | 1. Enter `standard_user`<br>2. Leave password empty<br>3. Click Login | Error: "Epic sadface: Password is required" | REQ-03 | login.feature: Invalid logins outline, row 3 |

### Products

Precondition for all Products test cases: the user is logged in as `standard_user`.

| ID | Title | Steps | Expected result | Req | Automated in |
|---|---|---|---|---|---|
| TC-PROD-01 | Item count | Open the Products page | Six items are listed | REQ-04 | products.feature: "Products page lists six items" (@smoke) |
| TC-PROD-02 | Page title | Open the Products page | Title reads "Products" | REQ-01 | products.feature: "Page title is Products" |
| TC-PROD-03 | Add to cart | 1. Click "Add to cart" on the first product | Cart badge shows "1" | REQ-05 | products.feature: "Adding a product updates the cart badge" |

### Manual-only test cases

These aren't automated yet and can be run by hand.

| ID | Title | Steps | Expected result | Req |
|---|---|---|---|---|
| TC-LOGIN-06 | Empty form submit | 1. Leave both fields empty<br>2. Click Login | Error: "Epic sadface: Username is required" | REQ-03 |
| TC-PROD-04 | Remove from cart | 1. Add a product<br>2. Click "Remove" | Cart badge disappears or shows 0 | REQ-05 |

## Traceability matrix

| Requirement | Test cases | Coverage |
|---|---|---|
| REQ-01 | TC-LOGIN-01, TC-PROD-02 | Automated |
| REQ-02 | TC-LOGIN-02 | Automated |
| REQ-03 | TC-LOGIN-03, TC-LOGIN-04, TC-LOGIN-05, TC-LOGIN-06 | Automated (06 manual) |
| REQ-04 | TC-PROD-01 | Automated |
| REQ-05 | TC-PROD-03, TC-PROD-04 | Automated (04 manual) |

## Test design techniques used

- **Equivalence partitioning:** valid credentials, invalid password, locked user, and empty field form separate classes of input.
- **Decision table:** the login outcome depends on username and password validity, which the Invalid logins outline covers.