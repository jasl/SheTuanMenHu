# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(($)->
  $('#join')
    .live("ajax:complete", (xhr)->
      alert('申请成功发送，等待社团管理员审核。')
    )
    .live("ajax:error", (data, status, xhr)->
      alert("申请失败，请重试。")
    )
  $('#modify')
    .live("ajax:complete", (xhr)->
      alert('修改成功！')
    )
    .live("ajax:error", (data, status, xhr)->
      alert("修改失败，请重试。")
    )
)
