# For key based authentication to linux server:
- Create key with "ssh-keygen" command for server which will connect another server (/home/username/.ssh/id_rsa)
- Copy key to server which we will connect with "ssh-copy-id username@remote_host" command. Your key will be added to other server's authorized_keys file.
