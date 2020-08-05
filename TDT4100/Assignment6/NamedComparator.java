package interfaces;

import java.util.Comparator;
import java.util.Objects;

public class NamedComparator implements Comparator<Named> {

	@Override
	public int compare(Named o1, Named o2) {
		if (Objects.equals(o2.getFamilyName(), o1.getFamilyName())){
			return o2.getGivenName().compareTo(o1.getGivenName());
		}
		return o2.getFamilyName().compareTo(o1.getFamilyName());
	}
	

}
