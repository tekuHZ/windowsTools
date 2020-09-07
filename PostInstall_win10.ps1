# autor:_teku


Write-host "##########################################"
Write-host "  #  Post-Instalacion de windowds 10  #"
Write-host "##########################################"
Write-host ''
Write-host ''

Write-host "comprobando privilegios"
$userStatus = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match"S-1-5-32-544")

if($userStatus -eq $false) {
    Write-host '>> Necesita ser Administrador <<' -F Yellow
    break
} else {
    Write-host '-> Administrador' -F Green
}

Write-host ''
Write-host "************************************"
Write-host "       Desintalar Bloatware         "
Write-host "************************************"

$listOfApps = "Microsoft.3DBuilder",
            "Microsoft.WindowsAlarms", #alarma y reloj
            "Microsoft.YourPhone", #tu telefono
            "Microsoft.windowscommunicationsapps", #mail y calendario
            "Microsoft.BingFoodAndDrink",
            "Microsoft.MicrosoftOfficeHub", #obtener office
            "Microsoft.Getstarted", #Comienzo
            "Microsoft.Windows.Photos",
            "Microsoft.WindowsZuneMusic",
            "Microsoft.ZuneMusic",
            "Microsoft.XboxApp",
            "Microsoft.BingHealthAndFitness",
            "Microsoft.WindowsMaps",
            "Microsoft.GetHelp",
            "Microsoft3DViewer",
            "Microsoft.Messaging",
            "Microsoft.WindowsZuneVideo",
            "Microsoft.BingNews",
            "skypeapp",
            "solitairecollection",
            "bingfinance", #dinero
            "zunevideo", # cine y tv
            "bingnews", #noticias
            "OneNote",
            "personas",
            "WindowsPhone", #phone companion
            "windowsstore",
            "bingsports", #deportes
            "SoundRecorder", #Grabador de vos
            "bingweather", #tiempo
            "Microsoft.XboxApp",
            "XboxIdentityProvider",
            "XboxGamingOverlay",
            "XboxGameOverlay",
            "bingnews",
            "SpotifyAB.SpotifyMusic",
            "Microsoft.OneConnect",
            "Microsoft.WindowsFeedbackHub",
            "Microsoft.People",
            "Microsoft.MixedReality.Portal",
            "Microsoft.Print3D",
            "Microsoft.Xbox.TCUI",
            "Microsoft.Windows.Cortana",
            "Microsoft.549981C3F5F10"
         


Write-host "Buscando Bloatware" -F Green
Write-host "--------------------"

$appsFound = @()

Foreach($i in $listOfApps){
    if(Get-appxPackage *$i*) {
        $appsFound += $i
        Write-host "-> $i"
     }
}

if($appsFound.Length -eq 0){
    Write-host '>> No se ha encotrado applicaciones que coincidan con la lista <<' -F Yellow
    Write-host ''
    }

function uninstall  {
    Foreach ($item in $appsFound) {
        Write-Host "[" -NonewLine
        Write-Host "OK" -NonewLine -Foreground Green
        Write-Host "]" "$item"
        Get-AppxPackage *$item* -AllUsers | Remove-AppxPackage
    }
}

$opcion = Read-host 'Desinstalar aplicaiones s/n'
if($opcion -eq 's') {
    uninstall
}

elseif($opcion -eq 'n') {
    '>> Operacion Cancelada <<'
    break
} else {
    Write-host "No se reconose la opcion -> " -NonewLine
    Write-host "$opcion" -F Red
}

Write-host '************************'
Write-host ' Deshabilitar servicios '
Write-host '************************'

$listServices = "DPS", # Servicio de directivas de diagnóstico
               "TrkWks", # Cliente de seguimiento de vínculos distribuidos
               "Fax", # Servicio de Fax
               "MapsBroker", # Administrador de Mapas Descargados (Si no usas la app Maps)
               "iphlpsvc", # Aplicación auxiliar IP (Si no usas conexión IPv6)
               "Spooler", # (Si no tienes impresora)
               "RemoteRegistry", # Este puedes desactivarlo por motivos de seguridad
               "seclogon", # Inicio de sesión secundario
               "wscsvc", # Centro de seguridad
               #"lmhosts", # Si no estás en una red local de trabajo
               "TabletInputService", # Servicio de Panel de escritura a mano y teclado táctil
               "stisvc" # adquisicion de imagenes de windows (WIA)

Write-host '************************'
Write-host ' Deshabilitar servicios '
Write-host '************************'

$listServices = "DPS", # Servicio de directivas de diagnóstico
               "TrkWks", # Cliente de seguimiento de vínculos distribuidos
               "Fax", # Servicio de Fax
               "MapsBroker", # Administrador de Mapas Descargados (Si no usas la app Maps)
               "iphlpsvc", # Aplicación auxiliar IP (Si no usas conexión IPv6)
               "Spooler", # (Si no tienes impresora)
               "RemoteRegistry", # Este puedes desactivarlo por motivos de seguridad
               "seclogon", # Inicio de sesión secundario
               "wscsvc", # Centro de seguridad
               "lmhosts", # Si no estás en una red local de trabajo
               "TabletInputService", # Servicio de Panel de escritura a mano y teclado táctil
               "stisvc" # adquisicion de imagenes de windows (WIA)

$listServices
Write-host '>> Servicios que seran Deshabilitados <<' -B Yellow -F Black

Foreach ($i in $listServices) {
    Set-Service $i -StartupType Disabled
    Write-host "Service -> $i " 
     
}