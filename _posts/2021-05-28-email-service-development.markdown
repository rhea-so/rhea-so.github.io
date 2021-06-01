---
layout: post
title:  "이메일 서비스 개발"
date:   2021-05-28 00:00:00 +0900
categories: 개발
changefreq: daily
---

## 필요성

이메일로 뉴스나, 전세계 트렌드, 컨퍼런스 일정등을 알려주는 서비스를 만들고 싶었습니다.  
이를 만드려고 보니, 이메일을 보내주는 서비스를 먼저 만들어야 했습니다.

## 목표

**안정적인** 이메일 서비스 개발

## 소스 코드

* [https://github.com/rhea-so/EmailService](https://github.com/rhea-so/EmailService)

-----

## 개발 도구

* VSCode v1.56.2
* NodeJS v12 Erbium
  * NodeMailer v6.6.1
* Typescript v4.3.2
  * [Repository Template](https://github.com/rhea-so/Typescript)
* RabbitMQ v3.8.9
* Docker
* Kubernetes

-----

## 아키텍처 구상

<img src="/images/email-service-구상-1.png" />

### 1. 서버를 이메일 전송 서버, 요청 수신 서버로 분리했습니다.

하나의 서버에서 모든 것을 처리하지 않습니다. 각자 작은 일들 하나씩 맡아 처리합니다.

저는 Micro Service Architecture를 좋아합니다.

나중에 "이메일 전송 부분"에 수정이 있거나 "요청 수신 부분"에 수정이 있을때, 다른 서버들에게 미치는 영향을 최소화 할 수 있기 때문입니다.

무중단 배포에도 용이하고, 오토 스케일링도 유연하게 할 수 있어서 좋습니다.

### 2. Message Queue를 사용해 서버 간 결합을 느슨하게 했습니다.

"이메일 전송 요청"과 "이메일 전송"은 강한 결합을 띄고 있습니다. (n대 n)

"이메일 전송 요청"이 없으면 "이메일 전송"은 실행 될 수 없습니다.

즉, "요청 수신 서버"와 "이메일 전송 서버" 간에는 통신이 필요합니다.

HTTP Request로 통신을 할 수 있습니다만, 전 아닌 것 같다고 판단했습니다.  

1. Circuit Breaking을 직접 구현해야합니다.
   1. 구현한다고 하더라도, HTTP Request를 보내는 서버가 장애 상황 조치 중 죽어버리면 의미가 없습니다.
   2. 모든 "이메일 전송 서버"가 죽어있다면, "요청 서버"에 부하가 이메일 요청이 들어올수록 점점 심해집니다.
2. 단일 서버로 띄워서 통신한다면, 단일 End Point를 사용하면 되지만 Scaling을 한다면 Load Balancer를 만들어줘야 합니다
   1. Load Balancer는 비쌉니다..
   2. "이메일 전송 서버"에 Load Balancer를 붙히는 이유가 "요청 수신 서버"와 통신하기 위해서인데. 기회비용이 너무 큽니다.
3. 이메일을 보내는 중에 에러가 발생한 경우, 이메일이 증발됩니다.
4. 장애 상황 대처가 힘듭니다.

--> 위 같은 문제들로 인해, Message Queue를 사용하기로 했습니다.



관리자가 이메일 등록기에 요청을 보내면 이를 RabbitMQ로 보내고, 이메일 전송기가 RabbitMQ로부터 이메일 요청을 뽑아와 전송하는 구조입니다.

<img src="/images/email-service-구상-2.png" width="500" />

이메일을 등록하는 부분과 전송하는 부분을 분리한 이유는 다음과 같습니다.

* Kubernetes Deployment를 분리함으로써 장애 피해를 최소화 할 수 있습니다.
  * 이메일을 전송하는 로직에서 장애가 발생해도, 이메일 등록에는 문제가 없습니다. 
* 수정이 필요한 서버만 업데이트하면 되기 때문에 전체적으로 업데이트로 인한 서비스 불안정 요소를 최소화 할 수 있습니다.
  * 전송 로직에 수정이 필요하면, 전송하는 서버만 재부팅하면 됩니다.
* Auto-Scaling을 좀 더 유연하게 할 수 있습니다.
  * 이메일 전송에 부하가 심하면, 이메일 전송 서버만 늘리면 되고, 이메일 등록에 부하가 심하면, 이메일 등록 서버만 늘리면 됩니다.
* 변경을 유연하게 대처할 수 있습니다.
   * 완전 새로운 이메일 등록 서버를 만들어도, 이메일 전송 서버는 그대로 사용할 수 있습니다.

위 구조를 보면, RabbitMQ(Message Queue)가 서버들 사이에 위치해 있습니다.

이메일 등록 서버와 전송 서버 사이를 HTTP나 Socket.io 등의 통신이 아닌 Message Queue로 연결한 이유는 다음과 같습니다.

* Loose Coupling
  * 전송 서버와 등록 서버는 로직적으로 서로가 엮여있지 않기 때문에, 서비스 자체의 유연성과 재사용성을 늘릴 수 있습니다.
* Horizontal Scaling
  * 여러 대의 서버가 하나의 Queue를 바라보도록 구성하면 처리할 데이터가 많아져도 각 서버는 자신의 처리량에 맞게 이메일 요청을 가져와 처리할 수 있습니다.
* 데이터 손실 방지
  * 이메일 전송 처리를 하는 도중에 갑작스럽게 서버가 죽은 경우, 이에 대한 요청이 다시 Queue로 돌아가기 때문에 장애 조치가 가능합니다.
  * 요청이 무시되는 Case를 제거할 수 있습니다.
* 부하 분산
  * 처리해야 할 이메일들을 Queue에 넣어두고 이메일 전송 서버는 자신이 동시에 처리할 수 있는 양에 따라 하나의 이메일 전송. 전송이 끝나면 다음에 처리할 이메일 정보를 Queue에서 가져와 처리하면 됩니다.
  * 많은 요청으로 인한 서버 다운이 일어나지 않습니다. 딱 서버 본인이 가능한 만큼만 이메일 정보를 전달합니다.
* 통신에 대한 이점
  * failover에 대한 코드를 안짜도 됩니다.
  * Queue에 넣고 빼는 코드만 짜면 되기 때문에 굉장히 단순합니다.
* 데이터의 가시화
  * 전 Queue를 통해 데이터를 주고 받는게, 코드로 표현했을때 꽤나 괜찮아보였습니다. 어떤 데이터를 주고 받는지를 한 눈에 명확하게 보였습니다.

<img src="/images/email-service-구상-3.png" width="600" />

Slack을 이용해 채팅 하나로 서버를 업데이트 할 수 있으면 좋을 것 같습니다.
서버를 업데이트하기 위해 매번 VM에 접속해서 명령어를 치는건 너무 불편하니까..  

내가 편한게 최고니까.

-----

## NodeMailer를 사용한 이메일 전송

```typescript
import nodeMailer from 'nodemailer';
const transporter = nodeMailer.createTransport({
	service: 'gmail',
	host: 'smtp.gmail.com',
	auth: {
		user: process.env.GMAIL_ID,
		pass: process.env.GMAIL_PASSWORD
	}
});

transporter.sendMail(
	{
		from: process.env.GMAIL_ID,
		to: message.to,
		subject: message.subject,
		html: message.html
	},
	
	(error, info) => {
		if (error) {
			reject(error);
		} else {
			resolve(info);
		}
	});
```

-----

## RabbitMQ 사용 방법

```typescript
import { RabbitMQ } from 'rhea-rabbitmq'; // NPM에 없습니다. 개인 NPM 저장소에 올렸습니다.
const client = new RabbitMQ.Client({
	serverAddress: process.env.RABBITMQ_ADDRESS as string,
	username: process.env.RABBITMQ_USERNAME as string,
	password: process.env.RABBITMQ_PASSWORD as string,
	vhost: process.env.RABBITMQ_VHOST as string
});


async function main() {
	await client.connect();

	// 이미 Queue가 생성되어있는 경우는, 아무 일도 하지 않습니다.
	client.createQueue(process.env.RABBITMQ_QUEUE as string);

	client.dequeue(process.env.RABBITMQ_QUEUE as string, async (message: IEmailRequest) => {
		// 이메일 전송
	});

	await client.enqueue(process.env.RABBITMQ_QUEUE as string, {
		// 전달할 데이터
	});
}

main();
```

-----

## Graceful Shutdown

```typescript
async function gracefulShutdown() {
	await client.free();
	setTimeout(async () => {
		process.exit(0);
	}, 5000); // 5초 안에 남아있는 모든 이메일 전송이 완료되는 것으로 판단함
}

process.on('SIGTERM', gracefulShutdown);
process.on('SIGINT', gracefulShutdown);
```

-----

## 이메일 전송 서버 구현

### 수신 차단 목록 관리

-----

## 이메일 등록 서버 구현

-----

## Kubernetes 배포

-----

## 서비스 동작

-----

## 소감