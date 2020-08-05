import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;


public class SushiBar {
    // SushiBar settings.
    private static int waitingAreaCapacity = 20;
    private static int waitressCount = 7;
    private static int duration = 5;
    public static int maxOrder = 15;
    public static int waitressWait = 60; // Used to calculate the time the waitress spends before taking the order
    public static int customerWait = 2500; // Used to calculate the time the customer spends eating
    public static int doorWait = 120; // Used to calculate the interval at which the door tries to create a customer
    public static boolean isOpen = true;

    // Creating log file.
    private static File log;
    private static String path = "./";

    // Variables related to statistics.
    public static SynchronizedInteger servedOrders;
    public static SynchronizedInteger takeawayOrders;
    public static SynchronizedInteger totalOrders;
    public static SynchronizedInteger customerIdTeller;


	public static void main(String[] args) {
        log = new File(path + "log.txt");

        // Initializing shared variables for counting number of orders.
        totalOrders = new SynchronizedInteger(0);
        servedOrders = new SynchronizedInteger(0);
        takeawayOrders = new SynchronizedInteger(0);
        customerIdTeller = new SynchronizedInteger(0);

        // TODO: initialize the bar and start the different threads.
        
        // init Clock
        new Clock(duration);
        
        // init Bar
        @SuppressWarnings("unused")
		SushiBar SushiBar = new SushiBar();
        
        // init WaitArea
        WaitingArea WaitingArea = new WaitingArea(waitingAreaCapacity);
        
        // init waitresses
        ArrayList <Thread> waitressList = new ArrayList<>();
        
        for(int i = 0; i<waitressCount; i++) {
        		Waitress waitress = new Waitress(WaitingArea);
        		Thread Thread = new Thread(waitress);
        		waitressList.add(Thread);
        		Thread.start();
        }
        
        // init Door
        Door Door = new Door(WaitingArea);
        Thread Thread = new Thread(Door, "Door Thread");
        Thread.start();
        
        
        // Wait for waitresses to die
        for(Thread thread: waitressList){
            try {
				thread.join();
			} catch (InterruptedException e) {e.printStackTrace();}
        }
        
        
        write("***** NO MORE CUSTOMERS - THE SHOP IS CLOSED NOW. *****");
        write("Total number of orders: " + totalOrders.get());
        write("Total number of takeaway orders: " + takeawayOrders.get());
        write("Total number of orders that customers have eaten at the bar: " + servedOrders.get());
        
        
        
    }

    // Writes actions in the log file and console.
    public static void write(String str) {
        try {
            FileWriter fw = new FileWriter(log.getAbsoluteFile(), true);
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(Clock.getTime() + ", " + str + "\n");
            bw.close();
            System.out.println(Clock.getTime() + ", " + str);
        } catch (IOException e) {e.printStackTrace();}
    }
}
