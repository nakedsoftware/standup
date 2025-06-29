#!/usr/bin/env pwsh

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

<#
.SYNOPSIS
    Command router script that looks for and executes subcommands.

.DESCRIPTION
    This script routes commands to appropriate executables or scripts:
    1. First looks for PowerShell scripts in bin/do-<command>.ps1
    2. Then looks for executables in bin/do-<command> (or .exe on Windows)
    3. Finally looks in PATH for do-<command> executables
    
    Any additional arguments are forwarded to the target command.

.PARAMETER Command
    The subcommand to execute

.PARAMETER Arguments
    Additional arguments to pass to the subcommand

.EXAMPLE
    .\do.ps1 build
    .\do.ps1 test --verbose
    .\do.ps1 setup arg1 arg2
#>

param(
    [Parameter(Position = 0)]
    [string]$Command,
    
    [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
    [string[]]$Arguments = @()
)

function Show-Usage {
    Write-Host "Usage: do <command> [arguments...]" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Available commands:" -ForegroundColor Green
    
    # Look for PowerShell scripts in bin directory
    $binDir = Join-Path $PSScriptRoot "bin"
    if (Test-Path $binDir) {
        $psScripts = Get-ChildItem -Path $binDir -Name "do-*.ps1" -ErrorAction SilentlyContinue
        $executables = Get-ChildItem -Path $binDir -Name "do-*" -ErrorAction SilentlyContinue | Where-Object { $_ -notlike "*.ps1" }
        
        $commands = @()
        
        # Extract command names from PowerShell scripts
        foreach ($script in $psScripts) {
            $cmdName = $script -replace "^do-", "" -replace "\.ps1$", ""
            $commands += "  $cmdName (PowerShell script)"
        }
        
        # Extract command names from executables
        foreach ($exe in $executables) {
            $cmdName = $exe -replace "^do-", "" -replace "\.exe$", ""
            $commands += "  $cmdName (executable)"
        }
        
        if ($commands.Count -gt 0) {
            $commands | Sort-Object | ForEach-Object { Write-Host $_ }
        } else {
            Write-Host "  No commands found in bin directory" -ForegroundColor Gray
        }
    }
    
    Write-Host ""
    Write-Host "Commands are searched in the following order:" -ForegroundColor Cyan
    Write-Host "  1. bin/do-<command>.ps1 (PowerShell scripts)"
    Write-Host "  2. bin/do-<command> or bin/do-<command>.exe (local executables)"
    Write-Host "  3. do-<command> in PATH (system executables)"
}

function Invoke-Command {
    param(
        [string]$CommandPath,
        [string[]]$Args
    )
    
    try {
        if ($Args.Count -gt 0) {
            & $CommandPath @Args
        } else {
            & $CommandPath
        }
        exit $LASTEXITCODE
    } catch {
        Write-Error "Failed to execute command: $_"
        exit 1
    }
}

# Show usage if no command specified
if (-not $Command) {
    Show-Usage
    exit 1
}

# Get the directory where this script is located
$scriptDir = $PSScriptRoot
$binDir = Join-Path $scriptDir "bin"

# 1. Look for PowerShell script in bin directory
$psScriptPath = Join-Path $binDir "do-$Command.ps1"
if (Test-Path $psScriptPath) {
    Write-Verbose "Found PowerShell script: $psScriptPath"
    Invoke-Command -CommandPath $psScriptPath -Args $Arguments
}

# 2. Look for executable in bin directory
$exePaths = @()
if ($IsWindows) {
    $exePaths += Join-Path $binDir "do-$Command.exe"
}
$exePaths += Join-Path $binDir "do-$Command"

foreach ($exePath in $exePaths) {
    if (Test-Path $exePath) {
        Write-Verbose "Found local executable: $exePath"
        Invoke-Command -CommandPath $exePath -Args $Arguments
    }
}

# 3. Look in PATH for executable
$pathCommands = @()
if ($IsWindows) {
    $pathCommands += "do-$Command.exe"
}
$pathCommands += "do-$Command"

foreach ($pathCommand in $pathCommands) {
    $foundInPath = Get-Command $pathCommand -ErrorAction SilentlyContinue
    if ($foundInPath) {
        Write-Verbose "Found command in PATH: $($foundInPath.Source)"
        Invoke-Command -CommandPath $foundInPath.Source -Args $Arguments
    }
}

# If we get here, no command was found
Write-Error "Command 'do-$Command' not found in bin directory or PATH"
Write-Host ""
Show-Usage
exit 1
