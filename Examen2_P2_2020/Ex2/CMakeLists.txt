cmake_minimum_required(VERSION 3.8)
project(gcd_test)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if (NOT verilator_FOUND)
  message(FATAL_ERROR "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable")
endif()

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_executable(${PROJECT_NAME} gcd_test.cpp)

# Add the Verilated circuit to the target
verilate(${PROJECT_NAME}
  TOP_MODULE "Main"
  PREFIX "VGcd"
  INCLUDE_DIRS "./verilog"
  SOURCES verilog/Main.v
          verilog/GcdFSM.v
          verilog/GPPM.v
          verilog/ALU.v
          verilog/RegFile.v)
