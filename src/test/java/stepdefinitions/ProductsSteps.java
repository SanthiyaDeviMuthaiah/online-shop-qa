package stepdefinitions;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.Assert;
import pages.LoginPage;
import pages.ProductsPage;
import utils.ConfigReader;
import utils.DriverFactory;
import utils.Pause;

public class ProductsSteps {
    private final LoginPage loginPage = new LoginPage(DriverFactory.getDriver());
    private final ProductsPage productsPage = new ProductsPage(DriverFactory.getDriver());

    @Given("the user is logged in as a valid user")
    public void userIsLoggedIn() {
        Pause.step();
        loginPage.open(ConfigReader.get("base.url"));
        loginPage.login(ConfigReader.get("valid.user"), ConfigReader.get("valid.password"));
    }

    @Then("the products page shows {int} items")
    public void productsPageShowsItems(int expected) {
        Pause.step();
        Assert.assertEquals(productsPage.getItemCount(), expected, "Unexpected number of products");
    }

    @Then("the page title is {string}")
    public void pageTitleIs(String expected) {
        Pause.step();
        Assert.assertEquals(productsPage.getTitle(), expected);
    }

    @When("the user adds the first product to the cart")
    public void addFirstProduct() {
        Pause.step();
        productsPage.addFirstProductToCart();
    }

    @Then("the cart badge shows {string}")
    public void cartBadgeShows(String expected) {
        Pause.step();
        Assert.assertEquals(productsPage.getCartBadgeCount(), expected);
    }
}