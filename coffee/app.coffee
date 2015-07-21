requirejs.config
  baseUrl: '/',
  paths:
    dbs: "compiled-coffee"
    jquery: "external/jquery",
    react: "external/react-0.13.3.min",
    cx: "external/classNames"
  shim: {}

requirejs ["dbs/main"]
