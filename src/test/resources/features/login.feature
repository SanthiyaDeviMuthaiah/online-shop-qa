@login
Feature: Login to SauceDemo

  Background:
    Given the user is on the login page

  @smoke
  Scenario: Valid user can log in
    When the user logs in with a valid account
    Then the products page is displayed

  @negative @regression
  Scenario: Locked out user sees an error
    When the user logs in with "locked_out_user" and "secret_sauce"
    Then the error "Epic sadface: Sorry, this user has been locked out." is shown

  @negative @regression
  Scenario Outline: Invalid logins show the correct error
    When the user logs in with "<username>" and "<password>"
    Then the error "<error>" is shown

    Examples:
      | username        | password     | error                                                                 |
      | standard_user   | wrong_pass   | Epic sadface: Username and password do not match any user in this service |
      |                 | secret_sauce | Epic sadface: Username is required                                    |
      | standard_user   |              | Epic sadface: Password is required                                    |
      | locked_out_user | secret_sauce | Epic sadface: Sorry, this user has been locked out.                   |