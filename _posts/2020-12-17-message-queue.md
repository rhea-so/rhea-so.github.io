---
layout: post
title:  "메시지 큐 알아보기"
date:   2020-12-17 01:00:00 +0900
categories: 메시지-브로커
changefreq: daily
---

## 메시지 큐(Message Queue 이하 MQ)란?

프로세스(프로그램) 간에 데이터를 교환할 때 사용하는 통신 방법 중에 하나로,  
더 큰 개념으로는 MOM(Message Oriented Middleware : 메시지 지향 미들웨어 이하 MOM)를 의미합니다.  
MOM이란 비동기 메시지를 사용하는 프로그램 간의 데이터 송수신을 의미하는데 MOM을 구현한 시스템을 MQ라고 합니다.  
MQ는 작업을 늦출 수 있는 유연성을 제공합니다.  
  
메시지를 교환할 때 AMQP(Advanced Message Queuing Protocol 이하 AMQP)을 이용합니다.  
AMQP는 ISO 응용 계층의 MOM 표준으로 JMS(Java Message Service)와 비교되는데 JMS는 MOM를 자바에서 지원하는 표준 API입니다.  
JMS는 다른 Java Application 간에 통신은 가능하지만 다른 MOM(AMQP, SMTP 등)끼리는 통신할 수 없습니다.  
그에 반해 AMQP는 protocol만 일치한다면 다른 AMQP를 사용한 Application과도 통신이 가능합니다.  
AMQP는 wire-protocol을 제공하는데 이는 octet stream을 이용해서 다른 네트워크 사이에 데이터를 전송할 수 있는 포맷입니다.  
 
 
### 메시지 큐의 장점

* 비동기 : Queue에 넣기 때문에 나중에 처리할 수 있습니다.
* 비동조 : Application과 분리할 수 있습니다.
* 탄력성 : 일부가 실패 시 전체는 영향을 받지 않습니다
* 과잉 : 실패할 경우 재실행이 가능합니다
* 확장성 : 다수의 프로세스들이 큐에 메시지를 보낼 수 있습니다.
 
### 메시지 큐 사용처

메시지 큐는 다음과 같이 다양한 곳에 사용이 가능합니다.

* 다른 곳의 API로부터 데이터 송수신
* 다양한 Application에서 비동기 통신 가능
* 이메일 발송 및 문서 업로드 가능
* 많은 양의 프로세스 처리
* 메시지 큐 종류

### 대표적인 메시지 큐

* Kafka
* RabbitMQ
* ActiveMQ
 
공통적으로 3가지 모두 비동기 통신을 제공하고 보낸 사람과 받는 사람을 분리합니다.  
하지만 업무에 따라서 다른 목적을 가지고 있습니다.  
 
성격상 Kafka(Apache)와 RabbitMQ, ActiveMQ(Apache)로 나눌 수 있는데 Kafka는 처리량이 많은 분산 메시징 시스템에 적합하고 RabbitMQ, ActiveMQ는 신뢰성 있는 메시지 브로커가 필요한 경우 적합합니다.  
여기서 신뢰성은 Kafka에 비해 높은 것이지 Kafka가 신뢰성이 없다는 것은 아닙니다.
 
## RabbitMQ

