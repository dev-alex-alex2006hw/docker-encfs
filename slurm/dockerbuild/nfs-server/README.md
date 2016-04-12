```
docker run -d --hostname nfs --name nfs \
	   --cap-add SYS_ADMIN --device /dev/fuse \
	   --net stack slurm_nfs \
	   $user `id -u $user` `id -g $user` 

```
