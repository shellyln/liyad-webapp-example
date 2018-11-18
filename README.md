# liyad-webapp-example

Web app example for Liyad Lisp interpreter CLI.  
Serve the http server and do server side rendering with React and LSX.  
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
$ liyad -p LSX_async --lsx-boot lsxboot.js app.lisp
```
