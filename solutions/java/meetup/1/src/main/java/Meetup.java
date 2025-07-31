import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.stream.Stream;

import static java.time.temporal.TemporalAdjusters.lastDayOfMonth;

/**
 * Solution solves for java.time instead of Joda Time.
 */
public final class Meetup {

    private final LocalDate startOfMonth;

    public Meetup(int month, int year) {
        startOfMonth = LocalDate.of(year, month, 1);
    }

    private static LocalDate searchWeek(LocalDate startDate, DayOfWeek dayOfWeek) {
        return Stream.iterate(startDate, date -> date.plusDays(1))
                     .limit(7)
                     .filter(date -> date.getDayOfWeek() == dayOfWeek)
                     .findFirst()
                     .get();
    }

    public LocalDate day(DayOfWeek dayOfWeek, MeetupSchedule schedule) {
        switch (schedule) {
            case FIRST:
                return searchWeek(startOfMonth, dayOfWeek);
            case SECOND:
                return searchWeek(startOfMonth.plusDays(7), dayOfWeek);
            case THIRD:
                return searchWeek(startOfMonth.plusDays(14), dayOfWeek);
            case FOURTH:
                return searchWeek(startOfMonth.plusDays(21), dayOfWeek);
            case TEENTH:
                return searchWeek(startOfMonth.plusDays(12), dayOfWeek);
            case LAST:
                return searchWeek(startOfMonth.with(lastDayOfMonth()).minusDays(6), dayOfWeek);
        }
        return LocalDate.now();
    }
}