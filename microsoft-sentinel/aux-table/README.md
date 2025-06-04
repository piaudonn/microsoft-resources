# ZIA Log Ingestion Helper

This repository contains **`main.py`**, a small utility for teams sending
Zscaler Internet Access (ZIA) firewall logs to **Azure Log Analytics** via a
**Data Collection Rule (DCR)**.

| What it does | Why you want it |
|--------------|-----------------|
| **1&nbsp;· Create an Auxiliary Table**<br>Generates a PowerShell script that creates a **Log Analytics _Aux_ table** (cheaper, long-term storage) tailored to the schema in your Bicep template. | Keeps seven-years (or more) of raw ZIA logs at a fraction of the cost of the main workspace. |
| **2 · Patch your DCR Bicep**<br>Adds a *secondary* `dataFlow` so the same stream that lands in **Microsoft-CommonSecurityLog** is also copied into the new Aux table—no extra agents or diagnostics settings required. | One ingestion path, two storage tiers. Zero manual edits. |

---

## Prerequisites

| Requirement | Notes |
|-------------|-------|
| **Python 3.8+** | Runs the helper script. |
| **Azure CLI** (`az`) | Needed by the generated PowerShell script. |
| **PowerShell 7** | Cross-platform execution of the `*_createRawTable.ps1` script. |
| **Contributor / Log Analytics Contributor** on the target resource group | Allows table creation and DCR deployment. |

---

## Quick Start

1. **Patch the Bicep and generate the create-table helper**

   ```bash
   python3 main.py cloud-nss-fw.bicep --table-name cloudnssfw_CL
   ```

   *Uses the ZIA firewall log feed and sample resource-group / workspace  
   names. Adjust as needed; the table name **must** still end with `_CL`.*

2. **Run the helper PowerShell script once to create the Aux table**

   ```powershell
   pwsh ./cloud-nss-fw_createAuxTable.ps1
   ```

3. **Deploy your (now patched) DCR as usual**

   ```bash
   az stack group create \
     --name cloud-nss-fw \
     --resource-group rg-sentinel-cloud-fw \
     --parameters cloud-nss-fw.bicepparam \
     --deny-settings-mode none \
     --action-on-unmanage deleteResources
   ```


