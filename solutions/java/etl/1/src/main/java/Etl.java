import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Etl {

    public Map<String, Integer> transform(Map<Integer, List<String>> old) {
        return old.entrySet()
                  .stream()
                  .reduce(new HashMap<String, Integer>(),
                          (acc, e) -> {
                              e.getValue().forEach((c) -> acc.put(c.toLowerCase(), e.getKey()));
                              return acc;
                          },
                          (_prev, acc) -> acc);
    }
}