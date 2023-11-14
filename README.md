# Inception
요약: 이 문서는 시스템 관리자와 관련된 예제입니다.
## Introduction

이 프로젝트는 [[Docker]]를 사용한 시스템 관리자의 지식을 확장하는데 초점이 맞춰져 있습니다.
몇 개의 도커 이미지를 가상화하여 새로운 개인 가상 머신에 그것들을 생성하게 될 것입니다.

## General guidelines

- 이 프로젝트는 가상 머신에서 수행해야 합니다.
- 프로젝트 구성에 필요한 모든 파일은 `srcs`폴더에 있어야 합니다.
- `Makefile`이 필요하며 루트 디렉토리에 있어야 합니다. 이 파일은 전체 application을 설정해야 합니다.
	- 즉 `docker-compose.yml`을 사용하여 Docker 이미지를 빌드해야 합니다.
- 이 주제는 여러분의 배경에 따라 아직 배우지 못했을 수 있는 개념을 실제로 적용시켜야 합니다. 따라서 **이 과제를 완료하기 위해 도움이 될 만한 문서뿐 아니라 Docker 사용과 관련된 많은 문서를 읽어보기를 권장합니다.**

## Mandatory part

이 프로젝트는 특정 규칙에 따라 다양한 서비스로 구성된 소규모 인프라를 설정하는 것으로 구성되어 있습니다. 전체 프로젝트는 가상 머신에서 수행해야 하며 [[docker compose]]를 사용해야 합니다.

각 [[Docker image]]는 해당 서미스와 동일한 이름을 가져야 합니다.
각 서비스는 전용 컨테이너에서 실행되어야 합니다.
성능 문제를 위해 컨테이너는 두 번째 안정적 버전인 Alpine 또는 Debian으로 빌드해야 합니다.
또한 서비스당 하나씩 자체 `Dockerfile`을 작성해야 합니다. `Dockerfile`은 메이크파일에 의해 `docker-compose.yml`에서 호출 되어야 합니다.
즉, 프로젝트의 Docker 이미지를  직접 빌드해야 합니다.
- 이미 만들어진 도커 이미지를 가져오거나 [[DockerHub]]같은 서비스를 사용하는 것도 금지됩니다.
	- Alpine/Debian은 이 규칙을 따르지 않음.

아래와 같이 설정 해야 합니다:
- TLSv1.2 또는 TLSv1.3을 사용하는 NGINX를 포함한 도커 컨테이너
- 워드프레스와 [[php-fpm]](설치 및 구성 해야 함)을 포함한 도커 컨테이너(NGINX가 없어야 함)
- MariaDB를 포함한 도커 컨테이너(NGINX가 없어야 함)
- 워드프레스 데이터베이스가 포함된 볼륨
- 워드프레스 웹 사이트 파일이 들어있는 두 번째 볼륨
- 컨테이너 간의 연결을 설정하는 도커 네트워크.
충돌이 발생할 경우 컨테이너를 다시 시작해야 합니다.

> [!info]
> 도커 컨테이너는 가상 머신이 아닙니다. 따라서 'tail -f'같은 해키 패치를 사용하는 것을 추천하지 않습니다. 데몬이 어떻게 작동하는지, 데몬을 사용하는 것이 좋은지 아닌지에 대해 알아보세요.


> [!caution]
> network (host, --link 또는 links)를 사용하는 것은 금지되어 있습니다.
> network line은 `docker-compose.yml`에 있어야 합니다. 무한 루프를 실행하는 명령으로 컨테이너를 시작하면 안 됩니다. 따라서 이는 엔트리 포인트로 사용되거나 엔트리 포인트 스크립트에서 사용되는 모든 명령에도 적용됩니다.
>  >[!tip] 금지되는 해킹 패치의 예시
>  >tail -f, bash, sleep infinity, while true.

> [!info]
> PID 1과 Docker 파일의 작성 사례에 대해 읽어보세요.
> 

- 워드프레스 데이터베이스에는 두 명의 사용자가 있어야 합니다. 그 중 하나는 관리자여야 합니다.
- 관리자의 사용자 이름에는 admin/Admin 또는 administrator/Administrator을 포함할 수 없습니다.
	- admin, administrator, Administrator, admin-123 등

> [!info]
> 볼륨은 도커를 사용하는 호스트 머신의 /home/login/data 폴더에서 사용할 수 있습니다. 물론 로그인을 사용자 계정으로 바꿔야 합니다.

To make things simpler, you have to configure your domain name so it points to your local IP address.
This domain name must be login.42.fr. Again, you gave to use your own login.
For example, if your login is jeseo, `jeseo.42.fr` will redirect to the IP address pointing to jeseo's website.

