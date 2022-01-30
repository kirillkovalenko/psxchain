$ThisPath = Split-Path $MyInvocation.MyCommand.Path -Parent
Import-Module $ThisPath\..\Module\XChain.psd1

Write-Progress "Fetching feed..."
$feed = Invoke-RestMethod https://droolingapebus.club/api/drooling-feed

$total = $feed.PSobject.Properties | Measure-Object | Select-Object -ExpandProperty Count
$progress = 0

$feed.PSobject.Properties.Name | ForEach-Object {
    Write-Progress -Activity "Query dispenser..." -Status $_ -PercentComplete ($progress++ / $total * 100)
    Get-XCDispenser -Asset $_ -Active | Select-Object -First 1
}
