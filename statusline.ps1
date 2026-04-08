[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = [Console]::In.ReadToEnd()
$data = $raw -replace '\\', '\\\\' | ConvertFrom-Json

$model = if ($data.model.display_name) { $data.model.display_name } else { '?' }
$dir = Split-Path -Leaf $data.workspace.current_dir
$pct = if ($data.context_window.used_percentage) {
    [math]::Round([double]$data.context_window.used_percentage)
} else { 0 }
$cost = if ($data.cost.total_cost_usd) {
    '$' + '{0:N2}' -f [double]$data.cost.total_cost_usd
} else { '$0.00' }

# Tokens — compact (e.g. 15.2k)
$totalTokens = 0
if ($data.context_window.total_input_tokens) { $totalTokens += [double]$data.context_window.total_input_tokens }
if ($data.context_window.total_output_tokens) { $totalTokens += [double]$data.context_window.total_output_tokens }
if ($totalTokens -ge 1000000) {
    $tokenStr = '{0:N1}M' -f ($totalTokens / 1000000)
} elseif ($totalTokens -ge 1000) {
    $tokenStr = '{0:N1}k' -f ($totalTokens / 1000)
} else {
    $tokenStr = [string]$totalTokens
}

# Git branch
$branch = ''
try {
    Push-Location $data.workspace.current_dir
    $b = git branch --show-current 2>$null
    if ($b) { $branch = "($b)" }
    Pop-Location
} catch {}

# Colors
$esc = [char]27
$reset = "${esc}[0m"
$dim = "${esc}[2m"
if ($pct -ge 90) { $ctxColor = "${esc}[91m" }
elseif ($pct -ge 70) { $ctxColor = "${esc}[93m" }
else { $ctxColor = "${esc}[92m" }

Write-Output "${dim}[$model]${reset} $dir${dim}${branch}${reset} ${ctxColor}${pct}%${reset} ${dim}|${reset} $tokenStr ${dim}|${reset} $cost"
