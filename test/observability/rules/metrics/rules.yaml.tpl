groups:
  - name: "loki_rules"
    rules:
      - expr: histogram_quantile(0.99, sum(rate(loki_request_duration_seconds_bucket[1m])) by (le, job))
        record: job:loki_request_duration_seconds:99quantile
        labels:
          app: "{{ .Values.app.name }}"