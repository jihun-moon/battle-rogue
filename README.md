# Battle Rogue PVP

UE5 기반 1:1 PvP 멀티플레이 격투 게임. 전용 Dedicated Server와 Replication·RPC 설계로 저지연 상태 동기화를 구현했습니다.

- Engine: Unreal Engine 5
- Language: C++ and Blueprint
- Networking: UE Replication, RPC, Session

## Demo

![Anim Montage Process](assets/anim-montage-process.gif)
![Gameplay Demo](assets/fighting-game-demo.gif)

assets 경로가 다르면 링크를 수정하세요.

## Features

- 서버 권위(Server-Authoritative) 구조
- 플레이어 이동·공격 상태 동기화(Replication, RPC)
- 매치메이킹 → 세션 생성 → 게임 종료 라이프사이클
- 보간·보정 기반 랙 보정(Lag Compensation) 초안

## Tech Stack

- Unreal Engine 5, C++/Blueprint
- Networking: Replication, Server/Client RPC, Session
- Infra: 컨테이너 기반 전용 서버 빌드·배포

## Getting Started

1. Requirements
   - UE 5.x
   - Visual Studio 2022 또는 clang toolchain
2. Clone
   - git clone https://github.com/<your-org>/battle-rogue.git
3. Open
   - UE에서 .uproject 열기
4. Run
   - 에디터: Play In Editor 또는 Standalone
   - Dedicated Server: 아래 참조

## Run Dedicated Server

Windows 예시
```
.\Engine\Binaries\Win64\UnrealEditor.exe Project.uproject -server -log
.\Engine\Binaries\Win64\UnrealEditor.exe Project.uproject -game -log -windowed -ResX=1280 -ResY=720
```
Docker(예시)
```
docker build -t battle-rogue-server -f Dockerfile.server .
docker run -p 7777:7777/udp battle-rogue-server
```

## Project Structure

```
/Config
/Content
/Source               # C++ 코드
/Assets or assets     # README 데모 GIF
/Build or Docker      # 서버 빌드/이미지 스크립트(있다면)
/README.md
```

## Core Architecture

- Input → Client Prediction → Server Authority
- State Replication: 위치, 애니메이션 상태, 체력 등 핵심만 선별 복제
- RPC
  - RunOnServer: 입력·스킬 사용
  - Multicast: 피격·이펙트 브로드캐스트
- Lag Compensation: 서버 히트 스캔 시 과거 위치 보정(초안)

## Code Snippet

```cpp
void APlayerPawn::Tick(float Dt){
  Super::Tick(Dt);
  HandleInput(Dt);          // Client prediction
  SimulatePhysics(Dt);      // Deterministic step
}
void APlayerPawn::Server_Attack_Implementation(const FInput& In){ /* validate, apply */ }
UPROPERTY(ReplicatedUsing=OnRep_State) FNetState NetState;
```

## Build

- Editor 빌드: Development 또는 Shipping
- Dedicated Server Target 포함 시 Packaging 메뉴에서 Server 빌드 가능
- CI/CD(Optional): BuildGraph 또는 GitHub Actions로 에셋 요리(Cook) 후 아티팩트 업로드

## Troubleshooting

- 이동 튐: 네트워크 스무딩 값 점검, 보정 윈도우 확대
- 애님 전이 끊김: Anim Notify 타이밍 재조정, Blend 설정 확인
- 프레임 드랍: Lumen 품질 단계 완화, 라이트 수·그림자 캐스팅 최적화

## Roadmap

- [ ] 랙 보정 히트스캔 정식 적용
- [ ] 매치메이킹 큐와 재시작 로직 고도화
- [ ] 전투 스킬 세트 확장 및 상태 머신 정리

## License

MIT 또는 프로젝트에 맞는 라이선스를 명시하세요.

Links
- Notion 프로젝트 페이지: https://www.notion.so/… 혹은 내부 링크
- 이슈 트래커: GitHub Issues

필요하면 영어 버전 README도 만들어 줄게. 파일 구조나 서버 스크립트가 있으면 섹션을 그에 맞춰 더 정확히 조정해 드릴 수 있어.
