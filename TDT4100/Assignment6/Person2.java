package interfaces;

public class Person2 implements Named{
	String _fullName;
	
	public Person2(String fullName){
		_fullName=fullName;
	}

	@Override
	public void setGivenName(String name) {
		_fullName=name + ' ' + getFamilyName();
		
	}

	@Override
	public String getGivenName() {
		return _fullName.substring(0,_fullName.indexOf(' '));
	}

	@Override
	public void setFamilyName(String familyName) {
		_fullName=getGivenName() + ' ' + familyName;
	}

	@Override
	public String getFamilyName() {
		return _fullName.substring(_fullName.indexOf(' ')+1);
	}

	@Override
	public void setFullName(String fullName) {
		_fullName = fullName;
	}

	@Override
	public String getFullName() {
		return _fullName;
	}
	
	

}
