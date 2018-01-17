# SpringMicroInAction


## Key Config

Run
```bash
source env.profile
```

## Kafka Setup:

1.- Download [kafka](https://kafka.apache.org/downloads)

2.- Start zookeeper

```bash
bin/zookeeper-server-start.sh config/zookeeper.properties
```

3.- Start kafka

```bash
bin/kafka-server-start.sh config/server.properties
```

4.- Create topic

```bash
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic orgChangeTopic
```
