$(function() {

var search_list = $(".listview.js-lazy-load-images");

function appendProduct(product) {
   var html = `<li>
                  <a class="listview__element--right-icon" href="/products/${ product.id }/reviews/new" title="${ product.title }">
                    <div class="position-right p1em">
                      <i class="icon-chevron-right color-sub"></i>
                    </div>
                    <div class="row no-space-bottom">
                      <div class="col2">
                        <div class="thumbnail thumbnail--movies">
                          <div class="thumbnail__figure" style="background-image: url(${ product.image });" title="${ product.title }"></div>
                        </div>
                      </div>
                      <div class="col6 push6">
                        <h3 class="text-middle text-break">
                          <span class="color-sub">${ product.title }</span>
                        </h3>
                        <p class="text-xsmall text-overflow">
                          ${ product.detail }
                        </p>
                      </div>
                    </div>
                  </a>
                </li>`
    search_list.append(html);
  }

 function appendNoProduct(product) {
    var html = `<li>
                  <div class='listview__element--right-icon'>${ product }</div>
                </li>`
    search_list.append(html);
  }

  $(".search__query").on("keyup", function() {
    var input = $(".search__query").val();
    // console.log(input);
    $.ajax({
      type: 'GET',
      url: '/products/search',
      data: { keyword: input },
      dataType: 'json'
    })

   .done(function(products) {
     $(".listview.js-lazy-load-images").empty();
     if (products.length !== 0) {
       products.forEach(function(product){
         appendProduct(product);
       });
     }
     else {
       appendNoProduct("一致する映画はありません");
     }
   })
    .fail(function() {
      alert('映画検索に失敗しました');
    })
  });
});
