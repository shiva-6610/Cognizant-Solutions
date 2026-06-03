public class TypeCasting {
    public static void main(String[] args) {

        double d = 10.75;
        int i = (int)d;

        int num = 25;
        double d2 = (double)num;

        System.out.println("Double Value: " + d);
        System.out.println("Converted to Int: " + i);

        System.out.println("Integer Value: " + num);
        System.out.println("Converted to Double: " + d2);
    }
}