package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.List;

public class ProductsPage {
    private final WebDriver driver;
    private final WebDriverWait wait;

    private final By pageTitle = By.cssSelector(".title");
    private final By inventoryItems = By.cssSelector(".inventory_item");
    private final By firstAddButton = By.cssSelector(".inventory_item button");
    private final By cartBadge = By.cssSelector(".shopping_cart_badge");

    public ProductsPage(WebDriver driver) {
        this.driver = driver;
        this.wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    }

    public String getTitle() {
        return wait.until(ExpectedConditions.visibilityOfElementLocated(pageTitle)).getText();
    }

    public boolean isLoaded() {
        return getTitle().equals("Products");
    }

    public int getItemCount() {
        wait.until(ExpectedConditions.visibilityOfElementLocated(inventoryItems));
        List<WebElement> items = driver.findElements(inventoryItems);
        return items.size();
    }

    private final By addToCartButton = By.cssSelector("button[id^='add-to-cart']");
    private final By removeButton = By.cssSelector("button[id^='remove']");

    public void addFirstProductToCart() {
        WebElement addButton = wait.until(ExpectedConditions.elementToBeClickable(addToCartButton));
        ((org.openqa.selenium.JavascriptExecutor) driver).executeScript("arguments[0].click();", addButton);
        wait.until(ExpectedConditions.presenceOfElementLocated(removeButton));
    }

    public String getCartBadgeCount() {
        List<WebElement> badges = driver.findElements(cartBadge);
        return badges.isEmpty() ? "0" : badges.get(0).getText();
    }
}