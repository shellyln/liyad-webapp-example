# liyad-webapp-example

Web app example for [Liyad](https://www.npmjs.com/package/liyad) Lisp interpreter [CLI](https://www.npmjs.com/package/liyad-cli).  
Serve the http server and do server side rendering with React and [LSX](https://github.com/shellyln/liyad#what-is-lsx).  
LSX is alternative notation of JSX using Lisp.

## Install

```bash
$ npm install -g liyad-cli
$ git clone https://github.com/shellyln/liyad-webapp-example.git
$ cd liyad-webapp-example
$ npm ci
```

## Run

```bash
$ liyad -p LSX_async --lsx-boot ./lsxboot.js app.lisp
```
Server will serve on port 3000.


## Run with PM2

```bash
$ npm install -g pm2@latest
$ npm install liyad-cli
$ pm2 start cluster.js -i max

$ pm2 stop cluster
$ pm2 delete cluster
```
