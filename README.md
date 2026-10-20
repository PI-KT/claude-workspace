# 🗂️ claude-workspace

> Claude Code와 함께 작업하는 **메인 작업 폴더**입니다.
> 위치: `C:\Projects\ai-project\claude-workspace`

---

## 📁 폴더 구조

```
claude-workspace/
├── 📄 CLAUDE.md          # Claude Code 지침서 (규칙, 소통 방식, 작업 원칙)
├── 🚨 SECURITY.md        # 키 노출 비상 매뉴얼
├── 📘 README.md          # 지금 보고 있는 문서 (폴더 안내도)
├── 🙈 .gitignore         # Git에 올리지 않을 파일 목록 (.env, *.key 등 민감 파일 제외)
├── 🔒 .env               # API 키·비밀번호 보관 (※ 아직 없음 / 절대 공유·업로드 금지)
├── 🌤️ weather.txt        # LA 날씨·미세먼지 기록 (매일 07:00 자동으로 아래에 추가)
├── 📂 portfolio/         # 포트폴리오 웹페이지 (더블클릭하면 브라우저에서 열림)
│   ├── style.css         # React·Vue 버전이 함께 쓰는 디자인
│   ├── react/index.html  # React 18 버전
│   └── vue/index.html    # Vue 3 버전
├── 📂 scripts/           # 자동 실행 스크립트
│   └── weather.ps1       # 날씨·미세먼지를 가져와 weather.txt에 저장 (Open-Meteo, 키 불필요)
└── 📂 tasks/             # 작업 기록 폴더
    ├── ✅ todo.md        # 오늘 할 일 (체크리스트)
    └── 📝 progress.md    # 한 일 기록 (append-only: 지우지 않고 계속 추가)
```

**폴더 밖에 있는 관련 파일**

| 파일 | 위치 | 역할 |
|---|---|---|
| Oracle SSH 키 | `~/.ssh/oracle-server.key` | Oracle 서버 접속용 개인 키 (**절대 공유 금지**) |
| SSH 설정 | `~/.ssh/config` | `oracle-server` 별칭 등록 |

> 💡 `~`는 내 사용자 폴더를 뜻해요. 예: `C:\Users\<내 계정>`

---

## 📄 파일별 역할

| 파일 | 누가 읽나요? | 언제 쓰나요? |
|---|---|---|
| `CLAUDE.md` | Claude Code (자동으로 읽어요) | Claude의 행동 규칙을 바꾸고 싶을 때 수정해요 |
| `SECURITY.md` | 나 + Claude Code | 키가 새어 나간 것 같을 때 순서대로 따라 해요 |
| `README.md` | 나 | 폴더 구조가 헷갈릴 때 봐요 |
| `.env` | 프로그램 | API 키를 보관해요. 코드는 여기서 키를 불러와요 |
| `tasks/todo.md` | 나 + Claude Code | 작업을 시작할 때 할 일을 확인해요 |
| `tasks/progress.md` | 나 + Claude Code | 작업을 끝낼 때 한 일을 기록해요 |

---

## 🔄 작업 루틴

### ▶️ 시작할 때
1. 이 폴더에서 Claude Code를 실행해요
2. `tasks/todo.md`를 열어 오늘 할 일을 확인해요
3. 큰 작업(3단계 이상)이면 계획을 `todo.md`에 먼저 적고, OK를 한 뒤 시작해요

### ⏹️ 끝낼 때
1. 완료한 항목은 `todo.md`에서 `[x]`로 체크해요
2. 한 일을 `progress.md` **맨 아래에 추가**해요 (기존 내용은 지우지 않기)

---

## 🔒 보안 한눈에 보기

- `.env`, `*.key`, `*.pem`, `id_rsa`, `credentials` 파일은 **절대 Git에 올리지 않기**
- 키는 코드에 직접 적지 말고 **환경변수로만** 사용하기
- 키를 보여줄 때는 항상 **마스킹** (예: `sk-or-v1-***`)
- 노출이 의심되면 → **[SECURITY.md](SECURITY.md)** 를 바로 열기

---

## 🧭 다음에 해 볼 만한 것

- [ ] `.env` 파일 만들기 (키 보관용)
- [x] `.gitignore` 만들기 (`.env`, `*.key` 등 제외)
- [x] GitHub private 레포에 올리기
