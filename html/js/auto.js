//非手机端访问就跳转
/* var system = {};
var p = navigator.platform;
var u = navigator.userAgent;

system.win = p.indexOf("Win") == 0;
system.mac = p.indexOf("Mac") == 0;
system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
if (system.win || system.mac || system.xll) { //如果是PC端   
    if (u.indexOf('Windows Phone') > -1) { //win手机端
      //
    } else {
        window.location.href = "//www.baidu.com";
    }
} */

//屏幕的宽度（兼容处理）
doResize();

function doResize() {
  var w = document.documentElement.clientWidth || document.body.clientWidth;
  var scale = w / 720;
  $('html').css('font-size', 100 * scale + 'px');
  //console.log(scale);
};