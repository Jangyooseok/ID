FROM bcgovimages/von-image:py35-1.6-8

USER indy

RUN python3 -m pip install --upgrade pip setuptools wheel

RUN pip install --no-cache-dir aiosqlite~=0.6.0

RUN python -m pip install pip==9.0.3

RUN pip install base58==1.0.0

RUN pip install python-dateutil==2.6.1

RUN pip install rlp==0.5.1

ENV RUST_LOG ${RUST_LOG:-warning}

RUN mkdir -p \
        $HOME/ledger/sandbox/data \
        $HOME/log \
        $HOME/.indy-cli/networks \
        $HOME/.indy_client/wallet && \
    chmod -R ug+rw $HOME/log $HOME/ledger $HOME/.indy-cli $HOME/.indy_client

ADD --chown=indy:indy indy_config.py /etc/indy/

ADD --chown=indy:indy . $HOME

RUN chmod uga+x scripts/* bin/*
