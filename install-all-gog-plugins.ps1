try {
    # Get all lines from the list command
    $lines = .\gog-plugins-downloader.exe -l
} catch {
    Write-Warning "Failed to get plugin list: $_"
    exit 1
}

# Filter lines: ignore empty lines and lines starting with "Available"
$plugins = $lines | Where-Object { $_ -and ($_ -notmatch '^Available') } | ForEach-Object {
    ($_ -split '\s+')[0]  # Take first word (plugin name)
}

foreach ($plugin in $plugins) {
    try {
        Write-Host "Installing plugin: $plugin"
        .\gog-plugins-downloader.exe -p $plugin
    } catch {
        Write-Warning "Failed to install plugin '$plugin': $_"
        # Continue with next plugin
    }
}

Write-Host "Plugin installation complete."
