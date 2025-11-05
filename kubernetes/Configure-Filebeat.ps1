helm install filebeat elastic/filebeat -n elk

#output.logstash:
#  hosts: ["logstash:5044"]
#
#helm upgrade --install filebeat elastic/filebeat -n elk -f filebeat-values.yaml
