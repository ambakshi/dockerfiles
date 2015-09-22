### black-screen


#### Quick start

`black-screen` is an X windows application, you'll need a host with X Windows (Linux/OSX). From that host, launch the
container and ssh into the container while enabling X forwarding. In the example below, we change the directory to
black-screen before invoking `npm start`. The black-screen windows should pop up on your host if all went well. Use `docker
logs -f black-screen` to assist in troubleshooting.

    $ docker run -ti -d -p 2222:22 --name black-screen ambakshi/black-screen:latest
    $ ssh -X -Y -oPort=2222 -i id_rsa user@dockerhost 'cd /usr/src/black-screen && npm start'



#### Security

I have pre-generated some ssh keys (id_bs and id_bs.pub). If you want to actually use this in anything other than just a
quick test you should generate your own ssh-keys before rebuilding the image.

    $ rm id_bs id_bs.pub
    $ ssh-keygen -f id_bs -t rsa -N ''
    $ docker build -t black-screen .


Amit Bakshi
09/21/2015
