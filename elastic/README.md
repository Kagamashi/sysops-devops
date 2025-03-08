## Elastic Stack (Elasticsearch, Kibana, Logstash, Beats)

The **Elastic Stack** (formerly ELK) is a set of tools for **search, logging, and observability**, including:
- **Elasticsearch** – A distributed search and analytics engine.
- **Kibana** – A UI for visualizing Elasticsearch data.
- **Logstash** – A data processing pipeline for transforming and sending logs.
- **Beats** – Lightweight data shippers for collecting logs, metrics, and security data.

- **Official Docs**: [https://www.elastic.co/guide/index.html](https://www.elastic.co/guide/index.html)
- **GitHub Repository**: [https://github.com/elastic/elasticsearch](https://github.com/elastic/elasticsearch)
- **Download Elastic Stack**: [https://www.elastic.co/downloads/](https://www.elastic.co/downloads/)
- **API Reference**: [https://www.elastic.co/guide/en/elasticsearch/reference/current/rest-apis.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/rest-apis.html)
- **Helm Charts**: [https://github.com/elastic/helm-charts](https://github.com/elastic/helm-charts)

---

### Dictionary (Key Elastic Terms)

- **Index**: A logical collection of documents in Elasticsearch.
- **Shard**: A smaller unit of an index, used for distribution and performance.
- **Node**: A single Elasticsearch instance participating in a cluster.
- **Cluster**: A collection of Elasticsearch nodes working together.
- **Mappings**: Schema definitions for how Elasticsearch indexes fields.
- **Query DSL**: Elasticsearch’s JSON-based query language.
- **Ingest Pipeline**: A way to process and transform data before indexing.
- **Kibana Dashboards**: Visual representations of Elasticsearch data.
- **Logstash Pipeline**: A series of input, filter, and output plugins for transforming logs.
- **Beats Modules**: Pre-configured log collection and processing for common applications.

---

### CRDs (Custom Resource Definitions)

Elastic provides **CRDs** for managing Elasticsearch on Kubernetes via the **Elastic Cloud on Kubernetes (ECK) Operator**:

1. **Elasticsearch**  
   - Defines cluster settings, node roles, storage, scaling.
2. **Kibana**  
   - Manages Kibana deployments integrated with Elasticsearch.
3. **Logstash**  
   - Configures Logstash pipelines and scaling.
4. **Beats**  
   - Manages Beats agents for log collection.

To install the **Elastic Kubernetes Operator**:
```sh
kubectl apply -f https://download.elastic.co/downloads/eck/2.8.0/operator.yaml
