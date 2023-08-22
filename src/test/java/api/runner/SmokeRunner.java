package api.runner;

import com.intuit.karate.junit5.Karate;

public class SmokeRunner {

	
	@Karate.Test
	public Karate runTest() {
		
		return Karate.run("classpath:features")

		.tags("Smoke");

}

}
