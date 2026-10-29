package utils;

public class Pause {

    public static void step() {
        sleep(Long.parseLong(ConfigReader.get("slow.millis")));
    }

    public static void hold() {
        sleep(Long.parseLong(ConfigReader.get("hold.millis")));
    }

    private static void sleep(long millis) {
        if (millis <= 0) {
            return;
        }
        try {
            Thread.sleep(millis);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}