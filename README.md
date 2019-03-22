RocketMQ_exporter
==============

[![Build Status](https://travis-ci.org/danielqsj/kafka_exporter.svg?branch=master)](https://travis-ci.org/danielqsj/kafka_exporter)[![Docker Pulls](https://img.shields.io/docker/pulls/danielqsj/kafka-exporter.svg)](https://hub.docker.com/r/danielqsj/kafka-exporter)[![Go Report Card](https://goreportcard.com/badge/github.com/danielqsj/kafka_exporter)](https://goreportcard.com/report/github.com/danielqsj/kafka_exporter)[![Language](https://img.shields.io/badge/language-Go-red.svg)](https://github.com/danielqsj/kafka-exporter)[![GitHub release](https://img.shields.io/badge/release-1.2.0-green.svg)](https://github.com/alibaba/derrick/releases)[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)

RocketMQ exporter for Prometheus. For other metrics from Kafka, have a look at the [JMX exporter](https://github.com/prometheus/jmx_exporter).

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
-   [Flags](#flags)
	-   [Notes](#notes)
-   [Metrics](#metrics)
	-   [Brokers](#brokers)
	-   [Topics](#topics)
	-   [Consumer Groups](#consumer-groups)
-   [Grafana Dashboard](#Grafana Dashboard) 
-   [Contribute](#contribute)

Compatibility
-------------

Support [Apache RocketMQ](https://rocketmq.apache.org) version 0.10.1.0 (and later).

Dependency
----------

-	[Prometheus](https://prometheus.io)

Download
--------

Binary can be downloaded from [Releases](https://github.com/danielqsj/kafka_exporter/releases) page.

Compile
-------

### Build Binary

```shell
make
```

### Build Docker Image

```shell
make docker
```

Docker Hub Image
----------------

```shell
docker pull danielqsj/kafka-exporter:latest
```

It can be used directly instead of having to build the image yourself. ([Docker Hub danielqsj/kafka-exporter](https://hub.docker.com/r/danielqsj/kafka-exporter)\)

Run
---

### Run Binary

```shell
kafka_exporter --kafka.server=kafka:9092 [--kafka.server=another-server ...]
```

### Run Docker Image

```
docker run -ti --rm -p 9308:9308 danielqsj/kafka-exporter --kafka.server=kafka:9092 [--kafka.server=another-server ...]
```

Flags
-----

This image is configurable using different flags

| Flag name                    | Default    | Description                                                                                         |
| ---------------------------- | ---------- | --------------------------------------------------------------------------------------------------- |
| kafka.server                 | kafka:9092 | Addresses (host:port) of Kafka server                                                               |
| kafka.version                | 1.0.0      | Kafka broker version                                                                                |
| sasl.enabled                 | false      | Connect using SASL/PLAIN                                                                            |
| sasl.handshake               | true       | Only set this to false if using a non-Kafka SASL proxy                                              |
| sasl.username                |            | SASL user name                                                                                      |
| sasl.password                |            | SASL user password                                                                                  |
| tls.enabled                  | false      | Connect using TLS                                                                                   |
| tls.ca-file                  |            | The optional certificate authority file for TLS client authentication                               |
| tls.cert-file                |            | The optional certificate file for client authentication                                             |
| tls.key-file                 |            | The optional key file for client authentication                                                     |
| tls.insecure-skip-tls-verify | false      | If true, the server's certificate will not be checked for validity                                  |
| topic.filter                 | .*         | Regex that determines which topics to collect                                                       |
| group.filter                 | .*         | Regex that determines which consumer groups to collect                                              |
| web.listen-address           | :9308      | Address to listen on for web interface and telemetry                                                |
| web.telemetry-path           | /metrics   | Path under which to expose metrics                                                                  |
| log.level                    | info       | Only log messages with the given severity or above. Valid levels: [debug, info, warn, error, fatal] |
| log.enable-sarama            | false      | Turn on Sarama logging                                                                              |

### Notes

Boolean values are uniquely managed by [Kingpin](https://github.com/alecthomas/kingpin/blob/master/README.md#boolean-values). Each boolean flag will have a negative complement:
`--<name>` and `--no-<name>`.

For example:

If you need to disable `sasl.handshake`, you could add flag `--no-sasl.handshake`

Metrics
-------

Documents about exposed Prometheus metrics.

For details on the underlying metrics please see [Apache RocketMQ](https://kafka.apache.org/documentation).

### Brokers

**Metrics details**

| Name            | Exposed informations                   |
| --------------- | -------------------------------------- |
| `kafka_brokers` | Number of Brokers in the Kafka Cluster |

**Metrics output example**

```txt
# HELP kafka_brokers Number of Brokers in the Kafka Cluster.
# TYPE kafka_brokers gauge
kafka_brokers 3
```

### Topics

**Metrics details**

| Name                | Exposed informations                               |
| ------------------- | -------------------------------------------------- |
| `producer_tps`      | sending messages number per second  for this topic |
| `producer_put_size` | sending messages size per second  for this topic   |
| `producer_offset`   | Current Offset of a Broker at Topic                |

**Metrics output example**

```txt
# HELP producer_tps TopicPutNums
# TYPE producer_tps gauge
producer_tps{cluster="MQCluster",broker="broker-a",topic="DEV_TID_tfq",} 0.0
producer_tps{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",} 0.0

# HELP producer_put_size TopicPutSize
# TYPE producer_put_size gauge
producer_put_size{cluster="MQCluster",broker="broker-a",topic="DEV_TID_tfq",} 0.0
producer_put_size{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",} 0.0

# HELP producer_offset TopicOffset
# TYPE producer_offset counter
producer_offset{cluster="MQCluster",broker="broker-a",topic="TBW102",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_tfq",} 1878633.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="DEV_TID_tfq",} 3843787.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_20190304",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="BenchmarkTest",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_20190305",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="MQCluster",} 0.0
producer_offset{cluster="MQCluster",broker="broker-a",topic="DEV_TID_topic_tfq",} 2608269.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="BenchmarkTest",} 0.0
producer_offset{cluster="MQCluster",broker="broker-b",topic="DEV_TID_topic_tfq",} 1269760.0
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

| Name                | Exposed informations                         |
| ------------------- | -------------------------------------------- |
| `consumer_tps`      | consumer message numbers per second at Topic |
| `consumer_get_size` | consumer message size per second at Topic    |
| `consumer_offset`   |                                              |

**Metrics output example**

```txt
# HELP kafka_consumergroup_current_offset Current Offset of a ConsumerGroup at Topic/Partition
# TYPE kafka_consumergroup_current_offset gauge
kafka_consumergroup_current_offset{consumergroup="KMOffsetCache-kafka-manager-3806276532-ml44w",partition="0",topic="__consumer_offsets"} -1

# HELP kafka_consumergroup_lag Current Approximate Lag of a ConsumerGroup at Topic/Partition
# TYPE kafka_consumergroup_lag gauge
kafka_consumergroup_lag{consumergroup="KMOffsetCache-kafka-manager-3806276532-ml44w",partition="0",topic="__consumer_offsets"} 1
```

Grafana Dashboard
-------

Grafana Dashboard ID: 7589, name: Kafka Exporter Overview.

For details of the dashboard please see [Kafka Exporter Overview](https://grafana.com/dashboards/7589).

Contribute
----------

If you like RocketMQ Exporter, please give me a star. This will help more people know RocketMQ Exporter.

Please feel free to send me [pull requests](https://github.com/danielqsj/kafka_exporter/pulls).