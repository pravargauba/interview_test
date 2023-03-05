Monitoring of VM's can be done by bunch of tools available in market, but I would want to choose Prometheus over any other tool due to its support, integration with third party apps, its features and its unique time series querying database functionality.

Prometheus has a central component called the Prometheus server that collects the metrics from different nodes. Prometheus server uses the concept of scraping by contacting the target system’s metric endpoints to fetch data at regular intervals.

We can monitor hundreds of EC2 or GCP VM's by leveraging node exporter.

Node Exporter
So to monitor a Linux machine we need a Node Exporter that is used to pull Linux system metrics like CPU load and disk I/O. Node Exporter will expose these as Prometheus-style metrics.

```
global:
...

scrape_configs:
...
- job_name: ec2_exporter
  relabel_configs:
    - source_labels: [__meta_ec2_tag_Name]
      target_label: instance
    - source_labels: [__meta_ec2_private_ip]
      target_label: ip
  ec2_sd_configs:
    - region: eu-central-1
      port: 9100
...

```

<img width="828" alt="Screenshot 2023-03-05 at 15 20 43" src="https://user-images.githubusercontent.com/18290521/222966183-293c6db7-e8b5-416f-9a85-02a08126d532.png">


<img width="946" alt="Screenshot 2023-03-05 at 15 22 12" src="https://user-images.githubusercontent.com/18290521/222966256-3f3db972-6ae8-4261-a09d-3791d9237252.png">


Now since there would be hundreds of virtual machines, we ofcourse won't be able to keep on adding the static targets of all the VMs, so we can achive the dynamic addition of targets using the ec2_sd_config parameter of prometheus.
The information to access the EC2 API.

```
# The AWS region. If blank, the region from the instance metadata is used.
[ region: <string> ]

# Custom endpoint to be used.
[ endpoint: <string> ]

# The AWS API keys. If blank, the environment variables `AWS_ACCESS_KEY_ID`
# and `AWS_SECRET_ACCESS_KEY` are used.
[ access_key: <string> ]
[ secret_key: <secret> ]
# Named AWS profile used to connect to the API.
[ profile: <string> ]

# AWS Role ARN, an alternative to using AWS API keys.
[ role_arn: <string> ]

# Refresh interval to re-read the instance list.
[ refresh_interval: <duration> | default = 60s ]

# The port to scrape metrics from. If using the public IP address, this must
# instead be specified in the relabeling rule.
[ port: <int> | default = 80 ]

```
Please note to collect metrics from all the VMs, we would need to install node exporter on all the machines. This can be either done using ansible for existing machines, or using Terraform remote-exec provisioner for newer machines with automated installation.


We can further visualize the metrics on Grafana.

<img width="1355" alt="Screenshot 2023-03-05 at 15 34 28" src="https://user-images.githubusercontent.com/18290521/222966891-357636ce-5c83-44b3-acbb-0b3aa7454045.png">

