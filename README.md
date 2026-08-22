# Battle Rogue

언리얼 엔진 5로 만든 1대1 온라인 대전 게임입니다. 데디케이티드 서버를 따로 빌드해서 붙였습니다.

<p>
  <img src="https://img.shields.io/badge/Unreal_Engine_5-313131?style=flat-square&logo=unrealengine&logoColor=white"/>
  <img src="https://img.shields.io/badge/Blueprint-9333EA?style=flat-square"/>
  <img src="https://img.shields.io/badge/Dedicated_Server-FF6B6B?style=flat-square"/>
  <img src="https://img.shields.io/badge/Git_LFS-F64935?style=flat-square&logo=gitlfs&logoColor=white"/>
  <img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square"/>
  <a href="https://www.notion.so/Battle-Rogue-PVP-UE5-8aad1e946e554a60a1ea0ccf8a35b7dd?source=copy_link"><img src="https://img.shields.io/badge/회고-Notion-000000?style=flat-square&logo=notion&logoColor=white"/></a>
</p>

<p>
  <img src="assets/fighting-game-demo.gif" alt="게임 플레이" width="48%">
  <img src="assets/anim-montage-process.gif" alt="애님 몽타주 작업" width="48%">
</p>

<br/>

## 1. 무엇을 해보고 싶었나

격투 게임은 판정이 한 프레임 차이로 갈립니다. 그걸 두 대의 클라이언트가 각자 계산하면 서로 다른 결과가 나옵니다.
그래서 판정을 서버 한 곳에서만 하도록 만드는 게 이 프로젝트의 목표였습니다.

혼자 하는 게임을 만드는 것과 서버를 따로 띄워야 하는 게임을 만드는 건 완전히 다른 일이라는 걸 해보고 알았습니다.

<br/>

## 2. 무엇으로 만들었나

**게임 로직은 전부 Blueprint 입니다.** C++ 는 모듈 스텁과 빌드 타깃 설정만 들어 있습니다.

`BattleRogue/Source/` 에 있는 것

| 파일 | 내용 |
|---|---|
| `BattleRogue.cpp` / `.h` | 엔진이 만들어 준 모듈 진입점. 6줄짜리 스텁입니다 |
| `BattleRogue.Build.cs` | 의존 모듈 지정 (`EnhancedInput`, `UMG`, `Slate`, `SlateCore` 추가) |
| `BattleRogue.Target.cs` | 게임 타깃 |
| `BattleRogueEditor.Target.cs` | 에디터 타깃 |
| `BattleRogueServer.Target.cs` | **서버 타깃.** `Type = TargetType.Server` |

C++ 로 게임플레이를 짠 건 아니고, 서버 전용 빌드가 나오게 타깃을 하나 더 만든 게 여기서 한 일입니다.
이걸 안 만들면 데디케이티드 서버 실행 파일이 안 나옵니다.

<br/>

## 3. 서버 구조

```
   ┌──────────────────────┐        ┌──────────────────────┐
   │   Client A           │        │   Client B           │
   │   BattleRogue.exe    │        │   BattleRogue.exe    │
   │   입력 전송 + 렌더링   │        │   입력 전송 + 렌더링   │
   └──────────┬───────────┘        └──────────┬───────────┘
              │                               │
              │      RPC / 프로퍼티 복제        │
              └───────────────┬───────────────┘
                              ▼
              ┌───────────────────────────────┐
              │   Dedicated Server            │
              │   BattleRogueServer.exe       │
              │   피격 판정과 데미지 계산        │
              │   매치 진행                    │
              └───────────────────────────────┘
```

클라이언트는 입력을 보내고 받은 상태를 그립니다. 맞았는지 아닌지는 서버만 정합니다.

<br/>

## 4. 콘텐츠 구성

`BattleRogue/Content/` 에 uasset 2,493개가 들어 있습니다. 출처를 나눠 보면 이렇습니다.

