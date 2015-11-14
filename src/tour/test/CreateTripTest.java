package tour.test;

import static org.junit.Assert.*;
import tour.process.*;
import org.junit.Test;

public class CreateTripTest {

	@Test
	public void test() {
		int a;
		SeatCheck seat= new SeatCheck();
		a=seat.check(11);
		assertEquals(1,a);
	}

}
