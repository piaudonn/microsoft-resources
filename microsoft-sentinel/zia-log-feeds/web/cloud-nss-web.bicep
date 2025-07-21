 /* 
This creates both the DCR and DCE's needed to ingest data into Sentinel from Zscaler's Cloud NSS capability. 
Please replace any references to workspace names or resource groups with your deployment details.
Steps needed to deploy:
1. Create an App Registration as per the Deployment Guide or Storylane demo
2. Run this script from Azure CLI using the following command:

    az stack group create --name cloud-nss-web --resource-group <resource group containing your log analytics workspace> --template-file ./cloud-nss-web.bicep --deny-settings-mode 'none' --action-on-unmanage deleteResources

  You will be prompted for parameters such as the resource group name and workspace id. You can enter ? and press enter to get a description of where to find each item. 
  
  Alternatively, you can specify these parameters ahead of time by populating the cloud-nss-web.bicepparams file and running the following command in Azure CLI to deploy:

    az stack group create --name cloud-nss-web --resource-group <resource group containing your log analytics workspace> --parameters cloud-nss-web.bicepparam --deny-settings-mode 'none' --action-on-unmanage deleteResources

3. Go to the DCR this bicep template creates -> IAM -> Add this DCR as a Monitoring Metrics Publisher for the App Registration you created earlier.
4. Configure your Cloud NSS feed in the Zscaler Portal. You can retrieve the feed API URL using the following command in Azure CLI:

    az stack group show -g <resource group containing your log analytics workspace> -n cloud-nss-web --query outputs.api_url

5. If you ever need to delete the deployment, you can run the following command from Azure CLI:

    az stack group delete --name cloud-nss-web --resource-group <resource group containing your log analytics workspace> --delete-resources

*/ 
// These resources need to be pre-configured
@description('Found under Log Analytics workspace -> your workspace -> Overview -> Resource group')
param resourceGroup string // Found under Log Analytics workspace -> your workspace -> Overview -> Resource group
@description('The name of your Log Analytics workspace')
param workspaceName string
@description('Found under Log Analytics workspace -> your workspace -> Overview -> JSON View -> location. I.e. australiaeast')
param location string
@description('Found under Log Analytics workspace -> your workspace -> Overview -> Subscription ID')
param subscriptionId string
@description('Found under Log Analytics workspace -> your workspace -> Overview -> Workspace ID')
param workspaceId string

// These resources are configured through bicep
@description('Name of the Data Collection Rule the template will create')
param dcrName string

