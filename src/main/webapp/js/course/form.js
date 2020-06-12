var course = new Array();
  
{
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = { 
  center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
  level: 3 // 지도의 확대 레벨
};
var map = new kakao.maps.Map(mapContainer, mapOption);
}
{
// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new kakao.maps.MapTypeControl();
// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
// 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
}

var locationArray = new Array();
var markerArray = new Array();
var distanceArray = new Array();

{
  var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
  var clickLine; // 마우스로 클릭한 좌표로 그려질 선 객체입니다
  var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
  var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
}

$('.ui.dropdown').dropdown({
  action:'nothing'
});

$('.minus.icon').css('margin', '0px');
$('.minus.icon').css('padding-left', 'calc(100% - 144px)');
$('.item').attr('style', 'padding:11px 5px 11px 14px !important');

$('#button_calendar')
.calendar({
  type: 'date',
  today: true,
  text: {
  days: ['일', '월', '화', '수', '목', '금', '토'],
  months: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
  monthsShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
  today: 'Today',
  now: 'Now',
  am: 'AM',
  pm: 'PM'
  },
  onChange: function (date, text, mode) {
    startDateChange(date);
  },
  formatter: {
    date: function (date, settings) {
    if (!date) return '';
    var day = date.getDate();
    var month = date.getMonth() + 1;
    month = month >= 10 ? month : '0' + month;
    var year = date.getFullYear();
    day = day >= 10 ? day : '0' + day;
    return year + '년 ' + month + '월 ' + day + '일';
    }
  }
});












{
var placeNameDragDropData = new Object();
var courseDateDragDropData = null;
}

$('.ui.sidebar').sidebar('setting', 'transition', 'overlay');

function sidebarToggle() {
 $('.ui.sidebar').sidebar('toggle');
}





$('.ui.accordion').accordion();

$('.trigger .accordion')
  .accordion({
    selector: {
      trigger: '.title .icon'
    }
  });
  
var heartIconValue = 0;

  $('.ui.rating')
  .rating({
    maxRating: 1,
    onRate: function(value) {
      heartIconValue = value;
    }
  })
;
  
  $('.clearing .rating')
  .rating('setting', 'clearable', true)
;
  
  $(document).ready(function() {
    $('.ui.rating').on("click", function() {
      scrapDataOnCourse(this);
    });
  });
  
  $(document).ready(function() {
    $('.plus.icon').on("click", function() {
      addDate();
    });
  });
  


function submitForm() {
  $('.ui.modal').modal({
    onApprove: function (e) {
      if (e.hasClass('ok')) {
        submit();
      }
    },
  }).modal('show')
}

function submit() {
  courseDataSave();
  getNewForm();
  
  
  document.getElementById('placeForm').innerHTML = "";
  var divForm = '<input class="placeName"  onchange="inputPlaceName();" name="placeNames" type="text" value=""><br>';
  divForm += '<input type="text" class="basicAddr" name="basicAddrs" value="" style="width:240px;" readonly/>';
  divForm += '<input type="text" class="detailAddr" name="detailAddrs" value="" style="width:240px;"/> <br/>';
  divForm += '<input class="etc" name="etcs" value="" type="text"><br>'
  
  document.querySelectorAll('.titlebar')[0].innerHTML = "";
  
  var divTitle = '<input name="title" type="text" value="" placeholder="제목" style="width:100%;"/><br>';
  divTitle += '<input class="dayNo" name="dayNos" type="dayNo" value=""/><br>' 
  divTitle += '<input class="dayLength" type="text" name="dayLengths" value=""/><br>';
  
  
  var count = 0;
  
  for (var i = 0; i < course.length; i++) {
    document.querySelectorAll('.titlebar')[0].innerHTML += divTitle;
    for (var j = 0; j < course[i].length; j++) {
      document.getElementById('placeForm').innerHTML += divForm;
    }
  }
  
  for (var i = 0; i < course.length; i++) {
    if (i == 0) {
      document.getElementsByName('dayDate')[0].value = course[0].dayDate;
    }
    document.getElementsByName('title')[i].value = course[i].title;
    if (typeof course[i].no == "undefined") {
      document.querySelectorAll('.dayNo')[i].value = course[i].no;
    }
    document.querySelectorAll('.dayLength')[i].value = course[i].length;
    for (var j = 0; j < course[i].length; j++) {
      document.getElementsByName('placeNames')[count].value = course[i][j].placeName;
      document.querySelectorAll('.basicAddr')[count].value = course[i][j].basicAddr;
      document.querySelectorAll('.detailAddr')[count].value = course[i][j].detailAddr;
      document.querySelectorAll('.etc')[count].value = course[i][j].etc;
      count++;
    }
  }
  
  for (var i = 0; i < course.length; i++) {
    if (i == 0) {
      console.log(i + "시작일 : " + course[i].dayDate);
    }
    console.log(i + "번째 title : " + course[i].title);
    console.log(i + "번째 dayNo : " + course[i].no);
    console.log(i + "번째 dayLength : " + course[i].length);

    for (var j = 0; j < course[i].length; j++) {
      console.log(i + "번째의 " + j +  " 번째 placeName : " + course[i][j].placeName);
      console.log(i + "번째의 " + j +  " 번째 basicAddr : " + course[i][j].basicAddr);
      console.log(i + "번째의 " + j +  " 번째 detailAddr : " + course[i][j].detailAddr);
      console.log(i + "번째의 " + j +  " 번째 etc : " + course[i][j].etc);
    }
  }
  
  document.getElementById('addForm').submit();
}

