

# Steps to deploy static site to AWS

1. Provision infrastructure using Terraform. Provide aws_access_key and aws_secret_key when asked. Navigate to the Terraform directory.Execute the following commands:
'''
terraform init
terraform apply --auto-approve
'''
2. Change file permission of pem file generated in terraform folder by executing following command:
'''
chmod 400 ubuntu-key-pair.pem
'''

3. Deploy Nginx , configure it for SSL , redirect HTTP to HTTPS using Ansible. Run the following command,before running it you need to replace all dns_name in the hosts file and default.conf with dns_name generated by Terraform:

'''
ansible-playbook -i hosts.ini playbook.yaml  
'''



