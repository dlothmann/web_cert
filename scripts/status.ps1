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
<html style="background: #F0F7EE">

<head>
    <title>IONOS Cert Generator</title>
</head>

<style>
    .h1_white {
        color: #698996
    }

    .center {
        margin: auto;
        width: 50%;
        border: 2px solid #102542;
        padding: 10px;
        text-align: center;
        border-radius: 30px;

    }

    .pushable {
        position: relative;
        border: none;
        background: transparent;
        padding: 0;
        cursor: pointer;
        outline-offset: 4px;
        transition: filter 250ms;
    }

    .shadow {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border-radius: 12px;
        background: hsl(0deg 0% 0% / 0.25);
        will-change: transform;
        transform: translateY(2px);
        transition:
            transform 600ms cubic-bezier(.3, .7, .4, 1);
    }

    .edge {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border-radius: 12px;
        background: linear-gradient(to left,
                hsl(340deg 100% 16%) 0%,
                hsl(340deg 100% 32%) 8%,
                hsl(340deg 100% 32%) 92%,
                hsl(340deg 100% 16%) 100%);
    }

    .front {
        display: block;
        position: relative;
        padding: 12px 42px;
        border-radius: 12px;
        font-size: 1.25rem;
        color: white;
        background: hsl(345deg 100% 47%);
        will-change: transform;
        transform: translateY(-4px);
        transition:
            transform 600ms cubic-bezier(.3, .7, .4, 1);
    }

    .pushable:hover {
        filter: brightness(110%);
    }

    .pushable:hover .front {
        transform: translateY(-6px);
        transition:
            transform 250ms cubic-bezier(.3, .7, .4, 1.5);
    }

    .pushable:active .front {
        transform: translateY(-2px);
        transition: transform 34ms;
    }

    .pushable:hover .shadow {
        transform: translateY(4px);
        transition:
            transform 250ms cubic-bezier(.3, .7, .4, 1.5);
    }

    .pushable:active .shadow {
        transform: translateY(1px);
        transition: transform 34ms;
    }

    .pushable:focus:not(:focus-visible) {
        outline: none;
    }

</style>

<body>
    <div class="center">
        <h1 class="h1_white">
            Check Status
        </h1>

        <a href="/status">

            <button class="pushable">
                <span class="shadow"></span>
                <span class="edge"></span>
                <span class="front">
                    Check Status
                </span>
            </button>
        </a>
'

$part2 = '    </div>
    <br>
    <br>
    <div class=center>
        <h1 class="h1_white">
            Generate Wildcard Certificates
        </h1>
        <a href="/generate_cert">
            <button class="pushable">
                <span class="shadow"></span>
                <span class="edge"></span>
                <span class="front">
                    Generate
                </span>
            </button></a>
        <br>
        <br>
    </div>
    <br>
    <br>
    <div class=center>
        <h1 class="h1_white">
            Download Certificates
        </h1>
        <a href="/download_certificate">
            <button class="pushable">
                <span class="shadow"></span>
                <span class="edge"></span>
                <span class="front">
                    Download All
                </span>
            </button></a>
        <a href="/download_pfx">
            <button class="pushable">
                <span class="shadow"></span>
                <span class="edge"></span>
                <span class="front">
                    Download .pfx
                </span>
            </button></a>
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

    $out_cert_pem = '<p style="color: #102542">Cert.pem: Created on ',$date_cert_pem,'.</p>'

    $out_chain_pem = '<p style="color: #102542">Chain.pem: Created on ',$date_chain_pem,'.</p>'

    $out_fullchian_pem = '<p style="color: #102542">Fullchain.pem: Created on ',$date_fullchain_pem,'.</p>'

    $out_privkey_pem = '<p style="color: #102542">Privkey.pem: Created on ',$date_privkey_pem,'.</p>'


Write-Output $part1 >> '/opt/web_cert/templates/index.html'
Write-Output $out_cert_pem >> '/opt/web_cert/templates/index.html'
Write-Output $out_chain_pem >> '/opt/web_cert/templates/index.html'
Write-Output $out_fullchian_pem >> '/opt/web_cert/templates/index.html'
Write-Output $out_privkey_pem >> '/opt/web_cert/templates/index.html'
Write-Output $part2 >> '/opt/web_cert/templates/index.html'
