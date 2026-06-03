import java.util.Random;
import java.util.Scanner;

public class GuessNumber {
    public static void main(String[] args) {

        Random random = new Random();
        int number = random.nextInt(100) + 1;

        Scanner sc = new Scanner(System.in);

        int guess;

        do {
            System.out.print("Guess a number (1-100): ");
            guess = sc.nextInt();

            if(guess > number)
                System.out.println("Too High!");
            else if(guess < number)
                System.out.println("Too Low!");
            else
                System.out.println("Correct! You guessed the number.");
        }
        while(guess != number);

        sc.close();
    }
}