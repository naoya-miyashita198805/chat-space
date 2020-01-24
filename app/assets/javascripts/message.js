$(function(){
  var buildHTML = function(message) {
    if (message.content && message.image) {
      //data-idが反映されるようにしている
      var html = `<div class="list-box message" data-message-id= ${message.id} >
        <div class="list-box__contents">
          <div class="list-box__contents__message-name">
            ${message.user_name}
          </div>
          <div class="list-box__contents__message-date">
            ${message.created_at}
          </div>
        </div>
        <div class="list-box__message-text">
          <p class="message-body">
            ${message.content}
          </p>
          <img src=" ${message.image} " class="message-body__image" >
        </div>
      </div>`
    } else if (message.content) {
      //同様に、data-idが反映されるようにしている
      var html = `<div class="list-box message" data-message-id= ${message.id}>
        <div class="list-box__contents">
          <div class="list-box__contents__message-name">
            ${message.user_name}
          </div>
          <div class="list-box__contents__message-date">
            ${message.created_at}
          </div>
        </div>
        <div class="list-box__message-text">
          <p class="message-body">
            ${message.content}
          </p>
        </div>
      </div>`
    } else if (message.image) {
      //同様に、data-idが反映されるようにしている
      var html = `<div class="list-box message" data-message-id= ${message.id} >
        <div class="list-box__contents">
          <div class="list-box__contents__message-name">
            ${message.user_name}
          </div>
          <div class="list-box__contents__message-date">
            ${message.created_at}
          </div>
        </div>
        <div class="message-body">
          <img src=" ${message.image}" class="message-body__image" >
        </div>
      </div>`
    };
    return html;
  };
  
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
      // $('.input-space').val('');
      // 空欄もピンポイントで指定する、なお68行目のresetがあるため記述も不要
      $('.send-btn').prop('disabled', false);
      // なんでも押せるようにするにはそこのクラスピンポイント全体ではない
      $('.new_message')[0].reset();
      // 自動で作られるformクラスにかけてやる
      // フォームを空にする処理、これしないと画像が削除されない
      // あと6８行の構文で6４行目の構文は補填できる
      // 実際resetできた便利
      $('.main-chat__message-list').animate({ scrollTop: $('.main-chat__message-list')[0].scrollHeight});
      // カリキュラム3818に説明あり
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
      $('.send-btn').prop('disabled', false);
    });
  });

  var reloadMessages = function() {
    // これは自動更新の構文
    //カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
    last_message_id = $('.message:last').data("message-id");
    // console.log(last_message_id)この場所で当然last_message_idの値が調べられるぞ
    $.ajax({
      //ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
      // url: "api/messages",これのurlがおかしい？
      url: "api/messages",
      //ルーティングで設定した通りhttpメソッドをgetに指定
      type: 'get',
      dataType: 'json',
      //dataオプションでリクエストに値を含める
      data: {id: last_message_id}
    })
    .done(function(messages) {
      if (messages.length !== 0) {
        // messagesの配列が0ではないとき発動つまり中身がある時
      //追加するHTMLの入れ物を作る
      var insertHTML = '';
      //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
      $.each(messages, function(i, message) {
        
        insertHTML += buildHTML(message)
        // console.log(i);
        // この時点ですでに全てが取得されブラウザに出力されている
        // ここが怪しい、each文が現在の投稿全てが０以上と判断し、
        // 全ての投稿を下記に表示させている。
        // そもそもi で配列を定義しているのに使わないものなのか？答え使わなかった
      });
      //メッセージが入ったHTMLに、入れ物ごと追加
      $('.main-chat__message-list').append(insertHTML);
      $('.main-chat__message-list').animate({ scrollTop: $('.main-chat__message-list')[0].scrollHeight});
      $(".new_message")[0].reset();
      $(".send-btn").prop("disabled", false);
      }
    })
    .fail(function() {
      alert('error');
    });
  };
  if (document.location.href.match(/\/groups\/\d+\/messages/)) {
    setInterval(reloadMessages, 7000);
  }
});
