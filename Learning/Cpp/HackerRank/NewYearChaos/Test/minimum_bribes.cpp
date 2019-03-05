#include <gtest/gtest.h>

#include "bribes.h"

constexpr std::int32_t INVALID_BRIBE = -1;

TEST(MinimumBribes, ValidSimple) { 
  EXPECT_EQ(3, bribe::calculateMinimumBribes({2, 1, 5, 3, 4}));
  EXPECT_EQ(4, bribe::calculateMinimumBribes({1, 2, 5, 3, 4, 7, 8, 6}));
  EXPECT_EQ(7, bribe::calculateMinimumBribes({1, 2, 5, 3, 7, 8, 6, 4}));
}

TEST(MinimumBribes, InvalidExamples) { 
  EXPECT_EQ(INVALID_BRIBE, bribe::calculateMinimumBribes({2, 5, 1, 3, 4}));
  EXPECT_EQ(INVALID_BRIBE, bribe::calculateMinimumBribes({5, 1, 2, 3, 7, 8, 6, 4}));
}

int main(int argc, char **argv) {
  testing::InitGoogleTest(&argc, argv);

  return RUN_ALL_TESTS();
}
