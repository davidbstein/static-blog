dependencies =
  React: "react"
  PageController: "dbs/views/page_controller"
  $: "jquery"
# copy/pastable require.js hacks
define (_v for _, _v of dependencies), () ->
  _i=0; @[_k] = arguments[_i++] for _k of dependencies
#/hacks

  React.render(
    React.createElement PageController, content: JSON.parse(unescape($('#content').text()))
    document.getElementById("render-target")
  )

  s = document.createElement('script')
  s.src = '//davidbstein.disqus.com/embed.js'
  s.setAttribute('data-timestamp', +new Date())
  (document.head or document.body).appendChild(s)
