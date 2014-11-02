# myfossil-vagrant

Development environment for myFOSSIL.


## Development


### Environment 

We use Vagrant to have a running WordPress instance locally.

#### Setup

To get an up-and-running development environment, you will need to install the
following software:

- git
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)

Then perform the following actions:

```
$ rm -rf .git
$ ./update.sh
$ vagrant plugin install vagrant-hostmanager
$ vagrant up
$ vagrant ssh
vagrant$ vim /etc/nginx/nginx.conf
```

In `nginx.conf`, comment out `sendfile on` by prepending a `#`. This fixes an 
issue with caching and linking the host and guest OS directories.

#### Usage

If you're unfamiliar with Vagrant, that's pretty much okay. All you really need
to know is that Vagrant manages a VirtualBox VM for you. The puppet scripts
that are run during machine instantiation fully configure nginx and MySQL (save
for commenting out `sendfile on` in `nginx.conf`).

Vagrant creates a symlink from this current working directory (wherever you
have cloned this repository) to `/vagrant` on the VM. This means that
you can develop new features for myFOSSIL using your regular tools and
environment, and the VM serves only to have a working WordPress installation
for you.


### Contributing

This repository encompasses several other repositories into a coherent, working
version of the myFOSSIL website. 

In order to make development easier for everyone, we've chosen to use
`subtrees` rather than `submodules`--this way you can develop under this parent
project and commit changes back to the other repositories.
