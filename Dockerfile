FROM ubuntu:jammy

# Install dependencies. This is done before copying the code, so that the dependencies
# do not have to be installed and built again when only the code has changed.
RUN apt-get update && \
    apt-get -y install git python3 gawk cmark-gfm cabal-install libghc-zlib-dev && \
    cabal update && \
    git clone https://github.com/jgm/texmath.git "$HOME"/texmath && \
    cd "$HOME"/texmath && \
    cabal install -fexecutable && \
    cp $HOME/.cabal/bin/texmath /usr/local/bin

# Copy the directory
COPY . /opt/incunable/

# Make the main script executable
RUN chmod +x /opt/incunable/html/compile.sh

# Create a symlink called 'incunable' in PATH
RUN ln -s /opt/incunable/html/compile.sh /usr/local/bin/incunable

# Set entrypoint to the incunable command
ENTRYPOINT ["incunable"]
