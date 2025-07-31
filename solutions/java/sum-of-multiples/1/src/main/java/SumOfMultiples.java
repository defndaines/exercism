import java.util.function.IntPredicate;
import java.util.stream.IntStream;

public class SumOfMultiples {

    public int Sum(int upTo, int[] multiples) {
        IntPredicate isMultiple = x -> {
            for (int multiple : multiples)
                if (x % multiple == 0)
                    return true;
            return false;
        };
        return IntStream.range(0, upTo)
                        .filter(isMultiple)
                        .sum();
    }
}