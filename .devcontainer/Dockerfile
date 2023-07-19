FROM nickblah/lua:5-luarocks

RUN apt-get update && apt-get install -y build-essential git libssl-dev m4 sudo

RUN useradd vscode -m -s /bin/bash && usermod -aG sudo vscode && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode
