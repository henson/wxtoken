<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,user-scalable=no,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0">
    <title>{{.Title}}</title>
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
    <script type="text/javascript" src="//cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript" src="/js/auto.js"></script>
    <script type="text/javascript" src="//res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
    <script type="text/javascript">
        $(function () {
            //自动播放音乐
            var music = document.getElementById("bgMusic");
            $("#audioBtn").click(function () {
                if (music.paused) {
                    music.play();
                    $("#audioBtn").removeClass("pause").addClass("play");
                } else {
                    music.pause();
                    $("#audioBtn").removeClass("play").addClass("pause");
                }
            });

            jQuery.post("/sign", {
                "url": encodeURIComponent(window.location.href.split('#')[0])
            }, function (result) {
                wx.config({
                    debug: true,
                    appId: result.app_id,
                    timestamp: result.timestamp,
                    nonceStr: result.nonce_str,
                    signature: result.signature,
                    jsApiList: [
                        'checkJsApi',
                        'onMenuShareTimeline',
                        'onMenuShareAppMessage',
                        'onMenuShareQQ',
                        'onMenuShareWeibo',
                        'onMenuShareQZone'
                    ]
                });
                var shareTitle = "标题文字";
                var shareDesc = "简介文字，最好不超过60个字";
                var shareLink = window.location.href.split('#')[0];
                var shareImgUrl = "//url/path/to/jpg"; //分享图标

                wx.ready(function () {
                    document.getElementById('bgMusic').play();
                    //分享给朋友
                    wx.onMenuShareAppMessage({
                        title: shareTitle,
                        desc: shareDesc,
                        link: shareLink,
                        imgUrl: shareImgUrl,
                        type: 'link', // 分享类型，music、video或link，不填默认为link
                        dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
                        success: function (res) {
                            alert("分享成功");
                            //成功后的响应操作
                        },
                        fail: function (res) {
                            alert("分享失败");
                            //alert(JSON.stringify(res));
                        }
                    });
                    //分享到朋友圈
                    wx.onMenuShareTimeline({
                        title: shareTitle,
                        link: shareLink,
                        imgUrl: shareImgUrl,
                        success: function (res) {
                            alert("分享成功");
                            //成功后的响应操作
                        },
                        fail: function (res) {
                            alert("分享失败");
                            //alert(JSON.stringify(res));
                        }
                    });
                    //分享到QQ
                    wx.onMenuShareQQ({
                        title: shareTitle,
                        desc: shareDesc,
                        link: shareLink,
                        imgUrl: shareImgUrl,
                        success: function (res) {
                            alert("分享成功");
                            //成功后的响应操作
                        },
                        fail: function (res) {
                            alert("分享失败");
                            //alert(JSON.stringify(res));
                        }
                    });
                    //分享到腾讯微博
                    wx.onMenuShareWeibo({
                        title: shareTitle,
                        desc: shareDesc,
                        link: shareLink,
                        imgUrl: shareImgUrl,
                        success: function (res) {
                            alert("分享成功");
                            //成功后的响应操作
                        },
                        fail: function (res) {
                            alert("分享失败");
                            //alert(JSON.stringify(res));
                        }
                    });
                    //分享到QQ空间
                    wx.onMenuShareQZone({
                        title: shareTitle,
                        desc: shareDesc,
                        link: shareLink,
                        imgUrl: shareImgUrl,
                        success: function (res) {
                            alert("分享成功");
                            //成功后的响应操作
                        },
                        fail: function (res) {
                            alert("分享失败");
                            //alert(JSON.stringify(res));
                        }
                    });

                });
            });
        });
    </script>
</head>

<body onresize="doResize()">
    <!--

其它页面

-->
    <div class="mc">
        <a id="audioBtn" class="mscBtn" title="音乐开关" style="cursor: pointer;"></a>
    </div>
    <audio controls="controls" id="bgMusic" hidden="hidden">
        <source src="/music.mp3" type="audio/mpeg" />
    </audio>
    {{ template "foot" }}
</body>

</html>