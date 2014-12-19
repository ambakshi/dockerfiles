### ambakshi/devbox

This devbox is based on centos6 with git 2.2, gcc, make, customized vim 7.4,
tmux 1.9a, ruby, python, go1.4, sshd (not running). The default user dev (1000:1000)
can sudo and do a password-less ssh into localhost as root. The pam modules
for su/ssh are fixed so they don't complain about being session-less.
