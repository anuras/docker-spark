#!/bin/bash

mkdir -p /root/airflow/dags/
cp /spark-flow/spark.py /root/airflow/dags/
airflow initdb
wait %1
airflow connections --add --conn_id spark_docker --conn_host spark://master:7077 --conn_type None #refers to spark master in docker-compose
airflow webserver -p 8082 &> /dev/null &
airflow unpause spark
airflow scheduler