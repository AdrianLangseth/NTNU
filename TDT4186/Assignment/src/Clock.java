import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;


public class Clock {
    Timer timer;

    public Clock(int seconds) {
        // A new Thread will be created, and scheduled to unset
        // SushiBar.isOpen after <duration> milliseconds.
        timer = new Timer();
        timer.schedule(new RemindTask(), seconds * 1000);
    }

    class RemindTask extends TimerTask {
        public void run() {
            // To prevent creating new customers.
            SushiBar.isOpen = false;
            timer.cancel();
        }
    }

    public static String getTime() {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss:SS");
        return sdf.format(cal.getTime());
    }
}
