I have used Terragrunt in this assesment as a tool to manage multiple environments and accounts.

The idea behind Terragrunt is that you define your environments using terragrunt.hcl files that specify what modules to deploy and what inputs to pass to those modules, and you run terragrunt commands instead of terraform commands (e.g., terragrunt apply and terragrunt destroy).


Directory structure:

<img width="241" alt="Screenshot 2023-03-05 at 14 30 52" src="https://user-images.githubusercontent.com/18290521/222963469-62b78c7e-2467-4dcf-b547-5ee362b396ce.png">


Running terragrunt apply

```
Terraform will perform the following actions:
# aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0fb653ca2d3203ac1"
      + instance_type                = "t2.micro"
      (...)
    }
Plan: 1 to add, 0 to change, 0 to destroy.
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
  Enter a value:
```

The above code will create an ec2 instance, in the environment of your choice. Terragrunt will just call the modules and provision the infra.
