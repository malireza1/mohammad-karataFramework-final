package api.utility.data;

public class GenerateData {


	public static String getEmail() {
		String prefix = "instructor_email";
		String provider = "@tekschool.us";		
		int random = (int) (Math.random() * 10000);
		String email = prefix + random + provider; 
		return email;
	}
	public static String getPhoneNumber() {
		String phoneNumber = "510";
		for (int i = 0; i<7; i ++) {
			phoneNumber += (int) (Math.random()* 10);
		}
		return phoneNumber;
	}
	public static String getLicensePlate() {
		String prefix = "ayz";
		String suffix = "db";
		int random = (int)(Math.random()*100);
		String licensePlate = prefix+random +suffix;
		return licensePlate;
		
	}

}