| 폴더 | 파일 수 | 무엇 |
|---|---|---|
| `Fap/FXVarietyPack` | 1,690 | 이펙트 에셋 팩 (외부) |
| `StarterContent` | 267 | 엔진 기본 제공 |
| `__ExternalActors__` | 252 | UE5 월드 파티션이 자동 생성 |
| `Characters` | 145 | 캐릭터 메시와 머티리얼 |
| `Blueprints` | 61 | 직접 만든 블루프린트 |
| `Sounds` | 46 | 사운드 |
| `Material`, `Maps`, `Input`, `Video` | 31 | 머티리얼, 맵, 입력 매핑 |

직접 만든 것은 `Blueprints/` 61개와 맵, 그리고 발판 기믹입니다.
`상하발판`, `좌우발판`, `상하좌우발판` 세 개를 만들어서 스테이지에 배치했습니다.

캐릭터는 XBot 을 쓰고 애니메이션 몽타주를 붙였습니다.
`AM_Punching_LR_Anim`, `AM_Martelo_2_binddummy_Anim`, `AM_Reaction_binddummy_Anim`,
`AM_Dying_Getting_Up_binddummy_Anim` 같은 식으로 공격, 피격, 다운, 기상을 몽타주로 나눴습니다.

이펙트와 스타터 콘텐츠는 외부 자산입니다. 전체 2,493개 중 직접 만든 비중은 크지 않습니다.

<br/>

## 5. 저장소가 큰 이유

이 저장소는 크기가 상당합니다. 이유가 두 가지입니다.

1. `Content/` 의 uasset 을 Git LFS 로 올렸습니다. GitHub API 가 보여주는 저장소 크기에는 LFS 가 안 잡힙니다
2. 패키징 결과물을 같이 커밋했습니다. `Client/Windows/` 와 `Server/WindowsServer/` 에 실행 파일과 pak, dll 이 들어 있습니다

빌드 없이 바로 실행해 볼 수 있게 하려고 넣었는데, 다시 한다면 릴리스 자산으로 올리고 저장소에서는 뺄 것 같습니다.
크래시 리포터 설정 파일 같은 것도 같이 딸려 들어갔습니다.

```
.
├── BattleRogue/              언리얼 프로젝트
│   ├── BattleRogue.uproject
│   ├── Config/               엔진, 게임, 입력 설정 ini
│   ├── Content/              uasset 2,493개 (LFS)
│   └── Source/               모듈 스텁 + 타깃 4개
├── Client/Windows/           패키징된 클라이언트
├── Server/WindowsServer/     패키징된 서버
└── assets/                   README 데모 GIF 2개
```

<br/>

## 6. 실행

**에디터에서**

1. `BattleRogue.uproject` 우클릭하고 Generate Visual Studio project files
2. 생성된 sln 을 Visual Studio 에서 빌드
3. UE5 에디터에서 `BattleRogue.uproject` 열고 Play

**패키징 빌드로 1대1 붙여 보기**

```bat
cd Server\WindowsServer\BattleRogue\Binaries\Win64
BattleRogueServer.exe
```

```bat
cd Client\Windows
BattleRogue.exe
```

클라이언트를 두 개 띄우면 됩니다. 같은 PC 에서도 되고 다른 PC 에서도 됩니다.

Git LFS 가 필요합니다. `git lfs install` 을 먼저 하고 클론해야 uasset 이 제대로 받아집니다.

<br/>

## 7. 막혔던 것

- 에디터에서는 되는데 패키징하면 자산이 빠지는 일이 자주 있었습니다. 참조가 블루프린트 안에만 있으면 쿠킹에서 제외됩니다
- 서버 타깃을 만들기 전까지는 데디케이티드 서버 실행 파일이 안 나온다는 걸 몰라서 한참 헤맸습니다
- 몽타주 캔슬 구간을 잡는 게 어려웠습니다. 너무 넓으면 무한 콤보가 되고 좁으면 조작이 답답해집니다

자세한 건 [Notion 회고](https://www.notion.so/Battle-Rogue-PVP-UE5-8aad1e946e554a60a1ea0ccf8a35b7dd?source=copy_link) 에 적어 뒀습니다.

<br/>

MIT License
