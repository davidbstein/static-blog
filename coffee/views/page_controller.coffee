dependencies =
  React: "react"
  cx: 'cx'
  $: "jquery"

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
            d.li {}, d.a href: "/blog", "blog"
            d.li {}, d.a href: "/projects", "projects"
            d.li {}, d.a href: "/about", "about"
            d.li {}, d.a href: "/contact", "contact"

  Content = React.createFactory React.createClass
    displayName: "ContentView"

    render: ->
      d.div
        id: 'content-wrapper'
        "#{@props.content}"

  Footer = React.createFactory React.createClass
    displayName: "FooterView"

    render: ->
      d.div
        id: 'footer-wrapper'

  PageController = React.createClass
    displayName: "PageController"

    propTypes:
      content: React.PropTypes.string

    getInitialState: -> {}

    render: ->
      d.div className: "wrapper",
        Header {}
        Content content: @props.content
        Footer {}
