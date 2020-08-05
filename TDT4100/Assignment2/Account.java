package encapsulation;

public class Account {
	
	private double balance;
	private double interestRate;
	
	public Account(double startBalance, double startInterestRate) {
		if (startBalance<0) {
			throw new IllegalArgumentException("Start balance must be positive.");
		}
		if (startInterestRate<0) {
			throw new IllegalArgumentException("Start balance must be positive.");
		}
		balance=startBalance;
		interestRate=startInterestRate;		
	}
	
	public double getBalance() {
		return balance;
	}
	
	public double getInterestRate(){
		return interestRate;
	}
	
	public void setInterestRate(double interestRate) {
		if (interestRate<0) {
			throw new IllegalArgumentException("Amount Exceeds balance");
		}
		this.interestRate=interestRate;
	}
	
	public void deposit(double amount) {
		if (amount<0) {
			throw new IllegalArgumentException("Amount Exceeds balance");
		}
		balance=balance+amount;
	}
	
	public void withdraw(double amount) {
		if (balance<amount) {
			throw new IllegalArgumentException("Amount Exceeds balance");
		}
		balance=balance-amount;
	}
	
	public void addInterest() {
		double interest=balance*interestRate;
		balance=balance+interest;
	}
	
}
