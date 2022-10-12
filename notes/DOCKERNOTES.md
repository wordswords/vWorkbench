## Images

A Docker image is a template for a container. A Docker image is a stopped container.

### Image Registry

You start by pulling images from an image registry such as Docker Hub. The pull operation downloads the image to your local Docker host where you can use it to start one or more Docker containers.

### Docker image ls

This checks your local Docker host for any images in its local repository.

`docker image ls`

### Docker image pull <image>

This pulls a docker image down from a repository, usually DockerHub.

`docker image pull ubuntu:latest`

### Image naming and tagging

`docker image pull <repository>:<tag>`

Top level repositories are trusted in DockerHub, for example 'ubuntu'. Untrusted repos are denoted by an additional level, for example 'nigelpoulton/tu-demo'.

Tag can be `:latest` or `3.3.11` a version tag, or anything similar.

If you do not specify a tag, Docker will presume you are pulling the latest.

### Third party repos

If you're not using DockerHub, you need to prefix the image name with the third party container registry, for example, `docker pull gcr.io/nigelpoulton/tu-demo:latest`

### Multiple tags

A particular image can have multiple tags, for example v2 and latest.

### Dangling images

Dangling images are images with no tags. You can delete them with `docker image prune` command.

### Docker search <name>

You can search DockerHub by using `docker search <name>`. This will return all images with `<name>` in them.

### Docker image digests

They are the cryptographic hashes of the docker image - it's 'truename' aside from tags, which are mutable and can be misleading.

`docker image ls --digests ubuntu:latest`

This will list the digest for ubuntu-latest

## Layers

Layers are changes you make to the original image. They are deltas recorded in the storage driver, like database increments.

### docker image inspect <image>

`docker image inspect ubuntu:latest` will show you the layers in the image

### Sharing layers

Multiple images can and do share layers. This leads to efficiencies in space and performance.

When you see 'Already exists' in a docker pull, that means that layer already exists in your local repo so it is not needed to be fetched again.

## Containers

### Docker run

`docker run -it <image> <command>`

`docker run -it ubuntu:latest cat /etc/issue`

This will pull down `<image>` and run `<command>` on it. -it makes sure your local terminal is connected to the image.

### Killing the process in the container will also kill the containers

Use the keystroke combo `<Control>-PQ` to exit a container without terminating it. That container will still run and you can use`docker container ls` to view the list of running containers.

### Reattaching to a running container

`docker container exec -it <digest> bash`

This will reattach your terminal to it with a docker container exec command.

This will result in TWO processes being seen when you do a `docker container ls`. This is because the reattach created a separate bash process. Now existing that second process will not terminate the container because the first process will still be running.

### Stopping a container

`docker container stop <digest>`

This is equivalent to 'pausing' a virtual machine. The state of the machine is saved until you start it again.

### Removing a container

`docker container rm <digest>`

This is equivalent to deleting a virtual machine. The state is wiped and the next time you start it, it will only contain what is in the pre built image.

## Docker compose

Docker compose is used for running multiple containers at once, and defining the network around them. The default config file is outlined in docker-compose.yml file in the current directory.

### docker-compose up

This will start the multi container app from the instructions in docker-compose.yml

### docker-compose down

This will down all the docker containers. The machines and network might be terminated but the data stored in the volumes will persist.

### docker-compose stop

This is effectively the same as pausing the virtual machine or stopping a docker container.

### docker-compose ps

The current state of the app.

### docker-compose top

The status of the processes running inside of each service (docker container).
