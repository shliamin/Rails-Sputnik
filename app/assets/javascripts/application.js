// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

 document.querySelector('#sort-asc').onclick = mySort();

function mySort(){
  let nav = document.querySelector('.cards-show');
  for (let i = 0; i < nav.children.length; i++){
    for (let j = 1; j< nav.children.length; j++){
      if(+nav.children[i].getAttribute('data-sort-price') > +nav.children[j].getAttribute('data-sort-price')){
          replacedNode = nav.replaceChild(nav.children[j], nav.children[i]);
          insertAfter(replacedNode, nav.children[i]);
      }
    }
  }
}

function insertAfter(elem, refElem){
  return refElem.parentNode.insertBefore(elem, refElem.nextSibling);
}
