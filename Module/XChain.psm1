function ConvertTo-HashTable {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [PSCustomObject] 
        $Object
    )
    $hashtable = @{}
    Get-Member -InputObject $object -MemberType *Property | ForEach-Object {
        $hashtable.$($_.Name) = $object.$($_.Name)
    }
    $hashtable
}

function Get-Address {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Address
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/address/$Address"
}

function Get-Asset {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Asset
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/asset/$Asset"    
}

function Get-Balance {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Address
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/balances/$Address" | Select-Object -ExpandProperty data | Add-Member -MemberType NoteProperty -Name 'address' -Value $Address -PassThru
}

function Get-Bet {
    [CmdletBinding(DefaultParameterSetName='Address')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    if ($PSCmdlet.ParameterSetName -eq 'Address') {
        Invoke-RestMethod -Uri "https://xchain.io/api/bets/$Address" | Select-Object -ExpandProperty data
    } else {
        Invoke-RestMethod -Uri "https://xchain.io/api/bets/$Block" | Select-Object -ExpandProperty data
    }
}

function Get-Block {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [UInt32]
        $Block
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/block/$Block"
}

function Get-Broadcast {
    [CmdletBinding(DefaultParameterSetName='Address')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    if ($PSCmdlet.ParameterSetName -eq 'Address') {
        Invoke-RestMethod -Uri "https://xchain.io/api/broadcasts/$Address" | Select-Object -ExpandProperty data
    } else {
        Invoke-RestMethod -Uri "https://xchain.io/api/broadcasts/$Block" | Select-Object -ExpandProperty data
    }
}

function Get-Burn {
    [CmdletBinding(DefaultParameterSetName='Address')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    if ($PSCmdlet.ParameterSetName -eq 'Address') {
        Invoke-RestMethod -Uri "https://xchain.io/api/burns/$Address" | Select-Object -ExpandProperty data
    } else {
        Invoke-RestMethod -Uri "https://xchain.io/api/burns/$Block" | Select-Object -ExpandProperty data
    }
}

function Get-Credit {
    [CmdletBinding(DefaultParameterSetName='Address')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    if ($PSCmdlet.ParameterSetName -eq 'Address') {
        Invoke-RestMethod -Uri "https://xchain.io/api/credits/$Address" | Select-Object -ExpandProperty data
    } else {
        Invoke-RestMethod -Uri "https://xchain.io/api/credits/$Block" | Select-Object -ExpandProperty data
    }
}

function Get-Debit {
    [CmdletBinding(DefaultParameterSetName='Address')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    if ($PSCmdlet.ParameterSetName -eq 'Address') {
        Invoke-RestMethod -Uri "https://xchain.io/api/debits/$Address" | Select-Object -ExpandProperty data
    } else {
        Invoke-RestMethod -Uri "https://xchain.io/api/debits/$Block" | Select-Object -ExpandProperty data
    }
}

function Get-Destruction {
    [CmdletBinding(DefaultParameterSetName='Address')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Asset')]
        [String]
        $Asset,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Address' {  
            Invoke-RestMethod -Uri "https://xchain.io/api/destructions/$Address" | Select-Object -ExpandProperty data
        }
        'Asset' {
            Invoke-RestMethod -Uri "https://xchain.io/api/destructions/$Asset" | Select-Object -ExpandProperty data
        }
        'Block' {
            Invoke-RestMethod -Uri "https://xchain.io/api/destructions/$Block" | Select-Object -ExpandProperty data
        }
    }
}

function Get-Dispenser {
    [CmdletBinding(DefaultParameterSetName='Asset')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Asset')]
        [String]
        $Asset,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block,
        [Parameter(Mandatory=$false)]
        [Switch]
        $Active
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Address' {  
            $dispenser = Invoke-RestMethod -Uri "https://xchain.io/api/dispensers/$Address" 
        }
        'Asset' {
            $dispenser = Invoke-RestMethod -Uri "https://xchain.io/api/dispensers/$Asset"
        }
        'Block' {
            $dispenser = Invoke-RestMethod -Uri "https://xchain.io/api/dispensers/$Block"
        }
    }

    if ($Active.IsPresent) {
        $dispenser | Select-Object -ExpandProperty data | Where-Object { $_.status -eq 0 -and $_.give_remaining -ne 0 } | Sort-Object satoshirate
    } else {
        $dispenser | Select-Object -ExpandProperty data
    }
}

function Get-Dispens {
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Transaction
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/dispenses/$Transaction" | Select-Object -ExpandProperty data
}

function Get-Dividend {
    [CmdletBinding(DefaultParameterSetName='Asset')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Asset')]
        [String]
        $Asset,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Address' {  
            Invoke-RestMethod -Uri "https://xchain.io/api/dividends/$Address" | Select-Object -ExpandProperty data
        }
        'Asset' {
            Invoke-RestMethod -Uri "https://xchain.io/api/dividends/$Asset" | Select-Object -ExpandProperty data
        }
        'Block' {
            Invoke-RestMethod -Uri "https://xchain.io/api/dividends/$Block" | Select-Object -ExpandProperty data
        }
    }
}

function Get-History {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Address
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/history/$Address" | Select-Object -ExpandProperty data
}

function Get-Holder {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Asset
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/holders/$Asset" | Select-Object -ExpandProperty data | Add-Member -MemberType NoteProperty -Name 'asset' -Value $Asset -PassThru
}

function Get-Issuance {
    [CmdletBinding(DefaultParameterSetName='Asset')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Asset')]
        [String]
        $Asset,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Address' {  
            Invoke-RestMethod -Uri "https://xchain.io/api/issuances/$Address" | Select-Object -ExpandProperty data
        }
        'Asset' {
            Invoke-RestMethod -Uri "https://xchain.io/api/issuances/$Asset" | Select-Object -ExpandProperty data
        }
        'Block' {
            Invoke-RestMethod -Uri "https://xchain.io/api/issuances/$Block" | Select-Object -ExpandProperty data
        }
    }
}

function Get-Market {
    [CmdletBinding(DefaultParameterSetName='Default')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Asset')]
        [String]
        $Asset,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Pair')]
        [String]
        $Asset1,
        [Parameter(Position=1, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Pair')]
        [String]
        $Asset2
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Asset' {  
            Invoke-RestMethod -Uri "https://xchain.io/api/markets/$Asset" | Select-Object -ExpandProperty data
        }
        'Pair' {
            Invoke-RestMethod -Uri "https://xchain.io/api/market/$Asset1/$Asset2"
        }
        Default {
            Invoke-RestMethod -Uri "https://xchain.io/api/markets" | Select-Object -ExpandProperty data
        }
    }
}

function Get-MarketHistory {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Asset1,
        [Parameter(Position=1, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Asset2,
        [Parameter(Position=2, Mandatory=$false, ValueFromPipeline=$true)]
        [String]
        $Address = $null
    )
    if ($null -eq $Address) {
        Invoke-RestMethod -Uri "https://xchain.io/api/market/$Asset1/$Asset2/history" | Select-Object -ExpandProperty data
    } else {
        Invoke-RestMethod -Uri "https://xchain.io/api/market/$Asset1/$Asset2/history/$Address" | Select-Object -ExpandProperty data
    }
}

function Get-MarketOrder {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Asset1,
        [Parameter(Position=1, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Asset2,
        [Parameter(Position=2, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Address
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/market/$Asset1/$Asset2/orders/$Address" | Select-Object -ExpandProperty data
}

function Get-MarketOrderBook {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Asset1,
        [Parameter(Position=1, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Asset2,
        [Parameter(Position=2, Mandatory=$false, ValueFromPipeline=$true)]
        [String]
        $Address = $null
    )
    if ($null -eq $Address) {
        Invoke-RestMethod -Uri "https://xchain.io/api/market/$Asset1/$Asset2/orderbook"
    } else {
        Invoke-RestMethod -Uri "https://xchain.io/api/market/$Asset1/$Asset2/orderbook/$Address"
    }
}

function Get-MemoryPool {
    [CmdletBinding(DefaultParameterSetName='Asset')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Asset')]
        [String]
        $Asset
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Address' {  
            Invoke-RestMethod -Uri "https://xchain.io/api/mempool/$Address" | Select-Object -ExpandProperty data
        }
        'Asset' {
            Invoke-RestMethod -Uri "https://xchain.io/api/mempool/$Asset" | Select-Object -ExpandProperty data
        }
    }
}

function Get-Network {
    [CmdletBinding()]
    param (
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/network"    
}

function Get-Order {
    [CmdletBinding(DefaultParameterSetName='Asset')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Asset')]
        [String]
        $Asset,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Address' {  
            Invoke-RestMethod -Uri "https://xchain.io/api/orders/$Address" | Select-Object -ExpandProperty data
        }
        'Asset' {
            Invoke-RestMethod -Uri "https://xchain.io/api/orders/$Asset" | Select-Object -ExpandProperty data
        }
        'Block' {
            Invoke-RestMethod -Uri "https://xchain.io/api/orders/$Block" | Select-Object -ExpandProperty data
        }
    }
}

function Get-OrderMatch {
    [CmdletBinding(DefaultParameterSetName='Asset')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Asset')]
        [String]
        $Asset,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Address' {  
            Invoke-RestMethod -Uri "https://xchain.io/api/order_matches/$Address" | Select-Object -ExpandProperty data
        }
        'Asset' {
            Invoke-RestMethod -Uri "https://xchain.io/api/order_matches/$Asset" | Select-Object -ExpandProperty data
        }
        'Block' {
            Invoke-RestMethod -Uri "https://xchain.io/api/order_matches/$Block" | Select-Object -ExpandProperty data
        }
    }
}

function Get-Send {
    [CmdletBinding(DefaultParameterSetName='Asset')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Asset')]
        [String]
        $Asset,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    switch ($PSCmdlet.ParameterSetName) {
        'Address' {  
            Invoke-RestMethod -Uri "https://xchain.io/api/sends/$Address" | Select-Object -ExpandProperty data
        }
        'Asset' {
            Invoke-RestMethod -Uri "https://xchain.io/api/sends/$Asset" | Select-Object -ExpandProperty data
        }
        'Block' {
            Invoke-RestMethod -Uri "https://xchain.io/api/sends/$Block" | Select-Object -ExpandProperty data
        }
    }
}

function Get-Sweep {
    [CmdletBinding(DefaultParameterSetName='Address')]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Address')]
        [String]
        $Address,
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Block')]
        [UInt32]
        $Block
    )
    if ($PSCmdlet.ParameterSetName -eq 'Address') {
        Invoke-RestMethod -Uri "https://xchain.io/api/sweeps/$Address" | Select-Object -ExpandProperty data
    } else {
        Invoke-RestMethod -Uri "https://xchain.io/api/sweeps/$Block" | Select-Object -ExpandProperty data
    }
}

function Get-Transaction {
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Transaction
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/transaction/$Transaction"
}

function Get-Utxo {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $Address
    )
    Invoke-RestMethod -Uri "https://xchain.io/api/utxos/$Address"
}
