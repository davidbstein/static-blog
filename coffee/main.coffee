dependencies =
  React: "react"
  PageController: "dbs/views/page_controller"
  $: "jquery"
# copy/pastable require.js hacks
define (_v for _, _v of dependencies), () ->
  _i=0; @[_k] = arguments[_i++] for _k of dependencies
#/hacks

  React.render(
    React.createElement PageController, content: $('body').text()
    document.getElementById("render-target")
  )
