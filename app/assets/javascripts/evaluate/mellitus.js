function e(id) {
    return document.getElementById(id);
}
function setText(id, txt) {
    e(id).textContent = txt;
}
function op(id) {
    s = e(id);
    return s.options[s.selectedIndex];
}
function show(id) {
    e(id).style.display = "block";
}
function hide(id) {
    e(id).style.display = "none";
}
function showP1() {
    show("p1");
    hide("p2");
    hide("p3")
};
function showP2() {
    show("p2");
    hide("p1");
    hide("p3")
};
function showP3() {
    show("p3");
    hide("p1");
    hide("p2")
};
function wait(callback, seconds) {
    var timelag = null; //这里应该用if判断一下；可以扩展
    timelag = window.setTimeout(callback, seconds);
}
function drawScore(s)
{
  var c=e("scoreCanv");
  var ctx=c.getContext("2d");
  x0=c.width/2.0;
  y0=c.height/2.0;
  ctx.strokeStyle="white";
  ctx.lineWidth=8;
  r=x0-ctx.lineWidth;

  startRad = 0.5*Math.PI;
  endRad = startRad+Math.PI*2*s/51;

  ctx.beginPath();
  //第一个和第二个参数，代表圆心坐标
  //第三个参数是圆的半径
  //第四个参数代表圆周起始位置(0 起始位置。沿顺时针路线，分别是0.5 (正下方)，1 PI和1.5 PI(正上方)，为画饼图提供了扇形范围的依据)
  //第五个参数是弧长(Math.PI*1 半圆、Math.PI*2就是整个圆)
  ctx.arc(x0, y0, r, startRad, endRad, false);
  ctx.stroke();
}
function toggleBtn(id1, id2){}
function onSexMaleClick()
{
  setText('sex','男');
  toggleBtn("btnMale", "btnFemale");
}
function onSexFemaleClick()
{
  setText('sex','女');
  toggleBtn("btnFemale", "btnMale");
}
function onHistYesClick()
{
  setText('hist', '有');
  toggleBtn("btnYes", "btnNo");
}
function onHistNoClick()
{
  setText('hist', '无');
  toggleBtn("btnNo", "btnYes");
}
function showSelect(id)
{
  s=e(id);
  if(s.style.display=="block")
  s.style.display="none";
  else
  s.style.display="block";
}
function onAgeChange(obj, ev)
{
  var age=e("age");
  selOp=age.getElementsByClassName("op-selected")[0];
  selOp.className="option";
  obj.className="op-selected";
  setText('ageTxt', obj.textContent);

  age.style.display="none";
  if (ev && ev.stopPropagation)
  ev.stopPropagation()
  else
  window.event.cancelBubble=true
}
function cal()
{
  showP2();
  wait(function(){showP3();},1500);

  male = e("sex").textContent;
  isMale = (male.indexOf("男")!=-1);
  var sexScore =  isMale ? 2 : 0;

  hist = e('hist').textContent;
  hasHist = (hist.indexOf("有")!=-1);
  var historyScore = hasHist ? 6 : 0;

  selOp=e("age").getElementsByClassName("op-selected")[0];
  var ageScore = parseInt(selOp.getAttribute("value"));

  height = Number(e("height").value)/100.0;
  weight = Number(e("weight").value);
  var hwRatio = 1.0 * weight / (height * height);
  var hwScore = 0;
  if(hwRatio<22)
  hwScore=0;
  if(hwRatio <24)
  hwScore = 1;
  else if(hwRatio < 30)
  hwScore = 3;
  else
  hwScore = 5;

  girdle = parseInt(e("girdle").value);
  var girdleScore = 0;
  if(!isMale)
  {
    girdle+=5;
  }
  if(girdle<75)
  girdleScore = 0;
  else if(girdle<80)
  girdleScore = 3;
  else if(girdle<85)
  girdleScore = 5;
  else if(girdle<90)
  girdleScore = 7;
  else if(girdle<95)
  girdleScore = 8;
  else
  girdleScore=10;

  pres = parseInt(e("pressure").value);
  var pressureScore = 0;
  if(pres<110)
  pressureScore = 0;
  else if(pres<120)
  pressureScore = 1;
  else if(pres<130)
  pressureScore = 3;
  else if(pres<140)
  pressureScore = 6;
  else if(pres<150)
  pressureScore = 7;
  else if(pres<160)
  pressureScore = 8;
  else
  pressureScore = 10;
  //!计算
  var ts = sexScore + ageScore + hwScore + girdleScore + pressureScore + historyScore;

  //!输出结果
  drawScore(ts);
  setText('score', ts);
  setText('score2', ts);

  if(ts >= 25)
  {
    show("risk3");
    hide("risk2");
    setText('risk', "高风险");
    e("resTab").style.color="red";
    e("resP").style.background="red";
  }
  else
  {
    setText('risk', "低风险");
    e("resTab").style.color="#009AD8";
    e("resP").style.background="#009AD8";
    show("risk2");
    hide("risk3");
  }
}

