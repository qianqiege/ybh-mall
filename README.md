# 御邦医通

## 如何修改公众号自定义菜单

1. 修改对应环境（development.yml 或者 production.yml） 目录下的 `menu` 配置
2. 执行 `rails wechat:generate_menu`
3. 取消并重新关注公共号，即可生效，否则第二天生效


## 如何开始微信开发

如果需要开发的功能或者页面需要依赖微信客户端，则需要准备好公众号沙盒账号，以及相关的配置参数。以下逐步讲解：

##### 1. 准备本地端口映射到公网工具
在稍后的配置过程中，微信服务器会主动发起 POST 请求到我们配置的URL，为了我们的本地服务器（局域网内）能够接收到来自公网的请求，我们需要将本地 3000 端口（或者其他你自己在 rails 服务器启动时指定的端口）映射到公网。推荐使用 [localtunnel](http://localtunnel.me/)。

下载 localtunnel 并且按照文档安装完 localtunnel 之后，直接通过 `lt --port 3000` （其他端口则为 `lt --port [端口号]`），成功启动后会显示类似以下的内容：
```
  your url is: https://justin.localtunnel.me

```

##### 2. 申请微信公众号沙盒账号
前往 [微信公众平台接口测试账号申请](http://mp.weixin.qq.com/debug/cgi-bin/sandbox?t=sandbox/login) 页面，直接点击“登录”后会弹出一个用于登录的二维码。使用你自己的手机微信扫一扫，在手机上确认登录后即可直接申请（已申请的情况下会直接登录）到沙盒账号。

##### 3. 配置 app_id 以及 app_secret
在成功申请或者登录公众号测试账号后，页面上有一个标题为“测试号信息”的表格，里边分别有你的 `appID` 以及 `app_secret` 的信息。

请记得把页面上的 `appID` 的值拷贝粘贴到我们刚才的 `settings/development.yml` 文件里的 `app_id`；另外把 `app_secret` 的值拷贝粘贴到文件里的 `app_secret`。则最后的 development.yml 里的配置应该是这样的：

```yaml
# settings/development.yml
  weixin:
    api_id: wx54acf8a779144bf4
    api_secret: 5ecd72fe80eec4db1f5a16eb6a1dfcd9
    token: 9ea435f4ac0c6161f25d2253
    secret: iZoqfJJJjGtG6nq-yER_1Ipb7wAu5D6V
    host: https://justin.localtunnel.me/
```

##### 5. 启动服务器
完成上面的配置后，就可以启动 rails 服务器了。

##### 6. 微信端配置
在确认步骤5中的服务器成功启动，并且启动端口号跟绑定到 localtunnel 的端口号一致后，在微信公众平台接口测试账号页面上找到“接口配置信息”，点击“配置”或者“修改”，然后在显示的表单中填写配置信息。

###### 6.1 填写URL
此处的URL 的格式是“http://[公网域名或者IP]/weixin/[secret_string]”，在我们的这个例子里，则相应地是："http://justin.localtunnel.me/weixin/iZoqfJJJjGtG6nq-yER_1Ipb7wAu5D6V"。

###### 6.2 填写 Token
所以在我们的这个例子中，则相应地是："9ea435f4ac0c6161f25d2253"。

填写完以上两项信息后，点击“提交”即可完成配置。微信服务器会在这个时候POST 请求到我们的服务器，如果上述步骤全部正确并且没有疏漏，则应该会显示“配置成功”。如果提示失败，请重新仔细检查你的配置，如果确认配置没有问题，则有可能是网络问题，重试几次提交一般都能解决问题。

