

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

4. Deploy webserver ,configure it to use SSL and redirect http to https using Ansible:
'''
ansible-playbook -i hosts.ini playbook.yaml  
'''


