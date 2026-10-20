import React, { useCallback, useEffect, useState } from 'react';
import { supabase, supabaseReady } from './supabase.js';

const NAME_MAX = 30;
const CONTENT_MAX = 500;

function formatDate(iso) {
  return new Date(iso).toLocaleString('ko-KR', { dateStyle: 'medium', timeStyle: 'short' });
}

export default function Guestbook() {
  const [messages, setMessages] = useState([]);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState('');
  const [name, setName] = useState('');
  const [content, setContent] = useState('');
  const [sending, setSending] = useState(false);
  const [formError, setFormError] = useState('');

  const load = useCallback(async () => {
    if (!supabaseReady) {
      setLoadError('Supabase 설정이 없어요. portfolio/app/.env.local 을 확인해 주세요.');
      setLoading(false);
      return;
    }
    const { data, error } = await supabase
      .from('messages')
      .select('id, name, content, created_at')
      .order('created_at', { ascending: false })
      .limit(50);
    if (error) setLoadError('방명록을 불러오지 못했어요. 잠시 후 다시 시도해 주세요.');
    else { setMessages(data); setLoadError(''); }
    setLoading(false);
  }, []);

  useEffect(() => { load(); }, [load]);

  const submit = async (e) => {
    e.preventDefault();
    const cleanName = name.trim();
    const cleanContent = content.trim();
    if (!cleanName || !cleanContent) {
      setFormError('이름과 메시지를 모두 입력해 주세요.');
      return;
    }
    if (!supabaseReady) {
      setFormError('Supabase 설정이 없어서 저장할 수 없어요.');
      return;
    }
    setSending(true);
    setFormError('');
    const { error } = await supabase.from('messages').insert({ name: cleanName, content: cleanContent });
    setSending(false);
    if (error) {
      setFormError('저장하지 못했어요. 잠시 후 다시 시도해 주세요.');
      return;
    }
    setContent('');
    await load();
  };

  return (
    <section className="section" id="guestbook">
      <div className="container">
        <h2>방명록</h2>
        <p className="lead">다녀가셨다면 한 줄 남겨 주세요.</p>

        <form className="gb-form" onSubmit={submit}>
          <label className="gb-field">
            <span>이름</span>
            <input
              type="text"
              value={name}
              maxLength={NAME_MAX}
              onChange={(e) => setName(e.target.value)}
              autoComplete="nickname"
              required
            />
          </label>
          <label className="gb-field">
            <span>메시지</span>
            <textarea
              rows={4}
              value={content}
              maxLength={CONTENT_MAX}
              onChange={(e) => setContent(e.target.value)}
              required
            />
            <small className="gb-count">{content.length} / {CONTENT_MAX}</small>
          </label>
          {formError && <p className="gb-error" role="alert">{formError}</p>}
          <button type="submit" className="btn primary" disabled={sending}>
            {sending ? '남기는 중…' : '남기기'}
          </button>
        </form>

        {loading && <p className="gb-empty">불러오는 중…</p>}
        {loadError && <p className="gb-error" role="alert">{loadError}</p>}
        {!loading && !loadError && messages.length === 0 && (
          <p className="gb-empty">아직 글이 없어요. 첫 번째 방문자가 되어 주세요!</p>
        )}

        <ul className="gb-list">
          {messages.map((m) => (
            <li className="gb-item" key={m.id}>
              <div className="gb-meta">
                <strong>{m.name}</strong>
                <time dateTime={m.created_at}>{formatDate(m.created_at)}</time>
              </div>
              {/* 텍스트로만 출력 (HTML로 해석하지 않음) */}
              <p>{m.content}</p>
            </li>
          ))}
        </ul>
      </div>
    </section>
  );
}
