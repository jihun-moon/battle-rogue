<h1 align="center">⚔️ Battle Rogue</h1>

<p align="center"><em>Unreal Engine 5 로 만든 1:1 온라인 대전 격투 게임 — Dedicated Server 아키텍처 기반.</em></p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square"/>
  <img src="https://img.shields.io/badge/Unreal_Engine-5-313131?style=flat-square&logo=unrealengine&logoColor=white"/>
  <img src="https://img.shields.io/badge/Blueprints-Visual_Scripting-9333EA?style=flat-square"/>
  <img src="https://img.shields.io/badge/C%2B%2B-game_logic-00599C?style=flat-square&logo=cplusplus&logoColor=white"/>
  <img src="https://img.shields.io/badge/Networking-Dedicated_Server-FF6B6B?style=flat-square"/>
  <img src="https://img.shields.io/badge/Mode-1v1_PvP-success?style=flat-square"/>
  <a href="https://www.notion.so/Battle-Rogue-PVP-UE5-8aad1e946e554a60a1ea0ccf8a35b7dd?source=copy_link"><img src="https://img.shields.io/badge/Deep_Dive-Notion-000000?style=flat-square&logo=notion&logoColor=white"/></a>
</p>

<p align="center">
  <img src="assets/fighting-game-demo.gif" alt="Gameplay" width="48%">
  <img src="assets/anim-montage-process.gif" alt="Animation montage" width="48%">
</p>

---

## 🎯 Why this project

대전 격투 장르는 **틱 단위 정확성** 과 **공정한 네트워크 동기화** 가 동시에 요구되는, 게임 개발에서 가장 까다로운 분야 중 하나입니다. 이 프로젝트의 목적은 단순한 미니 게임이 아니라 — **데디케이티드 서버 + 클라이언트 분리 빌드 + 애님 몽타주 기반 콤보 시스템** 까지, 상용 멀티플레이 격투 게임의 핵심 빌딩 블록을 직접 구현하며 학습하는 것입니다.

---

## ✨ Key Features

- ⚔️ **1:1 온라인 PvP** — 두 클라이언트가 동시에 데디케이티드 서버에 접속해 실시간 매치
- 🖧 **Dedicated Server 아키텍처** — 권위 있는 서버 시뮬레이션, 클라이언트는 입력 + 보간만
- 🎬 **Anim Montage 기반 콤보** — 공격/피격/리액션을 몽타주로 합성, 캔슬링 윈도우 처리
- 📦 **Client / Server 분리 패키징** — `Client/` (배포용 .exe), `Server/` (`ServerStart.bat`) 로 분리 빌드
- 🧩 **Blueprint + C++ 하이브리드** — 핵심 로직은 C++ (`Source/`), 게임플레이 튜닝은 Blueprint (`Content/`)

---

## 🏗 Networking Architecture

```
   ┌─────────────────────┐         ┌─────────────────────┐
   │   Client A          │         │   Client B          │
   │  (BattleRogue.exe)  │         │  (BattleRogue.exe)  │
   │  - input → server   │         │  - input → server   │
   │  - render world     │         │  - render world     │
   └──────────┬──────────┘         └──────────┬──────────┘
              │                               │
              │       Replicated state        │
              │  (RPC / Property replication) │
              └───────────────┬───────────────┘
                              ▼
            ┌──────────────────────────────────┐
            │   Dedicated Server               │
            │   (ServerStart.bat)              │
            │   - authoritative simulation     │
            │   - hit / damage validation      │
            │   - match flow                   │
            └──────────────────────────────────┘
```

서버가 모든 판정의 권위를 가지며, 클라이언트는 입력 송신과 보간된 시각적 표현만 담당 — 치트 저항성과 결정성을 동시에 확보.

---

## 🛠 Tech Stack

| Layer | Tool | Role |
|---|---|---|
| Engine | **Unreal Engine 5** | rendering, physics, networking |
| Logic (low-level) | **C++** (`BattleRogue/Source/`) | gameplay framework, replication |
| Logic (high-level) | **Blueprints** (`BattleRogue/Content/`) | combat tuning, UI, sequences |
| Networking | UE5 Replication + Dedicated Server | client/server split |
| Animation | Anim Montage | combo system |
| Build | Visual Studio + UnrealBuildTool | `.sln` from `.uproject` |

---

## 📦 Build & Run

### 에디터에서 실행 (개발)

1. `BattleRogue.uproject` 우클릭 → **Generate Visual Studio project files**
2. 생성된 `.sln` 을 Visual Studio 에서 열고 빌드
3. UE5 에디터에서 `BattleRogue.uproject` 열기 → **Play** ▶

### 패키징 빌드 실행 (멀티플레이 시연)

```bat
:: 1) 서버 실행
cd Server\
ServerStart.bat

:: 2) 클라이언트 두 개를 따로 실행 (같은 머신/다른 머신)
cd Client\
BattleRogue.exe
```

---

## 📂 Project Layout

```
.
├── BattleRogue/              # Unreal 프로젝트 루트
│   ├── BattleRogue.uproject
│   ├── Content/              # Blueprints, maps, materials, anim assets
│   └── Source/               # C++ gameplay code
├── Client/                   # 패키징된 클라이언트 빌드
│   └── BattleRogue.exe
├── Server/                   # 패키징된 서버 빌드
│   └── ServerStart.bat
├── assets/                   # README 데모 GIF
└── README.md
```

---

## 📚 Deep Dive

콤보 캔슬 윈도우 설계, 서버 권위 판정, 패키징 분리 시 빠진 자산 추적 등 — 격투 게임 만들면서 부딪힌 실전 이슈는 Notion 에 정리되어 있습니다.

➡ [**Battle Rogue — UE5 PvP 회고**](https://www.notion.so/Battle-Rogue-PVP-UE5-8aad1e946e554a60a1ea0ccf8a35b7dd?source=copy_link)

---

## 📄 License

MIT — see [LICENSE](LICENSE).

---

<p align="center">
  Built by <a href="https://github.com/jihun-moon">@jihun-moon</a> · <a href="mailto:jihun0948@naver.com">jihun0948@naver.com</a>
</p>
