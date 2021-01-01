---
layout: post
title:  "HTTP는 무엇일까요?"
date:   2021-01-01 22:37:00 +0900
categories: 인터넷
changefreq: daily
---

## 요약

![HTTP](/assets/2021-01-01-what-is-http/http-1.png)

**HTTP**(HyperText Transfer Protocol)는 [W3](https://ko.wikipedia.org/wiki/월드_와이드_웹)(World Wide Web) 상에서 정보를 주고받을 수 있는 프로토콜입니다.  
주로 HTML 문서를 주고받는 데에 쓰입니다.  
주로 TCP를 사용하고 HTTP/3 부터는 UDP를 사용하며, 80번 포트를 사용합니다.  

1996년에 버전 1.0, 그리고 1999년에 1.1이 각각 발표되었습니다.

**HTTP는 클라이언트와 서버 사이에 이루어지는 요청/응답(request/response) 프로토콜입니다.**

예를 들면, 클라이언트인 웹 브라우저가 HTTP를 통하여 서버로부터 웹페이지(HTML)나 그림 정보를 요청하면,  
서버는 이 요청에 응답하여 필요한 정보를 해당 사용자에게 전달하게 되고,  
이 정보가 모니터와 같은 출력 장치를 통해 사용자에게 나타나는 것입니다.

HTTP를 통해 전달되는 자료는 http:로 시작하는 URL(인터넷 주소)로 조회할 수 있습니다.

## 깊게 들어가기

### 역사

[하이퍼텍스트](https://ko.wikipedia.org/wiki/하이퍼텍스트)라는 용어는 1965년 제너두 프로젝트에서 테드 넬슨이 만들었으며, 제너두 프로젝트는 《As We May Think》(1945년)라는 수필에서 마이크로필름 기반 정보 수신 및 관리 "메멕스" 시스템을 기술한 버니바 부시의 비전(1930년대)에 의해 영감을 받았습니다.  

팀 버너스 리와 그의 팀은 CERN에서 HTML뿐 아니라 웹 브라우저 및 텍스트 기반 웹 브라우저 관련 기술과 더불어 오리지널 HTTP을 발명하였습니다.  
버너스 리는 최초로 "월드와이드웹" 프로젝트를 1989년에 제안하였으며, 이것이 현재의 월드 와이드 웹입니다.  

이 프로토콜의 최초 버전은 서버로부터 페이지를 요청하는 GET이라는 이름의 하나의 메소드만 있었습니다.  
서버로부터의 응답은 무조건 HTML 문서였습니다.

문서화된 최초의 HTTP 버전은 HTTP V0.9(1991년)입니다. 

데이브 레겟은 1995년 HTTP 워킹 그룹(HTTP WG)을 이끌었으며 확장된 조작, 확장된 협상, 더 보강된 메타 정보, 또 추가 메소드와 헤더 필드를 통한 더 효율적인 보안 프로토콜을 갖춘 프로토콜을 확장하기를 바랐습니다.  
RFC 1945는 공식적으로 1996년 HTTP v1.0을 도입하였습니다.

HTTP WG는 1995년 12월 새로운 표준을 출간하기로 계획하였으며, 당시 개발 중인 RFC 2068(이른바 HTTP-NG)에 기반한 이전 표준 HTTP/1.1에 대한 지원이 1996년 초에 주요 브라우저 개발자들에 의해 빠르게 채택되었습니다.  

1996년 3월, 이전 표준 HTTP/1.1을 지원한 웹 브라우저로 아레나, 넷스케이프 2.0, 넷스케이프 내비게이터 골드 2.01, 모자이크 2.7, 링크스 2.5, 인터넷 익스플로러 2.0이 있습니다.  
새로운 브라우저의 최종 사용자 채택 속도는 빨랐습니다.  

1996년 3월, 한 웹 호스팅 회사의 보고에 따르면 인터넷 상에서 사용 중인 브라우저 중 40% 이상이 HTTP 1.1과 호환되었습니다.  
같은 웹 호스팅 회사는 1996년 6월 기준으로 서버에 접근하는 모든 브라우저들 가운데 65%가 HTTP/1.1 호환이라고 보고하였습니다.  
RFC 2068에 정의된 HTTP/1.1 표준은 공식적으로 1997년 1월에 출시되었습니다.  
HTTP/1.1 표준에 대한 개선과 업데이트는 1999년 6월 RFC 2616으로 출시되었습니다.

2007년에 부분적으로 HTTP/1.1 사양을 개정하고 분명히 하기 위해 HTTPbis 워킹 그룹이 창설되었습니다.  
2014년 6월, WG는 RFC 2616를 obsolete 처리하는, 업데이트된 6 파트 사양을 출시하였습니다:

* RFC 7230, HTTP/1.1: Message Syntax and Routing
* RFC 7231, HTTP/1.1: Semantics and Content
* RFC 7232, HTTP/1.1: Conditional Requests
* RFC 7233, HTTP/1.1: Range Requests
* RFC 7234, HTTP/1.1: Caching
* RFC 7235, HTTP/1.1: Authentication

> HTTP/2는 2015년 5월 RFC 7540로 출판되었습니다.

### 메시지 포맷

클라이언트와 서버 사이의 소통은 평문(ASCII) 메시지로 이루어집니다.  
클라이언트는 서버로 요청메시지를 전달하며 서버는 응답메시지를 보냅니다.

**요청 메시지**

클라이언트가 서버에게 보내는 요청 메시지는 다음과 같습니다.

* 요청 내용
  * 보기) GET /images/logo.gif HTTP/1.1
* 헤더
  * 보기) Accept-Language: en
