#include "tasks.hpp"

#include <ranges>

namespace day_dash {
auto task_container::get_tasks(bool include_completed) const {
    return tasks | std::views::filter([include_completed](const auto& task) {
               return include_completed || !task.completed;
           });
}
auto task_container::add_task() -> void {}
auto task_container::complete_task() -> void {}
auto task_container::remove_task() -> void {}
} // namespace day_dash
