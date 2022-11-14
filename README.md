# docker-deluged

Before build create file named .env with content:
  DAEMON_PORT=123
  WEB_PORT=456
  LISTEN_PORT=789
  RPC_LOGIN=<Your favourite login>
  RPC_PASSWORD=<Your mega password>

Then run docker-compose up -d to build image and start the container.

Default password for web interface : deluge
