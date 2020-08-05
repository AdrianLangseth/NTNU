public class SynchronizedInteger {
    private int c ;

    public SynchronizedInteger(int initial){
    	c=initial;
    }
    public synchronized void add(int value){
    	c+=value;
    }

    public synchronized void subtract(int value){
    	c-=value;
    }
    
    /**
     * Small change to increment method where it also returns the new number.
     * @return new increased value
     */
    public synchronized int increment() {
        c++;
        return c;
    }
    
    /**
     * Small change to decrement method where it also returns the new number.
     * @return new decreased value
     */
    public synchronized int decrement() {
        c--;
        return c;
    }

    public synchronized int get() {
        return c;
    }

}
