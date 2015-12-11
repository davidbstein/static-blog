requirejs.config
  baseUrl: '/',
  paths:
    commonmark: "external/commonmark-react/commonmark.js/dist/commonmark.min"
    cx: "external/classNames"
    dbs: "compiled-coffee"
    highlight: "external/highlight.min"
    jquery: "external/jquery"
    react: "external/react-0.13.3.min"
  shim: {
  }

requirejs ["dbs/main"]
