## How to run this init.sql using docker commands ?

#### Build the image

-     docker build -t <image_name> .

#### Running the container

-      docker run --name <container_name>
                  -e POSTGRES_USER=<username>
                  -e POSTGRES_PASSWORD=<password>
                  -e POSTGRES_DB=<database_name>
                  -p 5432:5432
                  --rm
                  -d
                  <image_name>

* _-rm flag is used so that the container is deleted after stopped._

- _-d flag to run detatched from the current terminal._
  -NOTE:_Image name must come after all the flags like -e,-d,--rm,...
  and also note that it is -- for rm , if used a single - , then it is interpreted as -r and -m_

#### Adding database & Seeding

- Have the sql commands for table creation and indexing and views in .sql file ,
  along with the insert commands for seeding / working with sample data during devleopment.

- In the Dockerfile add the following line :
-      COPY ./init.sql docker-entrypoint-initdb.d/
- _docker-entrypoint-initdb.d/_ is a folder , and all the sql files in it will be executed automatically when the container is built from the image .
- _NOTE_ : The sql will be executed in alphabetical order.

#### Execurting psql directly from the Host machine directly .

-     docker exec -it <container_name> psql -U <pg_user> <pg_db>

#### What happens when i make changes to the init.sql ?

- Since the .sql files in the docker-entrypoint-initdb/ are executed once , we don't wanna do that if the init.sql is gonna keep changing.
- A couple of way are there to solve this :
- > 1. copy the init.sql to tmp/ and executing it via the interactive psql
- > 2. use volumes and sync the init.sql from the host machine and the container

#### 1) Copying init.sql manually and running using \i in psql

- This method works but it is != deleting and reconstructing the db
- So, if there are some tables already created they will be there , and if your init.sql tries to create an existing table again then it'll throw error pretty much like any other normal dbms server running on your machine .
- _Then WHY this method?_
- If you get any errors while creating the database from init.sql and needs a quick fix just do the below steps :
- COPY the init.sql to the tmp folder (can use any folder , but tmp has no permission issues so just copy it there )
-                 docker cp ./init.sql pgcont:/tmp/init.sql
- Activate the psql interactive terminal
-                 docker exec -it pgcont psql -U <user_name> <database_name>
- Then load the init.sql using \i - "include" / "import"
-                 \i /tmp/init.sql
- enter \q to exit the interactive psql

* NOTE: This method does not rebuild or rerun the container.

#### 2) Using volumes
