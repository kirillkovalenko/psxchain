# PowerShell API for XChain

This repository contains minimal PowerShell API for XChain.

[XChain](https://xchain.io/about) is a free [Counterparty](https://counterparty.io) blockchain explorer which allows users to explore and better understand the Counterparty platform.

[Counterparty](https://counterparty.io) is a free and open platform that puts powerful financial tools in the hands of everyone with an Internet connection. Counterparty creates a robust and secure marketplace directly on the Bitcoin blockchain, extending Bitcoin's functionality into a full fledged peer-to-peer financial platform. 

## Commands

```text
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        ConvertTo-XCHashTable                              1.0        XChain
Function        Get-XCAddress                                      1.0        XChain
Function        Get-XCAsset                                        1.0        XChain
Function        Get-XCBalance                                      1.0        XChain
Function        Get-XCBet                                          1.0        XChain
Function        Get-XCBlock                                        1.0        XChain
Function        Get-XCBroadcast                                    1.0        XChain
Function        Get-XCBurn                                         1.0        XChain
Function        Get-XCCredit                                       1.0        XChain
Function        Get-XCDebit                                        1.0        XChain
Function        Get-XCDestruction                                  1.0        XChain
Function        Get-XCDispens                                      1.0        XChain
Function        Get-XCDispenser                                    1.0        XChain
Function        Get-XCDividend                                     1.0        XChain
Function        Get-XCHistory                                      1.0        XChain
Function        Get-XCHolder                                       1.0        XChain
Function        Get-XCIssuance                                     1.0        XChain
Function        Get-XCMarket                                       1.0        XChain
Function        Get-XCMarketHistory                                1.0        XChain
Function        Get-XCMarketOrder                                  1.0        XChain
Function        Get-XCMarketOrderBook                              1.0        XChain
Function        Get-XCMemoryPool                                   1.0        XChain
Function        Get-XCNetwork                                      1.0        XChain
Function        Get-XCOrder                                        1.0        XChain
Function        Get-XCOrderMatch                                   1.0        XChain
Function        Get-XCSend                                         1.0        XChain
Function        Get-XCSweep                                        1.0        XChain
Function        Get-XCTransaction                                  1.0        XChain
Function        Get-XCUtxo                                         1.0        XChain```
```

## Examples

### Dispenser information

List all dispensers

```PowerShell
Import-Module .\Module\XChain.psd1
Get-XCDispenser -Asset PEPECASH
```

List open dispensers

```PowerShell
Import-Module .\Module\XChain.psd1
Get-XCDispenser -Asset PEPECASH -Active
```

### Check address balance against [DABC](https://droolingapebus.club) directory

Check cards an address has:

```PowerShell
.\Scripts\Get-DabcBalance.ps1 -Address '15JiUKBuUS5S1mXhdYY2jL37eZXa2S3ve6' | ? Quantity -ne 0
```

```PowerShell
.\Scripts\Get-DabcBalance.ps1 -Address '15JiUKBuUS5S1mXhdYY2jL37eZXa2S3ve6' | ? Quantity -eq 0
```