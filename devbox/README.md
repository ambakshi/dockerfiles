# ambakshi/devbox

This devbox is based on centos6 with git 2.2, gcc, make, customized vim 7.4,
tmux 1.9a, ruby, python, go1.4, sshd (not running). The default user dev (1000:1000)
can sudo and do a password-less ssh into localhost as root. The pam modules
for su/sudo/ssh are fixed so they don't complain about being session-less or
requiring a terminal. *NEW* now includes puppet-omnibus 3.7.3

## Installation

    $ git clone https://github.com/ambakshi/dockerfiles
    $ cd dockerfiles
    $ docker build -t devbox .

## Usage

    $ docker run -ti --name mydevbox devbox

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

TODO: Write history

## Credits

TODO: Write credits

## License

TODO: Write license
