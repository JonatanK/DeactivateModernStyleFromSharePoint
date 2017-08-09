# É necessário realizar o download do SharePoint Online Management Shell
write-host "Carregando as DLLs..." -Foreground Green
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.Runtime.dll"
write-host "Ok!" -Foreground Green

$siteUrl = "https://seudominio.sharepoint.com/sites/meusite"
$user = Read-Host -Prompt ("Informe o email do usuario administrador do site " + $siteUrl)
$pass = Read-Host -Prompt "Insira a senha para $user" -AsSecureString

write-host "Autenticando..." -Foreground Green
[Microsoft.SharePoint.Client.ClientContext]$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($user, $pass)
write-host "Ok!" -Foreground Green

$site = $ctx.Site;
$ctx.load($site);
# Feature que deve ser ativada para retornar ao estilo "Classic" do SharePoint
write-host "Processando..." -Foreground Green
$guid = new-object System.Guid "E3540C7D-6BEA-403C-A224-1A12EAFEE4C4"
$site.Features.Add($guid, $true, [Microsoft.SharePoint.Client.FeatureDefinitionScope]::None);
$ctx.ExecuteQuery();
write-host "Ok!" -Foreground Green
read-host "Processo finalizado, pressione qualquer tecla para sair..."
