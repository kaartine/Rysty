--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clubs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE clubs (
    id integer NOT NULL,
    name character varying(255),
    founded date,
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: contact_informations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contact_informations (
    id integer NOT NULL,
    phone_number character varying(255),
    address character varying(255),
    postal_code character varying(255),
    city character varying(255),
    country character varying(255),
    description text,
    email character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: contact_informations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contact_informations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: contact_informations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contact_informations_id_seq OWNED BY contact_informations.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    place character varying(255),
    "time" time without time zone,
    date date,
    description text,
    participants_id integer,
    oraganizer_id integer,
    event_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE games (
    id integer NOT NULL,
    first_referee_id integer,
    second_referee_id integer,
    trustee1 character varying(255),
    trustee2 character varying(255),
    trustee3 character varying(255),
    aob text,
    num_of_spectators integer,
    hall_id integer,
    home_team_id integer,
    guest_team_id integer,
    serie_id integer,
    event_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE games_id_seq OWNED BY games.id;


--
-- Name: goals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE goals (
    id integer NOT NULL,
    "time" time without time zone,
    penalty_shot boolean,
    delayed_penalty boolean,
    missed_penalty boolean,
    en boolean,
    pp boolean,
    sh boolean,
    equal boolean,
    scorer_id integer,
    assister_id integer,
    team_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: goals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goals_id_seq OWNED BY goals.id;


--
-- Name: halls; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE halls (
    id integer NOT NULL,
    name character varying(255),
    description text,
    number_of_fields integer,
    contact_information_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: halls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE halls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: halls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE halls_id_seq OWNED BY halls.id;


--
-- Name: head_lines; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE head_lines (
    id integer NOT NULL,
    posted date,
    title character varying(255),
    content text,
    person_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE news_id_seq OWNED BY head_lines.id;


--
-- Name: penalties; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE penalties (
    id integer NOT NULL,
    "time" time without time zone,
    reason integer,
    minutes integer,
    end_time time without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: penalties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE penalties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: penalties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE penalties_id_seq OWNED BY penalties.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE people (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    birthday date,
    height integer,
    weight integer,
    description text,
    nick_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    left_handed boolean
);


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE people_id_seq OWNED BY people.id;


--
-- Name: player_statistics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE player_statistics (
    id integer NOT NULL,
    plusminus integer,
    number integer,
    captain boolean,
    assistant_captain boolean,
    goalie boolean,
    game_time time without time zone,
    saved_shots integer,
    goals_against integer,
    player_id integer,
    game_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: player_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE player_statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: player_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE player_statistics_id_seq OWNED BY player_statistics.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE players (
    id integer NOT NULL,
    number integer,
    stick character varying(255),
    "position" character varying(255),
    person_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE players_id_seq OWNED BY players.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: series; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE series (
    id integer NOT NULL,
    name character varying(255),
    description text,
    organizer character varying(255),
    type character varying(255),
    teams_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: series_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE series_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE series_id_seq OWNED BY series.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE teams (
    id integer NOT NULL,
    short_name character varying(255),
    long_name character varying(255),
    string character varying(255),
    email character varying(255),
    home_town character varying(255),
    stadium_id integer,
    mascot character varying(255),
    description character varying(255),
    club_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_id_seq OWNED BY clubs.id;


--
-- Name: teams_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: teams_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_id_seq1 OWNED BY teams.id;


--
-- Name: teams_in_season; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE teams_in_season (
    id integer NOT NULL,
    picture character varying(255),
    logo character varying(255),
    team_id integer,
    season_id integer,
    contact_information_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: teams_in_season_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_in_season_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: teams_in_season_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_in_season_id_seq OWNED BY teams_in_season.id;


--
-- Name: teams_players; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE teams_players (
    id integer NOT NULL,
    number integer,
    "position" character varying(255),
    captain boolean,
    assistant_captain boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: teams_players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: teams_players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_players_id_seq OWNED BY teams_players.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255),
    password character varying(255),
    person_id integer,
    admin boolean,
    add_edit_delete boolean,
    intranet boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    salt character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE clubs ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE contact_informations ALTER COLUMN id SET DEFAULT nextval('contact_informations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE goals ALTER COLUMN id SET DEFAULT nextval('goals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE halls ALTER COLUMN id SET DEFAULT nextval('halls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE head_lines ALTER COLUMN id SET DEFAULT nextval('news_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE penalties ALTER COLUMN id SET DEFAULT nextval('penalties_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE player_statistics ALTER COLUMN id SET DEFAULT nextval('player_statistics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE players ALTER COLUMN id SET DEFAULT nextval('players_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE series ALTER COLUMN id SET DEFAULT nextval('series_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq1'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE teams_in_season ALTER COLUMN id SET DEFAULT nextval('teams_in_season_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE teams_players ALTER COLUMN id SET DEFAULT nextval('teams_players_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: contact_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contact_informations
    ADD CONSTRAINT contact_informations_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: games_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: goals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY (id);


--
-- Name: halls_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY halls
    ADD CONSTRAINT halls_pkey PRIMARY KEY (id);


--
-- Name: news_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY head_lines
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: penalties_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY penalties
    ADD CONSTRAINT penalties_pkey PRIMARY KEY (id);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: player_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY player_statistics
    ADD CONSTRAINT player_statistics_pkey PRIMARY KEY (id);


--
-- Name: players_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: series_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY series
    ADD CONSTRAINT series_pkey PRIMARY KEY (id);


--
-- Name: teams_in_season_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY teams_in_season
    ADD CONSTRAINT teams_in_season_pkey PRIMARY KEY (id);


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clubs
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: teams_pkey1; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey1 PRIMARY KEY (id);


--
-- Name: teams_players_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY teams_players
    ADD CONSTRAINT teams_players_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20100213191737');

INSERT INTO schema_migrations (version) VALUES ('20100214134101');

INSERT INTO schema_migrations (version) VALUES ('20100216202448');

INSERT INTO schema_migrations (version) VALUES ('20100222161735');

INSERT INTO schema_migrations (version) VALUES ('20100222161814');

INSERT INTO schema_migrations (version) VALUES ('20100222163341');

INSERT INTO schema_migrations (version) VALUES ('20100224202000');

INSERT INTO schema_migrations (version) VALUES ('20100228061827');

INSERT INTO schema_migrations (version) VALUES ('20100228111759');

INSERT INTO schema_migrations (version) VALUES ('20100228114011');

INSERT INTO schema_migrations (version) VALUES ('20100228114821');

INSERT INTO schema_migrations (version) VALUES ('20100228115330');

INSERT INTO schema_migrations (version) VALUES ('20100228120222');

INSERT INTO schema_migrations (version) VALUES ('20100228121154');

INSERT INTO schema_migrations (version) VALUES ('20100228122241');

INSERT INTO schema_migrations (version) VALUES ('20100228124407');

INSERT INTO schema_migrations (version) VALUES ('20100228124731');

INSERT INTO schema_migrations (version) VALUES ('20100228125643');

INSERT INTO schema_migrations (version) VALUES ('20100228151422');