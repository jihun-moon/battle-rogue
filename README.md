# Battle Rogue

코드는 이 저장소에, 상세 문서·스크린샷·회고는 Notion에 정리합니다.

## 🔗 Notion

  - **상세 문서:** [Battle Rogue 프로젝트 상세 문서](https://www.notion.so/Battle-Rogue-PVP-UE5-8aad1e946e554a60a1ea0ccf8a35b7dd?source=copy_link)

## 🚀 실행

이 프로젝트는 Unreal Engine으로 개발되었으며, 에디터 또는 패키징된 빌드를 통해 실행할 수 있습니다.

#### 에디터에서 실행

1.  `BattleRogue.uproject` 파일을 우클릭하여 'Generate Visual Studio project files'를 실행합니다.
2.  생성된 `.sln` 파일을 Visual Studio에서 열어 빌드합니다.
3.  Unreal Engine 에디터에서 `BattleRogue.uproject` 파일을 열고 'Play' 버튼을 눌러 실행합니다.

#### 패키징 빌드로 실행 (Client/Server)

1.  `Server/` 폴더로 이동하여 `ServerStart.bat` 파일을 실행해 서버를 엽니다.
2.  `Client/` 폴더로 이동하여 `BattleRogue.exe` 파일을 실행해 클라이언트에 접속합니다.

## 📂 폴더 구조

  - `assets/`: README 파일에 사용되는 GIF 등 에셋이 위치합니다.
  - `BattleRogue/`: Unreal Engine 프로젝트 메인 폴더입니다.
      - `Content/`: 블루프린트, 맵, 머티리얼 등 주요 게임 애셋이 위치합니다.
      - `Source/`: C++ 소스 코드가 위치합니다.
  - `Client/`: 패키징된 클라이언트 빌드 폴더입니다.
  - `Server/`: 패키징된 서버 빌드 폴더입니다.

## 🖼️ 데모 GIF

\<img src="assets/fighting-game-demo.gif" alt="게임 플레이 데모" width="48%"/\> \<img src="assets/anim-montage-process.gif" alt="애님 몽타주" width="48%"/\>

## 📄 라이선스

이 프로젝트는 **MIT** 라이선스를 따릅니다.
