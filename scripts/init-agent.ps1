param(
  [Parameter(Mandatory=$true)]
  [string]$Agent,
  [Parameter(Mandatory=$true)]
  [string]$Target,
  [switch]$Git,
  [switch]$DryRun
)

function Copy-IfExists {
  param($Source, $Dest)
  if (Test-Path $Source) {
    if ($DryRun) {
      Write-Output "Would copy: $Source -> $Dest"
    } else {
      $destDir = Split-Path $Dest -Parent
      if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
      Copy-Item -Path $Source -Destination $Dest -Recurse -Force
      Write-Output "Copied: $Source -> $Dest"
    }
  }
}

$root = Split-Path -Path $PSScriptRoot -Parent
$agentDir = Join-Path $root ".github/agents/$Agent"

if (-not (Test-Path $agentDir)) {
  Write-Error "Agent directory not found: $agentDir"
  exit 1
}

# files to copy
$files = @(
  "$agentDir/$Agent.md",
  "$agentDir/prompt.md",
  "$agentDir/agent.yml",
  "$agentDir/README.md"
)

foreach ($f in $files) {
  $rel = $f.Substring($root.Length+1)
  $dest = Join-Path $Target $rel
  Copy-IfExists -Source $f -Dest $dest
}

# copy templates and snippets directories
$dirs = @("templates","snippets")
foreach ($d in $dirs) {
  $srcDir = Join-Path $agentDir $d
  if (Test-Path $srcDir) {
    $destDir = Join-Path $Target ".github/agents/$Agent/$d"
    if ($DryRun) { Write-Output "Would copy directory: $srcDir -> $destDir" }
    else { Copy-Item -Path $srcDir -Destination $destDir -Recurse -Force; Write-Output "Copied directory: $srcDir -> $destDir" }
  }
}

if ($Git) {
  if ($DryRun) {
    Write-Output "Would run: git -C $Target add . && git -C $Target commit -m 'chore: add $Agent agent files' && git -C $Target push"
  } else {
    Write-Output "Committing changes in target repo..."
    & git -C $Target add .
    & git -C $Target commit -m "chore: add $Agent agent files" || Write-Output "No changes to commit"
    & git -C $Target push || Write-Output "Push failed or no remote configured"
  }
}