function courseDataSave() {
  for (var i = 0; i < document.querySelectorAll('.item').length; i++) {
    if (course.length == 0 || calculateDate(course[0].dayDate, i) == calculateDate((document.getElementById('dropdown').childNodes[5].childNodes[1].innerHTML).substring(55))) {   
      var courseDay = new Array();
      for (var j = 0; j < document.querySelectorAll('.placeName').length; j++) {
        var coursePlace = new Object();
        coursePlace.placeName = document.querySelectorAll('.placeName')[j].value;
        coursePlace.basicAddr = document.querySelectorAll('.basicAddr')[j].value;
        coursePlace.detailAddr = document.querySelectorAll('.detailAddr')[j].value;
        coursePlace.etc = document.querySelectorAll('.etc')[j].value;
        courseDay.push(coursePlace);
      }
      if (course.length != 0) {
      courseDay.no = course[i].no;
      }
      courseDay.title = document.getElementsByName('title')[0].value;
      courseDay.dayDate = calculateDate((document.getElementById('dropdown').childNodes[5].childNodes[1].innerHTML).substring(55));
      course[i] = courseDay; 
      break;
    }
  }
}

function courseDataReload(obj) {
  if (obj == null) {
    for (var i = 0; i < course.length; i++) {
      if (i == 0) {
        insertDayData(0);
      } else {
        addDate();
      }
    }
  } else {
    for (var i = 0; i < course.length; i++) {
      if (obj.innerHTML == document.querySelectorAll('.innerlineDate')[0].innerHTML) {
        if (i == 0) {
          courseDataSave();
          insertDayData(0);
          insertInnerDate(obj);
          break;
        }
      } 
      if (obj.innerHTML == course[i].dayDate) {
        courseDataSave();
        insertDayData(i);
        insertInnerDate(obj);
        dropdownInit();
        break;
      }
      if (i + 1 == course.length && obj.innerHTML != course[i].dayDate) {
        courseDataSave();
        getNewForm();
        insertInnerDate(obj);
        dropdownInit();
        break;
      }
    }
    if (document.querySelectorAll('.menu.transition.visible')[0] != null) {
      document.querySelectorAll('.menu.transition.visible')[0].className = 'menu transition hidden';
    }
  }
  inputPlaceName();
  getGeoLocation();
}

function insertInnerDate(obj) {
  document.getElementById('dropdown').childNodes[5].innerHTML = '<div class="dayCount">' + obj.parentNode.childNodes[0].innerHTML + '</div>';
  document.getElementById('dropdown').childNodes[5].innerHTML += '<div class="innerDate"><input type="hidden" name="dayDate" value="'+ obj.parentNode.childNodes[1].innerHTML + '">' + obj.parentNode.childNodes[1].innerHTML + '</div>';
  document.getElementById('dropdown').className = 'ui selection dropdown';
}

function insertDayData(i) {
  getNewForm();
  document.getElementsByName('title')[0].value = course[i].title;
  for (var j = 0; j < course[i].length; j++) {
    if (j != 0) {
      addForm();
    }
    document.querySelectorAll('.placeName')[j].value = course[i][j].placeName;
    document.querySelectorAll('.basicAddr')[j].value = course[i][j].basicAddr;
    document.querySelectorAll('.detailAddr')[j].value = course[i][j].detailAddr;
    document.querySelectorAll('.etc')[j].value = course[i][j].etc;
  }
  if (i != 0) {
    inputPlaceName();
    getGeoLocation();
  }
}

