<#
.SYNOPSIS
    Affiche les informations principales d'un ordinateur Windows.

.DESCRIPTION
    Ce script récupère le nom du PC, la version de Windows, la mémoire vive (RAM)
    et l'espace libre sur chaque disque, puis les affiche à l'écran.
    Auteur : Thierno Camara — THIERNO IT

.EXAMPLE
    .\Get-InfosPC.ps1
#>

# 1. Récupérer les informations du système d'exploitation (Windows)
$os = Get-CimInstance -ClassName Win32_OperatingSystem

# 2. Récupérer les informations de l'ordinateur (fabricant, modèle, RAM)
$pc = Get-CimInstance -ClassName Win32_ComputerSystem

# 3. Afficher un titre
Write-Host "===== Informations du PC =====" -ForegroundColor Cyan

# 4. Afficher le nom du PC, le modèle et la version de Windows
Write-Host "Nom du PC       : $($env:COMPUTERNAME)"
Write-Host "Fabricant       : $($pc.Manufacturer)"
Write-Host "Modèle          : $($pc.Model)"
Write-Host "Windows         : $($os.Caption) (version $($os.Version))"

# 5. Calculer la RAM totale en Go (elle est donnée en octets, on divise par 1 Go)
$ramGo = [math]::Round($pc.TotalPhysicalMemory / 1GB, 1)
Write-Host "Mémoire (RAM)   : $ramGo Go"

# 6. Afficher l'espace libre de chaque disque
Write-Host ""
Write-Host "===== Disques =====" -ForegroundColor Cyan

# On prend seulement les disques locaux (DriveType 3)
$disques = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"

foreach ($disque in $disques) {
    $totalGo  = [math]::Round($disque.Size / 1GB, 1)
    $libreGo  = [math]::Round($disque.FreeSpace / 1GB, 1)
    $pourcent = [math]::Round(($disque.FreeSpace / $disque.Size) * 100)

    # Rouge si moins de 10 % libre, vert sinon
    if ($pourcent -lt 10) { $couleur = "Red" } else { $couleur = "Green" }

    Write-Host "$($disque.DeviceID)  $libreGo Go libres sur $totalGo Go ($pourcent %)" -ForegroundColor $couleur
}
