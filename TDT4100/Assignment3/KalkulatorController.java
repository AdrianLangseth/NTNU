package encapsulation;

import java.io.IOException;
import java.util.function.BinaryOperator;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

public class KalkulatorController {
	
	private String valueText;
	private String operator;
	private double memory;
	
	
	@FXML
	private TextField valueTextField;
	
	@FXML
	void handleDigitButton(ActionEvent event) {
		Button button = (Button) event.getSource();
		
		if (button.getText().equals("=")) {
			computeAndStoreValue();
			updateValueTextField();
		}
		else if ( button.getText().equals("+") || button.getText().equals("*") || button.getText().equals("/") || button.getText().equals("-")) {
			storeValueText();
			storeOperator(button.getText());
			clearValueText();
		}
		else {
			appendDigit(button.getText());
			updateValueTextField();
		}
	}
	
	public void appendDigit(String digit) {
		valueText=valueTextField.getText() + String.valueOf(digit);
	}
	
	public void updateValueTextField() {
		valueTextField.setText(valueText);		
	}
	
	public void storeValueText() {
		memory = Double.valueOf(valueTextField.getText());
	}
	
	public void computeAndStoreValue() {
		if (operator.equals("+")) {
			double resultat = Double.valueOf(memory) + Double.valueOf(valueText);
			memory=resultat;
			valueText=String.valueOf(resultat);
		}
		else if (operator.equals("-")) {
			double resultat = Double.valueOf(memory) - Double.valueOf(valueText);
			memory=resultat;
			valueText=String.valueOf(resultat);
		}
		else if (operator.equals("*")) {
			double resultat = Double.valueOf(memory) * Double.valueOf(valueText);
			memory=resultat;
			valueText=String.valueOf(resultat);
		}
		else if (operator.equals("/")) {
			double resultat = Double.valueOf(memory) / Double.valueOf(valueText);
			memory=resultat;
			valueText=String.valueOf(resultat);
		}
	}
	
	public void storeOperator(String pressedOperator) {
		operator = pressedOperator;
	}
	
	public void clearValueText() {
		valueText="";
		updateValueTextField();
	}

}
