FROM python:3-slim

RUN apt-get update -q && \
    apt-get install -y python3-pip && \
    pip3 install prometheus-client && \
    apt-get install -y libncurses5 && \
    apt-get purge -y python3-pip && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Assuming that following files are ready at ./:
# - ${MACHBASE_HOME}/lib/libmachbasecli_dll.so
# - ${MACHBASE_HOME}/3rd-party/python3-module/machbaseAPI-1.0.tar.gz
COPY libmachbasecli_dll.so /usr/lib/
COPY machbaseAPI-1.0.tar.gz /tmp/

RUN tar zxf machbaseAPI-1.0.tar.gz && \
    cd /tmp/machbaseAPI-1.0 && \
    python setup.py install && \
    rm -rf /tmp/machbaseAPI-1.0*

WORKDIR /usr/src/app

COPY machbase-exporter.py exporter.cfg ./
COPY LICENSE README.md MANIFEST.in ./

EXPOSE 9297

ENTRYPOINT ["python", "/usr/src/app/machbase-exporter.py", "-c", "/usr/src/app/exporter.cfg"]
