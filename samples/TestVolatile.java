public class TestVolatile {
    private volatile int a;
    private int b;

    public int readA() {
        return a;
    }

    public int readB() {
        return b;
    }

    public void setA(int a) {
        this.a = a;
    }

    public void setB(int b) {
        this.b = b;
    }

    public static void main(String[] args) {
       TestVolatile t = new TestVolatile();
       t.setA(1);
       t.setB(2);
       System.out.println(t.readA());
       System.out.println(t.readB());
    }
} 

