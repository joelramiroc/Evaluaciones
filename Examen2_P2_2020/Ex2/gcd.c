#include <stdio.h>

int gcd(int a, int b)
{
    while (a != b) {
        if (a > b) {
            a = a - b;
        } else {
            b = b - a;
        }
    }
    return a;
}

int main() 
{
    printf("gcd(134, 567) = %d\n", gcd(134, 567));
    printf("gcd(132, 567) = %d\n", gcd(132, 567));
    printf("gcd(51492, 20636) = %d\n", gcd(51492, 20636));
    printf("gcd(53316, 33876) = %d\n", gcd(53316, 33876));
    printf("gcd(5416, 9236) = %d\n", gcd(5416, 9236));
    printf("gcd(5416, 9232) = %d\n", gcd(5416, 9232));
    printf("gcd(5406, 9231) = %d\n", gcd(5406, 9231));
    printf("gcd(5395, 9230) = %d\n", gcd(5395, 9230));
}
