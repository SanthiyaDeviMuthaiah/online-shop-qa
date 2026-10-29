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

public class LoginSteps {
    private final LoginPage loginPage = new LoginPage(DriverFactory.getDriver());
    private final ProductsPage productsPage = new ProductsPage(DriverFactory.getDriver());

    @Given("the user is on the login page")
    public void userIsOnLoginPage() {
        Pause.step();
        loginPage.open(ConfigReader.get("base.url"));
    }

    @When("the user logs in with a valid account")
    public void loginWithValidAccount() {
        Pause.step();
        loginPage.login(ConfigReader.get("valid.user"), ConfigReader.get("valid.password"));
    }

    @When("the user logs in with {string} and {string}")
    public void loginWith(String username, String password) {
        Pause.step();
        loginPage.login(username, password);
    }

    @Then("the products page is displayed")
    public void productsPageDisplayed() {
        Pause.step();
        Assert.assertTrue(productsPage.isLoaded(), "Products page was not shown");
    }

    @Then("the error {string} is shown")
    public void errorIsShown(String expected) {
        Pause.step();
        Assert.assertEquals(loginPage.getErrorText(), expected);
    }
}