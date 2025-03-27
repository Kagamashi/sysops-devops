APACHE KAFKA
- created in 2011 at LinkedIn, written in Java and Scola
distributed event streaming platform that can scale massive pipelines of real-time data

- when event occurs like a website visit
- PRODUCER API creates a new record
- records are stored to disk in ordered immutable log called a TOPIC which can persist forever or disappear when no longer needed
- topics are distributed and replicated in a CLUSTER
- which contains multiple servers called BROKERS
- this makes Kafka fault tolerant and able to scale to any workload
- multiple CONSUMERS can subscribe to this data - they can read most recent message like AQ or read entire topic log and listen to udpates in real time
- provides very powerful streams API that can transform and aggregate these topics before they ever reach the consumer

KAFKA CAN AHNDLE MORE THROUGHPUT THAN RABBITMQ and is ideal for streaming data applications
Lyft, Cloudflare, Spotify, Netflix

ZooKeeper
Kraft
tools used to manage Kafka cluster

RECORD
  timestamp
  key-value
  metadata (optional)

STREAM API
- filtering and mapping (stateless transofmration)
- aggregation and grouping (stateful)