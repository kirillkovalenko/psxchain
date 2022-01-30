@{
    ModuleToProcess = '.\XChain.psm1'
    ModuleVersion = '1.0'
    GUID = '44a825d7-ec1f-43d3-99ac-db5ebf79df57'
    Author = 'kirill.kovalenko@gmail.com'
    Copyright = '2022 (c) kirill.kovalenko@gmail.com. All rights reserved.'
    Description = 'PowerShell API for xchain.io'
    HelpInfoURI = 'https://xchain.io/api'
    FunctionsToExport = @(
        'ConvertTo-HashTable'
        'Get-Address'
        'Get-Asset'
        'Get-Balance'
        'Get-Bet'
        'Get-Block'
        'Get-Broadcast'
        'Get-Burn'
        'Get-Credit'
        'Get-Debit'
        'Get-Destruction'
        'Get-Dispenser'
        'Get-Dispens'
        'Get-Dividend'
        'Get-History'
        'Get-Holder'
        'Get-Issuance'
        'Get-Market'
        'Get-MarketHistory'
        'Get-MarketOrder'
        'Get-MarketOrderBook'
        'Get-MemoryPool'
        'Get-Network'
        'Get-Order'
        'Get-OrderMatch'
        'Get-Send'
        'Get-Sweep'
        'Get-Transaction'
        'Get-Utxo'
    )
    CmdletsToExport = '*'
    VariablesToExport = '*'
    AliasesToExport = '*'
    DefaultCommandPrefix = 'XC'
    PrivateData = @{
        PSData = @{
            Tags = @('bitcoin', 'counterparty', 'xchain', 'XCP', 'rarepepe', 'NFT')
            LicenseUri = ''
            ProjectUri = ''
            IconUri = ''
        }
    }
}

