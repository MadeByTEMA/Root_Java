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

{
  var placeNameDragDropData = new Object();
  var courseDateDragDropData = null;
  }

$('.ui.sidebar').sidebar('setting', 'transition', 'overlay');

function sidebarToggle() {
 $('.ui.sidebar').sidebar('toggle');
}

$('.ui.dropdown').dropdown({
  action:'nothing'
});

$('.minus.icon').css('margin', '0px');
$('.minus.icon').css('padding-left', 'calc(100% - 144px)');
$('.item').attr('style', 'padding:11px 5px 11px 14px !important');

$('#placeAddPlusButtonIcon').on("click", function() {
  addFormByEvent();
});

$('.ui.accordion').accordion();

$('.trigger .accordion')
  .accordion({
    selector: {
      trigger: '.title .icon'
    }
  });
  
var starvalue = 0;

  $('.ui.rating')
  .rating({
    maxRating: 1,
    onRate: function(value) {
      starvalue = value;
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
  
  $('.plus').on("click", '.plus.icon', function() {
    addDate();
  });
  

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

function submitForm() {
  $('#submitModal').modal({
    onApprove: function (e) {
      if (e.hasClass('ok')) {
        submit();
      }
    },
  }).modal('show')
}

function courseDataSave() {
  console.log(course);
  var index = (document.querySelectorAll('.dayCount')[0].innerHTML).substring(3, 5) - 1;
  console.log("index: " + index);
  for (var i = 0; i < course[index].length; i++) {
    console.log("i번째: " + i);
    console.log(document.querySelectorAll('.placeName')[i].value);
    console.log(document.querySelectorAll('.basicAddr')[i].value);
    console.log(document.querySelectorAll('.detailAddr')[i].value);
    console.log(document.querySelectorAll('.etc')[i].value);
    
    course[index][i].placeName = document.querySelectorAll('.placeName')[i].value;
    course[index][i].basicAddr = document.querySelectorAll('.basicAddr')[i].value;
    course[index][i].detailAddr = document.querySelectorAll('.detailAddr')[i].value;
    course[index][i].etc = document.querySelectorAll('.etc')[i].value;
  }
  console.log(document.querySelectorAll('.placeTitle')[0].value);
  course[index].title = document.querySelectorAll('.placeTitle')[0].value;
  
  console.log(course);
}


function submit() { // JSON으로는 안되는거 같다. 그냥 배열로 받자.
  courseDataSave();
  
  document.getElementById('placeForm').innerHTML = "";
  var divPlaceForm = '<input class="placeName"  onchange="inputPlaceName();" name="placeNames" type="text" value=""><br>';
  divPlaceForm += '<input type="text" class="basicAddr" name="basicAddrs" value="" />';
  divPlaceForm += '<input type="text" class="detailAddr" name="detailAddrs" value="" /> <br/>';
  divPlaceForm += '<input class="etc" name="etcs" value="" type="text"><br>'  
    
  document.querySelectorAll('.titlebar')[0].innerHTML = "";
  var divDayForm = '<input class="placeTitle" name="titles" type="text" value="" placeholder="제목"/><br>';
  divDayForm += '<input class="dayLength" type="text" name="dayLengths" value=""/><br>';
  
  setTimeout(() => {
  var count = 0;
  
  for (var i = 0; i < course.length; i++) {
    document.querySelectorAll('.titlebar')[0].innerHTML += divDayForm;
    for (var j = 0; j < course[i].length; j++) {
      document.querySelectorAll('.coursePlaceArea')[0].innerHTML += divPlaceForm;
    }
  }
  
  
  for (var i = 0; i < course.length; i++) {
    if (i == 0) {
      document.getElementsByName('dayDate')[0].value = course[0].dayDate;
    }
    document.querySelectorAll('.placeTitle')[i].value = course[i].title;
    document.querySelectorAll('.dayLength')[i].value = course[i].length;
    
    for (var j = 0; j < course[i].length; j++) {
      document.querySelectorAll('.placeName')[count].value = course[i][j].placeName;
      document.querySelectorAll('.basicAddr')[count].value = course[i][j].basicAddr;
      document.querySelectorAll('.detailAddr')[count].value = course[i][j].detailAddr;
      document.querySelectorAll('.etc')[count].value = course[i][j].etc;
      count++;
    }
  }
  }, 1000);
  setTimeout(() => {
  for (var i = 0; i < course.length; i++) {
    if (i == 0) {
      console.log(i + "시작일 : " + course[i].dayDate);
    }
    console.log(i + "번째 title : " + course[i].title);
    console.log(i + "번째 placeLength : " + course[i].length);

    for (var j = 0; j < course[i].length; j++) {
      console.log(i + "번째의 " + j +  " 번째 placeName : " + course[i][j].placeName);
      console.log(i + "번째의 " + j +  " 번째 basicAddr : " + course[i][j].basicAddr);
      console.log(i + "번째의 " + j +  " 번째 detailAddr : " + course[i][j].detailAddr);
      console.log(i + "번째의 " + j +  " 번째 etc : " + course[i][j].etc);
    }
  }
  console.log("-------------------------------------------------------");
  count = 0;
  for (var i = 0; i < course.length; i++) {
    if (i == 0) {
      console.log(document.getElementsByName('dayDate')[0]);
      console.log(document.getElementsByName('dayDate')[0].value);
    }
    console.log( document.querySelectorAll('.placeTitle')[i]);
    console.log( document.querySelectorAll('.placeTitle')[i].value);
    console.log( document.querySelectorAll('.dayLength')[i]);
    console.log(document.querySelectorAll('.dayLength')[i].value);

    for (var j = 0; j < course[i].length; j++) {
      console.log(document.querySelectorAll('.placeName')[count]);
      console.log(document.querySelectorAll('.placeName')[count].value);
      console.log(document.querySelectorAll('.basicAddr')[count]);
      console.log(document.querySelectorAll('.basicAddr')[count].value);
      console.log(document.querySelectorAll('.detailAddr')[count]);
      console.log(document.querySelectorAll('.detailAddr')[count].value);
      console.log(document.querySelectorAll('.etc')[count]);
      console.log(document.querySelectorAll('.etc')[count].value);
      count++;
    }
  }
  }, 3000);
  setTimeout(() => {
    document.getElementById('addForm').submit();
  }, 3000);
}

function removeDate(event) { // Dropdown에 Date 삭제 minus 버튼을 눌렀을 때,
  if (document.querySelectorAll('.item').length == 1) {
    console.log("마지막 하나는 지울 수 없습니다.");
  } else {
    var removeIndex = $(event.parentNode).index();
    var tmpDate = course[removeIndex].dayDate;
    
    course.splice($(event.parentNode).index(), 1);
    
    if (course.length > removeIndex) {
      var count = 0;
      for (var i = removeIndex; i < course.length; i++) {
        course[i].dayDate = calculateDate(tmpDate, count);
      }
    }
    document.getElementById('dropDownID').removeChild(event.parentNode);
    dropdownSort();
    if ((document.querySelectorAll('.dayCount')[0].innerHTML).substring(3, 5) == (removeIndex + 1)) {
    var index = removeIndex;
    if (course.length == removeIndex) {
      --index;
    }
    displayCourseDayByIndex(index);
    displayDropdownDate(index);
    }
  }

}

function newCourse() { // course에 새로운 Day를 추가함 dayDate 값만 넣는다.
  var newCourse = new Array();
  newCourse.dayDate = calculateDate(course[course.length-1].dayDate, 1);
  return newCourse;
}

function dropdownSort() { // course dayDate에 맞춰 dropdown을 정렬한다.
  for (var i = 0; i < document.querySelectorAll('.item').length; i++) {
    var str = '<div class="innerline"><div class="innerlineDay">Day' + (i + 1) + '</div>';
    str += '<div class="innerlineDate" onclick="displaySelectCourseDateData(this);">' + course[i].dayDate + '</div></div>';
    str += '<div class="minusArea" onclick="removeDate(this)"><i class="minus icon" style="margin: 0px; padding-left: calc(100% - 144px);"></i></div>'
    document.querySelectorAll('.item')[i].innerHTML = str;
    (document.querySelectorAll('.item')[i]).setAttribute('data-text', course[i].dayDate);
  }
}

function displaySelectCourseDateData(event) { // 해당 date 선택 시 해당 Data를 보여준다.
  courseDataSave();
  console.log("나 호출됨!");
  var index = $(event.parentNode.parentNode).index();
  displayCourseDayByIndex(index);
  displayDropdownDate(index);
}

function displayDropdownDate(index) { // dropdown에서 index에 해당하는 날짜를 보여주는 역할
  var str = 'Day' + (index + 1);
  document.querySelectorAll('.dayCount')[0].innerHTML = str;
  document.querySelectorAll('.innerDate')[0].innerHTML = '<div class="innerDate"><input type="hidden" name="dayDate" value="'+ course[0].dayDate + '">' + course[index].dayDate + '</div>';
  if (typeof (document.querySelectorAll('.menu.transition.visible')[0]) != "undefined") {
    document.querySelectorAll('.menu.transition.visible')[0].className = 'menu transition hidden'
  }
    $('.menu.transition.hidden').attr('style', '');
  document.getElementById('dropdown').className = 'ui selection dropdown';

}

function addDate(event) { // Dropdown에 Date 추가
  console.log(document.querySelectorAll('.datePlus')[0]);
  var datediv = document.querySelectorAll('.datePlus')[0];
  datediv.className = 'item';
  $('.item').attr('style', 'padding:11px 5px 11px 14px !important');
  $('.item').attr('draggable', 'true');
  $('.item').attr('ondragstart', 'courseDateDrag(event)');
  $('.item').attr('ondrop', 'courseDateDrop(event)');
  $('.item').attr('ondragover', 'allowDrop(event)');
  
  var plusdiv = document.createElement('div');
  plusdiv.className = 'datePlus';
  plusdiv.innerHTML += '<i class="plus icon" onclick="addDate(this);"></i>'
  document.getElementById('dropDownID').appendChild(plusdiv);
  if (event != null) {
    course.push(newCourse());
  }
  dropdownSort();
}

function calculateDate(date, addDays) { // date에 addDays를 넣어 date string 형식으로 리턴한다.
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

function dropdownInit() { // 가장 처음에 dropdown 초기화
  for (var i = 0; i < course.length; i++) {
    if (i != 0) {
    addDate();
    }
    var str = '<div class="innerline"><div class="innerlineDay">Day' + (i + 1) + '</div>';
    str += '<div class="innerlineDate" onclick="displaySelectCourseDateData(this);">' + course[i].dayDate + '</div></div>';
    str += '<div class="minusArea" onclick="removeDate(this)"><i class="minus icon" style="margin: 0px; padding-left: calc(100% - 144px);"></i></div>'
    document.querySelectorAll('.item')[i].innerHTML = str;
    (document.querySelectorAll('.item')[i]).setAttribute('data-text', course[i].dayDate);
  }
}

function startDateChange(date) { // startDate가 변동되면, Date dropdown에 적용한다.
  var newFirstdate = calculateDate(date);
  if (newFirstdate != course[0].dayDate) {
    for (var i = 0; i < course.length; i++) {
      course[i].dayDate = calculateDate(date, i);
    }
  }
  if (typeof (document.querySelectorAll('.dayCount')[0]) == "undefined") {
    document.getElementById('dropdown').childNodes[5].innerHTML = '<div class="dayCount">Day1</div>';
    document.getElementById('dropdown').childNodes[5].innerHTML += '<div class="innerDate"><input type="hidden" name="dayDate" value="'+ newFirstdate + '">' + newFirstdate + '</div>';
    document.getElementById('dropdown').className = 'ui selection dropdown';
    dropdownInit();
  } else {
    var dayIndex = (document.querySelectorAll('.dayCount')[0].innerHTML).substring(3, 5);
    dropdownSort();
    displayDropdownDate(dayIndex - 1);
  }
}

function matchShowCoursePlaceName() {
  for (var i = 0; i < document.querySelectorAll('.placeName').length; i++) {
  document.querySelectorAll('.showPlaceName')[i].value = document.querySelectorAll('.placeName')[i].value;
  }
}

function getSelectCourseDayForm(index) { // 해당한 index의 CourseDayForm을 만든다.
  var preDataLength = document.querySelectorAll('.placeName').length;
  var postDataLength = course[index].length;
  if (preDataLength < postDataLength) {
    for (var i = preDataLength; i < postDataLength; i++) {
      addForm();
    }
  }
  if (preDataLength > postDataLength) {
    for (var i = preDataLength; i > postDataLength; i--) {
      removeFormByIndex(i - 1);
    }
  }
}

function displayCourseDayByIndex(index) { // 현재 course Array에 맞는 Page를 보여준다.
  if (index != null) {
    getSelectCourseDayForm(index);
    if (course[index].title != null) {
      document.querySelectorAll('.placeTitle')[0].value = course[index].title;
      for (let i = 0; i < course[index].length; i++) {
        document.querySelectorAll('.placeName')[i].value = course[index][i].placeName;
        document.querySelectorAll('.basicAddr')[i].value =  course[index][i].basicAddr;
        document.querySelectorAll('.detailAddr')[i].value =  course[index][i].detailAddr;
        document.querySelectorAll('.etc')[i].value =  course[index][i].etc;
      }
    } else {
      document.querySelectorAll('.placeTitle')[0].value = "";
      document.querySelectorAll('.placeName')[0].value = "";
      document.querySelectorAll('.basicAddr')[0].value =  "";
      document.querySelectorAll('.detailAddr')[0].value =  "";
      document.querySelectorAll('.etc')[0].value =  "";
    }
  }
  matchShowCoursePlaceName();
  getGeoLocation();
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


function courseAddForm() {
  if (typeof document.querySelectorAll('.dayCount')[0] != 'undefined') {
    var i = (document.querySelectorAll('.dayCount')[0].innerHTML).substring(3, 5) - 1;
    var coursePlace = new Array();
    course[i].push(coursePlace);
  } else {
    var coursePlace = new Array();
    course[0].push(coursePlace);
  }
}

function addFormByEvent(){ // plus icon 클릭시 해당 Form 추가
  var div = document.createElement('div');
  div.className = 'placeArea';
  div.innerHTML = document.querySelectorAll('.placeArea')[0].innerHTML;
  document.getElementById('placeForm').appendChild(div);
  
  var div2 = document.createElement('div');
  var str2 = '<input class="showPlaceName" id="showPlaceName" draggable="true" ondragstart="placeNameDrag(event)" ondrop="placeNameDrop(event)" ondragover="allowDrop(event)" type="text" readonly>'
  div2.innerHTML = str2;
  document.getElementById('showPlaceNameArea').appendChild(div2);
  
  courseAddForm();
}

function addForm(){ // 다른 메서드에서 호출한다.
  var div = document.createElement('div');
  div.className = 'placeArea';
  div.innerHTML = document.querySelectorAll('.placeArea')[0].innerHTML;
  document.getElementById('placeForm').appendChild(div);
  
  var div2 = document.createElement('div');
  var str2 = '<input class="showPlaceName" id="showPlaceName" draggable="true" ondragstart="placeNameDrag(event)" ondrop="placeNameDrop(event)" ondragover="allowDrop(event)" type="text" readonly>'
  div2.innerHTML = str2;
  document.getElementById('showPlaceNameArea').appendChild(div2);
}

function courseRemoveForm(index) {
  if (typeof document.querySelectorAll('.dayCount')[0] != 'undefined') {
  var i = (document.querySelectorAll('.dayCount')[0].innerHTML).substring(3, 5) - 1;
  course[i].splice(index, 1);
  } else {
    course[0].splice(index, 1);
  }
}

function removeFormByIndex(index) { // index를 받으면 해당 Form을 지운다.
  if (document.querySelectorAll('.placeArea').length != 1) {
    document.getElementById('showPlaceNameArea').removeChild(document.getElementById('showPlaceNameArea').childNodes[index]);
    document.getElementById('placeForm').removeChild(document.querySelectorAll('.placeArea')[index]);
  }
}

function removeForm(event){ // minus icon 클릭시 해당 Form 삭제
  console.log(document.querySelectorAll('.placeArea'));
  console.log(document.querySelectorAll('.placeArea').length);
  if (document.querySelectorAll('.placeArea').length != 1) {
    var index = $(event.parentNode.parentNode).index();
    console.log(document.getElementById('showPlaceNameArea').childNodes);
    
    document.getElementById('showPlaceNameArea').removeChild(document.getElementById('showPlaceNameArea').childNodes[index]);
    document.getElementById('placeForm').removeChild(event.parentNode.parentNode);
    courseRemoveForm(index);
  }
  getGeoLocation();
}

function courseDataInit(courseData) { // DB로 전달받은 courseData를 course에 저장하고 첫번째 page를 준비한다.
  console.log(courseData);
  if (courseData.length != 0) { // courseData가 있을 때, 
    course = courseData;
    $('#button_calendar').calendar('set date', new Date(course[0].dayDate));
    displayCourseDayByIndex(0);
  } else { // New Form 일 때
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
