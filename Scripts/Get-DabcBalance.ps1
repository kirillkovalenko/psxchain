param(
    [Parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]
    $Address
)

$ThisPath = Split-Path $MyInvocation.MyCommand.Path -Parent

Import-Module $ThisPath\..\Module\XChain.psd1

$balance = Get-XCBalance $Address

$feed = Invoke-RestMethod https://droolingapebus.club/api/drooling-feed

$feed.PSobject.Properties.Name | ForEach-Object {    
    $asset = $balance | Where-Object asset -eq $_
    if ($null -eq $asset) {
        $quantity = 0
    } else {
        $quantity = $asset.quantity
    }
    [PSCustomObject]@{
        Name = $_
        Quantity = $quantity
    }
}
