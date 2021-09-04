document.addEventListener('DOMContentLoaded', function() {
  // ユーザー詳細画面でのみ実行する

  if (document.getElementById('follow_btn')){
    const FollowBtn = document.getElementById('follow_btn');
    FollowBtn.addEventListener('click', function(e){
      
      // コントローラーへのリクエスト
      const XHR = new XMLHttpRequest();
      const URL = `/users/${gon.user_id}/follows`
      XHR.open('POST', URL, true);
      XHR.responseType = "json";
      XHR.send();

      // clipマークとclip数を置き換える
      XHR.onload = () => {
        // followマーク
        FollowBtn.removeAttribute('type');
        const FollowMarkPath = document.getElementById('follow_mark_path');
        FollowMarkPath.setAttribute("d","M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.283.95l-3.523 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z");

        // フォロワー数
        const FollowInformation = document.getElementById('follow_information');
        const FollowerCount = document.getElementById('follower_count');
        FollowInformation.removeChild(FollowerCount);

        const FollowerLength = XHR.response.follower_count;
        const NewFollowerCount = `
         <div class="follower_count">
            ${FollowerLength}フォロワー
         </div>`;
        FollowInformation.insertAdjacentHTML("beforeend", NewFollowerCount);
      };
    });
  }
});
