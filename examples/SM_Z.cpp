/**
   @file
   @brief Basic check of SM \f$Z\f$ width
   
   @code
   g++ -std=c++11 -o SM_Z SM_Z.cpp -I/$GAMBIT/DecayBit/include/gambit/DecayBit/
   @endcode
*/

#include "SM_Z.hpp"
#include <iostream>
#include <iomanip>


int main() {
  auto Z = Gambit::DecayBit::SM_Z::TwoLoop();
  std::cout << std::setprecision(20) << Z.gamma_inv() << std::endl;
}
