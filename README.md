## C2Automation 🤖⚙️
![Terraform](https://img.shields.io/badge/made%20with-Terraform-blueviolet)
![Stars](https://img.shields.io/github/stars/ncerne00/C2Automation)
![License](https://img.shields.io/github/license/ncerne00/C2Automation)

Since red team operations can be time-sensitive, C2Automation is a terraform repository that aims to enable users to quickly manage their C2 infrastructure. 

Please note that C2Automation is a work in progress and currently only supports deployments to AWS. 

## Table of Contents

* [Features](#features)
* [Planned](#planned)
* [Resources](#resources)
* [Usage](#usage)
* [License](#license)

## Features

- **C2 Redirection** - Redirecting C2 traffic to hide the true location of the C2 server.

## Planned
- **Terraform Abstraction** - creating a CLI-tool to abstract terraform and ease C2 deployments.
- **Domain Fronting** - Fronting the C2 infrastructure through a CDN like Cloudfront. 

## Usage
```sh
terraform init
terraform apply --var $variables
```

## License
This project is licensed under the [**MIT License**](/License)
