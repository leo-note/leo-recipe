document.addEventListener('DOMContentLoaded', function() {
  // レシピ投稿画面でのみ実行する

  // 画像のプレビュー
  if ( document.getElementById('recipe_image')){
    const ImagePreview = document.getElementById('image_preview');

    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');

      // 表示する画像を生成
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('height', "15%");
      blobImage.setAttribute('width', "15%");

      // 画像の表示
      imageElement.appendChild(blobImage);
      ImagePreview.appendChild(imageElement);
    };

    document.getElementById('recipe_image').addEventListener('change', function(e){
      // 画像が表示されている場合のみ、すでに存在している画像を削除する
      const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  }

  // 材料、分量の複数表示
  if(document.getElementById('add_btn')){
    document.getElementById('add_btn').addEventListener('click', function(e){
      // 材料、分量の親要素
      const Material = document.createElement('div');
      Material.setAttribute('class', 'material');

      // 材料の要素
      const MaterialNameArea = document.createElement('div');
      MaterialNameArea.setAttribute('class','col-6 form-inline');

      const MaterialName = document.createElement('input');
      MaterialName.setAttribute('type','text');
      MaterialName.setAttribute('class','form-control');
      MaterialName.setAttribute('id','material_name');
      MaterialName.setAttribute('name','recipes_form[names][]');
      MaterialName.setAttribute('placeholder','材料');
      MaterialName.setAttribute('maxlength','10');

      MaterialNameArea.appendChild(MaterialName);
      // 分量の要素
      const AmountArea = document.createElement('div');
      AmountArea.setAttribute('class','col-6 form-inline');

      const Amount = document.createElement('input');
      Amount.setAttribute('type','text');
      Amount.setAttribute('class','form-control');
      Amount.setAttribute('id','recipe_amount');
      Amount.setAttribute('name','recipes_form[amounts][]');
      Amount.setAttribute('placeholder','分量');
      Amount.setAttribute('maxlength','10');

      AmountArea.appendChild(Amount);

      // 要素の追加
      Material.appendChild(MaterialNameArea);
      Material.appendChild(Amount);
      const MaterialAddArea = document.getElementById('material_add_area');
      MaterialAddArea.appendChild(Material);
    });
  }
});