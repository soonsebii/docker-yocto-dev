# yocto-base

Dockertized yocto build system

# ToDo
- [x] Ubuntu 14.04
- [x] Repo
- [ ] NFS for shared DL_DIR (NFS_ENABLED, NFS_URL, NFS_MOUNT_OPTION)
- [ ] Integration with Gitlab Runner

# Example

Step1. Build an image
```bash
docker build -t yocto-dev github.com/soonsebii/docker-yocto-dev
```

Step2. Launch a Yocto development container
```bash
docker run --name build-test -d \
  --env 'DEBUG=true' \
  --env 'REPO_ENABLED=true' \
  --env 'REPO_TRACE=true' \
  --env 'REPO_INIT_MANIFEST_URL=http://test.com/manifest' \
  --env 'REPO_INIT_MANIFEST_BRANCH=morty' \
  --env 'REPO_SYNC_JOBS=8' --env 'REPO_SYNC_OPTION=--no-repo-verify' \
  yocto-dev
```

Step3. Enjoy!
```bash
docker exec -it build-test /bin/bash
```
