#pragma once

#include <string>
#include <vector>

namespace day_dash {
struct task {
    std::string description;
    bool completed = false;
};

class task_container {
public:
    [[nodiscard]] auto get_tasks(bool include_completed = false) const;
    auto add_task() -> void;
    auto complete_task() -> void;
    auto remove_task() -> void;

private:
    std::vector<task> tasks;
};
} // namespace day_dash