function getNewDayForm() {
  document.getElementsByName('title')[0].value = "";
  var nullDataHTML = `     <div id="placeForm">
  장소명: <input class="placeName"  onchange="inputPlaceName();" name="placeNames" type="text"><br>
  기본주소:<input type="text" class="basicAddr" name="basicAddrs" style="width:240px;" readonly/> 
  <input type="button" onChange="getGeoLocation();" onClick="openDaumZipAddress(this);" value = "주소 찾기" /><br/>
  상세주소:<input type="text" class="detailAddr" name="detailAddrs" style="width:240px;"/> <br/>
  비고: <input class="etc" name="etcs" type="text"><br>
  </div>
  <div id="leftField"></div>
  <button type="button" onclick="addForm()"> 코스 추가</button> <br>
  <button type="button" onclick="submitForm()">등록</button> <br>`;
  document.querySelectorAll('.leftContent')[0].innerHTML = nullDataHTML;
  document.getElementById('rightField').innerHTML = "";
}
  
function changeCourseDate(obj) {
  if (obj != null) {
    for (var i = 0; i < document.querySelectorAll('.item').length; i++) {
      course[i].dayDate = calculateDate(obj, i);
    }
  } else {
    for (var i = 0; i < document.querySelectorAll('.item').length; i++) {
      if (course[i] == null) {
        var coursePlace = new Object();
        coursePlace.placeName = "";
        coursePlace.basicAddr = "";
        coursePlace.detailAddr = "";
        coursePlace.etc = "";
        var courseDay = new Array();
        courseDay.push(coursePlace);
        courseDay.title = "";
        course[i] = courseDay;
      }
      course[i].dayDate = calculateDate(document.querySelectorAll('.innerlineDate')[0].innerHTML, i);
    }
  }
}
  
function dropdownInit(obj) {
   for (var i = 0; i < document.querySelectorAll('.item').length; i++) {
     var str = '<div class="innerline"><div class="innerlineDay">Day' + (i + 1) + '</div>';
     var firstDate = new Object();
     if (obj != null) {
       firstDate = calculateDate(obj);
     } else {
       firstDate = document.querySelectorAll('.innerlineDate')[0].innerHTML;
     }
     var calculDate = calculateDate(firstDate, i);
     str += '<div class="innerlineDate" onclick="courseDataReload(this);">' + calculDate + '</div></div>';
//       if (i == 0) {
//         str += '<div class="minusArea"><i class="minus icon" style="margin: 0px; padding-left: calc(100% - 144px);"></i></div>'
//       } else {
     str += '<div class="minusArea" onclick="removeDate(this)"><i class="minus icon" style="margin: 0px; padding-left: calc(100% - 144px);"></i></div>'
//     }
     document.querySelectorAll('.item')[i].innerHTML = str;
     (document.querySelectorAll('.item')[i]).setAttribute('data-text', calculDate);
  }
}

function removeDate(event) {
  if (document.querySelectorAll('.item').length == 1) {
    console.log("마지막 하나는 지울 수 없습니다.");
  } else {
    //(obj.parentNode.parentNode).removeChild(obj.parentNode);
    var newFirstDay = null;
    if (event.parentNode.getAttribute('data-text') == course[0].dayDate) {
      newFirstDay = course[0].dayDate;
    }
    newCourse = new Array();
    for (var i = 0; i < course.length; i++) {
      if (event.parentNode.getAttribute('data-text') != course[i].dayDate) {
        newCourse.push(course[i]); 
      }
    }
    course = newCourse;
    if (newFirstDay != null) {
      getNewDropdown();
      $('#button_calendar').calendar('set date', new Date(newFirstDay));
      insertDayData(0);
    } else {
      getNewDropdown();
      $('#button_calendar').calendar('set date', course[0].dayDate);
      insertDayData(0);
    }
    courseDataReload();
  }
}

