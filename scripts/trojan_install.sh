#!/bin/bash
# 字体颜色
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
#copy from 秋水逸冰 ss scripts
if [[ -f /etc/redhat-release ]]; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
fi

function validate_ip() {
    ip_addr="$1"
    regex='^([0-9]{1,2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]{1,2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]{1,2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.([0-9]{1,2}|1[0-9]{2}|2[0-4][0-9]|25[0-5])$'

    if [[ ${ip_addr} =~ ${regex} ]]; then
        return 0  # Return 0 when IP is valid.
    else
        return 1  # Return 1 when IP is invalid.
    fi
}

function error() {
    red "==========================================================="
    for msg in "$@"; do
        red "$msg"
    done
    red "==========================================================="
}

function create_clash_config() {
  local trojan_passwd=$1
  local local_name=$2
  local your_domain=$3
  cat > /usr/share/nginx/html/ddd.yaml <<-EOF
port: 7890
socks-port: 7891
allow-lan: true
mode: Rule
log-level: silent
external-controller: 127.0.0.1:9090


proxies:

  - name: "$local_name"
    type: trojan
    server: "$your_domain"
    port: 443
    password: "$trojan_passwd"
    udp: true
    skip-cert-verify: false

proxy-groups:
  - name: Proxy
    type: select
    proxies:
      - "$local_name"

rules:
# (Proxy)
# > ABC
- DOMAIN-SUFFIX,edgedatg.com,Proxy
- DOMAIN-SUFFIX,go.com,Proxy

# > AbemaTV
- DOMAIN,linear-abematv.akamaized.net,Proxy
- DOMAIN-SUFFIX,abema.io,Proxy
- DOMAIN-SUFFIX,abema.tv,Proxy
- DOMAIN-SUFFIX,akamaized.net,Proxy
- DOMAIN-SUFFIX,ameba.jp,Proxy
- DOMAIN-SUFFIX,hayabusa.io,Proxy

# > Amazon Prime Video
- DOMAIN-SUFFIX,aiv-cdn.net,Proxy
- DOMAIN-SUFFIX,amazonaws.com,Proxy
- DOMAIN-SUFFIX,amazonvideo.com,Proxy
- DOMAIN-SUFFIX,llnwd.net,Proxy

# > Bahamut
- DOMAIN-SUFFIX,bahamut.com.tw,Proxy
- DOMAIN-SUFFIX,gamer.com.tw,Proxy
- DOMAIN-SUFFIX,hinet.net,Proxy

# > BBC
- DOMAIN-KEYWORD,bbcfmt,Proxy
- DOMAIN-KEYWORD,co.uk,Proxy
- DOMAIN-KEYWORD,uk-live,Proxy
- DOMAIN-SUFFIX,bbc.co,Proxy
- DOMAIN-SUFFIX,bbc.co.uk,Proxy
- DOMAIN-SUFFIX,bbc.com,Proxy
- DOMAIN-SUFFIX,bbci.co,Proxy
- DOMAIN-SUFFIX,bbci.co.uk,Proxy

# > CHOCO TV
- DOMAIN-SUFFIX,chocotv.com.tw,Proxy

# > Disney Plus
- DOMAIN,cdn.registerdisney.go.com,Proxy
- DOMAIN-SUFFIX,disneyplus.com,Proxy
- DOMAIN-SUFFIX,disney-plus.net,Proxy
- DOMAIN-SUFFIX,dssott.com,Proxy
- DOMAIN-SUFFIX,bamgrid.com,Proxy
- DOMAIN-SUFFIX,execute-api.us-east-1.amazonaws.com,Proxy

# > Epicgames
- DOMAIN-KEYWORD,epicgames,Proxy
- DOMAIN-SUFFIX,helpshift.com,Proxy

# > Fox+
- DOMAIN-KEYWORD,foxplus,Proxy
- DOMAIN-SUFFIX,config.fox.com,Proxy
- DOMAIN-SUFFIX,emome.net,Proxy
- DOMAIN-SUFFIX,fox.com,Proxy
- DOMAIN-SUFFIX,foxdcg.com,Proxy
- DOMAIN-SUFFIX,foxnow.com,Proxy
- DOMAIN-SUFFIX,foxplus.com,Proxy
- DOMAIN-SUFFIX,foxplay.com,Proxy
- DOMAIN-SUFFIX,ipinfo.io,Proxy
- DOMAIN-SUFFIX,mstage.io,Proxy
- DOMAIN-SUFFIX,now.com,Proxy
- DOMAIN-SUFFIX,theplatform.com,Proxy
- DOMAIN-SUFFIX,urlload.net,Proxy

# > HBO && HBO Go
- DOMAIN-SUFFIX,execute-api.ap-southeast-1.amazonaws.com,Proxy
- DOMAIN-SUFFIX,hbo.com,Proxy
- DOMAIN-SUFFIX,hboasia.com,Proxy
- DOMAIN-SUFFIX,hbogo.com,Proxy
- DOMAIN-SUFFIX,hbogoasia.hk,Proxy

# > Hulu
- DOMAIN-SUFFIX,happyon.jp,Proxy
- DOMAIN-SUFFIX,hulu.com,Proxy
- DOMAIN-SUFFIX,huluim.com,Proxy
- DOMAIN-SUFFIX,hulustream.com,Proxy

# > Imkan
- DOMAIN-SUFFIX,imkan.tv,Proxy

# > JOOX
- DOMAIN-SUFFIX,joox.com,Proxy

# > MytvSUPER
- DOMAIN-KEYWORD,nowtv100,Proxy
- DOMAIN-KEYWORD,rthklive,Proxy
- DOMAIN-SUFFIX,mytvsuper.com,Proxy
- DOMAIN-SUFFIX,tvb.com,Proxy

# > Netflix
- DOMAIN-SUFFIX,netflix.com,Proxy
- DOMAIN-SUFFIX,netflix.net,Proxy
- DOMAIN-SUFFIX,nflxext.com,Proxy
- DOMAIN-SUFFIX,nflximg.com,Proxy
- DOMAIN-SUFFIX,nflximg.net,Proxy
- DOMAIN-SUFFIX,nflxso.net,Proxy
- DOMAIN-SUFFIX,nflxvideo.net,Proxy

# > Pandora
- DOMAIN-SUFFIX,pandora.com,Proxy

# > Sky GO
- DOMAIN-SUFFIX,sky.com,Proxy
- DOMAIN-SUFFIX,skygo.co.nz,Proxy

# > Spotify
- DOMAIN-KEYWORD,spotify,Proxy
- DOMAIN-SUFFIX,scdn.co,Proxy
- DOMAIN-SUFFIX,spoti.fi,Proxy

# > viuTV
- DOMAIN-SUFFIX,viu.tv,Proxy

# > Youtube
- DOMAIN-KEYWORD,youtube,Proxy
- DOMAIN-SUFFIX,googlevideo.com,Proxy
- DOMAIN-SUFFIX,gvt2.com,Proxy
- DOMAIN-SUFFIX,youtu.be,Proxy

# (DIRECT)
# > Bilibili
- DOMAIN-KEYWORD,bilibili,DIRECT
- DOMAIN-SUFFIX,acg.tv,DIRECT
- DOMAIN-SUFFIX,acgvideo.com,DIRECT
- DOMAIN-SUFFIX,b23.tv,DIRECT
- DOMAIN-SUFFIX,biliapi.com,DIRECT
- DOMAIN-SUFFIX,biliapi.net,DIRECT
- DOMAIN-SUFFIX,bilibili.com,DIRECT
- DOMAIN-SUFFIX,biligame.com,DIRECT
- DOMAIN-SUFFIX,biligame.net,DIRECT
- DOMAIN-SUFFIX,hdslb.com,DIRECT
- DOMAIN-SUFFIX,im9.com,DIRECT

# > IQIYI
- DOMAIN-KEYWORD,qiyi,DIRECT
- DOMAIN-SUFFIX,qy.net,DIRECT

# > letv
- DOMAIN-SUFFIX,api.mob.app.letv.com,DIRECT

# > NeteaseMusic
- DOMAIN-SUFFIX,163yun.com,DIRECT
- DOMAIN-SUFFIX,music.126.net,DIRECT
- DOMAIN-SUFFIX,music.163.com,DIRECT

# > Tencent Video
- DOMAIN-SUFFIX,vv.video.qq.com,DIRECT

# > 抗 DNS 污染
- DOMAIN-KEYWORD,amazon,Proxy
- DOMAIN-KEYWORD,google,Proxy
- DOMAIN-KEYWORD,gmail,Proxy
- DOMAIN-KEYWORD,youtube,Proxy
- DOMAIN-KEYWORD,facebook,Proxy
- DOMAIN-SUFFIX,fb.me,Proxy
- DOMAIN-SUFFIX,fbcdn.net,Proxy
- DOMAIN-KEYWORD,twitter,Proxy
- DOMAIN-KEYWORD,instagram,Proxy
- DOMAIN-KEYWORD,dropbox,Proxy
- DOMAIN-SUFFIX,twimg.com,Proxy
- DOMAIN-KEYWORD,blogspot,Proxy
- DOMAIN-SUFFIX,youtu.be,Proxy
- DOMAIN-KEYWORD,whatsapp,Proxy

# > Speedtest
- DOMAIN-KEYWORD,speedtest,Proxy
- DOMAIN-SUFFIX,ooklaserver.net,Proxy

# > 国外网站
- DOMAIN-SUFFIX,9to5mac.com,Proxy
- DOMAIN-SUFFIX,abpchina.org,Proxy
- DOMAIN-SUFFIX,adblockplus.org,Proxy
- DOMAIN-SUFFIX,adobe.com,Proxy
- DOMAIN-SUFFIX,alfredapp.com,Proxy
- DOMAIN-SUFFIX,amplitude.com,Proxy
- DOMAIN-SUFFIX,ampproject.org,Proxy
- DOMAIN-SUFFIX,android.com,Proxy
- DOMAIN-SUFFIX,angularjs.org,Proxy
- DOMAIN-SUFFIX,aolcdn.com,Proxy
- DOMAIN-SUFFIX,apkpure.com,Proxy
- DOMAIN-SUFFIX,appledaily.com,Proxy
- DOMAIN-SUFFIX,appshopper.com,Proxy
- DOMAIN-SUFFIX,appspot.com,Proxy
- DOMAIN-SUFFIX,arcgis.com,Proxy
- DOMAIN-SUFFIX,archive.org,Proxy
- DOMAIN-SUFFIX,armorgames.com,Proxy
- DOMAIN-SUFFIX,aspnetcdn.com,Proxy
- DOMAIN-SUFFIX,att.com,Proxy
- DOMAIN-SUFFIX,awsstatic.com,Proxy
- DOMAIN-SUFFIX,azureedge.net,Proxy
- DOMAIN-SUFFIX,azurewebsites.net,Proxy
- DOMAIN-SUFFIX,bing.com,Proxy
- DOMAIN-SUFFIX,bintray.com,Proxy
- DOMAIN-SUFFIX,bit.com,Proxy
- DOMAIN-SUFFIX,bit.ly,Proxy
- DOMAIN-SUFFIX,bitbucket.org,Proxy
- DOMAIN-SUFFIX,bjango.com,Proxy
- DOMAIN-SUFFIX,bkrtx.com,Proxy
- DOMAIN-SUFFIX,blog.com,Proxy
- DOMAIN-SUFFIX,blogcdn.com,Proxy
- DOMAIN-SUFFIX,blogger.com,Proxy
- DOMAIN-SUFFIX,blogsmithmedia.com,Proxy
- DOMAIN-SUFFIX,blogspot.com,Proxy
- DOMAIN-SUFFIX,blogspot.hk,Proxy
- DOMAIN-SUFFIX,bloomberg.com,Proxy
- DOMAIN-SUFFIX,box.com,Proxy
- DOMAIN-SUFFIX,box.net,Proxy
- DOMAIN-SUFFIX,cachefly.net,Proxy
- DOMAIN-SUFFIX,chromium.org,Proxy
- DOMAIN-SUFFIX,cl.ly,Proxy
- DOMAIN-SUFFIX,cloudflare.com,Proxy
- DOMAIN-SUFFIX,cloudfront.net,Proxy
- DOMAIN-SUFFIX,cloudmagic.com,Proxy
- DOMAIN-SUFFIX,cmail19.com,Proxy
- DOMAIN-SUFFIX,cnet.com,Proxy
- DOMAIN-SUFFIX,cocoapods.org,Proxy
- DOMAIN-SUFFIX,comodoca.com,Proxy
- DOMAIN-SUFFIX,crashlytics.com,Proxy
- DOMAIN-SUFFIX,culturedcode.com,Proxy
- DOMAIN-SUFFIX,d.pr,Proxy
- DOMAIN-SUFFIX,danilo.to,Proxy
- DOMAIN-SUFFIX,dayone.me,Proxy
- DOMAIN-SUFFIX,db.tt,Proxy
- DOMAIN-SUFFIX,deskconnect.com,Proxy
- DOMAIN-SUFFIX,disq.us,Proxy
- DOMAIN-SUFFIX,disqus.com,Proxy
- DOMAIN-SUFFIX,disquscdn.com,Proxy
- DOMAIN-SUFFIX,dnsimple.com,Proxy
- DOMAIN-SUFFIX,docker.com,Proxy
- DOMAIN-SUFFIX,dribbble.com,Proxy
- DOMAIN-SUFFIX,droplr.com,Proxy
- DOMAIN-SUFFIX,duckduckgo.com,Proxy
- DOMAIN-SUFFIX,dueapp.com,Proxy
- DOMAIN-SUFFIX,dytt8.net,Proxy
- DOMAIN-SUFFIX,edgecastcdn.net,Proxy
- DOMAIN-SUFFIX,edgekey.net,Proxy
- DOMAIN-SUFFIX,edgesuite.net,Proxy
- DOMAIN-SUFFIX,engadget.com,Proxy
- DOMAIN-SUFFIX,entrust.net,Proxy
- DOMAIN-SUFFIX,eurekavpt.com,Proxy
- DOMAIN-SUFFIX,evernote.com,Proxy
- DOMAIN-SUFFIX,fabric.io,Proxy
- DOMAIN-SUFFIX,fast.com,Proxy
- DOMAIN-SUFFIX,fastly.net,Proxy
- DOMAIN-SUFFIX,fc2.com,Proxy
- DOMAIN-SUFFIX,feedburner.com,Proxy
- DOMAIN-SUFFIX,feedly.com,Proxy
- DOMAIN-SUFFIX,feedsportal.com,Proxy
- DOMAIN-SUFFIX,fiftythree.com,Proxy
- DOMAIN-SUFFIX,firebaseio.com,Proxy
- DOMAIN-SUFFIX,flexibits.com,Proxy
- DOMAIN-SUFFIX,flickr.com,Proxy
- DOMAIN-SUFFIX,flipboard.com,Proxy
- DOMAIN-SUFFIX,g.co,Proxy
- DOMAIN-SUFFIX,gabia.net,Proxy
- DOMAIN-SUFFIX,geni.us,Proxy
- DOMAIN-SUFFIX,gfx.ms,Proxy
- DOMAIN-SUFFIX,ggpht.com,Proxy
- DOMAIN-SUFFIX,ghostnoteapp.com,Proxy
- DOMAIN-SUFFIX,git.io,Proxy
- DOMAIN-KEYWORD,github,Proxy
- DOMAIN-SUFFIX,globalsign.com,Proxy
- DOMAIN-SUFFIX,gmodules.com,Proxy
- DOMAIN-SUFFIX,godaddy.com,Proxy
- DOMAIN-SUFFIX,golang.org,Proxy
- DOMAIN-SUFFIX,gongm.in,Proxy
- DOMAIN-SUFFIX,goo.gl,Proxy
- DOMAIN-SUFFIX,goodreaders.com,Proxy
- DOMAIN-SUFFIX,goodreads.com,Proxy
- DOMAIN-SUFFIX,gravatar.com,Proxy
- DOMAIN-SUFFIX,gstatic.com,Proxy
- DOMAIN-SUFFIX,gvt0.com,Proxy
- DOMAIN-SUFFIX,hockeyapp.net,Proxy
- DOMAIN-SUFFIX,hotmail.com,Proxy
- DOMAIN-SUFFIX,icons8.com,Proxy
- DOMAIN-SUFFIX,ifixit.com,Proxy
- DOMAIN-SUFFIX,ift.tt,Proxy
- DOMAIN-SUFFIX,ifttt.com,Proxy
- DOMAIN-SUFFIX,iherb.com,Proxy
- DOMAIN-SUFFIX,imageshack.us,Proxy
- DOMAIN-SUFFIX,img.ly,Proxy
- DOMAIN-SUFFIX,imgur.com,Proxy
- DOMAIN-SUFFIX,imore.com,Proxy
- DOMAIN-SUFFIX,instapaper.com,Proxy
- DOMAIN-SUFFIX,ipn.li,Proxy
- DOMAIN-SUFFIX,is.gd,Proxy
- DOMAIN-SUFFIX,issuu.com,Proxy
- DOMAIN-SUFFIX,itgonglun.com,Proxy
- DOMAIN-SUFFIX,itun.es,Proxy
- DOMAIN-SUFFIX,ixquick.com,Proxy
- DOMAIN-SUFFIX,j.mp,Proxy
- DOMAIN-SUFFIX,js.revsci.net,Proxy
- DOMAIN-SUFFIX,jshint.com,Proxy
- DOMAIN-SUFFIX,jtvnw.net,Proxy
- DOMAIN-SUFFIX,justgetflux.com,Proxy
- DOMAIN-SUFFIX,kat.cr,Proxy
- DOMAIN-SUFFIX,klip.me,Proxy
- DOMAIN-SUFFIX,linkedin.com,Proxy
- DOMAIN-SUFFIX,libsyn.com,Proxy
- DOMAIN-SUFFIX,linode.com,Proxy
- DOMAIN-SUFFIX,lithium.com,Proxy
- DOMAIN-SUFFIX,littlehj.com,Proxy
- DOMAIN-SUFFIX,live.com,Proxy
- DOMAIN-SUFFIX,live.net,Proxy
- DOMAIN-SUFFIX,livefilestore.com,Proxy
- DOMAIN-SUFFIX,llnwd.net,Proxy
- DOMAIN-SUFFIX,macid.co,Proxy
- DOMAIN-SUFFIX,macromedia.com,Proxy
- DOMAIN-SUFFIX,macrumors.com,Proxy
- DOMAIN-SUFFIX,mashable.com,Proxy
- DOMAIN-SUFFIX,mathjax.org,Proxy
- DOMAIN-SUFFIX,medium.com,Proxy
- DOMAIN-SUFFIX,mega.co.nz,Proxy
- DOMAIN-SUFFIX,mega.nz,Proxy
- DOMAIN-SUFFIX,megaupload.com,Proxy
- DOMAIN-SUFFIX,microsofttranslator.com,Proxy
- DOMAIN-SUFFIX,mindnode.com,Proxy
- DOMAIN-SUFFIX,mobile01.com,Proxy
- DOMAIN-SUFFIX,modmyi.com,Proxy
- DOMAIN-SUFFIX,msedge.net,Proxy
- DOMAIN-SUFFIX,myfontastic.com,Proxy
- DOMAIN-SUFFIX,name.com,Proxy
- DOMAIN-SUFFIX,nextmedia.com,Proxy
- DOMAIN-SUFFIX,nsstatic.net,Proxy
- DOMAIN-SUFFIX,nssurge.com,Proxy
- DOMAIN-SUFFIX,nyt.com,Proxy
- DOMAIN-SUFFIX,nytimes.com,Proxy
- DOMAIN-SUFFIX,omnigroup.com,Proxy
- DOMAIN-SUFFIX,onedrive.com,Proxy
- DOMAIN-SUFFIX,onenote.com,Proxy
- DOMAIN-SUFFIX,ooyala.com,Proxy
- DOMAIN-SUFFIX,openvpn.net,Proxy
- DOMAIN-SUFFIX,openwrt.org,Proxy
- DOMAIN-SUFFIX,orkut.com,Proxy
- DOMAIN-SUFFIX,osxdaily.com,Proxy
- DOMAIN-SUFFIX,outlook.com,Proxy
- DOMAIN-SUFFIX,ow.ly,Proxy
- DOMAIN-SUFFIX,paddleapi.com,Proxy
- DOMAIN-SUFFIX,parallels.com,Proxy
- DOMAIN-SUFFIX,parse.com,Proxy
- DOMAIN-SUFFIX,pdfexpert.com,Proxy
- DOMAIN-SUFFIX,periscope.tv,Proxy
- DOMAIN-SUFFIX,pinboard.in,Proxy
- DOMAIN-SUFFIX,pinterest.com,Proxy
- DOMAIN-SUFFIX,pixelmator.com,Proxy
- DOMAIN-SUFFIX,pixiv.net,Proxy
- DOMAIN-SUFFIX,playpcesor.com,Proxy
- DOMAIN-SUFFIX,playstation.com,Proxy
- DOMAIN-SUFFIX,playstation.com.hk,Proxy
- DOMAIN-SUFFIX,playstation.net,Proxy
- DOMAIN-SUFFIX,playstationnetwork.com,Proxy
- DOMAIN-SUFFIX,pushwoosh.com,Proxy
- DOMAIN-SUFFIX,rime.im,Proxy
- DOMAIN-SUFFIX,servebom.com,Proxy
- DOMAIN-SUFFIX,sfx.ms,Proxy
- DOMAIN-SUFFIX,shadowsocks.org,Proxy
- DOMAIN-SUFFIX,sharethis.com,Proxy
- DOMAIN-SUFFIX,shazam.com,Proxy
- DOMAIN-SUFFIX,skype.com,Proxy
- DOMAIN-SUFFIX,smartdnsProxy.com,Proxy
- DOMAIN-SUFFIX,smartmailcloud.com,Proxy
- DOMAIN-SUFFIX,sndcdn.com,Proxy
- DOMAIN-SUFFIX,sony.com,Proxy
- DOMAIN-SUFFIX,soundcloud.com,Proxy
- DOMAIN-SUFFIX,sourceforge.net,Proxy
- DOMAIN-SUFFIX,spotify.com,Proxy
- DOMAIN-SUFFIX,squarespace.com,Proxy
- DOMAIN-SUFFIX,sstatic.net,Proxy
- DOMAIN-SUFFIX,st.luluku.pw,Proxy
- DOMAIN-SUFFIX,stackoverflow.com,Proxy
- DOMAIN-SUFFIX,startpage.com,Proxy
- DOMAIN-SUFFIX,staticflickr.com,Proxy
- DOMAIN-SUFFIX,steamcommunity.com,Proxy
- DOMAIN-SUFFIX,symauth.com,Proxy
- DOMAIN-SUFFIX,symcb.com,Proxy
- DOMAIN-SUFFIX,symcd.com,Proxy
- DOMAIN-SUFFIX,tapbots.com,Proxy
- DOMAIN-SUFFIX,tapbots.net,Proxy
- DOMAIN-SUFFIX,tdesktop.com,Proxy
- DOMAIN-SUFFIX,techcrunch.com,Proxy
- DOMAIN-SUFFIX,techsmith.com,Proxy
- DOMAIN-SUFFIX,thepiratebay.org,Proxy
- DOMAIN-SUFFIX,theverge.com,Proxy
- DOMAIN-SUFFIX,time.com,Proxy
- DOMAIN-SUFFIX,timeinc.net,Proxy
- DOMAIN-SUFFIX,tiny.cc,Proxy
- DOMAIN-SUFFIX,tinypic.com,Proxy
- DOMAIN-SUFFIX,tmblr.co,Proxy
- DOMAIN-SUFFIX,todoist.com,Proxy
- DOMAIN-SUFFIX,trello.com,Proxy
- DOMAIN-SUFFIX,trustasiassl.com,Proxy
- DOMAIN-SUFFIX,tumblr.co,Proxy
- DOMAIN-SUFFIX,tumblr.com,Proxy
- DOMAIN-SUFFIX,tweetdeck.com,Proxy
- DOMAIN-SUFFIX,tweetmarker.net,Proxy
- DOMAIN-SUFFIX,twitch.tv,Proxy
- DOMAIN-SUFFIX,txmblr.com,Proxy
- DOMAIN-SUFFIX,typekit.net,Proxy
- DOMAIN-SUFFIX,ubertags.com,Proxy
- DOMAIN-SUFFIX,ublock.org,Proxy
- DOMAIN-SUFFIX,ubnt.com,Proxy
- DOMAIN-SUFFIX,ulyssesapp.com,Proxy
- DOMAIN-SUFFIX,urchin.com,Proxy
- DOMAIN-SUFFIX,usertrust.com,Proxy
- DOMAIN-SUFFIX,v.gd,Proxy
- DOMAIN-SUFFIX,v2ex.com,Proxy
- DOMAIN-SUFFIX,vimeo.com,Proxy
- DOMAIN-SUFFIX,vimeocdn.com,Proxy
- DOMAIN-SUFFIX,vine.co,Proxy
- DOMAIN-SUFFIX,vivaldi.com,Proxy
- DOMAIN-SUFFIX,vox-cdn.com,Proxy
- DOMAIN-SUFFIX,vsco.co,Proxy
- DOMAIN-SUFFIX,vultr.com,Proxy
- DOMAIN-SUFFIX,w.org,Proxy
- DOMAIN-SUFFIX,w3schools.com,Proxy
- DOMAIN-SUFFIX,webtype.com,Proxy
- DOMAIN-SUFFIX,wikiwand.com,Proxy
- DOMAIN-SUFFIX,wikileaks.org,Proxy
- DOMAIN-SUFFIX,wikimedia.org,Proxy
- DOMAIN-SUFFIX,wikipedia.com,Proxy
- DOMAIN-SUFFIX,wikipedia.org,Proxy
- DOMAIN-SUFFIX,windows.com,Proxy
- DOMAIN-SUFFIX,windows.net,Proxy
- DOMAIN-SUFFIX,wire.com,Proxy
- DOMAIN-SUFFIX,wordpress.com,Proxy
- DOMAIN-SUFFIX,workflowy.com,Proxy
- DOMAIN-SUFFIX,wp.com,Proxy
- DOMAIN-SUFFIX,wsj.com,Proxy
- DOMAIN-SUFFIX,wsj.net,Proxy
- DOMAIN-SUFFIX,xda-developers.com,Proxy
- DOMAIN-SUFFIX,xeeno.com,Proxy
- DOMAIN-SUFFIX,xiti.com,Proxy
- DOMAIN-SUFFIX,yahoo.com,Proxy
- DOMAIN-SUFFIX,yimg.com,Proxy
- DOMAIN-SUFFIX,ying.com,Proxy
- DOMAIN-SUFFIX,yoyo.org,Proxy
- DOMAIN-SUFFIX,ytimg.com,Proxy

# > Telegram
- DOMAIN-SUFFIX,telegra.ph,Proxy
- DOMAIN-SUFFIX,telegram.org,Proxy

# > 国内网站
- DOMAIN-SUFFIX,cn,DIRECT
- DOMAIN-KEYWORD,-cn,DIRECT

- DOMAIN-SUFFIX,126.com,DIRECT
- DOMAIN-SUFFIX,126.net,DIRECT
- DOMAIN-SUFFIX,127.net,DIRECT
- DOMAIN-SUFFIX,163.com,DIRECT
- DOMAIN-SUFFIX,360buyimg.com,DIRECT
- DOMAIN-SUFFIX,36kr.com,DIRECT
- DOMAIN-SUFFIX,acfun.tv,DIRECT
- DOMAIN-SUFFIX,air-matters.com,DIRECT
- DOMAIN-SUFFIX,aixifan.com,DIRECT
- DOMAIN-SUFFIX,akamaized.net,DIRECT
- DOMAIN-KEYWORD,alicdn,DIRECT
- DOMAIN-KEYWORD,alipay,DIRECT
- DOMAIN-KEYWORD,taobao,DIRECT
- DOMAIN-SUFFIX,amap.com,DIRECT
- DOMAIN-SUFFIX,autonavi.com,DIRECT
- DOMAIN-KEYWORD,baidu,DIRECT
- DOMAIN-SUFFIX,bdimg.com,DIRECT
- DOMAIN-SUFFIX,bdstatic.com,DIRECT
- DOMAIN-SUFFIX,bilibili.com,DIRECT
- DOMAIN-SUFFIX,caiyunapp.com,DIRECT
- DOMAIN-SUFFIX,clouddn.com,DIRECT
- DOMAIN-SUFFIX,cnbeta.com,DIRECT
- DOMAIN-SUFFIX,cnbetacdn.com,DIRECT
- DOMAIN-SUFFIX,cootekservice.com,DIRECT
- DOMAIN-SUFFIX,csdn.net,DIRECT
- DOMAIN-SUFFIX,ctrip.com,DIRECT
- DOMAIN-SUFFIX,dgtle.com,DIRECT
- DOMAIN-SUFFIX,dianping.com,DIRECT
- DOMAIN-SUFFIX,douban.com,DIRECT
- DOMAIN-SUFFIX,doubanio.com,DIRECT
- DOMAIN-SUFFIX,duokan.com,DIRECT
- DOMAIN-SUFFIX,easou.com,DIRECT
- DOMAIN-SUFFIX,ele.me,DIRECT
- DOMAIN-SUFFIX,feng.com,DIRECT
- DOMAIN-SUFFIX,fir.im,DIRECT
- DOMAIN-SUFFIX,frdic.com,DIRECT
- DOMAIN-SUFFIX,g-cores.com,DIRECT
- DOMAIN-SUFFIX,godic.net,DIRECT
- DOMAIN-SUFFIX,gtimg.com,DIRECT
- DOMAIN,cdn.hockeyapp.net,DIRECT
- DOMAIN-SUFFIX,hongxiu.com,DIRECT
- DOMAIN-SUFFIX,hxcdn.net,DIRECT
- DOMAIN-SUFFIX,iciba.com,DIRECT
- DOMAIN-SUFFIX,ifeng.com,DIRECT
- DOMAIN-SUFFIX,ifengimg.com,DIRECT
- DOMAIN-SUFFIX,ipip.net,DIRECT
- DOMAIN-SUFFIX,iqiyi.com,DIRECT
- DOMAIN-SUFFIX,jd.com,DIRECT
- DOMAIN-SUFFIX,jianshu.com,DIRECT
- DOMAIN-SUFFIX,knewone.com,DIRECT
- DOMAIN-SUFFIX,le.com,DIRECT
- DOMAIN-SUFFIX,lecloud.com,DIRECT
- DOMAIN-SUFFIX,lemicp.com,DIRECT
- DOMAIN-SUFFIX,licdn.com,DIRECT
- DOMAIN-SUFFIX,luoo.net,DIRECT
- DOMAIN-SUFFIX,meituan.com,DIRECT
- DOMAIN-SUFFIX,meituan.net,DIRECT
- DOMAIN-SUFFIX,mi.com,DIRECT
- DOMAIN-SUFFIX,miaopai.com,DIRECT
- DOMAIN-SUFFIX,microsoft.com,DIRECT
- DOMAIN-SUFFIX,microsoftonline.com,DIRECT
- DOMAIN-SUFFIX,miui.com,DIRECT
- DOMAIN-SUFFIX,miwifi.com,DIRECT
- DOMAIN-SUFFIX,mob.com,DIRECT
- DOMAIN-SUFFIX,netease.com,DIRECT
- DOMAIN-SUFFIX,office.com,DIRECT
- DOMAIN-SUFFIX,office365.com,DIRECT
- DOMAIN-KEYWORD,officecdn,DIRECT
- DOMAIN-SUFFIX,oschina.net,DIRECT
- DOMAIN-SUFFIX,ppsimg.com,DIRECT
- DOMAIN-SUFFIX,pstatp.com,DIRECT
- DOMAIN-SUFFIX,qcloud.com,DIRECT
- DOMAIN-SUFFIX,qdaily.com,DIRECT
- DOMAIN-SUFFIX,qdmm.com,DIRECT
- DOMAIN-SUFFIX,qhimg.com,DIRECT
- DOMAIN-SUFFIX,qhres.com,DIRECT
- DOMAIN-SUFFIX,qidian.com,DIRECT
- DOMAIN-SUFFIX,qihucdn.com,DIRECT
- DOMAIN-SUFFIX,qiniu.com,DIRECT
- DOMAIN-SUFFIX,qiniucdn.com,DIRECT
- DOMAIN-SUFFIX,qiyipic.com,DIRECT
- DOMAIN-SUFFIX,qq.com,DIRECT
- DOMAIN-SUFFIX,qqurl.com,DIRECT
- DOMAIN-SUFFIX,rarbg.to,DIRECT
- DOMAIN-SUFFIX,ruguoapp.com,DIRECT
- DOMAIN-SUFFIX,segmentfault.com,DIRECT
- DOMAIN-SUFFIX,sinaapp.com,DIRECT
- DOMAIN-SUFFIX,smzdm.com,DIRECT
- DOMAIN-SUFFIX,snapdrop.net,DIRECT
- DOMAIN-SUFFIX,sogou.com,DIRECT
- DOMAIN-SUFFIX,sogoucdn.com,DIRECT
- DOMAIN-SUFFIX,sohu.com,DIRECT
- DOMAIN-SUFFIX,soku.com,DIRECT
- DOMAIN-SUFFIX,sspai.com,DIRECT
- DOMAIN-SUFFIX,suning.com,DIRECT
- DOMAIN-SUFFIX,taobao.com,DIRECT
- DOMAIN-SUFFIX,tencent.com,DIRECT
- DOMAIN-SUFFIX,tenpay.com,DIRECT
- DOMAIN-SUFFIX,tianyancha.com,DIRECT
- DOMAIN-SUFFIX,tmall.com,DIRECT
- DOMAIN-SUFFIX,tudou.com,DIRECT
- DOMAIN-SUFFIX,umetrip.com,DIRECT
- DOMAIN-SUFFIX,upaiyun.com,DIRECT
- DOMAIN-SUFFIX,upyun.com,DIRECT
- DOMAIN-SUFFIX,veryzhun.com,DIRECT
- DOMAIN-SUFFIX,weather.com,DIRECT
- DOMAIN-SUFFIX,weibo.com,DIRECT
- DOMAIN-SUFFIX,xiami.com,DIRECT
- DOMAIN-SUFFIX,xiami.net,DIRECT
- DOMAIN-SUFFIX,xiaomicp.com,DIRECT
- DOMAIN-SUFFIX,ximalaya.com,DIRECT
- DOMAIN-SUFFIX,xmcdn.com,DIRECT
- DOMAIN-SUFFIX,xunlei.com,DIRECT
- DOMAIN-SUFFIX,yhd.com,DIRECT
- DOMAIN-SUFFIX,yihaodianimg.com,DIRECT
- DOMAIN-SUFFIX,yinxiang.com,DIRECT
- DOMAIN-SUFFIX,ykimg.com,DIRECT
- DOMAIN-SUFFIX,youdao.com,DIRECT
- DOMAIN-SUFFIX,youku.com,DIRECT
- DOMAIN-SUFFIX,zealer.com,DIRECT
- DOMAIN-SUFFIX,zhihu.com,DIRECT
- DOMAIN-SUFFIX,zhimg.com,DIRECT
- DOMAIN-SUFFIX,zimuzu.tv,DIRECT

- IP-CIDR,91.108.56.0/22,Proxy
- IP-CIDR,91.108.4.0/22,Proxy
- IP-CIDR,91.108.8.0/22,Proxy
- IP-CIDR,109.239.140.0/24,Proxy
- IP-CIDR,149.154.160.0/20,Proxy
- IP-CIDR,149.154.164.0/22,Proxy

# > LAN
- DOMAIN-SUFFIX,local,DIRECT
- IP-CIDR,127.0.0.0/8,DIRECT
- IP-CIDR,172.16.0.0/12,DIRECT
- IP-CIDR,192.168.0.0/16,DIRECT
- IP-CIDR,10.0.0.0/8,DIRECT
- IP-CIDR,17.0.0.0/8,DIRECT
- IP-CIDR,100.64.0.0/10,DIRECT

# yecao100
- DOMAIN-SUFFIX,i1069.net,DIRECT
- DOMAIN-SUFFIX,myapi.us,DIRECT
- DOMAIN-SUFFIX,wenjiushuobuzhidao.top,DIRECT

# > 最终规则
- GEOIP,CN,DIRECT
- MATCH,Proxy
EOF
}

