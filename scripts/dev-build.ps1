<#
.SYNOPSIS
  Incremental Orca build (+ optional ctest) with the VS cmake, run from the repo root.
.EXAMPLE
  & .\.agent\scripts\dev-build.ps1 -Target fff_print_tests -Test
#>
param(
    [Parameter(Mandatory)][ValidatePattern('^[A-Za-z0-9_]+$')][string]$Target,
    [ValidateSet('Release', 'Debug', 'RelWithDebInfo')][string]$Config = 'Release',
    [switch]$Test,
    [int]$Tail = 15
)
$ErrorActionPreference = 'Stop'
$bin = 'C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin'
$root = Resolve-Path (Join-Path $PSScriptRoot '..\..')
$build = Join-Path $root 'build'
$log = Join-Path $build 'dev-build.log'

function Show-Result([string[]]$lines, [int]$code, [string]$step) {
    $lines | Select-String -Pattern ': (fatal )?error |error:|FAILED|Failed' | Select-Object -First 40 | ForEach-Object Line
    $lines | Select-Object -Last $Tail
    Write-Output "== $step exit $code (full log: build\dev-build.log)"
}

# VS cmake by full path: Strawberry Perl's cmake on PATH breaks the generator.
$out = & "$bin\cmake.exe" --build $build --config $Config --target $Target -- -m 2>&1 | ForEach-Object { "$_" }
$code = $LASTEXITCODE
$out | Set-Content -Path $log -Encoding utf8
Show-Result $out $code 'build'
if ($code -ne 0 -or -not $Test) { exit $code }

$suite = if ($Target -match '^(\w+)_tests$') { $Matches[1] } else { '' }
$out = & "$bin\ctest.exe" --test-dir (Join-Path $build "tests\$suite") -C $Config --output-on-failure 2>&1 | ForEach-Object { "$_" }
$code = $LASTEXITCODE
$out | Add-Content -Path $log -Encoding utf8
Show-Result $out $code 'ctest'
exit $code
