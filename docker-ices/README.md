# Optimis Iguana Integration Engine

## Installation

To build the optimis-iguana image from the Dockerfile, run the command:
```docker build -t optimis-iguana .```

The generated docker image optimis-iguana can be run with the command:
```docker run -d -p 6543:6543 -p 6544:6544 optimis-iguana```

**NOTES**
- This only builds a base Iguana installation, that means:
  - There is no license
  - There are no configuration files
  - There are no channels
- The DB connectors are installed but the MySQL connector is not auto-detected, it's located at /usr/lib64/mysql/libmysqlclient.so.18.0.0

**TODO**
- Automate licensing
- Create gitlab repositories for channel configurations
- Create persistant volume for storage
