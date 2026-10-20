# 📋 TODO

> 오늘 할 일 체크리스트입니다. 작업을 시작할 때 이 파일부터 확인해요.
> 완료한 항목은 `[x]`로 체크하고, 한 일은 `progress.md`에 기록해요.

---

## 2026-10-19 — 작업 환경 구축

- [x] 1. `tasks/` 폴더 + `todo.md`, `progress.md` 생성
- [x] 2. `SECURITY.md` 비상 매뉴얼 작성
  - 키 노출 의심 시 즉시 할 일 (폐기 → 재발급 → 환경변수 교체)
  - 서비스별 안내: OpenRouter / Oracle 서버(SSH 키) / WordPress
  - 사용 이력 확인 방법
  - 평소 예방 수칙 (`.gitignore`, 마스킹 등)
- [x] 3. `README.md` 작성
  - 폴더 구조 트리
  - 각 파일의 역할 설명
  - 작업 시작·종료 루틴

---

## 2026-10-19 — 포트폴리오 웹페이지 (✅ 완료)

방식: **빌드 없이 파일을 더블클릭하면 바로 열리는** HTML 2개 (React 버전, Vue 3 버전)
- CDN으로 라이브러리 로드 (버전 고정), 인터넷 연결 필요. Node 설치·빌드 불필요
- 같은 디자인·같은 내용, 반응형 (폰/태블릿/PC), 다크모드 대응
- 위치: `portfolio/react/index.html`, `portfolio/vue/index.html` (새 폴더)

- [x] 0. 내 정보 받기 → `resume_sample.pdf` 사용 (김수민 샘플 이력서)
- [x] 1. 공통 디자인 정하고 React 버전 작성 (소개 / 경력 3개 / 연락처)
- [x] 2. React 버전 브라우저에서 열어 확인 (스크린샷, 폰 390px·태블릿 768px 너비 포함)
- [x] 3. Vue 3 버전 작성 (같은 내용·디자인)
- [x] 4. Vue 버전 확인 + 두 버전 비교
- [x] 5. `README.md`, `progress.md` 갱신

## 2026-10-19 — LA 날씨·미세먼지 자동 저장 (✅ 완료)

방식: **Open-Meteo** 무료 API 2개 사용 (키·가입 불필요) — 날씨 API + 대기질 API
스크립트: PowerShell 1개 (추가 설치 없음), 매일 7시에 Windows 작업 스케줄러가 실행

- [x] 1. `scripts/weather.ps1` 작성 (새 폴더 `scripts/`)
  - LA 날씨: 현재 기온·체감·습도·바람, 오늘 최고/최저, 강수확률
  - 미세먼지: US AQI(대기질 지수), PM2.5, PM10
  - 결과를 `weather.txt`에 **맨 아래에 추가** (날짜별 기록이 쌓임, 덮어쓰지 않음)
  - 인터넷 오류가 나면 오류 내용을 `weather.txt`에 남기고 종료
- [x] 2. 직접 한 번 실행해서 `weather.txt` 내용 확인 (시간대 Pacific 확인, 저장 위치 기본값 승인됨)
- [x] 3. 작업 스케줄러에 등록 (작업 이름 `LA-Weather-0700`, 매일 07:00)
  - ⚠️ 이 PC의 시스템 설정을 바꾸는 단계라 등록 전에 한 번 더 확인
  - PC가 꺼져 있었으면 켠 뒤 바로 실행되도록 설정
- [x] 4. 등록 확인 + `README.md`, `progress.md` 갱신

저장 위치(기본값): `C:\Projects\ai-project\claude-workspace\weather.txt`
주의: PC가 7시에 꺼져 있거나 인터넷이 없으면 그날은 건너뛰거나, 켠 뒤 실행됨


대상: `C:\Users\KYOUNGTAEK OH\Downloads` (바로 아래 파일 52개)

- [x] 1. `images`, `docs`, `misc` 폴더 만들기 (지금은 세 폴더 모두 없음)
- [x] 2. 파일 옮기기
  - `images`: jpg, png, gif, webp, svg, heic 등 → **해당 파일 0개** (빈 폴더만 생김)
  - `docs`: pdf, docx, xlsx, xls, pptx, txt, md 등 → **38개**
  - `misc`: 나머지 (zip, exe, json) → **14개**
- [x] 3. 결과 확인 (폴더별 개수가 미리보기와 같은지 확인)
- [x] 4. `progress.md`에 기록

안전 규칙
- 옮길 곳에 같은 이름의 파일이 있으면 **덮어쓰지 않고** `이름 (1).확장자`처럼 새 이름으로 저장
- 옮긴 내역을 `tasks/downloads-move-log.csv`에 저장 (원래대로 되돌릴 때 사용)
- 하위 폴더 6개는 **건드리지 않음**
- `desktop.ini`(Windows 시스템 파일)는 **건드리지 않음**

## 2026-10-20 — 포트폴리오 방명록 (Supabase + Vite) (🔧 진행 중: 6단계 브라우저 테스트 대기)

방식: 기존 `portfolio/react/index.html`은 **그대로 두고**, 새 폴더 `portfolio/app/`에 Vite+React 프로젝트를 만들어 포트폴리오를 옮기고 맨 아래에 방명록을 붙임
- 환경변수: `portfolio/app/.env.local` (`VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`) — git에 올라가지 않음
- 테이블: `messages` (id, name, content, created_at), RLS = 누구나 읽기 + 쓰기만 (수정·삭제는 막힘)
- ⚠️ 테이블 생성은 Supabase 대시보드 SQL Editor에서 **내가 직접 실행할 수 없음** → SQL 파일을 만들어 드리면 붙여넣어 실행

- [x] 1. `supabase/messages.sql` 작성 (테이블 + 길이 제한 + RLS 정책) → SQL Editor에서 실행 (사용자)
- [x] 2. `portfolio/app/`에 Vite+React 프로젝트 생성 (`npm install`, 외부 패키지 다운로드)
- [x] 3. 기존 포트폴리오(소개/경력/연락처, 다크모드, `style.css`)를 새 프로젝트로 옮기기 + 화면 확인
- [x] 4. `.env.local`, `.env.example` 만들기 + `.gitignore`로 제외되는지 `git check-ignore`로 확인
- [x] 5. Supabase 연결 코드 + 방명록 UI(폼 + 목록, 맨 아래) 추가 — 출력은 텍스트로만(XSS 방지)
- [ ] 6. 로컬 테스트: `npm run dev` → 글 작성·목록 표시·빈 값/긴 글 막힘 확인
- [ ] 7. `README.md`, `progress.md` 갱신
- [ ] (별도 확인 후) 8. `vercel.json` 빌드 설정 변경 + Vercel에 환경변수 등록 — 안 하면 배포본에서 방명록이 동작하지 않음
