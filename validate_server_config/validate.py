import os, subprocess,requests
import ssl
import socket
from datetime import datetime

os.environ['PYTHONPATH'] = '/Library/Frameworks/Python.framework/Versions/3.9/lib/python3.9/site-packages'


from ansible_runner import run



def test_package_installed(host):
    cmd = host.run('dpkg -l nginx')
    assert cmd.rc == 0
    assert 'nginx' in cmd.stdout

def test_nginx_installed():
    r = run(
        private_data_dir=os.path.abspath('../ansible'),
        inventory=os.path.abspath('../ansible/hosts.ini'),
        host_pattern='ubuntu',
        module='command',
        module_args='dpkg -s nginx',
    )
    for each_host_event in r.events:
        if each_host_event['event'] == 'runner_on_ok':
            if 'stdout' in each_host_event['event_data']:
                assert 'Status: install ok installed' in each_host_event['event_data']['stdout']

def test_website_access(url):
    try:
        response = requests.get(url)
        if response.status_code == 200:
            print(f"{url} is accessible!")
            return True
        else:
            print(f"Error: {url} returned status code {response.status_code}")
            return False
    except Exception as e:
        print(f"Error: {e}")
        return False
                
def test_ssl_certificate(host, port):
    # Connect to the server
    context = ssl.create_default_context()
    with socket.create_connection((host, port)) as sock:
        with context.wrap_socket(sock, server_hostname=host) as ssock:
            # Check the certificate expiration date
            cert = ssock.getpeercert()
            cert_expiration = datetime.strptime(cert['notAfter'], '%b %d %H:%M:%S %Y %Z')
            print(f'The SSL certificate for {host} expires on {cert_expiration}')        

test_nginx_installed()
test_website_access('https://ec2-34-239-227-49.compute-1.amazonaws.com/')
test_ssl_certificate('https://ec2-34-239-227-49.compute-1.amazonaws.com/',443)



