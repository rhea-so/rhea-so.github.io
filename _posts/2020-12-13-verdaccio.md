---
layout: post
title:  "나만의 NPM 저장소 만들기"
date:   2020-12-13 15:55:00 +0900
categories: verdaccio npm node
---

> Verdaccio를 이용해 Private한 NPM 저장소를 만드는 방법을 다룹니다


## 대상 독자

![대상독자](/assets/2020-12-13-verdaccio/대상독자.png)

* 만든 NodeJS 모듈을 사내에서만 배포를 하고 싶은 경우  
* 모듈을 외부에 공개안하고 싶은데 [npmjs.com](https://npmjs.com) Private을 쓰자니, 요금이 부담되는 경우
* 내 코드가 인터넷에 올라가는게 영 찝찝하고 마음에 안드는 경우

-----

## Verdaccio

-----

### 이게 대체 무엇인가?

NPM 저장소 오픈소스 프로젝트입니다.  
[npmjs.com](https://npmjs.com)처럼, NodeJS 패키지 관리자입니다.
NodeJS로 개발이 되었으며, `PM2`와 같은 프로세스 관리자를 이용하여 구동 할 수 있습니다.  

이 저장소를 어느 대상에게 open 하는가?에 따라 Private하게 이용할 수도 있고, Public하게 이용할 수도 있습니다.

### 백문이 불여일견! 바로 설치해보자!

```sh
npm i -g verdaccio # NodeJS로 개발이 되었기 때문에, NPM에서 다운로드 받아 실행만 해주면 됨

verdaccio # 1) PM2가 설치되어 있지 않은 경우
pm2 start verdaccio # 2) PM2가 설치되어 있는 경우
```

![설치_후_첫_실행](/assets/2020-12-13-verdaccio/첫실행.png)

> 성공적으로 띄운 모습
> verdaccio는 기본적으로 `4873`번 포트를 사용합니다.  

웹 브라우저로 접속을 하고 싶으신 경우, [http://localhost:4873](http://localhost:4873)로 들어가주세요.

![verdaccio_main](/assets/2020-12-13-verdaccio/main.png)

> 전반적으로 깔끔한 UI를 사용하고 있습니다.


### 샘플을 배포해보자

### 세부 설정

## 마무리

verdaccio로 local 환경에 NPM 저장소를 구축하는 법,  
`config.yaml`을 수정하여 NPM 저장소의 세부 설정하는 법,  
보안 그룹 설정을 통해 구축한 저장소를 Private하게 사용하는 법을 알게 되었습니다.

-----
