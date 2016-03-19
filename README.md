# Coding.net Coding Pages Deploy

A [wercker](http://wercker.com/) step to deploy to [Coding Pages](https://coding.net/help/doc/pages/index.html).

## Options

- `basedir` *optional* Set this if your build step outputs to a folder
- `domain` *optional* Custom domain ([documentation](https://coding.net/help/doc/pages/index.html#section))
- `repo` *optional* Set this to a coding.net repo like "user/repo". Defaults to your build repo

## Example

Check out [lowwor/lowwor.com](https://github.com/lowwor/lowwor.com) on GitHub.
Need to add ssh key first because coding.net doesn't provide token access.

    deploy:
      	steps:
      	    - install-packages:
        		packages: git ssh-client
        	- add-ssh-key:
        		keyname: CODING_SSH
   			- add-to-known_hosts:
        		hostname: git.coding.net
        		fingerprint: 98:ab:2b:30:60:00:82:86:bb:85:db:87:22:c4:4f:b1
    		- lowwor/coding-pages:
        		domain: lowwor.com
       			basedir: public