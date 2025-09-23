# ⚔️ Battle Rogue PVP | Unreal Engine 5

> ### 3줄 요약
>
>   - **PVP 전투 데모**: Unreal Engine 5와 C++, 블루프린트를 결합하여 제작한 실시간 3인칭 PVP 전투 데모입니다.
>   - **핵심 시스템**: 애니메이션 몽타주 기반의 콤보 시스템, 정교한 대미지 판정, 그리고 기본적인 네트워크 동기화 기능을 구현했습니다.
>   - **모듈화 설계**: UMG로 체력바 등 UI를 구현하고, 캐릭터의 입력, 이동, 상태 관리를 컴포넌트 기반으로 모듈화했습니다.

-----

## 🎮 데모

| 플레이 데모 | 애니메이션 몽타주 프로세스 |
| :---: | :---: |
| \<img src="assets/fighting-game-demo.gif" alt="Gameplay Demo" width="400"/\> | \<img src="assets/anim-montage-process.gif" alt="Anim Montage Process" width="400"/\> |

  - **시연 영상 (YouTube)**: `https://youtu.be/K5X9j_GAWU4`

-----

## ✅ 주요 기능

  - **전투 시스템**
      - 애니메이션 몽타주 기반의 콤보 시스템 및 캔슬 윈도우
      - 히트박스/허트박스를 이용한 정교한 충돌 판정, 대미지 계산, 피격 경직
  - **캐릭터 컨트롤**
      - 이동, 대시, 점프 등 기본 액션 및 상태머신(Idle/Attack/Hit/Down) 구현
  - **UI / HUD**
      - UMG를 이용한 HP 게이지, 콤보 히트 수, 매치 타이머 등 정보 시각화
  - **멀티플레이 기본**
      - `Replication`을 통한 위치/상태 동기화, `RPC`를 이용한 입력 처리, 서버 권위(Server Authority) 모델 적용

-----

## 🛠️ 개발 환경

  - **Engine**: Unreal Engine 5.x
  - **Language**: C++20
  - **IDE**: Visual Studio 2022 또는 Rider
  - **Platform**: Windows (64-bit)

-----

## 🚀 실행 및 빌드 방법

### 1\. 에디터에서 실행

1.  `BattleRogue.uproject` 파일을 더블클릭하여 언리얼 에디터를 엽니다.
2.  `Content/Maps/` 폴더의 PVP 테스트 맵을 열고 에디터에서 플레이(PIE)합니다.

### 2\. C++ 코드 빌드

  - Visual Studio 또는 Rider에서 프로젝트 솔루션을 빌드하거나, 언리얼 에디터 내의 **Compile** 버튼을 클릭합니다.

### 3\. 프로젝트 패키징

1.  **Edit → Project Settings → Packaging** 메뉴에서 빌드 타겟을 **Windows**로 설정합니다.
2.  **File → Package Project → Windows**를 선택하여 프로젝트를 패키징합니다.

-----

## 🧩 핵심 클래스 및 블루프린트

| 구분 | C++ 클래스 | 블루프린트 에셋 |
| :--- | :--- | :--- |
| **캐릭터** | `ABCharacter` | `BP_Player`, `BP_Enemy` |
| **컴포넌트** | `ABCombatComponent`, `ABHealthComponent`| N/A |
| **게임 로직**| `ABPlayerController`, `ABGameMode` | N/A |
| **UI** | N/A | `WBP_HUD`, `WBP_Scoreboard`|
| **애니메이션**| N/A | `BP_CombatMontage` |

-----

## 🔗 애니메이션 몽타주 가이드 (핵심 요약)

1.  **섹션 분리**: `Attack_A`, `Attack_B`, `Attack_C`와 같이 콤보 단계별로 몽타주 섹션을 분리합니다.
2.  **Notify 활용**: `AnimNotify`를 사용하여 특정 프레임에 히트박스 활성화/비활성화, 카메라 셰이크, 사운드 이펙트 등을 트리거합니다.
3.  **다음 콤보 전이**: 입력 버퍼와 캐릭터의 현재 상태를 체크하여 다음 몽타주 섹션으로 자연스럽게 전이되도록 로직을 구성합니다.

-----

## 🌐 네트워킹 메모

  - **변수 복제 (Replication)**: `Replicated` 키워드를 사용하여 위치, 캐릭터 상태, HP 등 중요한 변수를 서버에서 클라이언트로 동기화합니다.
  - **서버 권위 (Server Authority)**: 모든 대미지 판정은 서버에서만 수행하고, 그 결과를 `NetMulticast` RPC를 통해 모든 클라이언트에 시각 효과(VFX, SFX)로 재생합니다.
  - **입력 처리**: 사용자의 입력은 클라이언트에서 서버로 `Server_` 접두사가 붙은 RPC를 통해 전송하고, 서버 처리 결과는 `RepNotify`를 통해 각 클라이언트의 UI에 반영합니다.

-----

## 📜 라이선스

이 프로젝트는 [MIT 라이선스](https://opensource.org/licenses/MIT)를 따릅니다. (단, 사용된 애셋의 라이선스는 개별 폴더의 `NOTICE` 파일을 참고하세요.)
