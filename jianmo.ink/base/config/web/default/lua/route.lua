ngx.header.content_type = 'application/json;charset=utf-8';
ngx.say('{"name":"TuanduiMao App Server", "status":"ok", "home":"http://tuanduimao.com","lang":{"en":"Hello Tuandui Mao!", "jp":"こんにちは、猫チーム！", "zh-CN":"你好，团队猫!", "zh-TW":"妳好，團隊貓！"}}');
return ngx.null