function create_trojan_server_config() {
    local trojan_passwd=$1
    cat > /usr/src/trojan/server.conf <<-EOF
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        "$trojan_passwd"
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/usr/src/trojan-cert/fullchain.cer",
        "key": "/usr/src/trojan-cert/private.key",
        "key_password": "",
        "cipher_tls13":"TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
        "prefer_server_cipher": true,
        "alpn": [
            "http/1.1"
        ],
        "reuse_session": true,
        "session_ticket": false,
        "session_timeout": 600,
        "plain_http_response": "",
        "curves": "",
        "dhparam": ""
    },
    "tcp": {
        "no_delay": true,
        "keep_alive": true,
        "fast_open": false,
        "fast_open_qlen": 20
    },
    "mysql": {
        "enabled": false,
        "server_addr": "127.0.0.1",
        "server_port": 3306,
        "database": "trojan",
        "username": "trojan",
        "password": ""
    }
}
EOF
}

function create_and_start_service() {
    cat > ${systempwd}trojan.service <<-EOF
[Unit]
Description=trojan
After=network.target

[Service]
Type=simple
PIDFile=/usr/src/trojan/trojan/trojan.pid
ExecStart=/usr/src/trojan/trojan -c "/usr/src/trojan/server.conf"
ExecReload=
ExecStop=/usr/src/trojan/trojan
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
    chmod +x ${systempwd}trojan.service
    systemctl start trojan.service
    systemctl enable trojan.service
}

