#helm install filebeat elastic/filebeat -n elk `
#  --set output.logstash.enabled=true `
#  --set output.logstash.hosts=["logstash-service:5044"]


helm upgrade --install filebeat elastic/filebeat -n elk -f values-filebeat.yaml

#output.logstash:
#  hosts: ["logstash:5044"]
#
#helm upgrade --install filebeat elastic/filebeat -n elk -f filebeat-values.yaml
