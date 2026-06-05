-- OTEJ Link — Supabase schema
-- Coller dans : Dashboard → SQL Editor → New query → Run

create table if not exists centers (
  id          text primary key,
  name        text not null,
  city        text not null,
  address     text not null,
  lat         float not null,
  lng         float not null,
  phone       text not null,
  hours       text not null,
  created_at  timestamptz not null default now()
);

create table if not exists events (
  id          text primary key,
  title       text not null,
  description text not null,
  city        text not null,
  category    text not null,
  date_start  timestamptz not null,
  date_end    timestamptz,
  center_id   text references centers(id),
  is_free     boolean not null default true,
  image_url   text,
  lang        text not null default 'fr',
  created_at  timestamptz not null default now()
);

-- Index pour le delta sync (created_at > last_sync)
create index if not exists events_created_at_idx  on events(created_at);
create index if not exists centers_created_at_idx on centers(created_at);

-- Row Level Security : lecture publique (anon key suffit)
alter table events  enable row level security;
alter table centers enable row level security;

create policy "Lecture publique events"
  on events for select using (true);

create policy "Lecture publique centers"
  on centers for select using (true);
