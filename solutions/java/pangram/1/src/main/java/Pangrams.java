import java.util.Arrays;
import java.util.Locale;

import static java.util.stream.Collectors.counting;

public final class Pangrams {

    public static boolean isPangram(String phrase) {
        return 26 == Arrays.stream(phrase.toLowerCase(Locale.ENGLISH)
                                         .replaceAll("\\P{Alpha}", "")
                                         .split(""))
                           .distinct()
                           .collect(counting());
    }
}