# Pushの送り方

## PHP

```bash
# openssl を最新化
brew install openssl
echo "export PATH=\"/usr/local/opt/openssl/bin:$PATH\"" > ~/.zshrc.local
# http://qiita.com/dasisyouyu/items/c9621c29b0fe79d2b7c4
# curl を最新化
brew install curl --with-nghttp2 --with-openssl
echo "export PATH=\"/usr/local/opt/curl/bin:$PATH\"" > ~/.zshrc.local
# php を最新化
brew install --with-homebrew-curl --with-homebrew-openssl  --without-snmp php71
echo "export PATH=\"/usr/local/opt/php71/bin:$PATH\"" > ~/.zshrc.local
```

## Push送信

```bash
cd php
php new_api.php
```