작업을 더 간단하게 하려면 도메인 이름이 로컬 IP 주소를 가리키도록 구성해야 합니다.
도메인 이름은 {login}.42.fr이어야 합니다. 로그인 이름이 jeseo인 경우 'jeseo.42.fr'은 jeseo의 웹사이트를 가리키는 IP주소로 리디렉션 됩니다.

>[!caution]
> 가장 최신 태그는 금지됩니다. 가장 최신 버전의 이미지 태그를 사용하지 마십시오.
> `Dockerfile`에 비밀번호가 있으면 안 됩니다.
> 환경변수를 사용해야 합니다.
> 환경변수를 저장하기 위해 .env 파일을 사용하는 것을 강력하게 권장합니다.
> .env 파일은 srcs 디렉토리의 루트에 위치해야 합니다.
> NGINX 컨테이너는 포트 443을 통해서만 접근할 수 있어야 하며, TLSv1.2 또는 TLSv1.3 프로토콜을 사용해야 합니다.

Here is an example diagram of the expected result:
![[Pasted image 20231025163918.png]]
Below is an example of the expected directory structure:
```bash
$> ls -alR 
total XX 
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 . 
drwxrwxrwt 17 wil wil 4096 avril 42 20:42 .. 
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 Makefile 
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 srcs 

./srcs: 
total XX 
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 . 
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 .. 
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 docker-compose.yml 
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 .env 
drwxrwxr-x 5 wil wil 4096 avril 42 20:42 requirements 

./srcs/requirements: 
total XX 
drwxrwxr-x 5 wil wil 4096 avril 42 20:42 . 
drwxrwxr-x 3 wil wil 4096 avril 42 20:42 .. 
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 bonus 
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 mariadb 
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 nginx 
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 tools 
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 wordpress 

./srcs/requirements/mariadb: 
total XX 
drwxrwxr-x 4 wil wil 4096 avril 42 20:45 . 
drwxrwxr-x 5 wil wil 4096 avril 42 20:42 .. 
drwxrwxr-x 2 wil wil 4096 avril 42 20:42 conf 
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 Dockerfile 
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 .dockerignore 
drwxrwxr-x 2 wil wil 4096 avril 42 20:42 tools 
[...] 

./srcs/requirements/nginx: 
total XX 
drwxrwxr-x 4 wil wil 4096 avril 42 20:42 . 
drwxrwxr-x 5 wil wil 4096 avril 42 20:42 .. 
drwxrwxr-x 2 wil wil 4096 avril 42 20:42 conf 
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 Dockerfile 
-rw-rw-r-- 1 wil wil XXXX avril 42 20:42 .dockerignore 
drwxrwxr-x 2 wil wil 4096 avril 42 20:42 tools 
[...] 

$> cat srcs/.env 
DOMAIN_NAME=wil.42.fr 
# certificates 
CERTS_=./XXXXXXXXXXXX 
# MYSQL SETUP 
MYSQL_ROOT_PASSWORD=XXXXXXXXXXXX 
MYSQL_USER=XXXXXXXXXXXX 
MYSQL_PASSWORD=XXXXXXXXXXXX 
[...] 

$>
```

> [!caution]
> 명백한 보안상의 이유로 모든 자격 증명(credentials, API 키, 환경 변수 등은 .env 파일에 로컬로 저장하고 git에서 무시해야 합니다. 공개적으로 저장된 자격 증명을 사용하면 바로 프로젝트 실패로 이어질 수 있습니다.

## Bonus part

이 프로젝트에서는 보너스 부분을 단순하게 하려고 합니다.

각 추가 서비스에 대한 도커 파일을 작성해야 합니다. 따라서 각각은 자체 컨테이너 내에서 실행되며 필요한 경우 전용 볼륨을 갖게 됩니다.

보너스 목록:
- 캐시를 올바르게 관리하기 위해 워드프레스 웹사이트에 redis 캐시를 설정하세요.
- 워드프레스의 웹사이트의 볼륨을 가리키는 FTP 서버 컨테이너를 설정합니다.
- PHP를 제외한 원하는 언어로 간단한 정적 웹사이트를 만듭니다.
	- 예를 들어 쇼케이스 사이트나 이력서를 소개하는 사이트를 만들 수 있습니다. 
- 관리자를 설정합니다.
- 유용하다고 생각되는 서비스를 설정합니다.

>[!info]
>To complete the bonus part, you have the possibility to set up extra services.
>In this case, you may open more ports to suit your needs.

> [!caution]
> The bonus part will only be assessed if the mandatory part is PERFECT.