* 빈 줄 (empty line)
  * 기타 메시지를 포함하여 표시됩니다.

요청 내용과 헤더 필드는 `<CR><LF>`로 끝나야 합니다.  
즉, 캐리지 리턴(Carriage Return) 다음에 라인 피드(Line Feed)가 와야 합니다.  
빈 줄(empty line)은 `<CR><LF>`로 구성되며 그 외 다른 화이트스페이스(whitespace)가 있어서는 안됩니다.



**요약표**

|HTTP 메소드|RFC|요청에 Body가 있음|응답에 Body가 있음|안전|멱등(Idempotent)|캐시 가능|
|GET|RFC 7231|아니오|예|예|예|예|
|HEAD|RFC 7231|아니오|아니오|예|예|예|
|POST|RFC 7231|예|예|아니오|아니오|예|
|PUT|RFC 7231|예|예|아니오|예|아니오|
|DELETE|RFC 7231|아니오|예|아니오|예|아니오|
|CONNECT|RFC 7231|예|예|아니오|아니오|아니오|
|OPTIONS|RFC 7231|선택 사항|예|예|예|아니오|
|TRACE|RFC 7231|아니오|예|예|예|아니오|
|PATCH|RFC 5789|예|예|아니오|아니오|예|

**응답 메시지**

응답 메시지는 다음으로 구성됩니다.

* 상태표시 행(status line): 상태코드(status code)와 reason message를 포함합니다.  
  * (예. HTTP/1.1 200 OK. 클라이언트의 요청이 성공적으로 전달되었음을 표시)
* 응답 헤더필드 (예.Content-Type: text/html)
* 빈 줄 (empty line)
* 기타 메시지

**예시**

아래는 포트 80의 www.example.com에서 실행 중인 HTTP 클라이언트와 HTTP 서버 간의 샘플 변환입니다.  
모든 데이터는 줄 끝마다 2바이트 `<CR><LF>` ('\r\n')를 사용하여 플레인 텍스트(ASCII) 인코딩을 통해 송신됩니다.

**클라이언트 요청**

```html
GET /restapi/v1.0 HTTP/1.1
Accept: application/json
Authorization: Bearer UExBMDFUMDRQV1MwMnzpdvtYYNWMSJ7CL8h0zM6q6a9ntw
```

