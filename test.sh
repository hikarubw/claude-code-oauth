#!/bin/bash
# Claude OAuth CLI - Test Suite
# Verifies installation and functionality

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Claude OAuth CLI Test Suite${NC}"
echo "============================"
echo ""

# Test results
TESTS_PASSED=0
TESTS_FAILED=0

# Test function
run_test() {
    local test_name=$1
    local test_command=$2
    
    echo -n "Testing $test_name... "
    if eval "$test_command" >/dev/null 2>&1; then
        echo -e "${GREEN}PASS${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}FAIL${NC}"
        ((TESTS_FAILED++))
    fi
}

# Core file tests
run_test "claude-oauth CLI exists" "[ -f claude-oauth ]"
run_test "claude-oauth is executable" "[ -x claude-oauth ]"
run_test "installer script exists" "[ -f install.sh ]"
run_test "installer is executable" "[ -x install.sh ]"
run_test "workflow template exists" "[ -f templates/claude.yml ]"
run_test "README exists" "[ -f README.md ]"
run_test "LICENSE exists" "[ -f LICENSE ]"
run_test "VERSION exists" "[ -f VERSION ]"
run_test "CHANGELOG exists" "[ -f CHANGELOG.md ]"

# Syntax verification
run_test "claude-oauth syntax" "bash -n claude-oauth"
run_test "installer syntax" "bash -n install.sh"

# Version check
run_test "version consistency" "grep -q '2.1.0' VERSION && grep -q 'VERSION=\"2.1.0\"' claude-oauth"

# Command validation
run_test "help command" "./claude-oauth help | grep -q 'Claude Auth CLI'"
run_test "version flag" "./claude-oauth --version | grep -q 'v2.1.0'"

# Dependency checks in script
run_test "gh dependency check" "grep -q 'command -v gh' claude-oauth"
run_test "jq dependency check" "grep -q 'command -v jq' claude-oauth"
run_test "git dependency check" "grep -q 'command -v git' claude-oauth"

# Installation URL check
run_test "correct repo URL" "grep -q 'hikarubw/claude-code-oauth' install.sh"

# Old structure should not exist
run_test "no commands directory" "[ ! -d commands ]"
run_test "no tools directory" "[ ! -d tools ]"

# Summary
echo ""
echo "============================"
echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests failed: ${RED}$TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed!${NC}"
    exit 1
fi