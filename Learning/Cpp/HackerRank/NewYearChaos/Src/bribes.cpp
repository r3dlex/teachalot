#include <bits/stdc++.h>
#include <cstdint>

#include "bribes.h"

namespace bribe {

  std::int32_t calculateMinimumBribes(std::vector<std::int32_t> queue) {
    constexpr std::int32_t maximumBribedPersons = 2;
    std::int32_t bribes = 0;

    // First loop to just rule out the Too chaotic behavior
    for (std::int32_t i = queue.size() - 1; i >= 0; i--) {
      if (queue[i] - (i + 1) > maximumBribedPersons) {
        return -1;
      }
    }

    // Second loop to actually calculate the number of bribes
    for (std::int32_t i = queue.size() - 1; i >= 0; i--) {
      for (std::int32_t j = std::max(0, queue[i] - 2); j < i; j++) {
        if (queue[j] > queue[i]) {
          ++bribes;
        }
      }
    }

    return bribes;
  }

}
