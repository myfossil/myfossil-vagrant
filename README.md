# myfossil

WordPress based CMS for the myFOSSIL project.


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
$ vagrant plugin install vagrant-hostmanager
$ vagrant up
$ vagrant ssh
vagrant$ /vagrant/puppet/local/dev_db_import.sh
vagrant$ vim /etc/nginx/nginx.conf
```

In `nginx.conf`, comment out `sendfile on` by prepending a `#`. This fixes an 
issue with caching and linking the host and guest OS directories.

Now, that the server is set up, install the appropriate node modules for both the theme and the Buddypress plugin.

```
$ cd src/wp-content/themes/myfossil/
$ npm install -g gulp && npm install
$ gulp build
$ cd ../../plugins/buddypress
$ npm install
$ grunt
```


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


#### Workflow

If you wish to contribute, first fork this repository and the child repository
that you wish to contribute to. 

For example, if you wanted to contribute to the myFOSSIL theme, you would want
to clone this repository and fork the theme repository. Then perform the
following:

```
$ git clone https://github.com/myfossil/myfossil.git
$ cd myfossil/src/wp-content/themes/myfossil
$ git checkout -b theme/my-new-feature
```

Then make edits, commits, etc. as normal.

Once you're ready to push your changes back to the theme repository, enter the
**root of this repository** and perform the following.

```
$ git subtree push --prefix=src/wp-content/themes/myfossil git@github.com:<my-theme-repository-fork>.git <theme branch name>
```

This will push only the changes that you made to the theme to your theme fork.

You can then submit a pull request like normal to the theme repository.


#### Child Repositories

| Repository                                                          | Type   | Path (i.e. `prefix`)                       |
|---------------------------------------------------------------------|--------|--------------------------------------------|
| [WordPress](https://github.com/myfossil/WordPress) (fork)           | core   | `src/wp-core`                              |
| [BuddyPress](https://github.com/myfossil/BuddyPress) (fork)         | plugin | `src/wp-content/plugins/buddypress`        |
| [bbPress](https://github.com/myfossil/bbpress) (fork)               | plugin | `src/wp-content/plugins/bbpress`           |
| [myfossil-specimen](https://github.com/myfossil/wp-plugin-specimen) | plugin | `src/wp-content/plugins/myfossil-specimen` |
| [myfossil-logging](https://github.com/myfossil/wp-plugin-logging)   | plugin | `src/wp-content/plugins/myfossil-logging`  |
| [myfossil-theme](https://github.com/myfossil/wp-theme-myfossil)     | theme  | `src/wp-content/themes/myfossil`           |


#### Reference

If you are unfamiliar with git subtrees, read a [git subtree
tutorial](https://medium.com/@v/git-subtrees-a-tutorial-6ff568381844) to get
caught up.
