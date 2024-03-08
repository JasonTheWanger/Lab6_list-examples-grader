import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsA implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("a");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testListFilter(){
    List<String> orig = Arrays.asList("a", "b", "c", "a");
    StringChecker isA = new IsA();
    List<String> result = ListExamples.filter(orig, isA);
    List<String> expected = Arrays.asList("a", "a");
    assertEquals(expected, result);
  }
}