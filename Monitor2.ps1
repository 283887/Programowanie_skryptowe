# Monitorowanie folderu

#ustalenie folderu źródłowego i docelowego
$source_folder = "C:\Users\Admin\Documents\Folder_Testowy"
$final_folder = "C:\Users\Admin\Documents\Docelowy"

#jeśli nie istnieje to tworzymy docelowy folder
if(!(Test-Path -Path $final_folder)) {
    New-Item -Path $final_folder -ItemType Directory | Out-Null
    Write-Host "Utworzony został nowy folder: $final_folder"
    }

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = "C:\Users\Admin\Documents\Folder_Testowy"
$watcher.Filter = "*.txt"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

# Kluczowe: przypisz do zmiennej!
$subscriptionCreated = Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action $action
$subscriptionChanged = Register-ObjectEvent -InputObject $watcher -EventName "Changed" -Action $action


$action = {
    Start-Sleep -Seconds 1  # poczekaj, aż plik się zapisze w całości
    $plik = $Event.SourceEventArgs.FullPath
    $nazwa = $Event.SourceEventArgs.Name
    $folderDocelowy = "C:\Users\Admin\Documents\Docelowy"
    $cel = Join-Path -Path $folderDocelowy -ChildPath $nazwa

    try {
        Move-Item -Path $plik -Destination $cel -Force
    } catch {
        Write-Host "Błąd przenoszenia pliku: $_"
    }
}

Write-Host "Monitoring działa. Skopiuj .txt do folderu, aby przetestować."

while ($true) {
    Start-Sleep -Seconds 1
}