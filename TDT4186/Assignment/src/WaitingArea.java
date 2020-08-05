import java.util.LinkedList;
import java.util.Queue;
/**
 * This class implements a waiting area used as the bounded buffer, in the producer/consumer problem.
 */
public class WaitingArea {
	private int WAsize;
	private Queue<Customer> WAqueue;
	private int NumberOfCustomersInside;  
    /**
     * Creates a new waiting area.
     *
     * @param size The maximum number of Customers that can be waiting.
     */
    public WaitingArea(int size) {
        this.WAsize = size;
        this.WAqueue = new LinkedList<Customer>();
        this.NumberOfCustomersInside = 0;
        
        
    }

    /**
     * This method should put the customer into the waitingArea
     *
     * @param customer A customer created by Door, trying to enter the waiting area
     */
    public synchronized void enter(Customer customer) {
    
    // check for fullness
    	
    	while (this.NumberOfCustomersInside == this.WAsize) {
    		try {
				this.wait();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	
    	// Add customer
    	
    	this.WAqueue.add(customer);
    	this.NumberOfCustomersInside++;
    	
    	// LogIt
    	
		SushiBar.write(Thread.currentThread().getName() + ": Customer " + customer.getCustomerID() + " is now waiting.");

    	
    	// NotifyAll
		
		this.notifyAll();
    }

    
    /**
     * @return The customer that is first in line.
     */
    public synchronized Customer next() {
        // Wait while empty
    	
	    	while (this.NumberOfCustomersInside == 0) {
	    		try {
					this.wait();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	    	}
	    	
	    		// Pop customer from queue
	    	Customer nextCustomer = this.WAqueue.remove();
	    	this.NumberOfCustomersInside--;
	    	
	
			// LogIt
	    		SushiBar.write(Thread.currentThread().getName() + ": Customer " + nextCustomer.getCustomerID() + " is now fetched.");
	    		// Notify
	    		this.notifyAll();
	    		// Return next customer
	    	return nextCustomer;
    }
    
    
    public int getNumberOfCustomersInside() {
    		return this.NumberOfCustomersInside;
    }
    
    public boolean availiableRoom() {
    		return (this.WAsize > this.getNumberOfCustomersInside());
    }

    // Add more methods as you see fit
}
