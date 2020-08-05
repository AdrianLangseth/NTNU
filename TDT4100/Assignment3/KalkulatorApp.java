package encapsulation;
 
import java.io.IOException;
import javafx.application.Application;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.TextField;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;
 
 
public class KalkulatorApp extends Application {
	private String valueText;
	private String operator;
	private double memory;
	
	@FXML
	private TextField valueTextField;
	
	public void start(Stage primaryStage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(KalkulatorApp.class.getResource("KalkulatorApp.fxml"));
        Pane root = fxmlLoader.load();
        primaryStage.setScene(new Scene(root));
        primaryStage.show();
    }
 
    public static void main(String[] args) {
        launch(KalkulatorApp.class, args);
    }
    
    public void updateValueTextField() {
		valueTextField.setText(valueText);		
	}
    
    public void  appendDigit(String digit) {
		valueText=valueTextField.getText() + String.valueOf(digit);
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
    
    public void clearValueText() {
		valueText="";
		updateValueTextField();
	}
    
    public void storeOperator(String pressedOperator) {
		operator = pressedOperator;
	}
	
}