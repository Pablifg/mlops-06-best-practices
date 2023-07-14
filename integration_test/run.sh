#!/usr/bin/env bash

cd "$(dirname "$0")"

export INPUT_FILE_PATTERN="s3://nyc-duration/in/{year:04d}-{month:02d}.parquet"
export OUTPUT_FILE_PATTERN="s3://nyc-duration/out/{year:04d}-{month:02d}.parquet"
export S3_ENDPOINT_URL="http://localhost:4566"
export AWS_ACCESS_KEY_ID=tests
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=ca-central-1

docker-compose up -d

sleep 2

aws --endpoint-url=${S3_ENDPOINT_URL} \
    s3 mb s3://nyc-duration

pipenv run python integration_test.py

ERROR_CODE=$?

if [ $(ERROR_CODE) != 0 ]; then
    docker-compose logs
    docker-compose down
    exit $(ERROR_CODE)
fi

cd ../

pipenv run python batch.py 2022 1

aws --endpoint-url=${S3_ENDPOINT_URL} \
    s3 ls --recursive s3://nyc-duration

ERROR_CODE=$?

if [ ${ERROR_CODE} != 0 ]; then
    docker-compose logs
    docker-compose down
    exit ${ERROR_CODE}
fi


docker-compose down