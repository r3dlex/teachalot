cmake_minimum_required(VERSION 3.0)

project(NewYorkChaos)

# Used for YCM
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

##############
# Executable #
##############

file(GLOB_RECURSE source Src/*.cpp)
file(GLOB_RECURSE source_test Test/*.cpp)

add_library(new_york_chaos ${source})
target_include_directories(new_york_chaos PUBLIC Include)
target_compile_options(new_york_chaos PUBLIC -std=c++1y -Wall -Wfloat-conversion)

###########
# Testing #
###########

find_package(GTest)

if(GTEST_FOUND)
  add_executable(unit_test ${source_test} ${source})
  # Because of possible main definition
  target_compile_definitions(unit_test PUBLIC UNIT_TESTS)
  set_target_properties(new_york_chaos PROPERTIES ENABLE_EXPORTS on)
  target_link_libraries(unit_test PUBLIC ${GTEST_LIBRARIES} new_york_chaos pthread)
  target_include_directories(unit_test PUBLIC ${GTEST_INCLUDE_DIRS})
endif()
