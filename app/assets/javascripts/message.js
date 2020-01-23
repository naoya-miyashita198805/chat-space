$(function(){
  function buildHTML(message){
    // 「もしメッセージに画像が含まれていたら」という条件式
    // 故にmessage.content.present?という文は不要したのように
    // imageがあればif以下が出力され
    // imageがなければelse如何出力される
    // list-boxはrenderに入れないほうがいいかも一応入れてやってみる
    if (message.image) {
      var html = 
      `<div class = "list-box">
        <div class = "list-box__contents">
          <div class = "list-box__contents__message-name">
            ${message.user_name}
          </div>
          <div class = "list-box__contents__message-date">
            ${message.created_at}
          </div>
        </div>
        <div class = "list-box__message-text">
          <div class = "message-body" >
            ${message.content}
          </div>
          <img src = ${message.image}>
        </div>
      </div>`
      return html;
    } else {
      var html = 
      `<div class = "list-box">
        <div class = "list-box__contents">
          <div clss = "list-box__contents__message-name">
            ${message.user_name}
          </div>
          <div class = "list-box__contents__message-date">
            ${message.created_at}
          </div>
        </div>
        <div class = "list-box__message-text">
          <div class = "message-body">
            ${message.content}
          </div>
        </div>
      </div>`
      return html;
    };
  }
  $('#new_message').on('submit', function(e){
    e.preventDefault() 
    var formData = new FormData(this);
    // FormDataは#new_messageのformクラスにかかってくる！
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.main-chat__message-list').append(html);
      // このクラス以降にHTMLの上の記述が入ってくる
      $('.input-space').val('');
      // 空欄もピンポイント
      $('.send-btn').prop('disabled', false);
      // なんでも押せるようにするにはそこのクラスピンポイント全体ではない
      $('.new_message')[0].reset();
      // 自動で作られるformクラスにかけてやる
      // フォームを空にする処理、これしないと画像が削除されない
      // あとおそらく63行の構文で61行は補填できる
      // 実際resetできた便利
      $('.main-chat__message-list').animate({ scrollTop: $('.main-chat__message-list')[0].scrollHeight});
      // カリキュラム3818に説明あり
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
      $('.send-btn').prop('disabled', false);
    });
  });
});
