Run with

    docker run -it -u $(id -u):$(id -g) -v /etc/passwd:/etc/passwd:ro \
               --tmpfs=$HOME -v $HOME/.gphotos-uploader-cli:$HOME/.gphotos-uploader-cli \
               --device /dev/fuse --cap-add SYS_ADMIN willat8/lumix-upload camera

Where `camera` is optional and if specified should be the IP address or hostname of the Lumix camera to connect to

