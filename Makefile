# Variables
BUILD_DIR = build
TESTS_BUILD_DIR = tests_build

CMAKE = cmake
CMAKE_GENERATOR = Ninja
CMAKE_CCACHE = -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache
CMAKE_TOOLCHAIN=conan_toolchain.cmake
CMAKE_FLAGS = -DCMAKE_TOOLCHAIN_FILE=$(CMAKE_TOOLCHAIN) -G $(CMAKE_GENERATOR) $(CMAKE_CCACHE) -DCMAKE_CXX_FLAGS="-fcolor-diagnostics" -DCMAKE_C_FLAGS="-fcolor-diagnostics"

CONAN = conan
CONAN_PROFILE ?= default  # Default profile, but can be overridden

CTEST = ctest

BUILD_CMD = $(CMAKE) --build $(BUILD_DIR) -- -j $(NUM_CORES)
BUILD_TESTS_CMD = $(CMAKE) --build $(TESTS_BUILD_DIR) -- -j $(NUM_CORES)
# Detect number of jobs for parallel build
NUM_CORES := $(shell getconf _NPROCESSORS_ONLN 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 1)

# Dependency setup and CMake configuration target
.PHONY: deps
deps:
	@echo "Setting up dependencies and configuring the project for $(BUILD_TYPE)..."
	@rm -rf $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR) && mkdir -p $(TESTS_BUILD_DIR)
	@$(CONAN) install . --output-folder=$(BUILD_DIR) -s build_type=$(BUILD_TYPE) --profile=$(CONAN_PROFILE) --build=missing
	@ln -sf ../$(BUILD_DIR)/$(CMAKE_TOOLCHAIN) $(TESTS_BUILD_DIR)/$(CMAKE_TOOLCHAIN)
	@cd $(BUILD_DIR) && $(CMAKE) $(CMAKE_FLAGS) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) ../
	@cd $(TESTS_BUILD_DIR) && $(CMAKE) $(CMAKE_FLAGS) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -DBUILD_TESTS=ON ../
	@echo "Dependency setup and configuration complete."

# Build target
.PHONY: build
build:
	@echo "Building the project..."
	@$(BUILD_CMD)
	@python3 combine_compile_commands.py
	@echo "Build complete."

# Test target
.PHONY: test
test:
	@echo "Building the project..."
	@scan-build $(BUILD_CMD)
	@echo "Building tests..."
	@scan-build $(BUILD_TESTS_CMD)
	@python3 combine_compile_commands.py
	@echo "Running tests..."
	@cd $(TESTS_BUILD_DIR) && $(CTEST) --output-on-failure

# Clean target
.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD_DIR)
	@echo "Removed build directory ..."
	@rm -rf $(TESTS_BUILD_DIR)
	@echo "Removed tests build directory ..."
	@rm -f compile_commands.json
	@echo "Removed compile_commands.json symlink ..."
	@rm -rf CMakeUserPresets.json
	@echo "Removed CMakeUserPreset.json ..."
	@echo "Cleanup complete."
