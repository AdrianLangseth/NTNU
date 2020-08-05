package interfaces;

public class Person1 implements Named{
	String _givenName;
	String _familyName;
	
	public Person1(String givenName,String familyName) {
		_givenName=givenName;
		_familyName=familyName;
	}
	
	public String getGivenName() {
		return _givenName;
	}
	
	public void setGivenName(String name) {
		_givenName=name;
	}

	
	public void setFamilyName(String familyName) {
		_familyName=familyName;
	}

	
	public String getFamilyName() {
		return _familyName;
	}

	
	public void setFullName(String fullName) {
		int index = fullName.indexOf(' ');
		_givenName=fullName.substring(0, index);
		_familyName=fullName.substring(index+1);
	}

	
	public String getFullName() {
		return _givenName + " " + _familyName;
	}

}
