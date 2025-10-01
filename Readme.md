# Readme

Docker compose stack for running the [dmoj judge](https://github.com/DMOJ/judge-server).

## Initialization

1. Generate the configuration file `judges.conf`

    ```shell
    bash setup-judges-config.sh
    ```

2. Generate the files of each judge instance

    ```shell
    bash init-judges-files.sh
    ```

3. Show the project directory tree to see the new files  

    ```shell
    tree -a -I .git .
    ```

   Using `-a` to show hidden files and `-I` to ignore the git hidden directory.

4. Load the aliases in the current shell session

    ```shell
    source bash_aliases
    ```

    For example, the alias `arcadia1dc` allows the execution of the 
    `docker compose` command in the environment of the judge one.

## Build

1. Build the judge image

    ```shell
    docker compose build
    ```

2. Run the judge tests

    ```shell
    docker compose run --rm app test
    ```

    This command runs the available tests for each language run time. 

3. Tag the latest image as active

    ```shell
    bash tag-latest-image-as-active.sh
    ```

## Judge

1. Define the judge key in the `.key` file and 
review the environment variables in the `.env` file.

    ```shell
    nano dmoj/judge1/.key
    ```

2. Review the environment variables substitution in the docker compose.

    ```shell
    source bash_aliases 
    arcadia1dc config
    ```

3. Execute the judge, the `-d` option runs it in the background.

    ```shell
    arcadia1dc up -d
    ```

4. See the logs for the judge, the `-f` option waits for the judge output. 

    ```shell
    arcadia1dc logs -f
    ```

## Recreate the judges

1. Tag the latest image as active.

    ```shell
    bash tag-latest-image-as-active.sh
    ```

2. Recreate the judges to use the latest image.
    
    ```shell
    perl recreate-judges.pl
    ```
    
    If a judge is not running, it is starting during this process.