**서버 응답**

```html
HTTP/1.1 200 OK
Date: Mon, 23 May 2005 22:38:34 GMT
Content-Type: text/html; charset=UTF-8
Content-Encoding: UTF-8
Content-Length: 138
Last-Modified: Wed, 08 Jan 2003 23:11:55 GMT
Server: Apache/1.3.3.7 (Unix) (Red-Hat/Linux)
ETag: "3f80f-1b6-3e1cb03b"
Accept-Ranges: bytes
Connection: close

<html>
<head>
  <title>An Example Page</title>
</head>
<body>
  Hello World, this is a very simple HTML document.
</body>
</html>
```

### 응답 코드

클라이언트가 서버에 접속하여 어떠한 요청을 하면, 서버는 세 자리 수로 된 응답 코드와 함께 응답합니다.  
HTTP의 응답 코드는 다음과 같습니다.

|코드|메시지|설명|
|1XX|Informational(정보)|정보 교환.|
|100|Continue|클라이언트로부터 일부 요청을 받았으니 나머지 요청 정보를 계속 보내주길 바람.|
|101|Switching Protocols|서버는 클라이언트의 요청대로 Upgrade 헤더를 따라 다른 프로토콜로 바꿀 것임.|
|2XX|Success(성공)|데이터 전송이 성공적으로 이루어졌거나, 이해되었거나, 수락되었음.|
|200|OK|오류 없이 전송 성공.|
|202|Accepted|서버가 클라이언트의 요청을 수락함.|
|203|Non-authoritavive Information|서버가 클라이언트 요구중 일부만 전송.|
|204|Non Content|클라이언트의 요구를 처리했으나 전송할 데이터가 없음.|
|205|Reset Content|새 문서 없음. 하지만 브라우저는 문서 창을 리셋해야 함.|
|206|Partial Content|클라이언트가 Range 헤더와 함께 요청의 일부분을 보냈고 서버는 이를 수행했음.|
|3XX|Redirection(방향 바꿈)|자료의 위치가 바뀌었음.|
|300|Multiple Choices|최근에 옮겨진 데이터를 요청.|
|301|Moved Permanently|요구한 데이터를 변경된 URL에서 찾았음.|
|302|Moved Permanently|요구한 데이터가 변경된 URL에 있음을 명시. 301과 비슷하지만 새 URL은 임시 저장 장소로 해석됨.|
|303|See Other|요구한 데이터를 변경하지 않았기 때문에 문제가 있음.|
|304|Not modified|클라이언트의 캐시에 이 문서가 저장되었고 선택적인 요청에 의해 수행됨.|
|305|Use Proxy|요청된 문서는 Location 헤더에 나열된 프록시를 통해 추출되어야 함.|
|307|Temporary Redirect|자료가 임시적으로 옮겨짐.|
|4XX|Client Error(클라이언트 오류)|클라이언트 측의 오류. 주소를 잘못 입력하였거나 요청이 잘못 되었음.|
|400|Bad Request|요청 실패. 문법상 오류가 있어서 서버가 요청사항을 이해하지 못함.|
|401.1|Unauthorized|권한 없음 (접속실패). 서버에 로그온 하려는 요청사항이 서버에 들어있는 권한과 비교했을 때 맞지 않음.|
|401.2|Unauthorized|권한 없음 (서버설정으로 인한 접속 실패). 서버에 로그온 하려는 요청사항이 서버에 들어있는 권한과 비교했을 때 맞지않음.|
|401.3|Unauthorized|권한 없음 (자원에 대한 ACL에 기인한 권한 없음). 클라이언트가 특정 자료에 접근할 수 없음.|
|401.4|Unauthorized|권한 없음 (필터에 의한 권한 부여 실패). 서버에 접속하는 사용자들을 확인하기 위해 설치한 필터 프로그램이 있음.|
|401.5|Unauthorized|권한 없음 (ISA PI/CGI 애플리케이션에 의한 권한부여 실패). 이용하려는 서버의 주소에 ISA PI나 CGI프로그램이 설치되어 있고, 권한을 부여할 수 없음.|
|402|Payment Required|예약됨.|
|403.1|Forbidden|금지 (수행접근 금지). 수행시키지 못하도록 되어있는 디렉터리 내의 실행 파일을 수행하려고 하였음.|
|403.2|Forbidden|금지 (읽기 접근 금지). 접근한 디렉터리에 가용한 기본 페이지가 없음.|
|403.4|Forbidden|금지 (SSL 필요함). 접근하려는 페이지가 SSL로 보안유지 되고 있음.|
|403.5|Forbidden|금지 (SSL 128필요함). 페이지가 128비트의 SSL로 보안유지 되고 있음.|
|403.6|Forbidden|금지 (IP 주소 거부됨). 사용자가 허용되지 않은 IP로부터 접근함.|
|403.7|Forbidden|금지 (클라이언트 확인 필요). 클라이언트가 자료에 접근할 수 있는지 확인 요함.|
|403.8|Forbidden|금지 (사이트 접근 거부됨). 서버가 요청사항을 수행하고 있지 않거나, 해당 사이트에 접근하는 것이 허락되지 않음.|
|403.9|Forbidden|접근금지 (연결된 사용자수 과다). 서버가 BUSY 상태에 있어서 요청을 수행할 수 없음.|
|403.10|Forbidden|접근금지 (설정이 확실 하지 않음).|
|403.11|Forbidden|접근금지 (패스워드 변경됨). 잘못된 암호를 입력했음.|
|403.12|Forbidden|접근금지(Mapper 접근 금지됨). 클라이언트 인증용 맵이 해당 웹 사이트에 접근하는 것이 거부됨.|
|404|Not Found|문서를 찾을 수 없음. 서버가 요청한 파일이나 스크립트를 찾지 못함.|
|405|Method not allowed|메서드 허용 안됨. 요청 내용에 명시된 메서드를 수행하기 위해 해당 자원의 이용이 허용되지 않음.|
|406|Not Acceptable|받아들일 수 없음.|
|407|Proxy Authentication Required|프록시 서버의 인증이 필요함.|
|408|Request timeout|요청 시간이 지남.|
|409|Conflict|요청을 처리하는 데 문제가 있음. 보통 PUT 요청과 관계가 있다. 보통 다른 버전의 파일을 업로드할 경우 발생함.
|410|Gone|영구적으로 사용할 수 없음.|
|411|Length Required|클라이언트가 헤더에 Content-Length를 포함하지 않으면 서버가 처리할 수 없음|
|412|Precondition Failed|선결조건 실패. 헤더에 하나 이상의 선결조건을 서버에서 충족시킬 수 없음.|
|413|Request entity too large|요청된 문서가 현재 서버가 다룰 수 있는 크기보다 큼.|
|414|Request-URI too long|요청한 URI가 너무 김.|
|415|Unsupported media type|요청이 알려지지 않은 형태임.|
|5XX|Server Error(서버 오류)|서버 측의 오류로 올바른 요청을 처리할 수 없음.|
|500|Internal Server Error|서버 내부 오류.|
|501|Not Implemented|필요한 기능이 서버에 설치되지 않았음.|
|502|Bad gateway|게이트웨이 상태 나쁨.|
|503|Service Unavailable|외부 서비스가 죽었거나 현재 멈춘 상태 또는 이용할 수 없는 서비스.|
|504|Gateway timeout|프록시나 게이트웨이의 역할을 하는 서버에서 볼 수 있음. 초기 서버가 원격 서버로부터 응답을 받을 수 없음.
|505|HTTP Version Not Supported|해당 HTTP 버전을 지원하지 않음.|

## 참고

* [HTTPS](https://ko.wikipedia.org/wiki/HTTPS)
* [HTML](https://ko.wikipedia.org/wiki/HTML)
* [월드 와이드 웹](https://ko.wikipedia.org/wiki/월드_와이드_웹)