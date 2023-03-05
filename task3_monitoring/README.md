Prometheus has a central component called the Prometheus server that collects the metrics from different nodes. Prometheus server uses the concept of scraping by contacting the target system’s metric endpoints to fetch data at regular intervals.

We can monitor hundreds of EC2 or GCP VM's by leveraging node exporter.

Node Exporter
So to monitor a Linux machine we need a Node Exporter that is used to pull Linux system metrics like CPU load and disk I/O. Node Exporter will expose these as Prometheus-style metrics.
