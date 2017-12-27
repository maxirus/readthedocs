# Read the Docs Docker image

## Overview
This docker image was built to support a microservice based deployment of Read the Docs on Docker. Using this one image, you can run initdb, webserver or worker and bring it all together with a docker-compose.yml file.

> Note: Currently PDF and EPUB are not working.

## Getting Started
The easiest way to get started is to clone [this](https://github.com/maxirus/readthedocs-docker) repository, navigate to the ```examples/``` folder and run ```docker-compose up```. 

After the webserver comes up, you should be able to navigate to [http://localhost:8000/admin](http://localhost:8000/admin) to login and subsequently [http://localhost:8000/](http://localhost:8000/) to add projects. The default username/password is ```admin/admin```.

## Config

### RTD Config
You'll find the slumber password and the django settings module setting in the ```.env``` file.

You can modify any of the settings in the ```example/example.py``` file to suit your environment. If you wish to make your own environment class, be sure to update the ```DJANGO_SETTINGS_MODULE``` in the ```.env``` file to point to your new class.

### SSH
In order to support SSH access to Git repos, you must add the neccessary keys to the ```rtd``` user's home directory on the worker service. To do this, create a set of ssh keys using [ssh-keygen](https://www.ssh.com/ssh/keygen/) and save them in a folder named ```ssh```. You'll also need the SSH Fingerprint of the Git repo you wish to connect to; add the fingerprint to file called ```known_hosts``` in your ```ssh``` folder. You should have the following: ```ssh/id_rsa```, ```ssh/id_rsa.pub```, and ```ssh/known_hosts```. 

In the ```worker``` service of your ```docker-compose.yml```, add the volume mount:
```yaml
- ./ssh:/home/rtd/.ssh
```

That's it for configuring RTD. Be sure to add your public key (```id_rsa.pub```) to your Git repo's Access Keys.