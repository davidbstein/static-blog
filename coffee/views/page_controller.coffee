dependencies =
  React: "react"
  cx: 'cx'
  $: "jquery"
  CommonmarkElement: "external/commonmark-react/commonmark_react"
  hljs_shim: "highlight"

# copy/pastable require.js hacks
define (_v for _, _v of dependencies), () ->
  _i=0; @[_k] = arguments[_i++] for _k of dependencies
#/hacks

  d = React.DOM

  Header = React.createFactory React.createClass
    displayName: "HeaderView"

    getInitialState: ->
      @scrollTop = 0
      $(window).scroll (e) =>
        new_st = $(window).scrollTop()
        if new_st < 64 or new_st < @scrollTop
          @setState hidden: false
        else
          @setState hidden: true
        @scrollTop = new_st
      hidden: false

    render: ->
      d.header
        className: cx
          hidden: @state.hidden
        d.div
          id: "header-background"
        d.div
          id: "header-content"
          d.div
            className: "title"
            d.a href: "/", "stein"
          d.ul {},
            d.li {}, d.a href: "/blog/index.html", "blog"
            d.li {}, d.a href: "/about/index.html", "about"

  Content = React.createFactory React.createClass
    displayName: "ContentView"

    render: ->
      d.div
        id: 'content-wrapper'
        d.div
          id: 'content-wrapper-bg'
        d.div
          id: 'content-wrapper-fg'
          CommonmarkElement
            raw: "#{@props.content}"
            showTableOfContents: window.showTableOfContents

  Footer = React.createFactory React.createClass
    displayName: "FooterView"

    render: ->
      d.div
        id: 'footer-wrapper'
        "Copyright (c) David Stein"

  PageController = React.createClass
    displayName: "PageController"

    propTypes:
      content: React.PropTypes.string

    getInitialState: ->
      updated_content: null

    updateContent: ->
      if location.pathname.endsWith "html"
        filename = location.pathname.match(/(.*?)\.html$/)[1]
        path = "/raw#{filename}.md"
      else
        path = "/raw#{location.pathname}index.md"
      $.get path, (data) =>
        if data != @state.updated_content
          @setState updated_content: data

    componentDidMount: ->
      if location.host.startsWith "127.0.0.1"
        setInterval(@updateContent, 1000)
      do @highlight_code

    componentDidUpdate: ->
      do @highlight_code

    highlight_code: ->
      $("code").each (i, element) =>
        hljs.highlightBlock element

    render: ->
      d.div className: "wrapper",
        Header {}
        Content
          content: @state.updated_content ? @props.content
        Footer {}
