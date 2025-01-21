## Prerequisites

This project uses the DigitalOcean cloud platform. To run Terraform, you must first generate a DigitalOcean (DO) token:

```console
 export DO_PAT=<DigitalOcean token>
```

## Deployment

To deploy the infrastructure, run the following command:

```console
terraform apply -var "do_token=${DO_PAT}" -var "pvt_key=$HOME/.ssh/id_rsa"
```

> Note: This project assumes the _id_rsa_ key has been uploaded to your DigitalOcean account.

Terraform will provision an Ubuntu machine on the DigitalOcean cloud and configure it according to the project's requirements. Additionally, it will create a DigitalOcean firewall to allow traffic on ports **22**, **443**, and **19999** exclusively from your public IP.

After applying the Terraform configuration, the public IP of the Ubuntu machine will be displayed in the terminal output. Project shell scripts will also be copied to the remote machine.

## Usage

SSH into the remote machine:

```console
ssh ubuntu@<public-ubuntu-machine-ip>
```

Grant execution rights to the scripts and set up NetData:

```console
chmod +x *.sh
./setup.sh
```

Open the NetData dashboard in your browser:

    http://<public-ubuntu-machine-ip>:19999/

## Testing

On the Ubuntu machine, you can run a stress test to observe NetData metrics and alerts:

```console
./test_dashboard.sh 120
```

Replace 120 with the desired duration (in seconds) for the stress test.

## Cleanup

When you are done, clean up the remote machine by running:

```console
./cleanup.sh
```

Finally, destroy the Terraform-managed infrastructure:

```console
terraform destroy -var "do_token=${DO_PAT}" -var "pvt_key=$HOME/.ssh/id_rsa"
```
