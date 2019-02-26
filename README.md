# README

## How to run

```
docker run \
       --rm \
       --volume "$PWD:/home/mxnetuser/app" \
       --volume "$HOME/.m2:/home/mxnetuser/.m2" \
       --volume "$HOME/.m2:/root/.m2" \
       --interactive \
       -p "12121:12121" \
       --tty \
       chouffe/mxnet-clj-cpu \
       lein repl :start :host 0.0.0.0 :port 12121
```

## How to build

```
docker build --tag chouffe/mxnet-clj-cpu .
```