function getNewDropdown() {
  var newInnerHTML = `        <input type="hidden" name="selectDate" class="noselection">
      <i class="dropdown icon"></i>
      <div class="default text">Day
        <div class="innerDate"></div>
      </div>
        <div class="menu" tabindex="-1">
          <div class="item" draggable="true" ondragstart="courseDateDrag(event)" ondrop="courseDateDrop(event)" ondragover="allowDrop(event)" data-text="2020-05-02" style="padding:11px 5px 11px 14px !important">
            <div class="innerline">
              <div class="innerlineDay">Day1</div>
              <div class="innerlineDate" onclick="courseDataReload(this);">2020-05-04</div>
            </div>
            <div class="minusArea">
              <i class="minus icon" style="margin: 0px; padding-left: calc(100% - 144px);"></i>
            </div>
          </div>
          <div class="plus"><i class="plus icon" onclick="addDate();"></i></div>
      </div>`;
  document.getElementById('dropdown').innerHTML = newInnerHTML
  $('.ui.dropdown').dropdown({
    action:'nothing'
  });
}

function addDate() {
  // 기존 plusdiv datadiv(item)로 변경
  var datadiv = document.querySelectorAll('.plus')[0];
  datadiv.className = 'item';
  $('.item').attr('style', 'padding:11px 5px 11px 14px !important');
  $('.item').attr('draggable', 'true');
  $('.item').attr('ondragstart', 'courseDateDrag(event)');
  $('.item').attr('ondrop', 'courseDateDrop(event)');
  $('.item').attr('ondragover', 'allowDrop(event)');
  
  var plusdiv = document.createElement('div');
  plusdiv.className = 'plus';
  plusdiv.innerHTML += '<i class="plus icon" onclick="addDate();"></i>'
  
  // plusdiv 생성
  document.getElementById('dropdown').childNodes[7].appendChild(plusdiv);
  
  dropdownInit();
  changeCourseDate();
}

function scrapDataOnCourse(obj) {
  if (heartIconValue == 1) {
    if (document.querySelectorAll('.placeName').length == 1 && document.querySelectorAll('.placeName')[0].value == ""
      && document.querySelectorAll('.basicAddr')[0].value == "" && document.querySelectorAll('.detailAddr')[0].value == "") {
      var placeNames = document.querySelectorAll('.placeName');
      for (var i = 3; i < obj.parentNode.parentNode.childNodes.length; i += 4) {
        if((obj.parentNode.parentNode.childNodes[i].childNodes[0].textContent).substring(23)==(obj.parentNode.childNodes[0].textContent).substring(23)) {
          if(obj.parentNode.parentNode.parentNode.parentNode.id=="accordionArea") {
            placeNames[0].value = (obj.parentNode.parentNode.childNodes[i-2].childNodes[2].textContent).substring(17);
          } else {
            placeNames[0].value = (obj.parentNode.parentNode.childNodes[i-2].childNodes[2].textContent).substring(23);
          }
          // input(placeNames[0]);
          inputPlaceName();
        }
      }
      var basicAddrs = document.querySelectorAll('.basicAddr');
      var detailAddrs = document.querySelectorAll('.detailAddr');
      if(obj.parentNode.parentNode.parentNode.parentNode.id=="accordionArea") {
        basicAddrs[0].value = (obj.parentNode.childNodes[0].textContent).substring(17);
        detailAddrs[0].value = (obj.parentNode.childNodes[2].textContent).substring(17);
      } else {
        basicAddrs[0].value = (obj.parentNode.childNodes[0].textContent).substring(23);
        detailAddrs[0].value = (obj.parentNode.childNodes[2].textContent).substring(23);
      }
    } else {
    addForm();
    var placeNames = document.querySelectorAll('.placeName');
    for (var i = 3; i < obj.parentNode.parentNode.childNodes.length; i += 4) {
      if((obj.parentNode.parentNode.childNodes[i].childNodes[0].textContent).substring(23)==(obj.parentNode.childNodes[0].textContent).substring(23)) {
        if(obj.parentNode.parentNode.parentNode.parentNode.id=="accordionArea") {
          placeNames[placeNames.length-1].value = (obj.parentNode.parentNode.childNodes[i-2].childNodes[2].textContent).substring(17);
        } else {
          placeNames[placeNames.length-1].value = (obj.parentNode.parentNode.childNodes[i-2].childNodes[2].textContent).substring(23);
        }
        // input(placeNames[placeNames.length-1]);
        inputPlaceName();
      }
    }
      var basicAddrs = document.querySelectorAll('.basicAddr');
      var detailAddrs = document.querySelectorAll('.detailAddr');
      if(obj.parentNode.parentNode.parentNode.parentNode.id=="accordionArea") {
        basicAddrs[placeNames.length-1].value = (obj.parentNode.childNodes[0].textContent).substring(17);
        detailAddrs[placeNames.length-1].value = (obj.parentNode.childNodes[2].textContent).substring(17);
      } else {
        basicAddrs[placeNames.length-1].value = (obj.parentNode.childNodes[0].textContent).substring(23);
        detailAddrs[placeNames.length-1].value = (obj.parentNode.childNodes[2].textContent).substring(23);
      }
    }
  }
  getGeoLocation();
}
  
