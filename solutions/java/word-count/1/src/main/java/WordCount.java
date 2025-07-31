import java.util.Arrays;
import java.util.Map;

import static java.util.function.Function.identity;
import static java.util.stream.Collectors.toMap;

public class WordCount {

    public Map<String, Integer> phrase(String word) {
        return Arrays.stream(word.replaceAll("\\p{Punct}", "")
                                 .toLowerCase()
                                 .split("\\p{javaWhitespace}+"))
                     .collect(toMap(identity(), w -> 1, Integer::sum));
    }
}