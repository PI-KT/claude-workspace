# 📝 PROGRESS

> 한 일을 날짜별로 기록합니다. **append-only** — 기존 내용은 지우거나 고치지 않고 아래에 계속 추가해요.

---

## 2026-10-19

- `tasks/` 폴더 생성
- `tasks/todo.md` 생성 — 작업 환경 구축 계획 작성
- `tasks/progress.md` 생성 — 이 파일
- `SECURITY.md` 작성 — 키 노출 비상 매뉴얼 (공통 대응 순서, OpenRouter / Oracle SSH / WordPress별 방법, GitHub 노출 대응, 예방 수칙)
- `README.md` 작성 — 폴더 구조 트리, 파일별 역할, 작업 시작·종료 루틴, 보안 요약
- ✅ 작업 환경 구축 3단계 완료

### 다운로드 폴더 정리
- `Downloads`에 `images`, `docs`, `misc` 폴더 생성
- 파일 52개 이동: docs 38개 (pdf·docx·xlsx·xls·pptx·txt·md), misc 14개 (zip·exe·json), images 0개
- 덮어쓴 파일 0개, 이름 바뀐 파일 0개
- 하위 폴더 6개, `desktop.ini`는 그대로 둠
- 이동 내역: `tasks/downloads-move-log.csv` (되돌릴 때 사용)

### 자기소개서 초안
- `Downloads\resume_sample.pdf`(김수민 샘플 이력서, 8쪽)를 바탕으로 IT 마케팅 자기소개서 초안 작성
- 성장 과정 + 지원 동기 + 입사 후 포부, 본문 공백 포함 778자
- 저장 위치: `Downloads\자기소개서_초안_IT마케팅.txt`
- 남은 일: `[회사명]`, `[제품/서비스]`, `[시장]` 빈칸 채우기

### sample_sales.csv 분석
- `Downloads\sample_sales.csv`(66행, 2026-01-03 ~ 03-31) 분석: 월별 매출, 상품별 TOP 5, 이상치
- 이상치: ORD-2026-0059 매출 5,000,000원 (수량×단가 = 129,000원과 불일치). 원본 파일은 수정하지 않음

### LA 날씨·미세먼지 스크립트 (완료)
- `scripts/weather.ps1` 작성 (Open-Meteo, API 키 불필요) — 날씨 + US AQI/PM2.5/PM10을 `weather.txt` 맨 아래에 추가
- Windows PowerShell 5.1로 시험 실행 성공 (`weather.txt` 첫 기록 생성, 한글 정상)
- Windows 작업 스케줄러에 `LA-Weather-0700` 등록 (매일 07:00, 일반 권한, 놓치면 켠 뒤 실행) — 첫 자동 실행 예정: 2026-10-20 07:00
- 스케줄러로 수동 실행 1회 성공 (결과 코드 0) → `weather.txt` 기록 2건 (시험 실행 2건)
- 삭제 방법: `Unregister-ScheduledTask -TaskName LA-Weather-0700`

### 포트폴리오 웹페이지 (React / Vue 3)
- `resume_sample.pdf`(김수민 샘플 이력서) 내용으로 제작 — 소개, 경력 3개(회사 2곳 + 동아리 부회장), 연락처
- `portfolio/style.css`(공통 디자인), `portfolio/react/index.html`, `portfolio/vue/index.html` 작성 — 더블클릭으로 열림, CDN 사용(인터넷 필요)
- Edge로 열어서 확인: PC / 태블릿 768px / 폰 390px, 다크 모드. 태블릿에서 이메일이 끊기는 문제를 발견해 연락처 3열 기준을 900px로 수정
- 전화번호·거주지는 공개 페이지라 뺌
- 미확인: 라이트 모드 화면, 실제 스마트폰

## 2026-10-20

### GitHub CLI 설치
- `winget install GitHub.cli` (사용자 범위)로 gh 2.102.0 설치, `gh --version` 실행 확인
- 위치: `%LOCALAPPDATA%\Microsoft\WinGet\Links\gh.exe`
- 아직 GitHub 로그인 안 함 (`gh auth login` 필요)
