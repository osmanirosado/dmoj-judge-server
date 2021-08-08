# Readme

## Initialization

Generate the environment files (.env) and the aliases.

```shell
bash setupenv.sh
```

Load the aliases in the current shell session

```shell
source bash_aliases
```

Or, install the aliases for the current user

```shell
cat < bash_aliases >> ~/.bash_aliases
```

## Build

Set the image tag in the file `.env` and build the judge image.

```shell
docker-compose build --pull
```

## Judge

Define the judge key in the `.env` file for the judge one 
and review the other environment variables.

```shell
cat judge1/.env 
```
```
IMAGE_TAG=latest

BRIDGE_ADDRESS=10.12.101.21

JUDGE_NAME=main-judge-1
JUDGE_KEY=

PROBLEMS_DIR=/mnt/dmoj/problems
```

Execute the judge in the background. 
The command `judge1dc` is an alias for the `docker-compose` command 
configured for the judge one.

```shell
judge1dc up -d
```

See the logs for the judge.

```shell
judge1dc logs -f
```
