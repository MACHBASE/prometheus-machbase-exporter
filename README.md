Prometheus Machbase Exporter
============================

This Prometheus exporter periodically runs configured queries against a Machbase database and exports the results as Prometheus gauge metrics.

# Prerequisites

The exporter requires prometheus_client and machbaseAPI modules.

Python 2.7 and 3.x are supported.

# Usage

Just run:

```
./start-machbase-exporter.sh
```

It will prepare environments for you and run the exporter with reasonable option values. The environment variable `MACHBASE_HOME` must be set.

Or you can run the exporter by yourself. By default, it will bind to port 9297, connect to Machbase on `localhost:5656` using the `SYS` user and run queries configured in a file `exporter.cfg` in the working directory. You can change any defaults as required by passing in options:

```
python machbase-exporter.py -p <port> -s <machbase server> -u <machbase username> -P <machbase password> -c <path to query config file>
```

Run with the `-h` flag to see details on all the available options.

See the provided `exporter.cfg` file for query configuration examples and explanation.
