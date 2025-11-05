#helm install logstash elastic/logstash -n elk
helm upgrade --install logstash elastic/logstash -n elk -f logstash-values.yaml
kubectl apply -f logstash-service.yaml

#helm show values elastic/logstash > logstash-values.yaml
#logstashPipeline:
#logstash.conf: |
#    input {
#        beats {
#            port => 5044
#        }
#    }
#output {
#    elasticsearch {
#        hosts => ["http://elasticsearch-master:9200"]
#        index => "aks-logs-%{+YYYY.MM.dd}"
#    }
#}

#helm upgrade --install logstash elastic/logstash -n elk -f logstash-values.yaml
