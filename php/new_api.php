<?php
if(defined('CURL_HTTP_VERSION_2_0')){

    $device_token   = '232aabf3459ea8250b3aabb131ae9b3122dd34b22326e471ac60f2f36286286b';
    $pem_file       = '/Applications/developer/sample/NotifExtSmpl01/cert/development_jp.co.lib-gate.NotifExtSmpl01.pem';
    // $pem_secret     = 'your pem secret'; // パスワードを設定している場合は必要
    $apns_topic     = 'jp.co.lib-gate.NotifExtSmpl01';

    $alert = '{"aps":{"alert":{"title":"TitleSample","subtitle":"SubtitleSample","body":"BodySample"},"badge":1, "mutable-content":1}, "data": "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-5.jpg"}';

    // $alert = '{"aps":{"alert":{"title":"Hieda-dayo10","subtitle":"subtitle4","body":"Ryuichi-dattebayo4"},"badge":1,"shouldAlwaysAlertWhileAppIsForeground": 1, "mutable-content":1}, "data": "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-5.jpg"}';
    $url = "https://api.development.push.apple.com/3/device/$device_token";

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $alert);
    curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_2_0);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array("apns-topic: $apns_topic"));
    curl_setopt($ch, CURLOPT_SSLCERT, $pem_file);
    // curl_setopt($ch, CURLOPT_SSLCERTPASSWD, $pem_secret); // パスワードを設定している場合は必要
    $response = curl_exec($ch);
    $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

    var_dump($response);
    var_dump($httpcode);

    // デバッグ用
    // $info = curl_getinfo($ch);
    //$errno = curl_errno($ch);
    //$error = curl_error($ch);

    // var_dump($info);   
    // var_dump($errno);
    // var_dump($error);
}
