# IONOS Certificate Generator
Simple implementation for generating SSL wildcard certificates with IONOS API.

Based on this [article](https://medium.com/devlix-blog/automate-lets-encrypt-wildcard-certificate-creation-with-ionos-dns-rest-api-d66c3b3ddc9c)
German Version [here](https://www.devlix.de/lets-encrypt-wildcard-zertifikate-mit-ionos-dns-api-erzeugen/)
---


## Requirements for install script
```
sudo apt-get install -y sed
```
## Installation

1. Clone repository to ``/opt/``
2. ```
   sudo su
   cd /opt/web_cert
   chmod +x install.sh
   ```
3. ```./install.sh```


# Works on
![Static Badge](https://img.shields.io/badge/Ubuntu-22.04LTS-green)



## TODO's
- [ ] Replace poweshell script with bash
- [ ] Clear up installation script