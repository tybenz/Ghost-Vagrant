# node-vagrant

Vagrant setup for developing a node application

## Instructions

- Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant 1.2.2](http://downloads.vagrantup.com/tags/v1.2.2)
- *Linux Users:* Install an NFS daemon, e.g. `apt-get install nfs-kernel-server` 
- Clone this repo
- Edit the `Vagrantfile` in the root
    - Change your `AppSourcePath` to match your environment
- (Optional) Edit your machines `hosts` file add `192.168.33.10 <local.appurl.com>`
- Run `vagrant up` from the root of the cloned repo.
