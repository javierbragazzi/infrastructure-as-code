echo "***** Creation the infrastructure with Terraform *****"

echo "Initialize a working directory containing Terraform configuration files..."
terraform init

echo "*******************************************************************************"

echo "Apply the necessary changes to achieve the desired state of the configuration..."
terraform apply

echo "*******************************************************************************"