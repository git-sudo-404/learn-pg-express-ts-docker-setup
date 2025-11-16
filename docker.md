### Basic docker commands

##### Build an image

-     docker build -t <image_name> .

##### Run a container based on the image

-     docker run --name <container_name>
      -p <host_port>:<container_port>
      -e <environment_variables>=<env_variable_value>
      <image_name>

##### View all running container

-     docker ps
- (or)
-     docker container ls

##### View all container

-     docker container ls -a

##### View images

-     docker image ls

##### Remove/Delete an image

-     docker rmi <image_id>

##### Remove/Delete a container

-     docker rm <contianer_id>

##### View all volumes

-     docker volume ls

##### Delete all unused volumes

-     docker volume prune
