package encapsulation;

public class Nim {
	
	private int[] piles = {0,0,0};
	private int initPileSize = 0;
	
	
	public Nim(){
		for(int i=0; i<3; i++) {
			piles[i]=10;
		}
		
	}
	
	public Nim(int pileSize){
		initPileSize=pileSize;
		for(int i=0; i<3; i++) {
			piles[i]=initPileSize;
		}
	}
	
	public int getPile(int targetPile) {
		return piles[targetPile];
	}
	
	public String toString() {
		String tilstand = "Spillets tilstand er: Stack 0 har " + piles[0] + "brikker, Stack 1 har " + piles[1] + "brikker og Stack 2 har " + piles[2]  + "brikker.";
		return tilstand;
	}
	
	public boolean isGameOver() throws IllegalStateException{
		if (piles[0] == 0 | piles[1] == 0 | piles[2] == 0) {
			return true;
		}
		if (piles[0] <= 0 | piles[1] <= 0 | piles[2] <= 0) {
			throw new IllegalStateException("Faen funk da!");
		}
		return false;
	}
	
	//sjekk at game=over også da eller?
	public boolean isValidMove(int number, int targetPile) throws IllegalArgumentException{
		if (isGameOver()) {
			return false;
		}
		if (targetPile > 2 | targetPile < 0) {
			return false;
		}
		if (number > piles[targetPile]) {
			return false;
		}
		if (number < 1) {
			return false;
		}
		return true;
	}
	
	public void removePieces(int number, int targetPile) throws IllegalArgumentException{
		if (isGameOver()) {
			throw new IllegalStateException("Kampen er over!");
		}
		else if (!isValidMove(number, targetPile)) {
			throw new IllegalArgumentException("FAAIIILLL");
		}
		else {
			piles[targetPile]=piles[targetPile] - number;
		}
	}
	
}
