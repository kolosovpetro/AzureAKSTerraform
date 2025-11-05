## 🟡 Elasticsearch (REST API & Cluster Communication)
#kubectl port-forward svc/elasticsearch-master -n elk 9200:9200
#
## 🟢 Kibana (Web UI)
#kubectl port-forward svc/kibana-kibana -n elk 5601:5601
#
## 🔵 Logstash (HTTP Monitoring API)
#kubectl port-forward svc/logstash-logstash-headless -n elk 9600:9600

Start-Job { kubectl port-forward svc/elasticsearch-master -n elk 9200:9200 }
Start-Job { kubectl port-forward svc/kibana-kibana -n elk 5601:5601 }
Start-Job { kubectl port-forward svc/logstash-logstash-headless -n elk 9600:9600 }

