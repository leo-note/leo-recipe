document.addEventListener('DOMContentLoaded', function() {
  // レシピ詳細画面でのみ実行する

  if ( document.getElementById('clip_btn')){
    
    const ClipBtn = document.getElementById('clip_btn');
    ClipBtn.addEventListener('click', function(e){
      
      // clipコントローラーへのリクエスト
      const XHR = new XMLHttpRequest();
      const URL = `/recipes/${gon.receipe_id}/clips`
      XHR.open('POST', URL, true);
      XHR.responseType = "json";
      XHR.send();

      // clipマークとclip数を置き換える
      XHR.onload = () => {
        // clipマーク
        ClipBtn.removeAttribute('type');
        const ClipMarkPath = document.getElementById('clip_mark_path');
        ClipMarkPath.setAttribute("d","M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.283.95l-3.523 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z");

        // clip数
        const TopicsTopLeftBlock = document.getElementById('topics_top_left_block');
        const ClipCount = document.getElementById('clip_count');
        TopicsTopLeftBlock.removeChild(ClipCount);

        const ClipLength = XHR.response.clip_count;
        const NewClipCount = `
         <div class="clip_count">
            ${ClipLength}clip
         </div>`;
         TopicsTopLeftBlock.insertAdjacentHTML("beforeend", NewClipCount);
      };
    });
  }
});