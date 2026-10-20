-- 포트폴리오 방명록 테이블 + RLS
-- Supabase 대시보드 > SQL Editor 에 붙여넣어 실행하세요.

-- 1. 테이블
create table public.messages (
  id          bigint generated always as identity primary key,
  name        text        not null,
  content     text        not null,
  created_at  timestamptz not null default now(),

  -- 빈 값·너무 긴 값 방지
  constraint messages_name_length    check (char_length(btrim(name))    between 1 and 30),
  constraint messages_content_length check (char_length(btrim(content)) between 1 and 500)
);

-- 최신순 조회용 인덱스
create index messages_created_at_idx
  on public.messages (created_at desc);

-- 2. RLS 켜기 (정책이 없는 동작은 모두 막혀요)
alter table public.messages enable row level security;

-- 3. 누구나 읽기
create policy "messages: anyone can read"
  on public.messages
  for select
  to anon, authenticated
  using (true);

-- 4. 누구나 작성
create policy "messages: anyone can insert"
  on public.messages
  for insert
  to anon, authenticated
  with check (true);

-- 5. 테이블 접근 권한 (RLS와 별개로 필요)
--    update/delete 는 주지 않아서 남의 글을 고치거나 지울 수 없어요.
grant select, insert on public.messages to anon, authenticated;
