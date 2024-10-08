groups:
  - name: "loki_alerts"
    rules:
      - alert: "LokiRequestErrors"
        annotations:
          message: |
            {{`{{`}} $labels.job {{`}}`}} {{`{{`}} $labels.route {{`}}`}} is experiencing {{`{{`}} printf "%.2f" $value {{`}}`}}% errors.
        expr: |
          100 * sum(rate(loki_request_duration_seconds_count{status_code=~"5.."}[2m])) by (namespace, job, route)
            /
          sum(rate(loki_request_duration_seconds_count[2m])) by (namespace, job, route)
            > 10
        for: "15m"
        labels:
          severity: "critical"