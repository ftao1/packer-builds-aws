# HashiCorp Packer Builds for AWS

This is a Packer project to build AWS AMI's

## Assumptions

This project assumes no existing installed software (listed below) and everything will be created from scratch.

## Requirements

The following software must be installed on your local machine before you can use Packer to build this Vagrant box:

  - [Packer](http://www.packer.io/)
  - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

Ensure the IAM user has permission to create AMIs.

Although not strictly necessary this is a recommended tree structure to get things going:

```bash
├── LICENSE
├── packer-aws.pkr.hcl
├── README.md
└── scripts
    └── update.sh
```

## Scripts

  - **packer-aws.pkr.hcl** - Main packer file
  - **update.sh** - This updates the AMI OS

## Output

Once the AMI is created it will be stored in the **Images > AMIs** section of the WebUI.

## Usage

Clone the repo and run the packer build:

    $ git clone https://github.com/ftao1/packer-builds-aws.git
    $ cd packer-builds-aws
    $ packer build .

## License

MIT

## Author

These configurations are maintained by F.Tao.