resource dcr 'Microsoft.Insights/dataCollectionRules@2023-03-11'' = {
  properties: {
    streamDeclarations: {
      'Custom-nss_web_CL': {
        columns: [
	{
	  name: 'sourcetype'
	  type: 'string'
	}
	{
	  name: 'TimeGenerated'
	  type: 'datetime'
	}
	{
	  name: 'vendor'
	  type: 'string'
	}
	{
	  name: 'product'
	  type: 'string'
	}
	{
	  name: 'version'
	  type: 'string'
	}
	{
	  name: 'act'
	  type: 'string'
	}
	{
	  name: 'Severity'
	  type: 'string'
	}
	{
	  name: 'name'
	  type: 'string'
	}
	{
	  name: 'deviceEventClassId'
	  type: 'string'
	}
	{
	  name: 'app'
	  type: 'string'
	}
	{
	  name: 'cat'
	  type: 'string'
	}
	{
	  name: 'dhost'
	  type: 'string'
	}
	{
	  name: 'dst'
	  type: 'string'
	}
	{
	  name: 'src'
	  type: 'string'
	}
	{
	  name: 'in_bytes'
	  type: 'string'
	}
	{
	  name: 'outcome'
	  type: 'string'
	}
	{
	  name: 'out'
	  type: 'string'
	}
	{
	  name: 'request'
	  type: 'string'
	}
	{
	  name: 'rt'
	  type: 'string'
	}
	{
	  name: 'sourceTranslatedAddress'
	  type: 'string'
	}
	{
	  name: 'requestClientApplication'
	  type: 'string'
	}
	{
	  name: 'requestMethod'
	  type: 'string'
	}
	{
	  name: 'suser'
	  type: 'string'
	}
	{
	  name: 'spriv'
	  type: 'string'
	}
	{
	  name: 'externalId'
	  type: 'string'
	}
	{
	  name: 'fileType'
	  type: 'string'
	}
	{
	  name: 'reason'
	  type: 'string'
	}
	{
	  name: 'destinationServiceName'
	  type: 'string'
	}
	{
	  name: 'cn1'
	  type: 'string'
	}
	{
	  name: 'cn1Label'
	  type: 'string'
	}
	{
	  name: 'cs1'
	  type: 'string'
	}
	{
	  name: 'cs1Label'
	  type: 'string'
	}
	{
	  name: 'cs2'
	  type: 'string'
	}
	{
	  name: 'cs2Label'
	  type: 'string'
	}
	{
	  name: 'cs3'
	  type: 'string'
	}
	{
	  name: 'cs3Label'
	  type: 'string'
	}
	{
	  name: 'cs4'
	  type: 'string'
	}
	{
	  name: 'cs4Label'
	  type: 'string'
	}
	{
	  name: 'cs5'
	  type: 'string'
	}
	{
	  name: 'cs5Label'
	  type: 'string'
	}
	{
	  name: 'cs6'
	  type: 'string'
	}
	{
	  name: 'cs6Label'
	  type: 'string'
	}
	{
	  name: 'ZscalerNSSWeblogURLClass'
	  type: 'string'
	}
	{
	  name: 'ZscalerNSSWeblogDLPDictionaries'
	  type: 'string'
	}
	{
	  name: 'requestContext'
	  type: 'string'
	}
	{
	  name: 'contenttype'
	  type: 'string'
	}
	{
	  name: 'unscannabletype'
	  type: 'string'
	}
	{
	  name: 'deviceowner'
	  type: 'string'
	}
	{
	  name: 'devicehostname'
	  type: 'string'
	}
	{
	  name: 'keyprotectiontype'
	  type: 'string'
	}
	{
	  name: 'cloudname'
	  type: 'string'
	}
	{
	  name: 'company'
	  type: 'string'
	}
	{
	  name: 'throttlereqsize'
	  type: 'string'
	}
	{
	  name: 'throttlerespsize'
	  type: 'string'
	}
	{
	  name: 'bwthrottle'
	  type: 'string'
	}
	{
	  name: 'bwclassname'
	  type: 'string'
	}
	{
	  name: 'bwrulename'
	  type: 'string'
	}
	{
	  name: 'module'
	  type: 'string'
	}
	{
	  name: 'app_risk_score'
	  type: 'string'
	}
	{
	  name: 'datacenter'
	  type: 'string'
	}
	{
	  name: 'datacentercity'
	  type: 'string'
	}
	{
	  name: 'datacentercountry'
	  type: 'string'
	}
	{
	  name: 'dlpdicthitcount'
	  type: 'string'
	}
	{
	  name: 'dlpidentifier'
	  type: 'string'
	}
	{
	  name: 'dlpmd5'
	  type: 'string'
	}
	{
	  name: 'dlprulename'
	  type: 'string'
	}
	{
	  name: 'fileclass'
	  type: 'string'
	}
	{
	  name: 'fname'
	  type: 'string'
	}
	{
	  name: 'filesubtype'
	  type: 'string'
	}
	{
	  name: 'upload_fileclass'
	  type: 'string'
	}
	{
	  name: 'upload_filetype'
	  type: 'string'
	}
	{
	  name: 'upload_filename'
	  type: 'string'
	}
	{
	  name: 'upload_filesubtype'
	  type: 'string'
	}
	{
	  name: 'upload_doctypename'
	  type: 'string'
	}
	{
	  name: 'rdr_rulename'
	  type: 'string'
	}
	{
	  name: 'fwd_type'
	  type: 'string'
	}
	{
	  name: 'fwd_gw_name'
	  type: 'string'
	}
	{
	  name: 'fwd_gw_ip'
	  type: 'string'
	}
	{
	  name: 'zpa_app_seg_name'
	  type: 'string'
	}
	{
	  name: 'reqdatasize'
	  type: 'string'
	}
	{
	  name: 'reqhdrsize'
	  type: 'string'
	}
	{
	  name: 'respdatasize'
	  type: 'string'
	}
	{
	  name: 'resphdrsize'
	  type: 'string'
	}
	{
	  name: 'totalsize'
	  type: 'string'
	}
	{
	  name: 'df_hosthead'
	  type: 'string'
	}
	{
	  name: 'df_hostname'
	  type: 'string'
	}
	{
	  name: 'erefererhost'
	  type: 'string'
	}
	{
	  name: 'refererpath'
	  type: 'string'
	}
	{
	  name: 'eurlpath'
	  type: 'string'
	}
	{
	  name: 'reqversion'
	  type: 'string'
	}
	{
	  name: 'respversion'
	  type: 'string'
	}
	{
	  name: 'ua_token'
	  type: 'string'
	}
	{
	  name: 'uaclass'
	  type: 'string'
	}
	{
	  name: 'mobappname'
	  type: 'string'
	}
	{
	  name: 'mobappcat'
	  type: 'string'
	}
	{
	  name: 'mobdevtype'
	  type: 'string'
	}
	{
	  name: 'clt_sport'
	  type: 'string'
	}
	{
	  name: 'cpubip'
	  type: 'string'
	}
	{
	  name: 'alpnprotocol'
	  type: 'string'
	}
	{
	  name: 'trafficredirectmethod'
	  type: 'string'
	}
	{
	  name: 'euserlocationname'
	  type: 'string'
	}
	{
	  name: 'erulelabel'
	  type: 'string'
	}
	{
	  name: 'ruletype'
	  type: 'string'
	}
	{
	  name: 'eurlfilterrulelabel'
	  type: 'string'
	}
	{
	  name: 'ourlfilterrulelabel'
	  type: 'string'
	}
	{
	  name: 'eapprulelabel'
	  type: 'string'
	}
	{
	  name: 'fileHash'
	  type: 'string'
	}
	{
	  name: 'sha256'
	  type: 'string'
	}
	{
	  name: 'ssldecrypted'
	  type: 'string'
	}
	{
	  name: 'externalspr'
	  type: 'string'
	}
	{
	  name: 'clientsslcipher'
	  type: 'string'
	}
	{
	  name: 'clienttlsversion'
	  type: 'string'
	}
	{
	  name: 'clientsslsessreuse'
	  type: 'string'
	}
	{
	  name: 'cltsslfailreason'
	  type: 'string'
	}
	{
	  name: 'cltsslfailcount'
	  type: 'string'
	}
	{
	  name: 'srvsslcipher'
	  type: 'string'
	}
	{
	  name: 'srvtlsversion'
	  type: 'string'
	}
	{
	  name: 'srvocspresult'
	  type: 'string'
	}
	{
	  name: 'srvcertchainvalpass'
	  type: 'string'
	}
	{
	  name: 'srvwildcardcert'
	  type: 'string'
	}
	{
	  name: 'serversslsessreuse'
	  type: 'string'
	}
	{
	  name: 'srvcertvalidationtype'
	  type: 'string'
	}
	{
	  name: 'srvcertvalidityperiod'
	  type: 'string'
	}
	{
	  name: 'is_ssluntrustedca'
	  type: 'string'
	}
	{
	  name: 'is_sslselfsigned'
	  type: 'string'
	}
	{
	  name: 'is_sslexpiredca'
	  type: 'string'
	}
	{
	  name: 'threatseverity'
	  type: 'string'
	}
	{
	  name: 'malwareclass'
	  type: 'string'
	}
	{
	  name: 'urlcatmethod'
	  type: 'string'
	}
	{
	  name: 'bypassed_traffic'
	  type: 'string'
	}
	{
	  name: 'bypassed_etime'
	  type: 'string'
	}
	{
	  name: 'deviceappversion'
	  type: 'string'
	}
	{
	  name: 'devicemodel'
	  type: 'string'
	}
	{
	  name: 'devicename'
	  type: 'string'
	}
	{
	  name: 'deviceostype'
	  type: 'string'
	}
	{
	  name: 'devicetype'
	  type: 'string'
	}
	{
	  name: 'external_devid'
	  type: 'string'
	}
	{
	  name: 'flow_type'
	  type: 'string'
	}
	{
	  name: 'ztunnelversion'
	  type: 'string'
	}
	{
	  name: 'productversion'
	  type: 'string'
	}
	{
	  name: 'nsssvcip'
	  type: 'string'
	}
      ] 
    }
  }
  dataSources: {}
  destinations: {
    logAnalytics: [
      {
        workspaceResourceId: resourceId(subscriptionId, resourceGroup, 'microsoft.operationalinsights/workspaces', workspaceName)
        name: workspaceId
      }
    ]
  }
  dataFlows: [
    {
      streams: [
        'Custom-nss_web_CL'
      ]
      destinations: [
        workspaceId
      ]
        transformKql: 'source | project TimeGenerated, DeviceVendor=tostring(vendor), DeviceProduct=tostring(product), DeviceVersion=tostring(version), DeviceAction=tostring(act), LogSeverity=tostring(Severity), Activity=tostring(name), DeviceEventClassID=tostring(deviceEventClassId), ApplicationProtocol=tostring(app), DeviceEventCategory=tostring(cat), DestinationHostName=tostring(dhost), DestinationIP=tostring(dst), SourceIP=tostring(src), ReceivedBytes=tolong(in_bytes), EventOutcome=tostring(outcome), SentBytes=tolong(out), RequestURL=tostring(request), ReceiptTime=tostring(rt), SourceTranslatedAddress=tostring(sourceTranslatedAddress), RequestClientApplication=tostring(requestClientApplication), RequestMethod=tostring(requestMethod), SourceUserName=tostring(suser), SourceUserPrivileges=tostring(spriv), ExtID=tostring(externalId), FileType=tostring(fileType), Reason=tostring(reason), DestinationServiceName=tostring(destinationServiceName), DeviceCustomNumber1=toint(cn1), DeviceCustomNumber1Label=tostring(cn1Label), DeviceCustomString1=tostring(cs1), DeviceCustomString1Label=tostring(cs1Label), DeviceCustomString2=tostring(cs2), DeviceCustomString2Label=tostring(cs2Label), DeviceCustomString3=tostring(cs3), DeviceCustomString3Label=tostring(cs3Label), DeviceCustomString4=tostring(cs4), DeviceCustomString4Label=tostring(cs4Label), DeviceCustomString5=tostring(cs5), DeviceCustomString5Label=tostring(cs5Label), DeviceCustomString6=tostring(cs6), DeviceCustomString6Label=tostring(cs6Label), RequestContext=tostring(requestContext), FileName=tostring(fname), FileHash=tostring(fileHash), AdditionalExtensions = strcat("ZscalerNSSWeblogURLClass=",ZscalerNSSWeblogURLClass,";ZscalerNSSWeblogDLPDictionaries=",ZscalerNSSWeblogDLPDictionaries,";contenttype=",contenttype,";unscannabletype=",unscannabletype,";deviceowner=",deviceowner,";devicehostname=",devicehostname,";keyprotectiontype=",keyprotectiontype,";cloudname=",cloudname,";company=",company,";throttlereqsize=",throttlereqsize,";throttlerespsize=",throttlerespsize,";bwthrottle=",bwthrottle,";bwclassname=",bwclassname,";bwrulename=",bwrulename,";module=",module,";app_risk_score=",app_risk_score,";datacenter=",datacenter,";datacentercity=",datacentercity,";datacentercountry=",datacentercountry,";dlpdicthitcount=",dlpdicthitcount,";dlpidentifier=",dlpidentifier,";dlpmd5=",dlpmd5,";dlprulename=",dlprulename,";fileclass=",fileclass,";filesubtype=",filesubtype,";upload_fileclass=",upload_fileclass,";upload_filetype=",upload_filetype,";upload_filename=",upload_filename,";upload_filesubtype=",upload_filesubtype,";upload_doctypename=",upload_doctypename,";rdr_rulename=",rdr_rulename,";fwd_type=",fwd_type,";fwd_gw_name=",fwd_gw_name,";fwd_gw_ip=",fwd_gw_ip,";zpa_app_seg_name=",zpa_app_seg_name,";reqdatasize=",reqdatasize,";reqhdrsize=",reqhdrsize,";respdatasize=",respdatasize,";resphdrsize=",resphdrsize,";totalsize=",totalsize,";df_hosthead=",df_hosthead,";df_hostname=",df_hostname,";erefererhost=",erefererhost,";refererpath=",refererpath,";eurlpath=",eurlpath,";reqversion=",reqversion,";respversion=",respversion,";ua_token=",ua_token,";uaclass=",uaclass,";mobappname=",mobappname,";mobappcat=",mobappcat,";mobdevtype=",mobdevtype,";clt_sport=",clt_sport,";cpubip=",cpubip,";alpnprotocol=",alpnprotocol,";trafficredirectmethod=",trafficredirectmethod,";euserlocationname=",euserlocationname,";erulelabel=",erulelabel,";ruletype=",ruletype,";eurlfilterrulelabel=",eurlfilterrulelabel,";ourlfilterrulelabel=",ourlfilterrulelabel,";eapprulelabel=",eapprulelabel,";sha256=",sha256,";ssldecrypted=",ssldecrypted,";externalspr=",externalspr,";clientsslcipher=",clientsslcipher,";clienttlsversion=",clienttlsversion,";clientsslsessreuse=",clientsslsessreuse,";cltsslfailreason=",cltsslfailreason,";cltsslfailcount=",cltsslfailcount,";srvsslcipher=",srvsslcipher,";srvtlsversion=",srvtlsversion,";srvocspresult=",srvocspresult,";srvcertchainvalpass=",srvcertchainvalpass,";srvwildcardcert=",srvwildcardcert,";serversslsessreuse=",serversslsessreuse,";srvcertvalidationtype=",srvcertvalidationtype,";srvcertvalidityperiod=",srvcertvalidityperiod,";is_ssluntrustedca=",is_ssluntrustedca,";is_sslselfsigned=",is_sslselfsigned,";is_sslexpiredca=",is_sslexpiredca,";threatseverity=",threatseverity,";malwareclass=",malwareclass,";urlcatmethod=",urlcatmethod,";bypassed_traffic=",bypassed_traffic,";bypassed_etime=",bypassed_etime,";deviceappversion=",deviceappversion,";devicemodel=",devicemodel,";devicename=",devicename,";deviceostype=",deviceostype,";devicetype=",devicetype,";external_devid=",external_devid,";flow_type=",flow_type,";ztunnelversion=",ztunnelversion,";productversion=",productversion,";nsssvcip=",nsssvcip)'
        outputStream: 'Microsoft-CommonSecurityLog'
      }
  
      // 
    ]
  }
  location: location
  kind: 'Direct'
  name: dcrName
}

// Store feed api url in template output
output api_url string = '${dcr.properties.endpoints.logsIngestion}/dataCollectionRules/${dcr.properties.immutableId}/streams/Custom-nss_web_CL?api-version=2021-11-01-preview'
