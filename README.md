RocketMQ_exporter
==============

RocketMQ exporter for Prometheus.

Table of Contents
-----------------
-	[Compatibility](#compatibility)
-   [Dependency](#dependency)
-   [Download](#download)
-   [Compile](#compile)
	-   [Build Binary](#build-binary)
	-   [Build Docker Image](#build-docker-image)
-   [Run](#run)
	-   [Run Binary](#run-binary)
	-   [Run Docker Image](#run-docker-image)
-   [Metrics](#metrics)
	-   [Brokers](#brokers)
	-   [Topics](#topics)
	-   [Consumer Groups](#consumer-groups)
-   [Contribute](#contribute)

Compatibility
-------------

Support [Apache RocketMQ](https://rocketmq.apache.org) version 4.3.2 (and later).

Dependency
----------

-	[Prometheus](https://prometheus.io)

Download
--------

source code  can be downloaded from [github](https://github.com/hdchen/rocketmq-exporter ) page.

Compile
-------

### Build Binary

```shell
mvn clean install
```

### Build Docker Image

```shell
mvn package -Dmaven.test.skip=true docker:build
```


It can be used directly instead of having to build the image yourself. ([Docker Hub breezecoolyang/rocketmq-exporter](https://cloud.docker.com/repository/docker/breezecoolyang/rocketmq-exporter)\)

Run
---

### Run Binary

```shell
java -jar rocketmq-exporter-0.0.1-SNAPSHOT.jar
```

### Run Docker Image

```
docker container run -itd --rm  -p 5561:5557  breezecoolyang/rocketmq-exporter 
```

Metrics
-------

Documents about exposed Prometheus metrics.

### Broker 

**Metrics details**

| Name         | Exposed information                                  |
| ------------ | ---------------------------------------------------- |
| `broker_tps` | total put message numbers per second for this broker |
| `broker_qps` | total get message numbers per second for this broker |

**Metrics output example**

```txt
# HELP broker_tps BrokerPutNums
# TYPE broker_tps gauge
broker_tps{cluster="MQCluster",broker="broker-a",} 7.933333333333334
broker_tps{cluster="MQCluster",broker="broker-b",} 7.916666666666667
# HELP broker_qps BrokerGetNums
# TYPE broker_qps gauge
broker_qps{cluster="MQCluster",broker="broker-a",} 8.2
broker_qps{cluster="MQCluster",broker="broker-b",} 8.15
```

### Topics

**Metrics details**

| Name                | Exposed information                                |
| ------------------- | -------------------------------------------------- |
| `producer_tps`      | sending messages number per second  for this topic |
| `producer_put_size` | sending messages size per second  for this topic   |
| `producer_offset`   | Current Offset of a Broker for this topic          |

**Metrics output example**

```txt
# HELP producer_tps TopicPutNums
# TYPE producer_tps gauge
producer_tps{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",} 7.933333333333334
producer_tps{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",} 7.916666666666667
# HELP producer_put_size TopicPutSize
# TYPE producer_put_size gauge
producer_put_size{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",} 1642.2
producer_put_size{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",} 1638.75
# HELP producer_offset TopicOffset
# TYPE producer_offset counter
producer_offset{cluster="MQCluster",broker="broker-a",topic="TBW102",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_tfq",} 1878633.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="DEV_TID_tfq",} 3843787.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_20190304",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="BenchmarkTest",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_20190305",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="MQCluster",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",} 2798195.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="BenchmarkTest",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",} 1459666.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="MQCluster",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="SELF_TEST_TOPIC",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="OFFSET_MOVED_EVENT",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="broker-b",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="broker-a",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="SELF_TEST_TOPIC",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="RMQ_SYS_TRANS_HALF_TOPIC",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="DEV_TID_20190305",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="OFFSET_MOVED_EVENT",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="RMQ_SYS_TRANS_HALF_TOPIC",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="TBW102",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="DEV_TID_20190304",} 0.0

```

### Consumer Groups

**Metrics details**

| Name                              | Exposed information                                          |
| --------------------------------- | ------------------------------------------------------------ |
| `consumer_tps`                    | consumer message numbers per second for this Topic           |
| `consumer_get_size`               | consumer message size per second for this Topic              |
| `consumer_offset`                 | consumer offset for this topic                               |
| `group_get_latency`               | consumer latency on some topic for one queue                 |
| `group_get_latency_by_storetime ` | consumer latency between message consume time and message store time on some topic |

**Metrics output example**

```txt
# HELP consumer_tps GroupGetNums
# TYPE consumer_tps gauge
consumer_tps{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",} 7.916666666666667
consumer_tps{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",} 7.933333333333334
# HELP consumer_get_size GroupGetSize
# TYPE consumer_get_size gauge
consumer_get_size{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",} 1638.75
consumer_get_size{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",} 1642.2
# HELP consumer_offset GroupOffset
# TYPE consumer_offset counter
consumer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",} 1462030.0
consumer_offset{cluster="MQCluster",broker="broker-a",topic="DEV_TID_tfq",group="DEV_CID_cfq",} 3843787.0
consumer_offset{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",} 2800569.0
consumer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_tfq",group="DEV_CID_cfq",} 1878633.0
# HELP group_get_latency GroupGetLatency
# TYPE group_get_latency gauge
group_get_latency{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="0",} 0.05
group_get_latency{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="1",} 0.0
group_get_latency{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="7",} 0.05
group_get_latency{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="6",} 0.016666666666666666
group_get_latency{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="3",} 0.0
group_get_latency{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="7",} 0.03333333333333333
group_get_latency{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="4",} 0.0
group_get_latency{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="5",} 0.03333333333333333
group_get_latency{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="6",} 0.016666666666666666
group_get_latency{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="2",} 0.0
group_get_latency{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="3",} 0.0
group_get_latency{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="0",} 0.0
group_get_latency{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="4",} 0.0
group_get_latency{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="1",} 0.03333333333333333
group_get_latency{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="5",} 0.0
group_get_latency{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",queueid="2",} 0.0
# HELP group_get_latency_by_storetime GroupGetLatencyByStoreTime
# TYPE group_get_latency_by_storetime gauge
group_get_latency_by_storetime{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",} 3215.0
group_get_latency_by_storetime{cluster="MQCluster",broker="broker-a",topic="DEV_TID_tfq",group="DEV_CID_cfq",} 0.0
group_get_latency_by_storetime{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",group="DEV_CID_consumer_cfq",} 3232.0
group_get_latency_by_storetime{cluster="MQCluster",broker="broker-b",topic="DEV_TID_tfq",group="DEV_CID_cfq",} 0.0
```

Contribute
----------

If you like RocketMQ Exporter, please give me a star. This will help more people know RocketMQ Exporter.

Please feel free to send me [pull requests](https://github.com/hdchen/rocketmq-exporter/pulls).