# CloudTune

## Installation

To build the cloudtune images from the Dockerfiles, run the commands:

```docker build -t icecast:latest ./docker-icecast/```

```docker build -t ices:latest ./docker-ices/```

The generated docker images can be run with the commands:

```docker run -d -p 8000:8000 icecast:latest```

```docker run -d -p 8001:8001 ices:latest```

You can deploy the images to Kubernetes with the command:

```kubectl create -f docker-icecast/deploy -f docker-ices/deploy -f docker-frontend/deploy```

**NOTES**

- Early development limitations
  - OGG files must be placed in docker-ices/data/ folder

**TODO**

- Create PVC for OGG files
- Modify front-end to add OGG files
- Modify front-end to allow playlist reloads
- Modify configuration files to act as templates
