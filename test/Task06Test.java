import org.junit.*;
import static org.junit.Assert.*;

public class Task06Test {
 
    @Test
    public void addTest() {
        assertEquals(3, Task06.add(1, 2));
		assertEquals(5, Task06.add(3, 2));
		assertEquals(0, Task06.add(0, 0));
		assertEquals(-1, Task06.add(-2, 1));
    }
}