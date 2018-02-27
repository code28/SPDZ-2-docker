# SPDZ-2-docker

This is a repository offering to use [SPDZ-2](https://github.com/bristolcrypto/SPDZ-2) via Docker.


## Installation

You need to have [Docker](https://www.docker.com) installed.

For getting the image you can either use the [Docker Hub](https://hub.docker.com/r/code28/spdz-2/):
```
docker pull code28/spdz-2
```

or build the image from the `Dockerfile`:
```
docker build -t code28/spdz-2:latest .
```

#### Insecure offline phase

For benchmarking only the online phase, you can use the `insecure` build parameter:
```
docker build --build-arg insecure=true -t code28/spdz-2:insecure .
```

Alternatively from Docker Hub:
```
docker pull code28/spdz-2:insecure
```


## Usage

```
docker run -it code28/spdz-2
```
or
```
docker run -it code28/spdz-2:insecure
```

## Licence

The `Dockerfile` is licenced under the MIT Licence, see `LICENCE` file.  
For the submodule [SPDZ-2](https://github.com/bristolcrypto/SPDZ-2) see `Licence.txt` file inside that repository.
