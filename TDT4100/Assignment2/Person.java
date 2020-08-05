package encapsulation;

import java.util.Date;

public class Person {
	
	private String firstName;
	private String lastName;
	private String domain;
	private String countryCode;
	private Date birthday;
	private char gender;
	
	private boolean isValidDate(Date date) throws IllegalArgumentException{
		Date now = new Date();
		if (birthday.getTime() > now.getTime()){
			return false;
		}
		return true;
	}
	
	private boolean isValidName(String name) {
		String[] splitName=name.split(" ");
		
		if (splitName.length != 2 || splitName[0].length()<2 || splitName[1].length()<2 || !splitName[0].matches("[a-zA-Z]+") || !splitName[1].matches("[a-zA-Z]+")) {
			return false;
		}
		return true;
	}
	
	private boolean isValidCountryCode(String countryCode) {
		String[] validCodes = {"ad", "ae", "af", "ag", "ai", "al", "am", "ao", "aq", "ar", "as", "at", "au", "aw", "ax", "az",
			      "ba", "bb", "bd", "be", "bf", "bg", "bh", "bi", "bj", "bl", "bm", "bn", "bo", "bq", "br", "bs",
			      "bt", "bv", "bw", "by", "bz", "ca", "cc", "cd", "cf", "cg", "ch", "ci", "ck", "cl", "cm", "cn",
			      "co", "cr", "cu", "cv", "cw", "cx", "cy", "cz", "de", "dj", "dk", "dm", "do", "dz", "ec", "ee",
			      "eg", "eh", "er", "es", "et", "fi", "fj", "fk", "fm", "fo", "fr", "ga", "gb", "gd", "ge", "gf",
			      "gg", "gh", "gi", "gl", "gm", "gn", "gp", "gq", "gr", "gs", "gt", "gu", "gw", "gy", "hk", "hm",
			      "hn", "hr", "ht", "hu", "id", "ie", "il", "im", "in", "io", "iq", "ir", "is", "it", "je", "jm",
			      "jo", "jp", "ke", "kg", "kh", "ki", "km", "kn", "kp", "kr", "kw", "ky", "kz", "la", "lb", "lc",
			      "li", "lk", "lr", "ls", "lt", "lu", "lv", "ly", "ma", "mc", "md", "me", "mf", "mg", "mh", "mk",
			      "ml", "mm", "mn", "mo", "mp", "mq", "mr", "ms", "mt", "mu", "mv", "mw", "mx", "my", "mz", "na",
			      "nc", "ne", "nf", "ng", "ni", "nl", "no", "np", "nr", "nu", "nz", "om", "pa", "pe", "pf", "pg",
			      "ph", "pk", "pl", "pm", "pn", "pr", "ps", "pt", "pw", "py", "qa", "re", "ro", "rs", "ru", "rw",
			      "sa", "sb", "sc", "sd", "se", "sg", "sh", "si", "sj", "sk", "sl", "sm", "sn", "so", "sr", "ss",
			      "st", "sv", "sx", "sy", "sz", "tc", "td", "tf", "tg", "th", "tj", "tk", "tl", "tm", "tn", "to",
			      "tr", "tt", "tv", "tw", "tz", "ua", "ug", "um", "us", "uy", "uz", "va", "vc", "ve", "vg", "vi",
			      "vn", "vu", "wf", "ws", "ye", "yt", "za", "zm", "zw"};
		for (int i = 0; i < validCodes.length; i++) {
		      if (countryCode.equals(validCodes[i])) {
		        return true;
		      }
		    }
		return false;
	}
	
	private boolean isValidGender(char gender) {
		if (gender != 'M' && gender != 'F' && gender != '\0') {
			return false;	
		}
		return true;
	}
	
	private boolean verifyMail(String name0, String name1) {
	    return (name0.toLowerCase().equals(firstName.toLowerCase()) && name1.toLowerCase().equals(lastName.toLowerCase()));
	  }
	
	public Person() {
		firstName="";
		lastName="";
		domain="";
		countryCode="";
		birthday=null;
		gender='\0';
	}
	
	
	public void setName(String newName) throws IllegalArgumentException {
		String[] splitName=newName.split(" ");
		
		if (splitName.length != 2 || splitName[0].length()<2 || splitName[1].length()<2 || !splitName[0].matches("[a-zA-Z]+") || !splitName[1].matches("[a-zA-Z]+")) {
			throw new IllegalArgumentException("Name has to be two words of at least two letters sepparated by a space");
		}
		firstName = splitName[0];
	    lastName = splitName[1];
	}
	
	public void setEmail(String Email) {
		String[] splitEmail=Email.split("@");
		if (splitEmail.length != 2) {
	        throw new IllegalArgumentException("Illegal email format");
	      }
		String[] name = splitEmail[0].split("\\.");
		String[] address = splitEmail[1].split("\\.");
		if (name.length != 2 || !verifyMail(name[0],name[1]) || address.length != 2 || !isValidCountryCode(address[1])) {
			throw new IllegalArgumentException("Illegal email format");
		}
		domain=address[0];
		countryCode=address[1];
	}
	
	public void setBirthday(Date setDate) throws IllegalArgumentException {
		Date now = new Date();
		if ( setDate.getTime() > now.getTime() ) {
			throw new IllegalArgumentException("Birthday has to be in the past");
		}
		birthday=setDate;
	}
	
	public void setGender(char newGender) throws IllegalArgumentException {
		if (newGender != 'M' && newGender != 'F' && newGender != '\0') {
		      throw new IllegalArgumentException("Gender has to be 'M', 'F' or '\0'");
		}
		gender=newGender;
	}
	
	public String getName() {
		return firstName + " " + lastName;
	}
	
	public String getEmail() {
		return firstName.toLowerCase() + "." + lastName.toLowerCase() + "@" + domain + "." + countryCode;
		
	}
	
	public Date getBirthday() {
		return birthday;
		
	}
	
	public char getGender() {
		return gender;
		
	}

}
