import java.util.Random;

/**
 * This class implements the Door component of the sushi bar
 * assignment The Door corresponds to the Producer in the
 * producer/consumer problem
 */
public class Door implements Runnable {
	private WaitingArea WaitingArea;
	private static Random r = new Random();
	

    /**
     * Creates a new Door. Make sure to save the
     * @param waitingArea   The customer queue waiting for a seat
     */
    public Door(WaitingArea waitingArea) {
    		this.WaitingArea = waitingArea;
    }

    /**
     * This method will run when the door thread is created (and started).
     * The method should create customers at random intervals and try to put them in the waiting area.
     */
    @Override
    public void run() {
        
    		while(SushiBar.isOpen) {
    			// The Door will work as the producer. 
    			
    			// The door creates customers at random intervals
    			try {
					Thread.sleep(r.nextInt(SushiBar.doorWait));
				} catch (InterruptedException e) {e.printStackTrace();}
    			
    			Customer customer = new Customer();
    			
    			
    			// and tries to put them in the waiting area if there is room. 
    			this.WaitingArea.enter(customer);
    			
    		}
    		SushiBar.write("***** DOOR CLOSED *****");
    }

    // Add more methods as you see fit
}