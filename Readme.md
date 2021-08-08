# Readme

Docker compose stack for running the [dmoj judge](https://github.com/DMOJ/judge-server).

## Initialization

1. Generate the environment files (`.env`) and the aliases.

```shell
bash setupenv.sh
```

2. Show the project directory tree to see the new files created 
by the `setupenv.sh` script. 
Using `-a` to show hidden files and `-I` to ignore the git hidden directory. 

```shell
tree -a -I .git .
```

3. Load the aliases in the current shell session

```shell
source bash_aliases
```

Or, install the aliases for the current user

```shell
cat < bash_aliases >> ~/.bash_aliases
```

For example, the alias `judge1dc` allows the execution of the 
`docker-compose` command in the environment of the judge one.

## Build

1. Build the judge image. If you want to change the image tag,
modify the environment variable in the `.env` file.

```shell
docker-compose build --pull
```

2. Run the judge tests.

```shell
docker-compose run app test
```

This command runs the available tests for each language run time. 

## Judge

1. Define the judge key in the `.env` file for the judge one 
and review the other environment variables.

```shell
nano judge1/.env 
```

2. Review the environment variables substitution in the docker compose.

```shell
judge1dc config
```

3. Execute the judge, the `-d` option runs it in the background.

```shell
judge1dc up -d
```

4. See the logs for the judge, the `-f` option waits for the judge output. 

```shell
judge1dc logs -f
```
