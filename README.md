# Day-Dash

## Overview

Day-Dash is a simple to-do tracker that resets all tasks at midnight, helping you stay focused on daily goals without accumulating unfinished tasks over time. This project is designed to provide the core functionality of Day-Dash, but it does not include any client implementations such as CLI, TUI, or GUI. The focus here is purely on the underlying logic and providing a structure upon which clients can be built.

### Prerequisites

Ensure that the following tools are installed on your system:

- **CMake**: Version 3.28 or higher
- **Conan**
- **Python 3.x**
- **Ninja**
- **Ccache**

### Building the Project

#### 1. Setting Up Dependencies and Configuring the Project

To set up dependencies and configure the project, run the following command:

```
make deps BUILD_TYPE=Debug  # or Release
```

This command will:

- Install dependencies using Conan.
- Configure the project using CMake in separate directories for the core library and tests.

#### 2. Building the Core Library

To build the core library, use:

```
make build
```

This command compiles the core library in the build/ directory.

#### 3. Running Tests

To build and run the tests, use:

```
make test
```

This command compiles the core library in `build/`, and the tests in the `tests_build/` directory, links the lib as a dependancy for the tests, and runs the tests.

### Clean Up

To clean the build directories and remove generated files, use:

```
make clean
```

This command will remove both the `build/` and `tests_build/` directories, as well as the generated files.
