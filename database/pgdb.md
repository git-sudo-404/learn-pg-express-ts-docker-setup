## How to run this init.sql using docker commands ?

##### (Official Doc link)[https://docs.docker.com/guides/pre-seeding/]

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

-     docker run --name <container_name>
                  -p 5432:5432
                  -e POSTGRES_DB=<database_name>
                  -e POSTGRES_USER=<username>
                  -e POSTGRES_PASSWORD=<password>
                  -v "<volume_name>:/var/lib/postgresql/data"
                  <image_name>
- _/var/lib/postgresql/data_ -- this is where the postgresql by default looks into , the tables and the user data anol are stored here .

#### How to work with development :

- There are 2 - stages with regards to database
- i) development of the init.sql to create tables and seed the data
- ii) development of the backend once the init.sql is created and seeded succwssfully.

##### _i) For the development of the init.sql_

- use the docker-compose.db.yaml

##### ii) _For the development of the rest of the app once the db is setup_

- use teh docker-compose.dev.yaml

### Using docker-compose.db.yaml

##### _volumes vs bind mounts in docker-compose:_

- in docker compose the volumes refer to the generics , and not the "volume"
- when you specify
-       services:
          db:
            image: postgres

            volumes:
              - ./init.sql:/docker-entrypoint-initdb.d/

- here _./init.sql:/docker-entrypoint-initdb.d/_ acts as a bind mount

* when you specify
*       services:
          db:
            images: postgres

          volumes:
            - pg_data_sql:/var/lib/postgresql/data

        volumes:
          pg_data_sql:

* here _- pg_data_sql:/var/lib/postgresql/data_ acts a volume ;

* anyting that starts woth _/_ or _./_ acts as bind mount and when it starts with some name like _data_sql_ it is a volume