RabbitMQ는 AMQT 프로토콜을 구현해 놓은 프로그램으로써 빠르고 쉽게 구성할 수 있으며 직관적입니다.  
[https://blog.dudaji.com/general/2020/05/25/rabbitmq.html](https://blog.dudaji.com/general/2020/05/25/rabbitmq.html)

 
### 장점

* 신뢰성, 안정성
* 유연한 라우팅 (Message Queue가 도착하기 전에 라우팅 되며 플러그인을 통해 더 복잡한 라우팅도 가능)
* 클러스터링 (로컬네트워크에 있는 여러 RabbitMQ 서버를 논리적으로 클러스터링할 수 있고 논리적인 브로커도 가능)
* 관리 UI의 편리성 (관리자 페이지 및 모니터링 페이지가 제공됨)
* 거의 모든 언어 및 운영체제를 지원
* 오픈소스로 상업적 지원 가능
 
## Kafka

Kafka는 확장성과 고성능 및 높은 처리량을 내세운 제품이라고 보시면 됩니다.  
특화된 시스템이기 때문에 범용 메시징 시스템에서 제공하는 다양한 기능들은 제공되지 않습니다.  
분산 시스템을 기본으로 설계되었기 때문에 기존 메시징 시스템에 비해 분산 및 복제 구성을 손쉽게할 수 있습니다.
 
### 장점

* 대용량 실시간 로그 처리에 특화되어 있다
* AMQP 프로토콜이나 JSM API를 사용하지 않고 단순한 메시지 헤더를 지닌 TCP 기반 프로토콜 사용함으로써 오버헤드가 비교적 작다.
* 노드 장애에 대한 대응성을 가지고 있다
* 프로듀서는 각 메시지를 배치로 브로커에게 전달하여 TCP/IP 라운드 트립을 줄였다
* 메시지를 기본적으로 파일 시스템에 저장하여 별도의 설정을 하지 않아도 오류 발생 시 오류 지점부터 복구가 가능하다 (기존 메시징 시스템은 메시지를 메모리에 저장)
* 메시지를 파일시스템에 저장하기 때문에 메시지가 많이 쌓여도 기존 메시징 시스템에 비해 성능이 크게 감소하지 않는다
* window 단위의 데이터를 넣고 꺼낼 수 있다
 
## ActiveMQ

ActiveMQ는 자바로 만든 오픈소스 메시지 브로커입니다. JMS 1.1을 통해 자바 뿐만 아니라 다른 언어를 사용하는 클라이언트를 지원합니다.
 
### 장점

* 다양한 언어와 프로토콜 지원 (Java, C, C++, C#, Ruby, Perl, Python, PHP클라이언트 지원)
* OpenWire를 통해 고성능의 Java, C, C++, C# 클라이언트 지원
* Stomp를 통해 C, Ruby, Perl, Python, PHP 클라이언트가 다른 인기있는 메시지 브로커들과 마찬가지로 ActiveMQ에 접근 가능
* Message Groups, Virtual Destinations, Wildcards와 Composite Destination를 지원
* Spring 지원으로 ActiveMQ는 Spring Application에 매우 쉽게 임베딩될 수 있으며, Spring의 XML 설정 메커니즘에 의해 쉽게 설정 가능
* Geronimo, JBoss 4, GlassFish, WebLogic과 같은 인기있는 J2EE 서버들과 함께 테스트됨
* 고성능의 저널을 사용할 때에 JDBC를 사용하여 매우 빠른 Persistence를 지원
* REST API를 통해 웹기반 메시징 API를 지원
* 웹 브라우저가 메시징 도구가 될 수 있도록, Ajax를 통해 순수한 DHTML을 사용한 웹 스트리밍 지원  
  
  
-----
  
  
이렇게 해서 메시지 큐에 대한 기본적인 개념과 대표적으로 몇 가지 종류를 정리해보았습니다.
 
* 라운드 트립(Round-trip) : 클라이언트와 서버 간의 데이터 왕복 과정을 의미한다. 라운드 트립이 빈번하다는 것은 클라이언트와 서버 간에 요청과 응답이 빈번하다는 이야기이고, 결국 서버 측의 성능에 그리 좋지 않은 영향을 미친다. 따라서 라운드 트립이 적게 일어나도록 제작되는 것이 바람직하다.
 
> 이 글은 아래 사이트를 참고하여 작성되었습니다.  
> * https://12bme.tistory.com/176  
> * http://zzong.net/post/3  
> * https://m.blog.naver.com/PostView.nhn?blogId=myongsg&logNo=20176300457&targetKeyword=&targetRecommendationCode=1  
> * https://steady-snail.tistory.com/165  