function inputPlaceName() {
  for (var i = 0; i < document.querySelectorAll('.placeName').length; i++) {
  document.querySelectorAll('.showPlaceName')[i].value = document.querySelectorAll('.placeName')[i].value;
  }
}

function allowDrop(ev) {
  ev.preventDefault();
}

function courseDateDrag(ev) {
  for (var i = 0; i < course.length; i++) {
    if (course[i].dayDate == ev.target.childNodes[0].childNodes[1].innerHTML) {
      courseDateDragDropData = new Object();
      var courseDay = new Array();
      for (var j = 0; j < course[i].length; j++) {
        courseDateDragDropData.index = i;
        var coursePlace = new Object();
        coursePlace.placeName = course[i][j].placeName;
        coursePlace.basicAddr = course[i][j].basicAddr;
        coursePlace.detailAddr = course[i][j].detailAddr;
        coursePlace.etc = course[i][j].etc;
        courseDay.push(coursePlace);
      }
      courseDay.dayDate = course[i].dayDate;
      courseDay.title = course[i].title;
      courseDay.no = course[i].no;
      courseDateDragDropData.courseDay = courseDay;
    }
  }
}

function courseDateDrop(ev) {
  ev.preventDefault();
  if (ev.target.parentNode.parentNode.className == 'item') {
    for (var i = 0; i < course.length; i++) {
      if (course[i].dayDate == ev.target.parentNode.childNodes[1].innerHTML) {
        var courseDay = new Array();
        for (var j = 0; j < course[i].length; j++) {
          var coursePlace = new Object();
          coursePlace.placeName = course[i][j].placeName;
          coursePlace.basicAddr = course[i][j].basicAddr;
          coursePlace.detailAddr = course[i][j].detailAddr;
          coursePlace.etc = course[i][j].etc;
          courseDay.push(coursePlace);
        }
        courseDay.title = course[i].title;
        
        courseDay.no = courseDateDragDropData.courseDay.no;
        courseDay.dayDate = courseDateDragDropData.courseDay.dayDate;
        course[courseDateDragDropData.index] = courseDay;
        
        courseDateDragDropData.courseDay.no = course[i].no;
        courseDateDragDropData.courseDay.dayDate = course[i].dayDate;
        course[i] = courseDateDragDropData.courseDay;
        
        }
      }
    for (var x = 0; x < course.length; x++) {
      if (ev.target.parentNode.childNodes[1].innerHTML == document.querySelectorAll('.innerlineDate')[0].innerHTML) {
        if (i == 0) {
          insertDayData(0);
          insertInnerDate(ev.target.parentNode.childNodes[1]);
          break;
        }
      } 
      if (ev.target.parentNode.childNodes[1].innerHTML == course[x].dayDate) {
        insertDayData(x);
        insertInnerDate(ev.target.parentNode.childNodes[1]);
        dropdownInit();
        break;
      }
      if (x + 1 == course.length && ev.target.parentNode.childNodes[1].innerHTML != course[x].dayDate) {
        getNewForm();
        insertInnerDate(ev.target.parentNode.childNodes[1]);
        dropdownInit();
        break;
      }
    }
    if (document.querySelectorAll('.menu.transition.visible')[0] != null) {
      document.querySelectorAll('.menu.transition.visible')[0].className = 'menu transition hidden';
    }
  } else {
  }
}

function placeNameDrag(ev) {
  dragEvent = ev.target;
  if (ev.target.parentNode.parentNode.id == "rightField") {
    placeNameDragDropData.index = $(ev.target.parentNode).index();
    var leftFieldDiv = document.getElementById("leftField");
    for (var i = 0; i < leftFieldDiv.childNodes.length; i++) {
      if (i == placeNameDragDropData.index) {
        placeNameDragDropData.placeName = $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.placeName').val();
        placeNameDragDropData.basicAddr = $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.basicAddr').val();
        placeNameDragDropData.detailAddr = $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.detailAddr').val();
        placeNameDragDropData.etc = $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.etc').val();
        break;
      }
    }
  } else { // 가장 첫번째 place
    placeNameDragDropData.index = "first";
    var placeFormDiv = document.getElementById("placeForm");
    placeNameDragDropData.placeName = $(placeFormDiv).find('.placeName').val();
    placeNameDragDropData.basicAddr = $(placeFormDiv).find('.basicAddr').val();
    placeNameDragDropData.detailAddr = $(placeFormDiv).find('.detailAddr').val();
    placeNameDragDropData.etc = $(placeFormDiv).find('.etc').val();
  }
}

