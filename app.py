from flask import Flask, render_template, send_file

app = Flask(__name__)

@app.route("/")
def home():
    return render_template('index.html')

@app.route("/generate_cert")
def get_ses():
    import os
    os.system("sh /opt/web_cert/scripts/docker.sh")
    return render_template('index.html')

@app.route("/status")
def status():
    import os
    os.system("pwsh /opt/web_cert/scripts/status.ps1")
    return render_template('index.html')

@app.route("/download_certificate")
def down_cert():
    import os
    os.system("sh /opt/web_cert/scripts/zip_up.sh")
    path = "/tmp/INSTALL_DOMAIN_VAR_Cert_ALL.tar.gz"
    return send_file(path, as_attachment=True)

@app.route("/download_pfx")
def down_pfx():
    import os
    os.system("sh /opt/web_cert/scripts/create_pfx.sh")
    path = "/tmp/wildcard.INSTALL_DOMAIN_VAR_Cert_PFX.tar.gz"
    return send_file(path, as_attachment=True)
if __name__ == '__main__':
    app.run()
