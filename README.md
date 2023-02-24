

# Steps to deploy this application to AWS

1. Provision infrastructure using Terraform. Provide aws_access_key and aws_secret_key when asked. Navigate to the Terraform directory.Execute the following commands:
'''
terraform init
terraform apply --auto-approve
'''
2. Change file permission of pem file generated in terraform folder by executing following command:
'''
chmod 400 ubuntu-key-pair.pem
'''
3. open envVars.env file and replace PGHOST with db_host printed by terraform , PGUSER and PGPASS with value you entered during provisioning of the infrastructure.
4. Deploy the Django application as a Docker container; Replace the public_dns name of the remote server defined in Ansible's host file with the value Terraform printed out. Replace the value of the environment variable PGHOST defined in the docker-compose file with the value of db_host printed by Terraform and replace PGUSER and PGPASS with value you entered when provisioning infrastructure. Navigate to the Ansible directory and run the following command:
'''
ansible-playbook -i hosts playbook.yaml  
'''


