# WXToken

因为手上有一个项目需要用到微信的朋友圈分享，涉及到微信JSSDK，所以写了个生成示例，自动获取微信access_token、jsapi_ticket和signature签名算法，开箱即用。

## 配置

首选进入main.go，配置相关参数：

```go
var (
	//微信公众号
	wxAppID  = ""
	wxSecret = ""
	//随机字符串
	wxNoncestr = ""
	//Port 本地端口
	Port = ":8383"
)
```

因为access_token和jsapi_ticket的有效期都只有7200秒，需要在自己的服务全局缓存，所以用BoltDB做了持久化并自动更新。

## JSSDK使用步骤

### 步骤一：绑定域名

先登录微信公众平台进入“公众号设置”的“功能设置”里填写“JS接口安全域名”。

备注：登录后可在“开发者中心”查看对应的接口权限。

### 步骤二：引入JS文件

在需要调用JS接口的页面引入如下JS文件，（支持https）：http://res.wx.qq.com/open/js/jweixin-1.2.0.js

备注：支持使用 AMD/CMD 标准模块加载方法加载

### 步骤三：通过config接口注入权限验证配置

所有需要使用JS-SDK的页面必须先注入配置信息，否则将无法调用（同一个url仅需调用一次，对于变化url的SPA的web app可在每次url变化时进行调用,目前Android微信客户端不支持pushState的H5新特性，所以使用pushState来实现web app的页面会导致签名失败，此问题会在Android6.2中修复）。

```js
wx.config({
    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    appId: '', // 必填，公众号的唯一标识
    timestamp: , // 必填，生成签名的时间戳
    nonceStr: '', // 必填，生成签名的随机串
    signature: '',// 必填，签名
    jsApiList: [] // 必填，需要使用的JS接口列表
});
```

签名算法见[微信JSSDK说明附录1](https://mp.weixin.qq.com/wiki?action=doc&id=mp1421141115#62)，所有JS接口列表见[微信JSSDK说明附录2](https://mp.weixin.qq.com/wiki?action=doc&id=mp1421141115#63)

### 步骤四：通过ready接口处理成功验证

```js
wx.ready(function(){
    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
});
```

### 步骤五：通过error接口处理失败验证

```js
wx.error(function(res){
    // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
});
```

详细请参考[微信官方说明文档](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421141115)