function placeNameDrop(ev) {
  ev.preventDefault();
  var tempData = new Object();
  tempData.index = $(ev.target.parentNode).index();
  drawingFlag = false;
  if (placeNameDragDropData.index == "first") { // drag가 가장 첫번째 place인지 확인
    var leftFieldDiv = document.getElementById("leftField");
    tempData.placeName = $(leftFieldDiv.childNodes[tempData.index]).find('.placeName').val();
    tempData.basicAddr = $(leftFieldDiv.childNodes[tempData.index]).find('.basicAddr').val();
    tempData.detailAddr = $(leftFieldDiv.childNodes[tempData.index]).find('.detailAddr').val();
    tempData.etc = $(leftFieldDiv.childNodes[tempData.index]).find('.etc').val();
    
    $(leftFieldDiv.childNodes[tempData.index]).find('.placeName').val(placeNameDragDropData.placeName);
    $(leftFieldDiv.childNodes[tempData.index]).find('.basicAddr').val(placeNameDragDropData.basicAddr);
    $(leftFieldDiv.childNodes[tempData.index]).find('.detailAddr').val(placeNameDragDropData.detailAddr);
    $(leftFieldDiv.childNodes[tempData.index]).find('.etc').val(placeNameDragDropData.etc);
    
    var placeFormDiv = document.getElementById("placeForm");
    $(placeFormDiv).find('.placeName').val(tempData.placeName);
    $(placeFormDiv).find('.basicAddr').val(tempData.basicAddr);
    $(placeFormDiv).find('.detailAddr').val(tempData.detailAddr);
    $(placeFormDiv).find('.etc').val(tempData.etc);
    
    // input(placeFormDiv.childNodes[1]);
    // input(leftFieldDiv.childNodes[tempData.index].childNodes[1]);
    inputPlaceName();
    
  } else if (ev.target.parentNode.parentNode.id == "rightField") { // drag &
                                                                    // drop 둘다
                                                                    // first
                                                                    // place
                                                                    // 아님.
    var leftFieldDiv = document.getElementById("leftField");
    tempData.placeName = $(leftFieldDiv.childNodes[tempData.index]).find('.placeName').val();
    tempData.basicAddr = $(leftFieldDiv.childNodes[tempData.index]).find('.basicAddr').val();
    tempData.detailAddr = $(leftFieldDiv.childNodes[tempData.index]).find('.detailAddr').val();
    tempData.etc = $(leftFieldDiv.childNodes[tempData.index]).find('.etc').val();
    
    $(leftFieldDiv.childNodes[tempData.index]).find('.placeName').val(placeNameDragDropData.placeName);
    $(leftFieldDiv.childNodes[tempData.index]).find('.basicAddr').val(placeNameDragDropData.basicAddr);
    $(leftFieldDiv.childNodes[tempData.index]).find('.detailAddr').val(placeNameDragDropData.detailAddr);
    $(leftFieldDiv.childNodes[tempData.index]).find('.etc').val(placeNameDragDropData.etc);
    
    $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.placeName').val(tempData.placeName);
    $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.basicAddr').val(tempData.basicAddr);
    $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.detailAddr').val(tempData.detailAddr);
    $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.etc').val(tempData.etc);
    
    // input(leftFieldDiv.childNodes[tempData.index].childNodes[1]);
    // input(leftFieldDiv.childNodes[placeNameDragDropData.index].childNodes[1]);
    inputPlaceName();
    
  } else { // drop이 first place.
    var placeFormDiv = document.getElementById("placeForm");
    tempData.placeName = $(placeFormDiv).find('.placeName').val();
    tempData.basicAddr = $(placeFormDiv).find('.basicAddr').val();
    tempData.detailAddr = $(placeFormDiv).find('.detailAddr').val();
    tempData.etc = $(placeFormDiv).find('.etc').val();
    
    $(placeFormDiv).find('.placeName').val(placeNameDragDropData.placeName);
    $(placeFormDiv).find('.basicAddr').val(placeNameDragDropData.basicAddr);
    $(placeFormDiv).find('.detailAddr').val(placeNameDragDropData.detailAddr);
    $(placeFormDiv).find('.etc').val(placeNameDragDropData.etc);
    
    var leftFieldDiv = document.getElementById("leftField");
    $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.placeName').val(tempData.placeName);
    $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.basicAddr').val(tempData.basicAddr);
    $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.detailAddr').val(tempData.detailAddr);
    $(leftFieldDiv.childNodes[placeNameDragDropData.index]).find('.etc').val(tempData.etc);
    
    // input();leftFieldDiv.childNodes[placeNameDragDropData.index].childNodes[1]);
    // input(placeFormDiv.childNodes[1]);
    inputPlaceName();
    
  }
  
  getGeoLocation();
}













