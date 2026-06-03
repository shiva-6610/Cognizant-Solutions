import java.util.HashMap;
import java.util.Scanner;

public class HashMapDemo {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        HashMap<Integer, String> map = new HashMap<>();

        map.put(101, "Alice");
        map.put(102, "Bob");
        map.put(103, "Charlie");

        System.out.print("Enter Student ID: ");
        int id = sc.nextInt();

        if(map.containsKey(id))
            System.out.println("Name: " + map.get(id));
        else
            System.out.println("ID not found.");

        sc.close();
    }
}