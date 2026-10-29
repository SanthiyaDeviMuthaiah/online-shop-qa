package stepdefinitions;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import utils.DriverFactory;
import utils.Pause;

public class Hooks {

    @Before
    public void setUp() {
        DriverFactory.getDriver();
    }

    @After
    public void tearDown() {
        Pause.hold();
        DriverFactory.quitDriver();
    }
}