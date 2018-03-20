import org.junit.*;
import static org.junit.Assert.*;

public class Task07Test {
 
    @Test
    public void subTest() {
        assertEquals(1, Task07.substract(2, 1));
		assertEquals(5, Task07.substract(10, 5));
		assertEquals(0, Task07.substract(0, 0));
		assertEquals(-3, Task07.substract(-2, 1));
    }
}