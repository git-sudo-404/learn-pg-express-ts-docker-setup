### How to run this init.sql using docker commands ?

##### Build the image

-     docker build -t <image_name> .

##### Running the container

-      docker run --name <container_name>
                  -e POSTGRES_USER=<username>
                  -e POSTGRES_PASSWORD=<password>
                  -e POSTGRES_DB=<database_name>
                  -p 5432:5432
                  -rm

* _-rm flag is used so that the container is deleted after stopped._
