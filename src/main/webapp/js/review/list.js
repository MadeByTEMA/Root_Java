$('.reviewArea').css('height', (((parseInt(document.querySelectorAll('.reviewForm').length + 1) / 3) + 1) * 330) + 'px');
$(".reviewPlusForm").mouseover(function(){
  $(this).css("border", "2px solid #eb5d1e");
  $('.big.plus.icon').attr('class', 'big orange plus icon')
  });
$(".reviewPlusForm").mouseleave(function(){
  $(this).css("border", "1px solid rgba(34,36,38,.15)");
  $('.big.plus.icon').attr('class', 'big plus icon')
  });
$(".reviewForm").mouseover(function(){
  $(this).find('.title').show();
  $(this).find('.reviewScrapArea').show();
  $(this).find('.reviewStatusButtonArea').show();
  });
$(".reviewForm").mouseleave(function(){
  $(this).find('.title').css('display', 'none');
  $(this).find('.reviewScrapArea').css('display', 'none');
  $(this).find('.reviewStatusButtonArea').css('display', 'none');
  });

// 나중에 마우스 오버 추가하기