function create_nginx_config() {
  cat > /etc/nginx/nginx.conf <<-EOF
user  root;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {
    worker_connections  1024;
}
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile        on;
    #tcp_nopush     on;
    keepalive_timeout  120;
    client_max_body_size 20m;
    #gzip  on;
    server {
        listen       80;
        server_name  $your_domain;
        root /usr/share/nginx/html;
        index index.php index.html index.htm;
    }
}
EOF
}


# checkPortExist 端口检测
function checkPortExist() {
  port="$1"
  Port=$(netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w "$port")
  if [ -n "$Port" ]; then
    process=$(netstat -tlpn | awk -F '[: ]+' '$5=="80"{print $9}')
    error "检测到$1端口被占用，占用进程为：${process}，本次安装结束"
    return 0 # Return 0 when IP is valid.
  fi
  return 1 # Return 1 when IP is invalid.
}

function install_trojan(){
systemctl stop nginx
$systemPackage -y install net-tools socat
if checkPortExist 80; then
    exit 1
fi
if checkPortExist 443; then
    exit 1
fi

CHECK=$(grep SELINUX= /etc/selinux/config | grep -v "#")
if [ "$CHECK" == "SELINUX=enforcing" ]; then
    red "======================================================================="
    red "检测到SELinux为开启状态，为防止申请证书失败，请先重启VPS后，再执行本脚本"
    red "======================================================================="
    read -p "是否现在重启 ?请输入 [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
	    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
            setenforce 0
	    echo -e "VPS 重启中..."
	    reboot
	fi
    exit
fi
if [ "$CHECK" == "SELINUX=permissive" ]; then
    red "======================================================================="
    red "检测到SELinux为宽容状态，为防止申请证书失败，请先重启VPS后，再执行本脚本"
    red "======================================================================="
    read -p "是否现在重启 ?请输入 [Y/n] :" yn
	[ -z "${yn}" ] && yn="y"
	if [[ $yn == [Yy] ]]; then
	    sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
            setenforce 0
	    echo -e "VPS 重启中..."
	    reboot
	fi
    exit
fi
if [ "$release" == "centos" ]; then
    if  [ -n "$(grep ' 6\.' /etc/redhat-release)" ] ;then
    red "==============="
    red "当前系统不受支持"
    red "==============="
    exit
    fi
    if  [ -n "$(grep ' 5\.' /etc/redhat-release)" ] ;then
    red "==============="
    red "当前系统不受支持"
    red "==============="
    exit
    fi
    systemctl stop firewalld
    systemctl disable firewalld
    rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
elif [ "$release" == "ubuntu" ]; then
    if  [ -n "$(grep ' 14\.' /etc/os-release)" ] ;then
    red "==============="
    red "当前系统不受支持"
    red "==============="
    exit
    fi
    if  [ -n "$(grep ' 12\.' /etc/os-release)" ] ;then
    red "==============="
    red "当前系统不受支持"
    red "==============="
    exit
    fi
    systemctl stop ufw
    systemctl disable ufw
    apt-get update
elif [ "$release" == "debian" ]; then
    apt-get update
fi
$systemPackage -y install  nginx wget unzip zip curl tar >/dev/null 2>&1
systemctl enable nginx
systemctl stop nginx
green "======================="
blue "请输入绑定到本VPS的域名"
green "======================="
read your_domain
real_addr=`ping ${your_domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
if validate_ip $real_addr; then
    echo "Valid IP."
else
    echo "Invalid IP."
fi
local_name=`curl -s -L ip.tool.lu | awk -F "归属地: " '{print $2}'`
local_addr=`curl -s -L ip.tool.lu|grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"`

if [ $real_addr != $local_addr ] ; then
  red "================================"
  red "域名解析地址与本VPS IP地址不一致"
  red "本次安装失败，请确保域名解析正常"
  red "================================"
  return 1
fi
	green "=========================================="
	green "       域名解析正常，开始安装trojan"
	green "=========================================="
	sleep 1s
  create_nginx_config
	#设置伪装站
	rm -rf /usr/share/nginx/html/*
	cd /usr/share/nginx/html/ || return
	wget https://github.com/qiruos/ChatGPT-Next-Web/releases/download/v1.0.0/web.zip
    	unzip web.zip
	systemctl stop nginx
	sleep 5
	#申请https证书
	mkdir /usr/src/trojan-cert /usr/src/trojan-temp
	curl https://get.acme.sh | sh
	echo "申请https证书"
        ~/.acme.sh/acme.sh  --register-account -m qiruos@outlook.com
	~/.acme.sh/acme.sh  --issue  -d $your_domain  --standalone
    	~/.acme.sh/acme.sh  --installcert  -d  $your_domain   \
        --key-file   /usr/src/trojan-cert/private.key \
        --fullchain-file /usr/src/trojan-cert/fullchain.cer
	echo "申请https证书ok"
	if test -s /usr/src/trojan-cert/fullchain.cer; then
    systemctl start nginx
    cd /usr/src || return 1
    #wget https://github.com/trojan-gfw/trojan/releases/download/v1.13.0/trojan-1.13.0-linux-amd64.tar.xz
    wget https://api.github.com/repos/trojan-gfw/trojan/releases/latest
    latest_version=`grep tag_name latest| awk -F '[:,"v]' '{print $6}'`
    wget https://github.com/trojan-gfw/trojan/releases/download/v${latest_version}/trojan-${latest_version}-linux-amd64.tar.xz
    tar xf trojan-${latest_version}-linux-amd64.tar.xz
    #下载trojan WIN客户端
    wget https://github.com/atrandys/trojan/raw/master/trojan-cli.zip
    wget -P /usr/src/trojan-temp https://github.com/trojan-gfw/trojan/releases/download/v${latest_version}/trojan-${latest_version}-win.zip
    unzip trojan-cli.zip
    unzip /usr/src/trojan-temp/trojan-${latest_version}-win.zip -d /usr/src/trojan-temp/
    cp /usr/src/trojan-cert/fullchain.cer /usr/src/trojan-cli/fullchain.cer
    mv -f /usr/src/trojan-temp/trojan/trojan.exe /usr/src/trojan-cli/
          #下载trojan MAC客户端
          wget -P /usr/src/trojan-macos https://github.com/trojan-gfw/trojan/releases/download/v${latest_version}/trojan-${latest_version}-macos.zip
          unzip /usr/src/trojan-macos/trojan-${latest_version}-macos.zip -d /usr/src/trojan-macos/
          rm -rf /usr/src/trojan-macos/trojan-${latest_version}-macos.zip
    trojan_passwd=$(cat /dev/urandom | head -1 | md5sum | head -c 8)
          #配置trojan mac
    create_clash_config "$trojan_passwd" "$local_name" "$local_addr"
    create_trojan_server_config "$trojan_passwd"
    create_and_start_service

    green "======================================================================"
    green "Trojan已安装完成"
    blue "clash：http://${your_domain}/ccc.yaml"
    green "======================================================================"
  else
    red "==================================="
    red "https证书没有申请成果，自动安装失败"
    green "不要担心，你可以手动修复证书申请"
    green "1. 重启VPS"
    green "2. 重新执行脚本，使用修复证书功能"
    red "==================================="
	fi
}

function repair_cert(){
systemctl stop nginx
Port80=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w 80`
if [ -n "$Port80" ]; then
    process80=`netstat -tlpn | awk -F '[: ]+' '$5=="80"{print $9}'`
    red "==========================================================="
    red "检测到80端口被占用，占用进程为：${process80}，本次安装结束"
    red "==========================================================="
    exit 1
fi
green "======================="
blue "请输入绑定到本VPS的域名"
blue "务必与之前失败使用的域名一致"
green "======================="
read your_domain
real_addr=`ping ${your_domain} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
local_addr='198.13.32.205'
if [ $real_addr == $local_addr ] ; then
    ~/.acme.sh/acme.sh  --issue  -d $your_domain  --standalone
    ~/.acme.sh/acme.sh  --installcert  -d  $your_domain   \
        --key-file   /usr/src/trojan-cert/private.key \
        --fullchain-file /usr/src/trojan-cert/fullchain.cer
    if test -s /usr/src/trojan-cert/fullchain.cer; then
        green "证书申请成功"
	green "请将/usr/src/trojan-cert/下的fullchain.cer下载放到客户端trojan-cli文件夹"
	systemctl restart trojan
	systemctl start nginx
    else
    	red "申请证书失败"
    fi
else
    red "================================"
    red "域名解析地址与本VPS IP地址不一致"
    red "本次安装失败，请确保域名解析正常"
    red "================================"
fi	
}

function remove_trojan(){
    red "================================"
    red "即将卸载trojan"
    red "同时卸载安装的nginx"
    red "================================"
    systemctl stop trojan
    systemctl disable trojan
    rm -f ${systempwd}trojan.service
    if [ "$release" == "centos" ]; then
        yum remove -y nginx
    else
        apt autoremove -y nginx
    fi
    rm -rf /usr/src/trojan*
    rm -rf /usr/share/nginx/html/*
    green "=============="
    green "trojan删除完毕"
    green "=============="
}

function bbr_boost_sh(){
    wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
}

start_menu(){
    clear
    green " ===================================="
    green " Trojan 一键安装自动脚本 2020-2-27 更新      "
    green " 系统：centos7+/debian9+/ubuntu16.04+"
    green " 网站：www.v2rayssr.com （已开启禁止国内访问）"
    green " 此脚本为 atrandys 的，波仔集成BBRPLUS加速及MAC客户端 "
    green " Youtube：波仔分享                "
    green " ===================================="
    blue " 声明："
    red " *请不要在任何生产环境使用此脚本"
    red " *请不要有其他程序占用80和443端口"
    red " *若是第二次使用脚本，请先执行卸载trojan"
    green " ======================================="
    echo
    green " 1. 安装trojan"
    red " 2. 卸载trojan"
    green " 3. 修复证书"
    green " 4. 安装BBR-PLUS加速4合一脚本"
    blue " 0. 退出脚本"
    echo
    read -p "请输入数字:" num
    case "$num" in
    1)
    install_trojan
    ;;
    2)
    remove_trojan 
    ;;
    3)
    repair_cert 
    ;;
    4)
    bbr_boost_sh 
    ;;
    0)
    exit 1
    ;;
    *)
    clear
    red "请输入正确数字"
    sleep 1s
    start_menu
    ;;
    esac
}

start_menu
