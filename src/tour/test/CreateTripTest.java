package tour.test;

import static org.junit.Assert.*;
import tour.process.*;
import org.junit.Test;

public class CreateTripTest {

	@Test
	public void test() {
		int a;
		SeatCheck seat= new SeatCheck();
		a=seat.check("Mumbai","Paris","2015-11-25",40);
		assertEquals(1,a);
	}

}
