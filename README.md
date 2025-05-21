# reposcanner

### Purpose
The goal of this Dockerfile is to generate a docker container that, upon launch, will
check out a go repo you supply, scan the module dependencies and generate
a report indicating which libraries in the supply chain have vulenrabilities
that have not been fixed.

### Building
Building this container is simple.  In the directory containing the Dockerfile,
run the following command:

```docker build -t reposcanner:latest .```

### Running
To launch the container, create a local folder on your docker host called "docs"
(referred to here as <docsfolder>) and run the following command:

```docker run -it -v <docsfolder>:/docs --env repo="<github-repo>" --name mrscanner reposcanner:demo /bin/bash```

where <github-repo> is the full https url of the github repository you would like to scan.
To scan the repo https://github.com/grafana/grafana with the folder /Users/houseofpwn/Documents as your
docs folder, run the following command:

```docker run -it -v /Users/houseofpwn/Documents:/docs --env repo="https://github.com/grafana/grafana" --name mrscanner reposcanner:demo /bin/bash```


### Output
After launch, the scanners will run and produce the following output:

1. Scanner results will print to the console
2. JSON files containing the data will output to the <docsfolder> folder.

