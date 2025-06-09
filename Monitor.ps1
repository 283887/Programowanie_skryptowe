# Monitorowanie folderu

# Ustalenie folderu źródłowego i docelowego
$source_folder = "C:\Users\Admin\Documents\Folder_Testowy"
$final_folder = "C:\Users\Admin\Documents\Docelowy"

# Jeśli nie istnieje, to tworzymy docelowy folder
if (!(Test-Path -Path $final_folder)) {
    New-Item -Path $final_folder -ItemType Directory | Out-Null
}

# Tworzymy akcję do przenoszenia plików
$action = {
    Start-Sleep -Seconds 3  # Czekamy az plik sie zapisze
    $plik = $Event.SourceEventArgs.FullPath
    $nazwa = $Event.SourceEventArgs.Name
    $folderDocelowy = "C:\Users\Admin\Documents\Docelowy"
    $cel = Join-Path -Path $folderDocelowy -ChildPath $nazwa

    try {
        Move-Item -Path $plik -Destination $cel -Force
    } catch {
        Write-Host "Błąd :("
    }
}

# Tworzymy FileSystemWatcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $source_folder
$watcher.Filter = "*.txt"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

# Rejestracja zdarzenia "Created" i "Changed"
$subscriptionCreated = Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action $action
$subscriptionChanged = Register-ObjectEvent -InputObject $watcher -EventName "Changed" -Action $action

Write-Host "Monitoring działa skopiuj lub utwórz plik .txt w folderze Ctrl+C aby zakonczyc"

# Pętla ktora wykonuje sie az do momentu zakonzcenia przez uzytkownika
while ($true) {
    Start-Sleep -Seconds 1

}