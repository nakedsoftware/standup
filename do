#!/bin/bash

# Copyright 2025 Naked Software, LLC
#
# Version 1.0.0 (June 28, 2025)
#
# This Naked Standup License Agreement ("Agreement") is a legal agreement
# between you ("Licensee") and Naked Software, LLC ("Licensor") for the use
# of the Naked Standup software product ("Software"). By using the Software,
# you agree to be bound by the terms of this Agreement.
#
# 1. Grant of License
#
# Licensor grants Licensee a non-exclusive, non-transferable,
# non-sublicensable license to use the Software for non-commercial,
# educational, or other non-production purposes. Licensee may not use the
# Software for any commercial purposes without purchasing a commercial
# license from Licensor.
#
# 2. Commercial Use
#
# To use the Software for commercial purposes, Licensee must purchase a
# commercial license from Licensor. A commercial license allows Licensee to
# use the Software in production environments, build their own version, and
# add custom features or bug fixes. Licensee may not sell the Software or
# any derivative works to others.
#
# 3. Derivative Works
#
# Licensee may create derivative works of the Software for their own use,
# provided that they maintain a valid commercial license. Licensee may not
# sell or distribute derivative works to others. Any derivative works must
# include a copy of this Agreement and retain all copyright notices.
#
# 4. Sharing and Contributions
#
# Licensee may share their changes or bug fixes to the Software with others,
# provided that such changes are made freely available and not sold.
# Licensee is encouraged to contribute their bug fixes back to Licensor for
# inclusion in the Software.
#
# 5. Restrictions
#
# Licensee may not:
#
# - Use the Software for any commercial purposes without a valid commercial
#   license.
# - Sell, sublicense, or distribute the Software or any derivative works.
# - Remove or alter any copyright notices or proprietary legends on the
#   Software.
#
# 6. Termination
#
# This Agreement is effective until terminated. Licensor may terminate this
# Agreement at any time if Licensee breaches any of its terms. Upon
# termination, Licensee must cease all use of the Software and destroy all
# copies in their possession.
#
# 7. Disclaimer of Warranty
#
# The Software is provided "as is" without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose, and noninfringement. In no event shall
# Licensor be liable for any claim, damages, or other liability, whether in
# an action of contract, tort, or otherwise, arising from, out of, or in
# connection with the Software or the use or other dealings in the Software.
#
# 8. Limitation of Liability
#
# In no event shall Licensor be liable for any indirect, incidental,
# special, exemplary, or consequential damages (including, but not limited
# to, procurement of substitute goods or services; loss of use, data, or
# profits; or business interruption) however caused and on any theory of
# liability, whether in contract, strict liability, or tort (including
# negligence or otherwise) arising in any way out of the use of the
# Software, even if advised of the possibility of such damage.
#
# 9. Governing Law
#
# This Agreement shall be governed by and construed in accordance with the
# laws of the jurisdiction in which Licensor is located, without regard to
# its conflict of law principles.
#
# 10. Entire Agreement
#
# This Agreement constitutes the entire agreement between the parties with
# respect to the Software and supersedes all prior or contemporaneous
# understandings regarding such subject matter.
#
# By using the Software, you acknowledge that you have read this Agreement,
# understand it, and agree to be bound by its terms and conditions.

# Script: do
# Purpose: Execute do-<command> scripts from bin directory or PATH
# Usage: ./do <command> [arguments...]

set -euo pipefail

# Function to display usage information
show_usage() {
    echo "Usage: $0 <command> [arguments...]"
    echo ""
    echo "This script looks for executable commands in the following order:"
    echo "  1. bin/do-<command> (executable script or program)"
    echo "  2. bin/do-<command>.ps1 (PowerShell script, if PowerShell is installed)"
    echo "  3. do-<command> in PATH"
    echo ""
    echo "Any additional arguments are forwarded to the found command."
    echo ""
    echo "Examples:"
    echo "  $0 build"
    echo "  $0 test"
    echo "  $0 start"
}

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "Error: No command specified." >&2
    echo "" >&2
    show_usage >&2
    exit 1
fi

# Get the command name and remaining arguments
COMMAND="$1"
shift  # Remove the command from arguments list, leaving only the additional args

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$SCRIPT_DIR/bin"

# 1. Look for executable in bin subdirectory
BIN_EXECUTABLE="$BIN_DIR/do-$COMMAND"
if [ -x "$BIN_EXECUTABLE" ]; then
    exec "$BIN_EXECUTABLE" "$@"
fi

# 2. Look for PowerShell script if PowerShell is available
if command -v pwsh >/dev/null 2>&1 || command -v powershell >/dev/null 2>&1; then
    PS_SCRIPT="$BIN_DIR/do-$COMMAND.ps1"
    if [ -f "$PS_SCRIPT" ]; then
        # Determine which PowerShell command to use
        if command -v pwsh >/dev/null 2>&1; then
            exec pwsh -File "$PS_SCRIPT" "$@"
        else
            exec powershell -File "$PS_SCRIPT" "$@"
        fi
    fi
fi

# 3. Look for command in PATH
PATH_COMMAND="do-$COMMAND"
if command -v "$PATH_COMMAND" >/dev/null 2>&1; then
    exec "$PATH_COMMAND" "$@"
fi

# If we get here, no command was found
echo "Error: Command 'do-$COMMAND' not found." >&2
echo "Searched in:" >&2
echo "  - $BIN_EXECUTABLE" >&2
if command -v pwsh >/dev/null 2>&1 || command -v powershell >/dev/null 2>&1; then
    echo "  - $BIN_DIR/do-$COMMAND.ps1" >&2
fi
echo "  - PATH for do-$COMMAND" >&2
echo "" >&2
echo "Available commands in bin directory:" >&2
if [ -d "$BIN_DIR" ]; then
    # List available do-* commands in bin directory
    find "$BIN_DIR" -name "do-*" -type f \( -executable -o -name "*.ps1" \) 2>/dev/null | \
    sed "s|^$BIN_DIR/do-||" | sed 's|\.ps1$||' | sort | \
    while read -r cmd; do
        echo "  - $cmd" >&2
    done
else
    echo "  (bin directory does not exist)" >&2
fi

exit 1