function removeForm(obj){
  if (document.querySelectorAll('.reviewPlace').length != 1) {
    document.getElementById('rightField').removeChild(document.getElementById("rightField").childNodes[$(obj.parentNode).index()]);
    document.getElementById('leftField').removeChild(obj.parentNode);
    getGeoLocation();
  }
}

function addForm(){
  var div = document.createElement('div');
  var str = document.getElementById('placeForm').innerHTML;
  str +=  '<button type="button" onclick="removeForm(this)"> 코스 삭제</button>';
  div.innerHTML = str;
  document.getElementById('leftField').appendChild(div);
  
  var div2 = document.createElement('div');
  var str2 = '<input class="showPlaceName" draggable="true" ondragstart="placeNameDrag(event)" ondrop="placeNameDrop(event)" ondragover="allowDrop(event)" type="text" readonly>';
  div2.innerHTML = str2;
  document.getElementById('rightField').appendChild(div2);
}

function displayCourseDayByIndex(index) { // 현재 review Array에 맞는 Page를 보여준다.
  
}

function calculateDate(date, addDays) {
  var dateFormData = new Date(date);
  if (typeof addDays == "number") {
    dateFormData.setDate(dateFormData.getDate() + addDays);
  }
  var day = dateFormData.getDate();
  var month = dateFormData.getMonth() + 1;
  month = month >= 10 ? month : '0' + month;
  var year = dateFormData.getFullYear();
  day = day >= 10 ? day : '0' + day;
  
  return year + '-' + month + '-' + day;
}

function startDateChange(date) { // startDate가 변동되면, Date dropdown에 적용한다.
  if (calculateDate(date) != course[0].dayDate) {
    for (var i = 0; i < course.length; i++) {
      course[i].dayDate = calculateDate(date, i);
    } 
  }
}

function courseDataInit(courseData) {
  if (courseData.length != 0) {
    course = courseData;
    $('#button_calendar').calendar('set date', new Date(course[0].dayDate));
    displayCourseDayByIndex(0);
  }
}

function openDaumZipAddress(btn) { // 주소 API 연결
  new daum.Postcode({
    oncomplete:function(data) {
      $(btn.parentNode).find('.basicAddr').val(data.address);
      $(btn.parentNode).find('.detailAddr').focus(); // 상세주소에 focus 주기
      getGeoLocation();
    }
  }).open();
}
function getGeoLocation() {
  drawingFlag = false;
  deleteClickLine();
  deleteCircleDot();
  deleteDistnce();
  deleteMarker();
  locationArray = new Array();
  var geocoder = new kakao.maps.services.Geocoder();
  var basicAddrs = document.querySelectorAll('.basicAddr');
  for (let i = 0; i < basicAddrs.length; i++) {
    geocoder.addressSearch(basicAddrs[i].value, function(result, status) {
      if (status === kakao.maps.services.Status.OK) {
        locationArray[i] = {x:result[0].x, y:result[0].y};
      }
    });
  }
  
  setTimeout(() => {
    displayMarkers(locationArray);      
  }, 1000);
}

function displayMarkers(geoLocations) {
  var bounds = new kakao.maps.LatLngBounds();

  for (var i = 0; i < geoLocations.length; i++) {
    var geoLocation = geoLocations[i];
    var markerPosition = new kakao.maps.LatLng(geoLocation.y, geoLocation.x);
    var marker = new kakao.maps.Marker({
      position: markerPosition
    });
    marker.setMap(map);
    markerArray.push(marker);
    // LatLngBounds 객체에 좌표를 추가합니다
    bounds.extend(markerPosition);
    mapDrawingStart(i);
  }
  
  if (geoLocations.length == 1) {
    map.panTo(markerPosition);
  }
  map.setBounds(bounds);
}

