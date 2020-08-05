/**
 * This class implements the consumer part of the producer/consumer problem.
 * One waitress instance corresponds to one consumer.
 */
public class Waitress implements Runnable {
	private WaitingArea WaitingArea;
    /**
     * Creates a new waitress. Make sure to save the parameter in the class
     *
     * @param waitingArea The waiting area for customers
     */
    Waitress(WaitingArea waitingArea) {
        // TODO: Implement required functionality.
    		this.WaitingArea = waitingArea;
    }

    /**
     * This is the code that will run when a new thread is
     * created for this instance
     */
    @Override
    public void run() {
    	
    		// After the customer is finished ordering and done eating, the waitress can fetch a new customer from the waiting area.
    		while(this.WaitingArea.getNumberOfCustomersInside() > 0 || SushiBar.isOpen) {
    			
    			// When a customer is fetched, 
	    		Customer CurrCust = this.WaitingArea.next();
	    	
	    		// the waitress uses some time
	    		try {Thread.sleep(SushiBar.waitressWait);} catch (InterruptedException e) {e.printStackTrace();}
	    		
	    		// before taking the customer’s order.
	    		CurrCust.order();
	    		
    		}
    		
    	
    }


}

