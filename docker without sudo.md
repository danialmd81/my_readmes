To create the docker group and add your user:

1. Create the docker group:

 ```sh
 sudo groupadd docker
 ```

2. Add your user to the docker group:

 ```sh
 sudo usermod -aG docker $USER
 ```

3. Log out and log back in so that your group membership is re-evaluated.

 If you're running Linux in a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.

4. You can also run the following command to activate the changes to groups:

 ```sh
 newgrp docker
 ```

5. Verify that you can run docker commands without sudo:

 ```sh
 docker run hello-world
 ```

 This command downloads a test image and runs it in a container. When the container runs, it prints a message and exits.

If you initially ran Docker CLI commands using sudo before adding your user to the docker group, you may see the following error:

```
WARNING: Error loading config file: /home/user/.docker/config.json - stat /home/user/.docker/config.json: permission denied
```

This error indicates that the permission settings for the `~/.docker/` directory are incorrect, due to having used the sudo command earlier.

To fix this problem, either remove the `~/.docker/` directory (it's recreated automatically, but any custom settings are lost), or change its ownership and permissions using the following commands:

```sh
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
```
