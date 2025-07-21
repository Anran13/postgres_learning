## **Preprocessing 1** 
* Construct a container:
    * Install the **docker** (can download from  https://docs.docker.com/)

    * Construct a container for "miniconda" in **docker** and run

      Please enter the following command in Terminal 
    
      `docker run --platform linux/amd64 -it --name python-postgres -d roberthsu2003/conda_uv_npx`
    
      (https://github.com/roberthsu2003/python/tree/master/%E4%BD%BF%E7%94%A8Dock%E5%AE%B9%E5%99%A8%E9%96%8B%E7%99%BC)

* Visual Studio Code (VSCode)
    * Install VSCode (can be download from https://code.visualstudio.com/)

    * Install the packages:
        - [x] Container Tools
        - [x] Dev Containers

    * Link to Github
        * Open VSCode
        * Click package "Container Tools"
        * Right click --> Choose "attach ... "
        * Click file --> choose our github repository

        Note that for the first time to link to github account, enter the following commands in Terminal ("miniconda" container):

        ```js
        git config --global user.name "____"
        git config --global user.email "__@__.com"
        git config --global pull.rebase false
        python --version
        ```

        * Search **repository name** that we would like to modify in the search box and click it!
        * Congrats! We can finally modify the repository in VSCode.
        * Once **README.md** file is changed,  the **exclamation mark** in **Source Control** will show up!
        * Click **Changes** --> right click and choose **Stage All Changes** --> enter modified index in **Message box** --> click **Commit** --> click **Sync...**


## **Preprocessing 2** 
* Construct an environment for postgresSQL

    * Construct a container for "postgres" in **docker** and run

      Please enter the following command in Terminal 

      `docker run --name my-postgres -e POSTGRES_PASSWORD=yourpassword -p 5432:5432 -d postgres`

    * Install **DBeaver** (can download from  https://dbeaver.io/)
    * Open **DBeaver** and click "Create a new database connection"
    * Select PostgresSQL
    * Enter the database name **postgres** and the **password** corresponding to previous constructed container "postgres"
    * Click the database called **postgres** --> **Schemas** --> **public** --> **Tables**


## **Preprocessing 3** 

* Link to **Copilot**

    Please establish a file for MCP (model context protocol)

    Copy the following **.json** content and we'll see the **start** button.

    ```json
    {
     "servers": {
         "vscode_postgres": {
             "command": "npx",
             "args": [
                 "-y",
                 "@modelcontextprotocol/server-postgres",
                 "postgresql://postgres:raspberry@host.docker.internal:5432/postgres"
                 ]
             }
         },
     }
    ```
    Press **start** and we can finally link to our container (see [image](https://github.com/Anran13/postgres_learning/blob/main/image/copilot.png)).
    
    Choose the **Agent** and start querying some questions.

    **Note that we should be careful about avoiding linking the private database to Copilot!**
