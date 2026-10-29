@products
Feature: Products page after login

  Background:
    Given the user is logged in as a valid user

  @smoke
  Scenario: Products page lists six items
    Then the products page shows 6 items

  @regression
  Scenario: Page title is Products
    Then the page title is "Products"

  @regression
  Scenario: Adding a product updates the cart badge
    When the user adds the first product to the cart
    Then the cart badge shows "1"