##################################
#                                #
# Install Script Variables Block #
#                                #
##################################

$domain = "INSTALL_DOMAIN_VAR"


##################################
#                                #
# Do not change something below  #
#                                #
##################################

$part1 = '<!DOCTYPE html>
<html style="background: black">

<head>
    <title>IONOS Cert Generator</title>
</head>

<style>
    .h1_white {
        color: white
    }
    .center {
        margin: auto;
        width: 50%;
        border: 5px solid red;
        padding: 10px;
        text-align: center;

    }

    .myButton {
        background-color: #05aeef;
        border-radius: 28px;
        border: 1px solid #2b59c3;
        display: inline-block;
        cursor: pointer;
        color: #ffffff;
        font-family: Calibri;
        font-size: 25px;
        padding: 16px 31px;
        text-decoration: none;

    }

    .myButton:hover {
        background-color: #2b59c3;
    }

    .myButton:active {
        position: relative;
        top: 1px;
    }

</style>

<body>
    <div class="center">
        <h1 class="h1_white">
            Check Status
        </h1>
        <a href="/status"><input type="button" class="myButton" value="Status"></a><br><br>
'

$part2 = '    </div>
    <br>
    <br>
    <div class=center>
        <h1 class="h1_white">
            Generate Wildcard Certificates
        </h1>
        <a href="/generate_cert"><input type="button" class="myButton" value="Generate"></a>
        <br>
        <br>
    </div>
    <br>
    <br>
    <div class=center>
        <h1 class="h1_white">
            Download Certificates
        </h1>
        <a href="/download_certificate"><input type="button" class="myButton" value="Download all"></a>
        <a href="/download_pfx"><input type="button" class="myButton" value="Download .pfx"></a>
        <br>
        <br>
    </div>
</body>

</html>
'



$date_cert_pem = (Get-Item "/opt/letsencrypt/cert/live/$($domain)/cert.pem" | Select-Object -ExpandProperty LastWriteTime).toString("dd.MM.yyyy")
$date_chain_pem = (Get-Item "/opt/letsencrypt/cert/live/$($domain)/chain.pem" | Select-Object -ExpandProperty LastWriteTime).toString("dd.MM.yyyy")
$date_fullchain_pem = (Get-Item "/opt/letsencrypt/cert/live/$($domain)/fullchain.pem" | Select-Object -ExpandProperty LastWriteTime).toString("dd.MM.yyyy")
$date_privkey_pem = (Get-Item "/opt/letsencrypt/cert/live/$($domain)/privkey.pem" | Select-Object -ExpandProperty LastWriteTime).toString("dd.MM.yyyy")

if('/opt/web_cert/templates/index.html'){
        Remove-Item '/opt/web_cert/templates/index.html'
}

    $out_cert_pem = '<p style="color: lawngreen">Cert.pem: Created on ',$date_cert_pem,'.</p>'

    $out_chain_pem = '<p style="color: lawngreen">Chain.pem: Created on ',$date_chain_pem,'.</p>'

    $out_fullchian_pem = '<p style="color: lawngreen">Fullchain.pem: Created on ',$date_fullchain_pem,'.</p>'

    $out_privkey_pem = '<p style="color: lawngreen">Privkey.pem: Created on ',$date_privkey_pem,'.</p>'


Write-Output $part1 >> '/opt/web_cert/templates/index.html'
Write-Output $out_cert_pem >> '/opt/web_cert/templates/index.html'
Write-Output $out_chain_pem >> '/opt/web_cert/templates/index.html'
Write-Output $out_fullchian_pem >> '/opt/web_cert/templates/index.html'
Write-Output $out_privkey_pem >> '/opt/web_cert/templates/index.html'
Write-Output $part2 >> '/opt/web_cert/templates/index.html'
