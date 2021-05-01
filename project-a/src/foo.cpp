#include "libtest_a/foo.hpp"
#include <fmt/format.h>

namespace libtest_a {
    std::string get_str() { return fmt::format("Hello! {}", 12); }
}
