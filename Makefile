all    :; dapp build
clean  :; dapp clean
test   :; ./test.sh
reset  :; rm -rf cache/yearn-cache && dapp --make-cache cache/yearn-cache
deploy :; dapp create MapleYearnStrategy
