import json
import os

output_compile_commands = "compile_commands.json"

def load_compile_commands(path):
    if os.path.isfile(path):
        with open(path, "r") as f:
            commands = json.load(f)
            print(f"Loaded {len(commands)} commands from {path}")
            return commands
    else:
        print(f"Warning: {path} not found.")
        return []

compile_commands_paths = [
    "build/compile_commands.json",
    "tests_build/compile_commands.json"
]
combined_commands = []
for path in compile_commands_paths:
    compile_commands = load_compile_commands(path)
    if compile_commands:
        combined_commands.extend(compile_commands)

with open(output_compile_commands, "w") as f:
    json.dump(combined_commands, f, indent=2)

print(f"Combined compile_commands.json generated at {output_compile_commands}")