function getLocation(address) {
  var geocoder = new kakao.maps.services.Geocoder();
  var location = new Object();
  var markerPosition = "";
  var callback = function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
      location.x = result[0].x;
      location.y = result[0].y;
      locationArray.push(location);
      if (locationArray.length == 1) {
        deleteClickLine();
        deleteCircleDot();
        deleteDistnce();
        deleteMarker();
        markerPosition = new kakao.maps.LatLng(location.y, location.x);
        var marker = new kakao.maps.Marker({
          position: markerPosition
        });
        marker.setMap(map);
        markerArray.push(marker);
        map.panTo(markerPosition);
      } else {
        mapReMapping();
      }
    }
  };
  geocoder.addressSearch(address, callback);
}


function mapReMapping() {
var bounds = new kakao.maps.LatLngBounds();
var marker;
drawingFlag = false;
for (var i = 0; i < locationArray.length; i++) {
    // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
    var points = new kakao.maps.LatLng(locationArray[i].y, locationArray[i].x);
    marker = new kakao.maps.Marker({ position : points });
    marker.setMap(map);
    markerArray.push(marker);
    // LatLngBounds 객체에 좌표를 추가합니다
    bounds.extend(points);
    mapDrawingStart(i);
  }
  map.setBounds(bounds);
}

function mapDrawingStart(i) {
  var points = new kakao.maps.LatLng(locationArray[i].y, locationArray[i].x);
  if (!drawingFlag) {
    drawingFlag = true;
    deleteClickLine();
    deleteCircleDot();
    deleteDistnce();
    clickLine = new kakao.maps.Polyline({
      map: map, // 선을 표시할 지도입니다
      path: [points], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
      strokeWeight: 3, // 선의 두께입니다
      strokeColor: '#db4040', // 선의 색깔입니다
      strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
      strokeStyle: 'solid' // 선의 스타일입니다
    });
  } else {
    var preDistance = Math.round(clickLine.getLength());
    var path = clickLine.getPath();
    path.push(points);
    clickLine.setPath(path);
    var totalDistance = Math.round(clickLine.getLength());
    content = getTimeHTML(totalDistance - preDistance);
    showDistance(content, points);
  }
}

function deleteClickLine() {
  if (clickLine) {
      clickLine.setMap(null);    
      clickLine = null;        
  }
}

function deleteDistnce() {
  for (var i = 0; i < distanceArray.length; i++) {
    if (distanceArray[i]) {
    (distanceArray[i]).setMap(null);
    distanceArray[i] = null;
    delete distanceArray[i];
    }
  }
}

function deleteMarker() {
  for (var i = 0; i < markerArray.length; i++) {
    if (markerArray[i]) {
    (markerArray[i]).setMap(null);
    markerArray[i] = null;
    delete markerArray[i];
    }
  }
}

function deleteCircleDot() {
  var i;
  for ( i = 0; i < dots.length; i++ ){
      if (dots[i].distance) {
          dots[i].distance.setMap(null);
      }
  }
  dots = [];
}

function showDistance(content, position) {
  distanceOverlay = new kakao.maps.CustomOverlay({
    map: map, // 커스텀오버레이를 표시할 지도입니다
    content: content,  // 커스텀오버레이에 표시할 내용입니다
    position: position, // 커스텀오버레이를 표시할 위치입니다.
    xAnchor: 0,
    yAnchor: 0,
    zIndex: 3  
});
  distanceArray.push(distanceOverlay);
}

function getTimeHTML(distance) {

  // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
  var walkkTime = distance / 67 | 0;
  var walkHour = '', walkMin = '';

  // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
  if (walkkTime > 60) {
      walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
  }
  walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

  // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
  var bycicleTime = distance / 227 | 0;
  var bycicleHour = '', bycicleMin = '';

  // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
  if (bycicleTime > 60) {
      bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
  }
  bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

  // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
  var content = '<ul class="dotOverlay distanceInfo">';
  content += '    <li>';
  content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
  content += '    </li>';
  content += '    <li>';
  content += '        <span class="label">도보</span>' + walkHour + walkMin;
  content += '    </li>';
  content += '    <li>';
  content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
  content += '    </li>';
  content += '</ul>'

  return content;
}