function reCal()
{
  showP1();
}
function onweight()
{
  updateSlider("weight");

}
function onheight()
{
  updateSlider("height");
}
function ongirdle()
{
  updateSlider("girdle");
}
function onpressure()
{
  updateSlider("pressure");
}
function updateSlider(id)
{
  r=e(id);
  setText(id+"Txt", r.value);
  rv=e(id+"-v");
  if(rv!=null)
  {
    rv.textContent=r.value;
    perF=1.0*(r.value-r.min)/(r.max-r.min);
    rvw=rv.clientWidth;
    rw=r.clientWidth;
    bound=rw-rvw;
    pos=r.clientWidth*perF;
    if(pos>bound)
    pos=bound;
    else if(pos < 0)
    pos = 0;
    rv.style.marginLeft=pos;
  }
}

function setupTouch(id, touchFunc)
{
  var obj = document.getElementById(id);
  obj.addEventListener("touchstart",touchFunc, false);
  obj.addEventListener("touchmove",touchFunc, false);
  obj.addEventListener("touchend",touchFunc, false);
}

function load()
{
  updateSlider("weight");
  updateSlider("height");
  updateSlider("girdle");
  updateSlider("pressure");

  if(navigator && navigator.userAgent)
  {
    if(navigator.userAgent.match("MQQBrowser"))
    {
      setupTouch("weight", touch);
      setupTouch("height", touch);
      setupTouch("girdle", touch);
      setupTouch("pressure", touch);
      //alert(navigator.userAgent);
    }
  }

  var startX = 0;
  var startVal = 0;
  function touch (event){
    var event = event || window.event;
    var o = event.target;
    var t = event.changedTouches[0];
    var min = parseInt(o.min);
    var max = parseInt(o.max);
    switch(event.type){
      case "touchstart":
      startX = t.clientX;
      startVal = parseInt(o.value);
      break;
      case "touchmove":
      event.preventDefault();
      var detal = t.clientX-startX;
      detal = parseInt( (max-min)*(1.0*detal/o.clientWidth))
      var cv = startVal+detal;
      if(cv < min)
      cv = min;
      if(cv > max)
      cv = max;
      o.value = cv;

      var evt = document.createEvent('Event');
      evt.initEvent('input',true,true);
      o.dispatchEvent(evt);
      break;
    }
  }//end function touch
}

function initBaseFontSize()
{
  bw = document.body.clientWidth;
  bh = document.body.clientHeight;
  sw=bw/42;
  sh=bh/66.0;
  if(sw>sh)
  sw=sh;
  hm=document.getElementsByTagName("html")[0];
  hm.style.fontSize=sw;
}
function updatePageHeight(id,adjustPTop)
{
  hm=document.getElementsByTagName("html")[0];
  bh = document.body.clientHeight;
  fs=hm.style.fontSize
  fs.replace("px","");
  fs=parseFloat(fs);
  sw=fs*42;

  p1=e(id);
  p1.style.width=sw;

  if(adjustPTop)
  {
    sh=fs*60.0;
    paddingTop=(bh-sh)/2.0;
    if(paddingTop>fs)
    paddingTop=fs;
    if(paddingTop>0)
    p1.style.paddingTop=paddingTop;
  }
}
var imgUrl = "http://meeting.360med.so/plugin/diabetes-evaluation/heart.png";
var lineLink = "http://meeting.360med.so/plugin/diabetes-evaluation/";
var shareTitle = "糖尿病风险评估工具";
var descContent = "糖尿病风险评估工具";
