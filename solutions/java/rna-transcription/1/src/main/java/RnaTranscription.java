import java.util.stream.Collector;
import java.util.stream.Collectors;

public final class RnaTranscription {

    private static Collector<Character, StringBuilder, String> STRING_COLLECTOR
            = Collectors.collectingAndThen(Collector.of(StringBuilder::new, StringBuilder::append, StringBuilder::append),
            StringBuilder::toString);

    public static String ofDna(String c) {
        return c.chars()
                .mapToObj(RnaTranscription::transcribe)
                .collect(STRING_COLLECTOR);
    }

    private static char transcribe(int c) {
        switch (c) {
            case 'A': return 'U';
            case 'C': return 'G';
            case 'G': return 'C';
            case 'T': return 'A';
            default: return '\0';
        }
    }
}