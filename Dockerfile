# Download golang container
FROM golang:latest

# Update Ubuntu software repository
RUN apt-get update
RUN ln -fs /usr/share/zoneinfo/America/Denver /etc/localtime
RUN echo "#!/bin/bash\\napt-get update && apt-get -y install jq python3-colorama; mkdir /repos && cd /repos && git clone https://github.com/houseofpwn/depvulnanalyzer && git clone https://github.com/houseofpwn/gomod2json && git clone https://github.com/grafana/grafana && go install golang.org/x/vuln/cmd/govulncheck@latest && git clone https://github.com/houseofpwn/govulnreport && cd /repos/grafana/ && govulncheck  -scan package -json ./... | jq -s > /docs/vulns.json ; cd /repos/gomod2json && find ../grafana -type f -name \"*.mod\" | grep -v \"/\.\" |  while read line; do python3 gomod2json.py \"\$line\" \"/docs/deps.json\";  done; cd /repos/govulnreport/ && python3 govulnreport.py /docs/vulns.json /docs && cd /repos/depvulnanalyzer/ && python3 depvulnanalyzer.py /docs/deps.json /docs/notfixed.json; /bin/bash" > /startup.sh 
RUN chmod a+rx /startup.sh
RUN cat /startup.sh
ENTRYPOINT ["/startup.sh"]
