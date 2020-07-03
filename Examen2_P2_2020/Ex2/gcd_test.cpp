#include <iostream>
#include <limits>
#include "VGcd__Syms.h"

void reset(VGcd& vgcd)
{
    vgcd.rst = 1;
    vgcd.clk = 0;
    vgcd.eval();
    vgcd.clk = 1;
    vgcd.eval();
    vgcd.rst = 0;
    vgcd.eval();
}

#define START           0x0
#define INIT_R1         0x1
#define LOOP            0x2
#define IF_STEP0        0x3
#define IF_STEP1        0x4
#define IF_TRUE_STEP0   0x5
#define IF_TRUE_STEP1   0x6
#define IF_FALSE_STEP0  0x7
#define IF_FALSE_STEP1  0x8
#define FINAL           0xf

const char *stateToStr(unsigned state)
{
    switch (state)
    {
        case START         : return "START";
        case INIT_R1       : return "INIT_R1";
        case LOOP          : return "LOOP";
        case IF_STEP0      : return "IF_STEP0";
        case IF_STEP1      : return "IF_STEP1";
        case IF_TRUE_STEP0 : return "IF_TRUE_STEP0";
        case IF_TRUE_STEP1 : return "IF_TRUE_STEP1";
        case IF_FALSE_STEP0: return "IF_FALSE_STEP0";
        case IF_FALSE_STEP1: return "IF_FALSE_STEP1";
        case FINAL         : return "FINAL";
    }

    return "Unknown";
}

void make_pause()
{
    std::cout << "\nPress <Enter> to continue...";
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    std::cin.clear();
}

unsigned gcd(VGcd& vgcd, int a, int b)
{
    reset(vgcd);

    vgcd.a = a;
    vgcd.b = b;

    while (vgcd.Main->fsm->cs != FINAL)
    {
        vgcd.clk = !vgcd.clk;
        vgcd.eval();
    }

    return vgcd.Main->gppm->reg_file->regs[0];
}

int main()
{
    VGcd vgcd;

    std::cout << "gcd(134, 567) = " << gcd(vgcd, 134, 567) << '\n';
    std::cout << "gcd(132, 567) = " << gcd(vgcd, 132, 567) << '\n';
    std::cout << "gcd(51492, 20636) = " << gcd(vgcd, 51492, 20636) << '\n';
    std::cout << "gcd(53316, 33876) = " << gcd(vgcd, 53316, 33876) << '\n';
    std::cout << "gcd(5416, 9236) = " << gcd(vgcd, 5416, 9236) << '\n';
    std::cout << "gcd(5416, 9232) = " << gcd(vgcd, 5416, 9232) << '\n';
    std::cout << "gcd(5406, 9231) = " << gcd(vgcd, 5406, 9231) << '\n';
    std::cout << "gcd(5395, 9230) = " << gcd(vgcd, 5395, 9230) << '\n';

    vgcd.final();

    return 0;
}