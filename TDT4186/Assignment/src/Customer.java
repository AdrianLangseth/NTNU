import java.util.Random;


/**
 * This class implements a customer, which is used for holding data
 * and update the statistics
 */
public class Customer {
	private final int customerID;
	private static Random r = new Random();
    /**
     *  Creates a new Customer.  Each customer should be given a
     *  unique ID
     */
    public Customer() {
        // When a customer is created it should be given a unique ID. 
    		this.customerID = SushiBar.customerIdTeller.increment();
    		
    		// TODO: Logg it
    		SushiBar.write(Thread.currentThread().getName() + ": Customer " + this.customerID + " is now created.");
    }


    /**
     * Here you should implement the functionality for ordering food
     * as described in the assignment.
     */
    public void order() {
        // Create number of orders, takeaway and sit in
    		int OrderNum = r.nextInt(SushiBar.maxOrder) + 1; // Must add 1 to have from 1 to max inclusive.
    		int takeawayNum = r.nextInt(OrderNum + 1); // from 0 to max (inclusive).
    		int SitHereNum = OrderNum - takeawayNum;
    		
    		
    		// Statistic updating
    		SushiBar.totalOrders.add(OrderNum);
    		SushiBar.servedOrders.add(SitHereNum);
    		SushiBar.takeawayOrders.add(takeawayNum);
    		
    	
    		// Customer Eating
    		if (SitHereNum > 0) {
        		SushiBar.write(Thread.currentThread().getName() + ": Customer " + this.customerID + " is now eating.");
    			try {
					Thread.sleep(SushiBar.customerWait*SitHereNum);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
    		}
    		
    		// Person Leaves
    		SushiBar.write(Thread.currentThread().getName() + ": Customer " + this.customerID + " is now leaving.");
    		
    		
    	
    		// Print something about customer leaves.
    }

    /**
     *
     * @return Should return the customerID
     */
    public int getCustomerID() {
        // TODO: Implement required functionality.
    		return this.customerID;
    }

    // Add more methods as you see fit.
    
    
    /*
     * When a customer is created it should be given a unique ID. 
     * The customer should be able to order food, when he is fetched from the waiting area by a waitress. 
     * After ordering, the customer takes some time eating.
     * Note that the customer should have minimal functionality, leaving the adding and removing of customers in the waiting area to the producer (door) and consumers (waitresses).
     */
}
