--
-- PostgreSQL database dump
--

-- Dumped from database version 11.18 (Ubuntu 11.18-1.pgdg18.04+1)
-- Dumped by pg_dump version 14.2

-- Started on 2023-02-08 13:56:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 15 (class 3079 OID 17135)
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- TOC entry 5579 (class 0 OID 0)
-- Dependencies: 15
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- TOC entry 19 (class 3079 OID 17676)
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- TOC entry 5580 (class 0 OID 0)
-- Dependencies: 19
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- TOC entry 8 (class 3079 OID 16661)
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- TOC entry 5581 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- TOC entry 17 (class 3079 OID 17573)
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- TOC entry 5582 (class 0 OID 0)
-- Dependencies: 17
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- TOC entry 5583 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- TOC entry 14 (class 3079 OID 17130)
-- Name: dict_int; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dict_int WITH SCHEMA public;


--
-- TOC entry 5584 (class 0 OID 0)
-- Dependencies: 14
-- Name: EXTENSION dict_int; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_int IS 'text search dictionary template for integers';


--
-- TOC entry 20 (class 3079 OID 18299)
-- Name: dict_xsyn; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dict_xsyn WITH SCHEMA public;


--
-- TOC entry 5585 (class 0 OID 0)
-- Dependencies: 20
-- Name: EXTENSION dict_xsyn; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_xsyn IS 'text search dictionary template for extended synonym processing';


--
-- TOC entry 18 (class 3079 OID 17660)
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- TOC entry 5586 (class 0 OID 0)
-- Dependencies: 18
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- TOC entry 7 (class 3079 OID 16650)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 5587 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 13 (class 3079 OID 17007)
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- TOC entry 5588 (class 0 OID 0)
-- Dependencies: 13
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- TOC entry 12 (class 3079 OID 16889)
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- TOC entry 5589 (class 0 OID 0)
-- Dependencies: 12
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- TOC entry 4 (class 3079 OID 16444)
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- TOC entry 5590 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


--
-- TOC entry 22 (class 3079 OID 18311)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- TOC entry 5591 (class 0 OID 0)
-- Dependencies: 22
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- TOC entry 11 (class 3079 OID 16812)
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- TOC entry 5592 (class 0 OID 0)
-- Dependencies: 11
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- TOC entry 10 (class 3079 OID 16775)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5593 (class 0 OID 0)
-- Dependencies: 10
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 16 (class 3079 OID 17571)
-- Name: pgrowlocks; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgrowlocks WITH SCHEMA public;


--
-- TOC entry 5594 (class 0 OID 0)
-- Dependencies: 16
-- Name: EXTENSION pgrowlocks; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrowlocks IS 'show row-level locking information';


--
-- TOC entry 5 (class 3079 OID 16619)
-- Name: pgstattuple; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgstattuple WITH SCHEMA public;


--
-- TOC entry 5595 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION pgstattuple; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgstattuple IS 'show tuple-level statistics';


--
-- TOC entry 23 (class 3079 OID 18318)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 5596 (class 0 OID 0)
-- Dependencies: 23
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- TOC entry 6 (class 3079 OID 16629)
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- TOC entry 5597 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- TOC entry 21 (class 3079 OID 18304)
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- TOC entry 5598 (class 0 OID 0)
-- Dependencies: 21
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- TOC entry 9 (class 3079 OID 16764)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 5599 (class 0 OID 0)
-- Dependencies: 9
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 3 (class 3079 OID 16430)
-- Name: xml2; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS xml2 WITH SCHEMA public;


--
-- TOC entry 5600 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION xml2; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION xml2 IS 'XPath querying and XSLT';


SET default_tablespace = '';

--
-- TOC entry 258 (class 1259 OID 5631963)
-- Name: etsy_info; Type: TABLE; Schema: public; Owner: joqivmzw
--

CREATE TABLE public.etsy_info (
    id integer NOT NULL,
    app_name character varying NOT NULL,
    app_key character varying NOT NULL,
    app_secret character varying NOT NULL,
    owner_name character varying NOT NULL,
    owner_key character varying NOT NULL,
    owner_secret character varying NOT NULL,
    write_date timestamp without time zone NOT NULL
);


ALTER TABLE public.etsy_info OWNER TO joqivmzw;

--
-- TOC entry 257 (class 1259 OID 5631961)
-- Name: etsy_info_id_seq; Type: SEQUENCE; Schema: public; Owner: joqivmzw
--

ALTER TABLE public.etsy_info ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.etsy_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 245 (class 1259 OID 5621892)
-- Name: fd_feeds_feed_id_seq; Type: SEQUENCE; Schema: public; Owner: joqivmzw
--

CREATE SEQUENCE public.fd_feeds_feed_id_seq
    AS integer
    START WITH 500
    INCREMENT BY 1
    MINVALUE 500
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fd_feeds_feed_id_seq OWNER TO joqivmzw;

--
-- TOC entry 246 (class 1259 OID 5621894)
-- Name: fd_feeds; Type: TABLE; Schema: public; Owner: joqivmzw
--

CREATE TABLE public.fd_feeds (
    feed_id integer DEFAULT nextval('public.fd_feeds_feed_id_seq'::regclass) NOT NULL,
    feed_type character varying,
    feed_name character varying,
    feed_date timestamp without time zone,
    write_date timestamp without time zone,
    write_user character varying,
    android_id character varying,
    state character varying,
    feed_parent_id character varying,
    feed_price numeric(13,0)
);


ALTER TABLE public.fd_feeds OWNER TO joqivmzw;

--
-- TOC entry 256 (class 1259 OID 5626187)
-- Name: fd_feeds_last_id; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.fd_feeds_last_id AS
 SELECT max(fd_feeds.feed_id) AS id
   FROM public.fd_feeds
  GROUP BY fd_feeds.feed_name
  ORDER BY (max(fd_feeds.feed_id)) DESC;


ALTER TABLE public.fd_feeds_last_id OWNER TO joqivmzw;

--
-- TOC entry 248 (class 1259 OID 5621907)
-- Name: fd_foods_food_id_seq; Type: SEQUENCE; Schema: public; Owner: joqivmzw
--

CREATE SEQUENCE public.fd_foods_food_id_seq
    AS integer
    START WITH 700
    INCREMENT BY 1
    MINVALUE 700
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fd_foods_food_id_seq OWNER TO joqivmzw;

--
-- TOC entry 249 (class 1259 OID 5621909)
-- Name: fd_foods; Type: TABLE; Schema: public; Owner: joqivmzw
--

CREATE TABLE public.fd_foods (
    food_id integer DEFAULT nextval('public.fd_foods_food_id_seq'::regclass) NOT NULL,
    person_id integer NOT NULL,
    feed_id integer NOT NULL,
    food_qty numeric(13,0),
    food_amount numeric(13,0),
    food_date timestamp without time zone,
    write_date timestamp without time zone,
    write_user character varying,
    android_id character varying,
    state character varying,
    food_price numeric(13,0)
);


ALTER TABLE public.fd_foods OWNER TO joqivmzw;

--
-- TOC entry 242 (class 1259 OID 5621854)
-- Name: fd_persons_id_seq; Type: SEQUENCE; Schema: public; Owner: joqivmzw
--

CREATE SEQUENCE public.fd_persons_id_seq
    AS integer
    START WITH 800
    INCREMENT BY 1
    MINVALUE 800
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fd_persons_id_seq OWNER TO joqivmzw;

--
-- TOC entry 243 (class 1259 OID 5621856)
-- Name: fd_persons; Type: TABLE; Schema: public; Owner: joqivmzw
--

CREATE TABLE public.fd_persons (
    id integer DEFAULT nextval('public.fd_persons_id_seq'::regclass) NOT NULL,
    status character varying,
    company character varying,
    address character varying,
    country character varying,
    person_name character varying,
    phone character varying,
    write_date timestamp without time zone,
    user_mail character varying,
    android_id character varying,
    town character varying,
    state character varying,
    write_user character varying,
    android_ids character varying,
    see_param boolean DEFAULT true NOT NULL
);


ALTER TABLE public.fd_persons OWNER TO joqivmzw;

--
-- TOC entry 255 (class 1259 OID 5626182)
-- Name: fd_persons_last_id; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.fd_persons_last_id AS
 SELECT max(fd_persons.id) AS id
   FROM public.fd_persons
  GROUP BY fd_persons.user_mail
  ORDER BY (max(fd_persons.id)) DESC;


ALTER TABLE public.fd_persons_last_id OWNER TO joqivmzw;

--
-- TOC entry 239 (class 1259 OID 5621573)
-- Name: querys; Type: TABLE; Schema: public; Owner: joqivmzw
--

CREATE TABLE public.querys (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    query character varying(250),
    columns character varying(1000),
    heading character varying(200),
    submenu character varying,
    sql character varying(1000)
);


ALTER TABLE public.querys OWNER TO joqivmzw;

--
-- TOC entry 238 (class 1259 OID 5621571)
-- Name: querys_id_seq; Type: SEQUENCE; Schema: public; Owner: joqivmzw
--

CREATE SEQUENCE public.querys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.querys_id_seq OWNER TO joqivmzw;

--
-- TOC entry 5601 (class 0 OID 0)
-- Dependencies: 238
-- Name: querys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joqivmzw
--

ALTER SEQUENCE public.querys_id_seq OWNED BY public.querys.id;


--
-- TOC entry 247 (class 1259 OID 5621903)
-- Name: v_feeds; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.v_feeds AS
 SELECT fd_feeds.feed_id,
    fd_feeds.feed_type,
    fd_feeds.feed_name,
    fd_feeds.feed_price,
    fd_feeds.feed_date,
    fd_feeds.write_date,
    fd_feeds.write_user,
    fd_feeds.android_id,
    fd_feeds.state
   FROM public.fd_feeds
  WHERE ((COALESCE(fd_feeds.state, ''::character varying))::text <> 'del'::text);


ALTER TABLE public.v_feeds OWNER TO joqivmzw;

--
-- TOC entry 250 (class 1259 OID 5621928)
-- Name: v_foods; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.v_foods AS
 SELECT fd_foods.food_id,
    fd_foods.person_id,
    fd_foods.feed_id,
    fd_foods.food_qty,
    fd_foods.food_amount,
    fd_foods.food_date,
    fd_foods.write_date,
    fd_foods.write_user,
    fd_foods.android_id,
    fd_foods.state,
    fd_foods.food_price
   FROM public.fd_foods
  WHERE ((COALESCE(fd_foods.state, ''::character varying))::text <> 'del'::text);


ALTER TABLE public.v_foods OWNER TO joqivmzw;

--
-- TOC entry 244 (class 1259 OID 5621866)
-- Name: v_persons; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.v_persons AS
 SELECT fd_persons.id,
    fd_persons.status,
    fd_persons.company,
    fd_persons.address,
    fd_persons.country,
    fd_persons.person_name,
    fd_persons.phone,
    fd_persons.write_date,
    fd_persons.user_mail,
    fd_persons.android_id,
    fd_persons.town,
    fd_persons.state,
    fd_persons.write_user,
    fd_persons.android_ids
   FROM public.fd_persons
  WHERE ((COALESCE(fd_persons.state, ''::character varying))::text <> 'del'::text);


ALTER TABLE public.v_persons OWNER TO joqivmzw;

--
-- TOC entry 254 (class 1259 OID 5626178)
-- Name: r_foods; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.r_foods AS
 SELECT ( SELECT persons.person_name
           FROM public.v_persons persons
          WHERE (persons.id = foods.person_id)) AS person_name,
    ( SELECT feeds.feed_name
           FROM public.v_feeds feeds
          WHERE (feeds.feed_id = foods.feed_id)) AS feed_name,
    ( SELECT feeds.feed_type
           FROM public.v_feeds feeds
          WHERE (feeds.feed_id = foods.feed_id)) AS feed_type,
    foods.food_qty,
    foods.food_price,
    foods.food_amount,
    date(foods.food_date) AS food_date,
    foods.state
   FROM public.v_foods foods
  WHERE (0 = 0)
  ORDER BY foods.food_id DESC;


ALTER TABLE public.r_foods OWNER TO joqivmzw;

--
-- TOC entry 253 (class 1259 OID 5626174)
-- Name: v_feed_type; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.v_feed_type AS
 SELECT DISTINCT fd_feeds.feed_type AS param
   FROM public.fd_feeds
  WHERE (((fd_feeds.feed_type)::text = ''::text) OR (fd_feeds.feed_type IS NOT NULL))
  ORDER BY fd_feeds.feed_type;


ALTER TABLE public.v_feed_type OWNER TO joqivmzw;

--
-- TOC entry 251 (class 1259 OID 5626165)
-- Name: v_foodorders; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.v_foodorders AS
 SELECT foods.food_id,
    foods.person_id,
    foods.feed_id,
    foods.food_qty,
    foods.food_amount,
    foods.food_date,
    foods.write_date,
    foods.write_user,
    foods.android_id,
    foods.state,
    foods.food_price,
    ( SELECT persons.person_name
           FROM public.v_persons persons
          WHERE (persons.id = foods.person_id)) AS person_name,
    ( SELECT feeds.feed_name
           FROM public.v_feeds feeds
          WHERE (feeds.feed_id = foods.feed_id)) AS feed_name,
    ( SELECT feeds.feed_type
           FROM public.v_feeds feeds
          WHERE (feeds.feed_id = foods.feed_id)
         LIMIT 1) AS feed_type
   FROM public.v_foods foods
  WHERE (0 = 0);


ALTER TABLE public.v_foodorders OWNER TO joqivmzw;

--
-- TOC entry 240 (class 1259 OID 5621582)
-- Name: v_querys; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.v_querys AS
 SELECT querys.id,
    querys.name,
    querys.query,
    querys.columns,
    querys.heading,
    querys.submenu,
        CASE
            WHEN ((COALESCE(querys.sql, ''::character varying))::text <> ''::text) THEN (length((querys.sql)::text) || ' char'::text)
            ELSE NULL::text
        END AS _sql
   FROM public.querys querys;


ALTER TABLE public.v_querys OWNER TO joqivmzw;

--
-- TOC entry 241 (class 1259 OID 5621586)
-- Name: v_querys_sql; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.v_querys_sql AS
 SELECT querys.id,
    querys.name,
    querys.query,
    querys.sql
   FROM public.querys querys;


ALTER TABLE public.v_querys_sql OWNER TO joqivmzw;

--
-- TOC entry 252 (class 1259 OID 5626170)
-- Name: v_status; Type: VIEW; Schema: public; Owner: joqivmzw
--

CREATE VIEW public.v_status AS
 SELECT DISTINCT fd_persons.status AS param
   FROM public.fd_persons
  WHERE (((fd_persons.status)::text = ''::text) OR ((fd_persons.status)::text IS NOT NULL))
  ORDER BY fd_persons.status;


ALTER TABLE public.v_status OWNER TO joqivmzw;

--
-- TOC entry 5405 (class 2604 OID 5621576)
-- Name: querys id; Type: DEFAULT; Schema: public; Owner: joqivmzw
--

ALTER TABLE ONLY public.querys ALTER COLUMN id SET DEFAULT nextval('public.querys_id_seq'::regclass);


--
-- TOC entry 5573 (class 0 OID 5631963)
-- Dependencies: 258
-- Data for Name: etsy_info; Type: TABLE DATA; Schema: public; Owner: joqivmzw
--

INSERT INTO public.etsy_info (id, app_name, app_key, app_secret, owner_name, owner_key, owner_secret, write_date) VALUES (1, 'getMyTansaction', 'o63wzrgegsx0kep6tobqvkyt', 'rcvjxnh9rs', 'YoungAgeLab', '3a83aba985d39f5006d1615d546dd7', '159e7ccc51', '2020-11-15 09:59:00');


--
-- TOC entry 5569 (class 0 OID 5621894)
-- Dependencies: 246
-- Data for Name: fd_feeds; Type: TABLE DATA; Schema: public; Owner: joqivmzw
--

INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (7, 'варенья', 'Вишнёвое (с косточками) 345', '0021-09-09 00:00:00', '2019-03-16 08:45:00', '140', 'ab0c6b16e41f44b0', 'del', NULL, 255);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (84, 'варенья', 'Вишнёвое (с косточками)', '0015-03-14 00:00:00', '2019-03-16 08:45:00', '140', 'ab0c6b16e41f44b0', NULL, NULL, 25);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (108, 'Заказ обеда', 'Заказ обеда(первое+салат) на завтра', NULL, NULL, NULL, NULL, 'del', NULL, 0);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (117, 'Заказ обеда', 'Заказ обеда на завтра', NULL, NULL, NULL, NULL, 'del', NULL, 0);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (118, 'Заказ обеда', 'Заказ обеда на послезавтра', NULL, NULL, NULL, NULL, 'del', NULL, 0);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (183, 'выпечка', 'С вишней', NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (185, 'выпечка', 'С капустой', NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (181, 'выпечка', 'С картошкой и печенью', NULL, NULL, NULL, NULL, NULL, NULL, 4);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (180, 'выпечка', 'С мясом', NULL, NULL, NULL, NULL, NULL, NULL, 5);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (184, 'выпечка', 'С яблоками', NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (176, 'напиток', 'Компот', NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (8, 'выпечка', 'С мясом копченым', '0022-09-09 00:00:00', '2019-03-17 11:09:00', '140', 'a696945e7053af62', NULL, NULL, 8);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (111, 'Заказ обеда', 'Заказ обеда(только второе) на послезавтра', NULL, NULL, NULL, NULL, 'del', NULL, 0);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (110, 'Заказ обеда', 'Заказ обеда(только второе) на завтра', NULL, NULL, NULL, NULL, 'del', NULL, 0);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (1, 'ПолуФабрикат', 'Вареники с вишней', NULL, '2019-02-21 07:09:00', NULL, NULL, 'del', NULL, 19);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (119, 'заказ полдника', 'Полдник (заказ)', NULL, NULL, NULL, NULL, 'del', NULL, 0);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (177, 'напиток', 'Кофе', NULL, NULL, NULL, NULL, NULL, NULL, 4);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (178, 'напиток', 'Кофе с молоком', NULL, NULL, NULL, NULL, NULL, NULL, 5);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (162, 'напиток', 'Молоко (300 мл)', NULL, NULL, NULL, NULL, NULL, NULL, 4);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (174, 'напиток', 'Салат овощной', NULL, NULL, NULL, NULL, NULL, NULL, 4);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (175, 'напиток', 'Салат с майонезом', NULL, NULL, NULL, NULL, NULL, NULL, 6);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (130, 'обед', 'Обед полный', NULL, NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (132, 'обед', 'Обед(первое+салат)', NULL, NULL, NULL, NULL, NULL, NULL, 9);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (131, 'обед', 'Обед(только второе)', NULL, NULL, NULL, NULL, NULL, NULL, 9);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (179, 'полдник', 'Полдник', NULL, NULL, NULL, NULL, NULL, NULL, 11);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (186, 'ПолуФабрикат', 'Вареники с капустой', NULL, NULL, NULL, NULL, NULL, NULL, 15);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (187, 'ПолуФабрикат', 'Вареники с картошкой и грибами', NULL, NULL, NULL, NULL, NULL, NULL, 17);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (190, 'ПолуФабрикат', 'Вареники с мясом', NULL, NULL, NULL, NULL, NULL, NULL, 29);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (133, 'ПолуФабрикат', 'Вареники со смородиной', NULL, NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (191, 'ПолуФабрикат', 'Пельмени по-домашнему', NULL, NULL, NULL, NULL, NULL, NULL, 25);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (140, 'ПолуФабрикат', 'Пельмени с дичью', NULL, NULL, NULL, NULL, NULL, NULL, 26);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (189, 'ПолуФабрикат', 'Вареники с вишней', NULL, '2019-02-21 07:46:00', NULL, NULL, NULL, NULL, 20);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (4, 'ПолуФабрикат', 'Вареники с вишней NEW2', '0021-09-09 00:00:00', '2019-03-16 15:41:00', '140', 'ab0c6b16e41f44b0', 'del', NULL, 20);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (2, 'Porcion', 'Вареники с вишней', NULL, '2019-03-12 09:38:00', NULL, NULL, 'del', NULL, 23);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (182, 'выпечка', 'Ватрушка', '0020-02-09 00:00:00', '2019-08-14 19:14:00', '140', '447f3df9c7240c3c', NULL, NULL, 5);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (9, 'варенья', 'клубничное новое', '0015-09-01 00:00:00', '2019-09-28 09:42:00', '140', '447f3df9c7240c3c', NULL, NULL, 25);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (83, 'варенья', 'Джем из кр. смородины со сливками2', '0017-09-05 00:00:00', '2019-09-30 12:51:00', '140', '447f3df9c7240c3c', NULL, NULL, 35);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (97, 'ПолуФабрикат', 'Икра кабачковая', '0035-09-10 00:00:00', '2020-03-30 06:19:00', '528', '70566f4ac30bd154', NULL, NULL, 15);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (188, 'ПолуФабрикат', 'Вареники с творогом', '0032-12-10 00:00:00', '2020-06-27 09:02:00', '140', 'cb99776f4779ac6d', NULL, NULL, 23);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (10, 'ПолуФабрикат', 'Вареники с творогом', '0032-12-10 00:00:00', '2020-06-27 09:01:00', '140', 'cb99776f4779ac6d', 'del', NULL, 25);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (11, 'ПолуФабрикат', 'Вареники с дичью', '2020-11-28 11:01:00', '2020-11-28 11:01:00', '140', '46860b782c3139e3', 'del', NULL, 29);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (138, 'ПолуФабрикат', 'Вареники с дичью', '2020-11-28 11:03:00', '2020-11-28 11:03:00', '140', '46860b782c3139e3', NULL, NULL, 29);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (12, 'полдник', 'Полдник22', '2020-11-29 13:29:00', '2020-11-29 13:29:00', '140', '10505312be2c4abb', 'del', NULL, 115);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (103, 'ПолуФабрикат', 'Торт печеночный (100 г)', '0035-09-10 00:00:00', '2020-03-30 06:19:00', '', '', '', NULL, 9);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (81, 'варенья', 'Клубничное', '0022-09-09 00:00:00', '2019-09-28 09:42:00', '', '', '', NULL, 30);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (3, 'ПолуФабрикат', 'Вареники с вишней', '0022-09-09 00:00:00', '2019-02-21 11:15:00', '', '', '', NULL, 21);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (82, 'варенья', 'Черная смородина', '0022-09-09 00:00:00', '2019-09-28 09:42:00', '', '', '', NULL, 30);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (32, 'напиток', 'Сок', '0022-09-09 00:00:00', '2019-09-28 09:42:00', '', '', '', NULL, 3);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (31, 'напиток', 'Фреш апельсиновый НОВЫЙ', '0022-09-09 00:00:00', '2019-09-28 09:42:00', '', '', '', NULL, 8);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (99, 'ПолуФабрикат', 'Колбаса домашняя говяжья', '0035-09-10 00:00:00', '2020-03-30 06:19:00', '', '', '', NULL, 71);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (13, 'ПолуФабрикат', 'Вареники с творогом', '0032-12-10 00:00:00', '2020-06-27 09:02:00', '999', 'cb99776f4779ac6d', '', NULL, 23);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (14, 'ПолуФабрикат', 'Вареники с творогом', '0032-12-10 00:00:00', '2020-06-27 09:02:00', '999', 'cb99776f4779ac6d', '', NULL, 23);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (15, 'ПолуФабрикат', 'Вареники с творогом', '0032-12-10 00:00:00', '2020-06-27 09:02:00', '999', 'cb99776f4779ac6d', '', NULL, 23);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (16, 'ПолуФабрикат', 'Вареники с творогом', '0032-12-10 00:00:00', '2020-06-27 09:02:00', '145', 'cb99776f4779ac6d', '', NULL, 23);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (98, 'ПолуФабрикат', 'Капуста квашеная', '0035-09-10 00:00:00', '2020-03-30 06:19:00', '140', '', '', NULL, 6);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (109, 'Заказ обеда', 'Заказ обеда(первое+салат) на послезавтра', NULL, NULL, '140', NULL, 'del', NULL, 0);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (100, 'ПолуФабрикат', 'Котлета по-киевски', '0035-09-10 00:00:00', '2020-03-30 06:19:00', '140', '', '', NULL, 10);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (501, 'ПолуФабрикат', 'Вареники с вишней', NULL, '2019-02-21 07:46:00', NULL, NULL, NULL, NULL, 20);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (502, 'ПолуФабрикат', 'Вареники с мясом', NULL, NULL, NULL, NULL, NULL, NULL, 29);
INSERT INTO public.fd_feeds (feed_id, feed_type, feed_name, feed_date, write_date, write_user, android_id, state, feed_parent_id, feed_price) VALUES (503, 'ПолуФабрикат', 'Пельмени по-домашнему', NULL, NULL, NULL, NULL, NULL, NULL, 25);


--
-- TOC entry 5571 (class 0 OID 5621909)
-- Dependencies: 249
-- Data for Name: fd_foods; Type: TABLE DATA; Schema: public; Owner: joqivmzw
--

INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (38, 140, 83, 3, 90, '2019-03-19 00:00:00', '2019-03-13 22:05:00', NULL, 'ab0c6b16e41f44b0', 'del', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (5, 53, 83, 3, 50, '1970-03-15 00:00:00', '2019-03-09 13:17:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (74, 528, 110, 1, 0, '2019-03-25 00:00:00', '2019-03-17 11:08:00', '528', 'a696945e7053af62', 'del', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (66, 464, 132, 1, 9, '2019-03-25 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', NULL, 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (67, 464, 132, 1, 9, '2019-03-26 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', NULL, 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (68, 464, 132, 1, 9, '2019-03-27 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', NULL, 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (70, 464, 132, 1, 9, '2019-03-29 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', NULL, 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (71, 53, 181, 5, 20, '2019-03-27 00:00:00', '2019-03-17 11:07:00', '53', 'a696945e7053af62', NULL, 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (73, 53, 181, 5, 20, '2019-03-26 00:00:00', '2019-03-17 11:07:00', '53', 'a696945e7053af62', NULL, 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (42, 689, 185, 5, 15, '2019-03-20 00:00:00', '2019-03-20 19:08:00', '689', 'a696945e7053af62', 'done', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (69, 464, 132, 1, 9, '2019-03-28 00:00:00', '2019-03-28 20:57:00', '464', 'a696945e7053af62', 'done', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (72, 53, 181, 5, 20, '2019-03-28 00:00:00', '2019-03-28 20:56:00', '53', 'a696945e7053af62', 'done', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (90, 61, 176, 1, 3, '2019-04-03 00:00:00', '2019-03-29 12:34:00', '61', 'a696945e7053af62', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (92, 61, 176, 1, 3, '2019-04-05 00:00:00', '2019-03-29 12:34:00', '61', 'a696945e7053af62', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (34, 716, 182, 11, 44, '2019-03-12 00:00:00', '2019-03-12 18:04:00', NULL, 'aa3130d9ed20b81a', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (35, 716, 185, 11, 33, '2019-03-12 00:00:00', '2019-03-12 18:05:00', NULL, 'aa3130d9ed20b81a', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (33, 689, 185, 5, 15, '2019-03-16 00:00:00', '2019-03-16 11:30:00', '689', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (21, 140, 185, 1, 50, '2019-03-11 00:00:00', '2019-03-11 07:55:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (22, 140, 81, 1, 55, '2019-03-11 00:00:00', '2019-03-11 07:56:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (23, 140, 183, 5, 15, '2019-03-11 00:00:00', '2019-03-11 08:32:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (24, 140, 180, 5, 25, '2019-03-11 00:00:00', '2019-03-11 08:40:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (47, 500, 98, 1, 6, '2019-03-18 00:00:00', '2019-03-14 20:46:00', NULL, 'f962f6723f86cb26', 'del', 6);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (48, 500, 100, 1, 10, '2019-03-18 00:00:00', '2019-03-14 20:46:00', NULL, 'f962f6723f86cb26', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (44, 689, 185, 5, 15, '2019-03-22 00:00:00', '2019-03-14 20:43:00', NULL, 'f962f6723f86cb26', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (46, 500, 188, 1, 21, '2019-03-18 00:00:00', '2019-03-14 20:46:00', NULL, 'f962f6723f86cb26', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (43, 689, 185, 5, 15, '2019-03-21 00:00:00', '2019-03-21 14:16:00', '689', 'a696945e7053af62', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (45, 689, 185, 5, 15, '2019-03-23 00:00:00', '2019-03-23 11:24:00', '689', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (52, 427, 182, 5, 20, '2019-03-18 00:00:00', '2019-03-18 12:07:00', '427', 'ab0c6b16e41f44b0', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (51, 500, 176, 1, 3, '2019-03-18 00:00:00', '2019-03-14 20:46:00', NULL, 'f962f6723f86cb26', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (53, 427, 182, 5, 20, '2019-03-19 00:00:00', '2019-03-15 20:38:00', NULL, '874da9a893938146', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (54, 427, 182, 5, 20, '2019-03-21 00:00:00', '2019-03-21 14:17:00', '427', 'a696945e7053af62', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (60, 140, 82, 5, 150, '2019-03-16 00:00:00', '2019-03-16 21:12:00', '140', 'a696945e7053af62', 'del', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (61, 52, 182, 1, 4, '2019-03-18 00:00:00', '2019-03-16 19:27:00', '52', 'ab0c6b16e41f44b0', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (62, 52, 182, 1, 4, '2019-03-19 00:00:00', '2019-03-16 19:27:00', '52', 'ab0c6b16e41f44b0', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (63, 53, 100, 2, 20, '2019-03-25 00:00:00', '2019-03-17 10:42:00', '53', 'a696945e7053af62', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (64, 53, 100, 2, 20, '2019-03-27 00:00:00', '2019-03-17 10:42:00', '53', 'a696945e7053af62', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (55, 427, 185, 5, 15, '2019-03-21 00:00:00', '2019-03-21 14:17:00', '427', 'a696945e7053af62', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (75, 358, 3, 1, 23, '2019-03-25 00:00:00', '2019-03-17 11:15:00', '358', 'a696945e7053af62', 'del', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (76, 358, 182, 1, 4, '2019-03-25 00:00:00', '2019-03-17 11:15:00', '358', 'a696945e7053af62', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (77, 358, 182, 1, 4, '2019-03-26 00:00:00', '2019-03-17 11:15:00', '358', 'a696945e7053af62', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (78, 358, 182, 1, 4, '2019-03-28 00:00:00', '2019-03-17 11:15:00', '358', 'a696945e7053af62', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (79, 53, 191, 2, 50, '2019-03-26 00:00:00', '2019-03-17 16:14:00', '53', 'f962f6723f86cb26', 'del', 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (89, 61, 176, 1, 3, '2019-04-02 00:00:00', '2019-03-29 12:34:00', '61', 'a696945e7053af62', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (86, 689, 183, 5, 15, '2019-03-28 00:00:00', '2019-03-23 11:23:00', '689', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (88, 61, 176, 1, 3, '2019-04-01 00:00:00', '2019-03-29 12:34:00', '61', 'a696945e7053af62', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (87, 689, 183, 5, 15, '2019-03-29 00:00:00', '2019-03-23 11:24:00', '689', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (18, 53, 98, 5, 30, '2019-03-10 00:00:00', '2019-03-10 15:14:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (19, 689, 177, 1, 50, '2019-03-10 00:00:00', '2019-03-10 18:52:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (20, 689, 83, 1, 50, '2019-03-14 00:00:00', '2019-03-14 20:42:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (17, 53, 83, 1, 30, '2019-03-10 00:00:00', '2019-03-10 15:12:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (26, 53, 98, 2, 12, '2019-03-15 00:00:00', '2019-03-15 20:40:00', NULL, 'ab0c6b16e41f44b0', 'del', 6);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (25, 140, 83, 3, 90, '2019-03-16 00:00:00', '2019-03-16 21:12:00', '140', 'a696945e7053af62', 'del', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (32, 689, 183, 1, 3, '2019-03-16 00:00:00', '2019-03-16 11:30:00', '689', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (84, 689, 183, 5, 15, '2019-03-26 00:00:00', '2019-03-23 11:23:00', '689', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (83, 427, 182, 5, 20, '2019-03-29 00:00:00', '2019-03-18 12:09:00', '427', 'ab0c6b16e41f44b0', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (85, 689, 183, 5, 15, '2019-03-26 00:00:00', '2019-03-23 11:23:00', '689', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (28, 500, 190, 1, 29, '2019-03-12 00:00:00', '2019-03-12 07:39:00', NULL, 'ab0c6b16e41f44b0', 'del', 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (29, 500, 188, 1, 21, '2019-03-12 00:00:00', '2019-03-12 07:40:00', NULL, 'ab0c6b16e41f44b0', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (31, 689, 182, 1, 4, '2019-03-13 00:00:00', '2019-03-13 09:30:00', NULL, 'ab0c6b16e41f44b0', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (91, 61, 176, 9, 27, '2019-04-04 00:00:00', '2019-08-14 19:13:00', '140', '447f3df9c7240c3c', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (59, 140, 81, 3, 90, '2019-03-19 00:00:00', '2019-03-16 08:52:00', '140', 'ab0c6b16e41f44b0', 'del', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (94, 61, 182, 2, 8, '2019-04-04 00:00:00', '2019-03-29 12:34:00', '61', 'a696945e7053af62', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (56, 427, 185, 5, 15, '2019-03-22 00:00:00', '2019-03-15 20:38:00', NULL, '874da9a893938146', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (57, 427, 84, 5, 125, '2019-03-22 00:00:00', '2019-03-15 20:38:00', NULL, '874da9a893938146', 'del', 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (27, 500, 189, 1, 20, '2019-03-12 00:00:00', '2019-03-12 07:39:00', NULL, 'ab0c6b16e41f44b0', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (49, 500, 100, 1, 10, '2019-03-20 00:00:00', '2019-03-20 19:07:00', '500', 'a696945e7053af62', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (50, 500, 100, 1, 10, '2019-03-23 00:00:00', '2019-03-23 18:43:00', '500', 'a696945e7053af62', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (99, 689, 8, 5, 40, '2019-08-20 00:00:00', '2019-08-12 16:27:00', '689', '3924fd504ff1ea2d', NULL, 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (100, 689, 8, 5, 40, '2019-08-21 00:00:00', '2019-08-12 16:27:00', '689', '3924fd504ff1ea2d', NULL, 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (103, 61, 182, 2, 8, '2019-04-02 00:00:00', '2019-08-13 18:05:00', '140', '3924fd504ff1ea2d', NULL, 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (104, 61, 176, 1, 3, '2019-08-20 00:00:00', '2019-08-13 18:06:00', '140', '3924fd504ff1ea2d', NULL, 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (102, 689, 176, 1, 3, '2019-08-22 00:00:00', '2019-08-12 16:27:00', '689', '3924fd504ff1ea2d', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (101, 689, 8, 5, 40, '2019-08-22 00:00:00', '2019-08-12 16:27:00', '689', '3924fd504ff1ea2d', 'del', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (93, 61, 182, 2, 8, '2019-04-05 00:00:00', '2019-03-29 12:34:00', '61', 'a696945e7053af62', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (107, 528, 97, 10, 150, '2020-04-06 00:00:00', '2020-03-30 06:20:00', '528', '70566f4ac30bd154', NULL, 15);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (106, 528, 97, 10, 150, '2020-04-07 00:00:00', '2020-03-30 06:20:00', '528', '70566f4ac30bd154', NULL, 15);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (108, 4, 3, 1, 20, '2020-04-06 00:00:00', '2020-04-03 05:43:00', '4', '70566f4ac30bd154', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (58, 140, 83, 3, 102, '2019-03-19 00:00:00', '2019-03-16 08:51:00', '140', 'ab0c6b16e41f44b0', 'del', 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (110, 15, 3, 1, 20, '2020-05-04 00:00:00', '2020-04-26 07:13:00', '15', '70566f4ac30bd154', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (111, 17, 3, 1, 20, '2020-05-04 00:00:00', '2020-04-27 09:43:00', '17', 'b1aef469408b5b2e', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (112, 18, 181, 10, 40, '2020-05-04 00:00:00', '2020-04-27 06:47:00', '18', '6b7784294592c43c', NULL, 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (113, 18, 180, 10, 50, '2020-05-04 00:00:00', '2020-04-27 06:48:00', '18', '6b7784294592c43c', NULL, 5);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (114, 18, 180, 10, 50, '2020-05-06 00:00:00', '2020-04-27 06:48:00', '18', '6b7784294592c43c', NULL, 5);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (125, 16, 133, 1, 16, '2020-06-03 00:00:00', '2020-05-29 15:04:49.362734', '16', '70566f4ac30bd154', NULL, 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (126, 16, 176, 1, 3, '2020-06-03 00:00:00', '2020-05-29 15:04:49.362734', '16', '70566f4ac30bd154', NULL, 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (127, 16, 3, 1, 20, '2020-06-04 00:00:00', '2020-05-29 15:04:49.747148', '16', '70566f4ac30bd154', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (128, 16, 133, 1, 16, '2020-06-04 00:00:00', '2020-05-29 15:04:49.747148', '16', '70566f4ac30bd154', NULL, 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (129, 16, 176, 1, 3, '2020-06-04 00:00:00', '2020-05-29 15:04:49.747148', '16', '70566f4ac30bd154', NULL, 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (130, 16, 3, 1, 20, '2020-06-05 00:00:00', '2020-05-29 15:04:50.133063', '16', '70566f4ac30bd154', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (131, 16, 133, 1, 16, '2020-06-05 00:00:00', '2020-05-29 15:04:50.133063', '16', '70566f4ac30bd154', NULL, 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (132, 16, 176, 1, 3, '2020-06-05 00:00:00', '2020-05-29 15:04:50.133063', '16', '70566f4ac30bd154', NULL, 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (115, 16, 3, 1, 20, '2020-05-29 00:00:00', '2020-05-29 15:05:00', '16', '70566f4ac30bd154', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (116, 16, 133, 1, 16, '2020-05-29 00:00:00', '2020-05-29 15:05:00', '16', '70566f4ac30bd154', 'done', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (117, 16, 176, 1, 3, '2020-05-29 00:00:00', '2020-05-29 15:05:00', '16', '70566f4ac30bd154', 'done', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (121, 16, 3, 1, 20, '2020-06-02 00:00:00', '2020-05-29 15:04:48.97752', '16', '70566f4ac30bd154', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (120, 16, 176, 1, 3, '2020-05-31 00:00:00', '2020-05-31 08:12:00', '16', '70566f4ac30bd154', 'done', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (118, 16, 3, 1, 20, '2020-06-01 00:00:00', '2020-06-01 10:40:00', '16', 'b1aef469408b5b2e', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (119, 16, 133, 1, 16, '2020-06-01 00:00:00', '2020-06-01 10:40:00', '16', 'b1aef469408b5b2e', 'done', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (142, 53, 100, 2, 20, '2020-06-17 00:00:00', '2020-06-17 14:00:00', '53', 'cb99776f4779ac6d', 'done', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (6, 53, 97, 3, 50, '2019-03-10 00:00:00', '2019-03-10 13:19:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (7, 53, 83, 3, 50, '2019-03-10 00:00:00', '2019-03-10 13:29:00', NULL, 'ab0c6b16e41f44b0', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (36, 716, 183, 11, 33, '2019-03-12 00:00:00', '2019-03-12 18:05:00', NULL, 'aa3130d9ed20b81a', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (39, 140, 83, 3, 105, '2019-03-19 00:00:00', '2019-03-14 07:49:00', NULL, 'ab0c6b16e41f44b0', 'del', 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (40, 689, 185, 5, 15, '2019-03-18 00:00:00', '2019-03-14 20:42:00', NULL, 'f962f6723f86cb26', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (41, 689, 185, 5, 15, '2019-03-19 00:00:00', '2019-03-14 20:42:00', NULL, 'f962f6723f86cb26', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (136, 53, 100, 2, 20, '2020-06-22 00:00:00', '2020-06-17 13:59:36.958217', '53', '447f3df9c7240c3c', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (137, 53, 100, 2, 20, '2020-06-23 00:00:00', '2020-06-17 13:59:37.350225', '53', '447f3df9c7240c3c', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (138, 53, 100, 2, 20, '2020-06-24 00:00:00', '2020-06-17 13:59:37.717256', '53', '447f3df9c7240c3c', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (139, 53, 100, 2, 20, '2020-06-25 00:00:00', '2020-06-17 13:59:38.083992', '53', '447f3df9c7240c3c', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (140, 53, 100, 2, 20, '2020-06-26 00:00:00', '2020-06-17 13:59:38.450665', '53', '447f3df9c7240c3c', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (141, 53, 100, 2, 20, '2020-06-27 00:00:00', '2020-06-17 13:59:38.818355', '53', '447f3df9c7240c3c', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (133, 16, 3, 1, 20, '2020-06-06 00:00:00', '2020-05-29 15:04:50.517689', '16', '70566f4ac30bd154', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (134, 16, 133, 1, 16, '2020-06-06 00:00:00', '2020-05-29 15:04:50.517689', '16', '70566f4ac30bd154', 'del', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (135, 16, 176, 1, 3, '2020-06-06 00:00:00', '2020-05-29 15:04:50.517689', '16', '70566f4ac30bd154', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (122, 16, 133, 1, 16, '2020-06-02 00:00:00', '2020-05-29 15:04:48.97752', '16', '70566f4ac30bd154', 'del', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (123, 16, 176, 1, 3, '2020-06-02 00:00:00', '2020-05-29 15:04:48.97752', '16', '70566f4ac30bd154', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (124, 16, 3, 1, 20, '2020-06-03 00:00:00', '2020-05-29 15:04:49.362734', '16', '70566f4ac30bd154', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (147, 17, 3, 1, 20, '2020-06-26 00:00:00', '2020-06-17 17:26:22.113036', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (148, 17, 3, 1, 20, '2020-06-27 00:00:00', '2020-06-17 17:26:22.399266', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (143, 17, 3, 1, 20, '2020-06-22 00:00:00', '2020-06-17 17:25:45.198437', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (144, 17, 3, 1, 20, '2020-06-23 00:00:00', '2020-06-17 17:26:21.257273', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (145, 17, 3, 1, 20, '2020-06-24 00:00:00', '2020-06-17 17:26:21.542077', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (146, 17, 3, 1, 20, '2020-06-25 00:00:00', '2020-06-17 17:26:21.828002', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (151, 17, 3, 1, 20, '2020-06-24 00:00:00', '2020-06-17 21:10:24.979435', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (152, 17, 3, 1, 20, '2020-06-25 00:00:00', '2020-06-17 21:10:25.272972', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (153, 17, 3, 1, 20, '2020-06-26 00:00:00', '2020-06-17 21:10:25.563931', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (154, 17, 3, 1, 20, '2020-06-27 00:00:00', '2020-06-17 21:10:25.999187', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (156, 17, 3, 1, 20, '2020-06-24 00:00:00', '2020-06-17 21:21:53.357479', '17', 'b1aef469408b5b2e', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (157, 17, 3, 1, 20, '2020-06-25 00:00:00', '2020-06-17 21:21:53.842356', '17', 'b1aef469408b5b2e', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (159, 17, 3, 1, 20, '2020-06-27 00:00:00', '2020-06-17 21:21:54.573275', '17', 'b1aef469408b5b2e', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (160, 53, 100, 2, 20, '2020-06-23 00:00:00', '2020-06-18 07:52:29.148882', '53', 'cb99776f4779ac6d', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (161, 53, 100, 2, 20, '2020-06-24 00:00:00', '2020-06-18 07:52:29.446706', '53', 'cb99776f4779ac6d', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (155, 53, 100, 2, 20, '2020-06-22 00:00:00', '2020-06-17 18:16:42.042458', '53', 'cb99776f4779ac6d', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (150, 17, 3, 1, 20, '2020-06-23 00:00:00', '2020-06-23 19:29:00', '17', 'b1aef469408b5b2e', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (149, 17, 3, 1, 20, '2020-06-19 00:00:00', '2020-06-19 14:42:00', '17', 'b1aef469408b5b2e', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (98, 689, 8, 5, 40, '2019-08-19 00:00:00', '2019-08-12 16:27:00', '689', '3924fd504ff1ea2d', 'del', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (158, 17, 3, 1, 20, '2020-06-26 00:00:00', '2020-06-26 20:33:00', '17', 'b1aef469408b5b2e', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (95, 61, 182, 4, 16, '2019-04-03 00:00:00', '2019-03-29 12:35:00', '61', 'a696945e7053af62', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (96, 61, 182, 2, 8, '2019-04-02 00:00:00', '2019-03-29 12:35:00', '61', 'a696945e7053af62', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (97, 61, 182, 2, 8, '2019-04-01 00:00:00', '2019-03-29 12:35:00', '61', 'a696945e7053af62', 'del', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (162, 53, 100, 2, 20, '2020-06-25 00:00:00', '2020-06-18 07:52:29.737318', '53', 'cb99776f4779ac6d', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (163, 53, 100, 2, 20, '2020-06-26 00:00:00', '2020-06-18 07:52:30.025434', '53', 'cb99776f4779ac6d', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (164, 53, 100, 2, 20, '2020-06-27 00:00:00', '2020-06-18 07:52:30.31494', '53', 'cb99776f4779ac6d', 'del', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (165, 16, 3, 1, 20, '2020-06-22 00:00:00', '2020-06-19 09:54:24.004018', '16', '70566f4ac30bd154', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (166, 16, 133, 1, 16, '2020-06-22 00:00:00', '2020-06-19 09:54:24.004018', '16', '70566f4ac30bd154', NULL, 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (167, 16, 176, 1, 3, '2020-06-22 00:00:00', '2020-06-19 09:54:24.004018', '16', '70566f4ac30bd154', NULL, 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (168, 16, 3, 1, 20, '2020-06-23 00:00:00', '2020-06-19 09:54:24.344966', '16', '70566f4ac30bd154', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (169, 16, 133, 1, 16, '2020-06-23 00:00:00', '2020-06-19 09:54:24.344966', '16', '70566f4ac30bd154', NULL, 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (170, 16, 176, 1, 3, '2020-06-23 00:00:00', '2020-06-19 09:54:24.344966', '16', '70566f4ac30bd154', NULL, 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (171, 16, 3, 1, 20, '2020-06-24 00:00:00', '2020-06-19 09:54:24.635355', '16', '70566f4ac30bd154', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (172, 16, 133, 1, 16, '2020-06-24 00:00:00', '2020-06-19 09:54:24.635355', '16', '70566f4ac30bd154', NULL, 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (173, 16, 176, 1, 3, '2020-06-24 00:00:00', '2020-06-19 09:54:24.635355', '16', '70566f4ac30bd154', NULL, 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (80, 427, 183, 5, 15, '2019-03-27 00:00:00', '2019-03-18 12:08:00', '427', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (81, 427, 183, 5, 15, '2019-03-28 00:00:00', '2019-03-18 12:08:00', '427', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (82, 427, 183, 5, 15, '2019-03-29 00:00:00', '2019-03-18 12:08:00', '427', 'ab0c6b16e41f44b0', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (174, 16, 3, 1, 20, '2020-06-25 00:00:00', '2020-06-19 09:54:24.924535', '16', '70566f4ac30bd154', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (175, 16, 133, 1, 16, '2020-06-25 00:00:00', '2020-06-19 09:54:24.924535', '16', '70566f4ac30bd154', 'del', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (176, 16, 176, 1, 3, '2020-06-25 00:00:00', '2020-06-19 09:54:24.924535', '16', '70566f4ac30bd154', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (177, 16, 3, 1, 20, '2020-06-26 00:00:00', '2020-06-19 09:54:25.212256', '16', '70566f4ac30bd154', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (178, 16, 133, 1, 16, '2020-06-26 00:00:00', '2020-06-19 09:54:25.212256', '16', '70566f4ac30bd154', 'del', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (179, 16, 176, 1, 3, '2020-06-26 00:00:00', '2020-06-19 09:54:25.212256', '16', '70566f4ac30bd154', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (180, 16, 3, 1, 20, '2020-06-27 00:00:00', '2020-06-19 09:54:25.501685', '16', '70566f4ac30bd154', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (181, 16, 133, 1, 16, '2020-06-27 00:00:00', '2020-06-19 09:54:25.501685', '16', '70566f4ac30bd154', 'del', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (182, 16, 176, 1, 3, '2020-06-27 00:00:00', '2020-06-19 09:54:25.501685', '16', '70566f4ac30bd154', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (183, 17, 3, 1, 20, '2020-06-22 00:00:00', '2020-06-19 17:05:06.663687', '17', 'b1aef469408b5b2e', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (195, 464, 3, 1, 23, '2020-06-24 00:00:00', '2020-06-20 07:39:21.491456', '464', '', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (196, 464, 132, 1, 9, '2020-06-24 00:00:00', '2020-06-20 07:39:21.491456', '464', '', NULL, 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (197, 464, 3, 1, 23, '2020-06-25 00:00:00', '2020-06-20 07:39:21.82148', '464', '', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (198, 464, 132, 1, 9, '2020-06-25 00:00:00', '2020-06-20 07:39:21.82148', '464', '', NULL, 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (199, 464, 3, 1, 23, '2020-06-26 00:00:00', '2020-06-20 07:39:22.154637', '464', '', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (200, 464, 132, 1, 9, '2020-06-26 00:00:00', '2020-06-20 07:39:22.154637', '464', '', NULL, 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (201, 464, 3, 1, 23, '2020-06-27 00:00:00', '2020-06-20 07:39:22.487554', '464', '', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (190, 20, 3, 1, 20, '2020-06-27 00:00:00', '2020-06-19 14:18:18.482538', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (189, 20, 3, 1, 20, '2020-06-26 00:00:00', '2020-06-19 14:18:18.177205', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (186, 20, 3, 1, 20, '2020-06-23 00:00:00', '2020-06-19 14:18:17.281351', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (207, 20, 3, 1, 20, '2020-07-03 00:00:00', '2020-06-21 14:27:07.325711', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (208, 20, 3, 1, 20, '2020-07-04 00:00:00', '2020-06-21 14:27:07.688317', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (204, 20, 3, 1, 20, '2020-06-30 00:00:00', '2020-06-21 14:27:06.237607', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (205, 20, 3, 1, 20, '2020-07-01 00:00:00', '2020-06-21 14:27:06.5997', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (206, 20, 3, 1, 20, '2020-07-02 00:00:00', '2020-06-21 14:27:06.963113', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (188, 20, 3, 1, 20, '2020-06-25 00:00:00', '2020-06-19 14:18:17.879542', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (203, 20, 3, 1, 20, '2020-06-29 00:00:00', '2020-06-21 14:27:05.861072', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (213, 20, 3, 1, 20, '2020-07-03 00:00:00', '2020-06-21 15:29:14.269884', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (214, 20, 3, 1, 20, '2020-07-04 00:00:00', '2020-06-21 15:29:14.550109', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (212, 20, 3, 1, 20, '2020-07-02 00:00:00', '2020-06-21 15:29:13.987526', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (210, 20, 3, 1, 20, '2020-06-30 00:00:00', '2020-06-21 15:29:13.428067', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (211, 20, 3, 1, 20, '2020-07-01 00:00:00', '2020-06-21 15:29:13.70775', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (187, 20, 3, 1, 20, '2020-06-24 00:00:00', '2020-06-19 14:18:17.580959', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (209, 20, 3, 1, 20, '2020-06-29 00:00:00', '2020-06-21 15:29:13.121019', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (218, 20, 3, 1, 20, '2020-07-02 00:00:00', '2020-06-21 15:45:50.593298', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (219, 20, 3, 1, 20, '2020-07-03 00:00:00', '2020-06-21 15:45:50.900485', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (220, 20, 3, 1, 20, '2020-07-04 00:00:00', '2020-06-21 15:45:51.207044', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (215, 20, 3, 1, 20, '2020-06-29 00:00:00', '2020-06-21 15:45:49.667487', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (216, 20, 3, 1, 20, '2020-06-30 00:00:00', '2020-06-21 15:45:49.979779', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (217, 20, 3, 1, 20, '2020-07-01 00:00:00', '2020-06-21 15:45:50.287069', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (226, 20, 3, 1, 20, '2020-07-04 00:00:00', '2020-06-21 17:19:13.862042', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (222, 20, 3, 1, 20, '2020-06-30 00:00:00', '2020-06-21 17:19:12.621482', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (224, 20, 3, 1, 20, '2020-07-02 00:00:00', '2020-06-21 17:19:13.21317', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (221, 20, 3, 1, 20, '2020-06-29 00:00:00', '2020-06-21 17:18:46.217154', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (225, 20, 3, 1, 20, '2020-07-03 00:00:00', '2020-06-21 17:19:13.508697', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (223, 20, 3, 1, 20, '2020-07-01 00:00:00', '2020-06-21 17:19:12.917617', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (228, 20, 3, 1, 20, '2020-06-30 00:00:00', '2020-06-21 17:53:10.009561', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (229, 20, 3, 1, 20, '2020-07-02 00:00:00', '2020-06-21 17:53:10.614888', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (230, 20, 3, 1, 20, '2020-07-03 00:00:00', '2020-06-21 17:53:10.916335', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (231, 20, 3, 1, 20, '2020-07-04 00:00:00', '2020-06-21 17:53:11.216535', '20', 'cb99776f4779ac6d', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (227, 20, 188, 1, 21, '2020-06-29 00:00:00', '2020-06-29 08:13:00', '20', 'cb99776f4779ac6d', 'done', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (232, 17, 3, 1, 20, '2020-06-29 00:00:00', '2020-06-23 19:29:52.946163', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (233, 17, 3, 1, 20, '2020-06-30 00:00:00', '2020-06-23 19:29:53.432929', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (234, 17, 3, 1, 20, '2020-07-01 00:00:00', '2020-06-23 19:29:53.803384', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (235, 17, 3, 1, 20, '2020-07-02 00:00:00', '2020-06-23 19:29:54.173384', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (236, 17, 3, 1, 20, '2020-07-03 00:00:00', '2020-06-23 19:29:54.663017', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (237, 17, 3, 1, 20, '2020-07-04 00:00:00', '2020-06-23 19:29:55.034574', '17', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (238, 689, 8, 5, 40, '2020-06-29 00:00:00', '2020-06-26 07:44:39.39769', '689', '70566f4ac30bd154', NULL, 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (239, 689, 8, 5, 40, '2020-06-30 00:00:00', '2020-06-26 07:44:39.748583', '689', '70566f4ac30bd154', NULL, 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (240, 689, 8, 5, 40, '2020-07-01 00:00:00', '2020-06-26 07:44:40.070926', '689', '70566f4ac30bd154', NULL, 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (241, 689, 8, 5, 40, '2020-07-02 00:00:00', '2020-06-26 07:44:40.393942', '689', '70566f4ac30bd154', NULL, 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (242, 689, 8, 5, 40, '2020-07-03 00:00:00', '2020-06-26 07:44:40.719413', '689', '70566f4ac30bd154', NULL, 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (243, 689, 8, 5, 40, '2020-07-04 00:00:00', '2020-06-26 07:44:41.042324', '689', '70566f4ac30bd154', NULL, 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (247, 500, 189, 1, 20, '2020-06-30 00:00:00', '2020-06-26 09:57:42.499406', '500', 'b1aef469408b5b2e', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (248, 500, 190, 1, 29, '2020-06-30 00:00:00', '2020-06-26 09:57:42.499406', '500', 'b1aef469408b5b2e', NULL, 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (249, 500, 188, 1, 21, '2020-06-30 00:00:00', '2020-06-26 09:57:42.499406', '500', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (250, 500, 189, 1, 20, '2020-07-01 00:00:00', '2020-06-26 09:57:42.799142', '500', 'b1aef469408b5b2e', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (251, 500, 190, 1, 29, '2020-07-01 00:00:00', '2020-06-26 09:57:42.799142', '500', 'b1aef469408b5b2e', NULL, 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (252, 500, 188, 1, 21, '2020-07-01 00:00:00', '2020-06-26 09:57:42.799142', '500', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (254, 500, 190, 1, 29, '2020-07-02 00:00:00', '2020-06-26 09:57:43.106674', '500', 'b1aef469408b5b2e', NULL, 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (255, 500, 188, 1, 21, '2020-07-02 00:00:00', '2020-06-26 09:57:43.106674', '500', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (288, 528, 83, 10, NULL, '2020-07-04 00:00:00', '2020-06-27 08:45:44.678123', '140', '7964256e0a63db1f', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (289, 528, 82, 1, NULL, '2020-07-04 00:00:00', '2020-06-27 08:45:44.678123', '140', '7964256e0a63db1f', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (245, 500, 190, 1, 29, '2020-06-26 00:00:00', '2020-06-26 09:59:00', '500', 'cb99776f4779ac6d', 'done', 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (246, 500, 188, 1, 21, '2020-06-26 00:00:00', '2020-06-26 09:59:00', '500', 'cb99776f4779ac6d', 'done', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (262, 500, 3, 1, 20, '2020-06-26 00:00:00', '2020-06-26 09:59:00', '500', 'cb99776f4779ac6d', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (191, 464, 3, 1, 23, '2020-06-22 00:00:00', '2020-06-20 07:39:20.81742', '464', '70566f4ac30bd154', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (266, 528, 83, 10, 350, '2020-06-30 00:00:00', '2020-06-27 08:24:04.633714', '528', '3924fd504ff1ea2d', NULL, 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (267, 528, 82, 1, 30, '2020-06-30 00:00:00', '2020-06-27 08:24:04.633714', '528', '3924fd504ff1ea2d', NULL, 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (268, 528, 9, 5, 125, '2020-06-30 00:00:00', '2020-06-27 08:24:04.633714', '528', '3924fd504ff1ea2d', NULL, 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (185, 20, 3, 1, 25, '2020-06-21 00:00:00', '2020-06-21 18:03:00', '20', 'cb99776f4779ac6d', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (269, 528, 83, 10, 350, '2020-07-01 00:00:00', '2020-06-27 08:24:04.919569', '528', '3924fd504ff1ea2d', NULL, 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (270, 528, 82, 1, 30, '2020-07-01 00:00:00', '2020-06-27 08:24:04.919569', '528', '3924fd504ff1ea2d', NULL, 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (271, 528, 9, 5, 125, '2020-07-01 00:00:00', '2020-06-27 08:24:04.919569', '528', '3924fd504ff1ea2d', NULL, 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (272, 528, 83, 10, 350, '2020-07-02 00:00:00', '2020-06-27 08:24:05.204944', '528', '3924fd504ff1ea2d', NULL, 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (273, 528, 82, 1, 30, '2020-07-02 00:00:00', '2020-06-27 08:24:05.204944', '528', '3924fd504ff1ea2d', NULL, 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (274, 528, 9, 5, 125, '2020-07-02 00:00:00', '2020-06-27 08:24:05.204944', '528', '3924fd504ff1ea2d', NULL, 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (275, 528, 83, 10, 350, '2020-07-03 00:00:00', '2020-06-27 08:24:05.488735', '528', '3924fd504ff1ea2d', NULL, 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (276, 528, 82, 1, 30, '2020-07-03 00:00:00', '2020-06-27 08:24:05.488735', '528', '3924fd504ff1ea2d', NULL, 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (277, 528, 9, 5, 125, '2020-07-03 00:00:00', '2020-06-27 08:24:05.488735', '528', '3924fd504ff1ea2d', NULL, 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (281, 63, 3, 1, 20, '2020-06-27 00:00:00', '2020-06-27 08:36:00', '63', 'cb99776f4779ac6d', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (282, 63, 3, 1, NULL, '2020-06-29 00:00:00', '2020-06-27 08:41:50.434301', '63', '', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (283, 63, 3, 1, NULL, '2020-06-30 00:00:00', '2020-06-27 08:42:00.255088', '63', '', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (284, 63, 3, 1, NULL, '2020-07-01 00:00:00', '2020-06-27 08:42:00.537586', '63', '', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (285, 63, 3, 1, NULL, '2020-07-02 00:00:00', '2020-06-27 08:42:00.819206', '63', '', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (286, 63, 3, 1, NULL, '2020-07-03 00:00:00', '2020-06-27 08:42:01.104098', '63', '', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (287, 63, 3, 1, NULL, '2020-07-04 00:00:00', '2020-06-27 08:42:01.386215', '63', '', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (278, 528, 83, 10, 350, '2020-07-04 00:00:00', '2020-06-27 08:24:05.77949', '528', '3924fd504ff1ea2d', 'del', 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (279, 528, 82, 1, 30, '2020-07-04 00:00:00', '2020-06-27 08:24:05.77949', '528', '3924fd504ff1ea2d', 'del', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (280, 528, 9, 5, 125, '2020-07-04 00:00:00', '2020-06-27 08:24:05.77949', '528', '3924fd504ff1ea2d', 'del', 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (290, 528, 9, 5, NULL, '2020-07-04 00:00:00', '2020-06-27 08:45:44.678123', '140', '7964256e0a63db1f', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (253, 500, 189, 1, 20, '2020-07-02 00:00:00', '2020-06-26 09:57:43.106674', '500', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (292, 500, 189, 1, NULL, '2020-07-04 00:00:00', '2020-06-27 09:08:34.323196', '140', '7964256e0a63db1f', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (291, 20, 188, 2, 42, '2020-06-30 00:00:00', '2020-06-27 09:00:00', '140', 'cb99776f4779ac6d', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (259, 500, 189, 1, 20, '2020-07-04 00:00:00', '2020-06-26 09:57:43.697055', '500', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (260, 500, 190, 1, 29, '2020-07-04 00:00:00', '2020-06-26 09:57:43.697055', '500', 'b1aef469408b5b2e', 'del', 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (261, 500, 188, 1, 21, '2020-07-04 00:00:00', '2020-06-26 09:57:43.697055', '500', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (293, 500, 190, 1, NULL, '2020-07-04 00:00:00', '2020-06-27 09:08:34.323196', '140', '7964256e0a63db1f', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (294, 500, 188, 1, NULL, '2020-07-04 00:00:00', '2020-06-27 09:08:34.323196', '140', '7964256e0a63db1f', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (256, 500, 189, 1, 20, '2020-07-03 00:00:00', '2020-06-26 09:57:43.401479', '500', 'b1aef469408b5b2e', 'del', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (257, 500, 190, 1, 29, '2020-07-03 00:00:00', '2020-06-26 09:57:43.401479', '500', 'b1aef469408b5b2e', 'del', 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (295, 500, 188, 1, NULL, '2020-07-04 00:00:00', '2020-06-27 09:21:52.800431', '140', '7964256e0a63db1f', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (296, 500, 188, 1, NULL, '2020-07-04 00:00:00', '2020-06-27 09:22:37.527677', '140', '7964256e0a63db1f', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (297, 500, 188, 1, 23, '2020-07-04 00:00:00', '2020-06-27 09:25:00.009614', '140', '7964256e0a63db1f', 'del', NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (298, 500, 188, 2, 46, '2020-07-04 00:00:00', '2020-06-27 09:32:00', '140', 'cb99776f4779ac6d', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (258, 500, 188, 2, 46, '2020-07-03 00:00:00', '2020-06-27 09:32:00', '140', 'cb99776f4779ac6d', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (244, 500, 189, 1, 20, '2020-06-29 00:00:00', '2020-06-29 08:13:00', '500', 'cb99776f4779ac6d', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (301, 18, 181, 10, NULL, '2020-07-07 00:00:00', '2020-06-29 08:16:11.711075', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (302, 18, 180, 10, NULL, '2020-07-07 00:00:00', '2020-06-29 08:16:11.711075', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (303, 18, 181, 10, NULL, '2020-07-08 00:00:00', '2020-06-29 08:16:12.006825', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (263, 528, 83, 10, 350, '2020-06-29 00:00:00', '2020-06-29 08:15:00', '528', 'cb99776f4779ac6d', 'done', 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (264, 528, 82, 1, 30, '2020-06-29 00:00:00', '2020-06-29 08:15:00', '528', 'cb99776f4779ac6d', 'done', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (265, 528, 9, 5, 125, '2020-06-29 00:00:00', '2020-06-29 08:15:00', '528', 'cb99776f4779ac6d', 'done', 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (304, 18, 180, 10, NULL, '2020-07-08 00:00:00', '2020-06-29 08:16:12.006825', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (305, 18, 181, 10, NULL, '2020-07-09 00:00:00', '2020-06-29 08:16:12.301977', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (306, 18, 180, 10, NULL, '2020-07-09 00:00:00', '2020-06-29 08:16:12.301977', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (307, 18, 181, 10, NULL, '2020-07-10 00:00:00', '2020-06-29 08:16:12.596558', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (308, 18, 180, 10, NULL, '2020-07-10 00:00:00', '2020-06-29 08:16:12.596558', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (309, 18, 181, 10, NULL, '2020-07-11 00:00:00', '2020-06-29 08:16:12.891953', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (310, 18, 180, 10, NULL, '2020-07-11 00:00:00', '2020-06-29 08:16:12.891953', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (311, 17, 3, 1, 21, '2020-08-31 00:00:00', '2020-08-27 17:47:31.030448', '17', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (312, 17, 3, 1, 21, '2020-09-01 00:00:00', '2020-08-27 17:47:31.233595', '17', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (313, 17, 3, 1, 21, '2020-09-02 00:00:00', '2020-08-27 17:47:31.411219', '17', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (314, 17, 3, 1, 21, '2020-09-03 00:00:00', '2020-08-27 17:47:31.588829', '17', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (318, 36, 189, 1, 20, '2020-10-05 00:00:00', '2020-09-29 15:20:10.838945', '36', 'bc3421a02ec01187', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (319, 36, 189, 1, 20, '2020-10-06 00:00:00', '2020-09-29 15:20:11.070305', '36', 'bc3421a02ec01187', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (320, 36, 189, 1, 20, '2020-10-07 00:00:00', '2020-09-29 15:20:11.289277', '36', 'bc3421a02ec01187', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (321, 36, 189, 1, 20, '2020-10-08 00:00:00', '2020-09-29 15:20:11.508488', '36', 'bc3421a02ec01187', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (322, 36, 189, 1, 20, '2020-10-09 00:00:00', '2020-09-29 15:20:11.727127', '36', 'bc3421a02ec01187', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (323, 36, 189, 1, 20, '2020-10-10 00:00:00', '2020-09-29 15:20:11.945019', '36', 'bc3421a02ec01187', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (317, 36, 189, 1, 21, '2020-09-29 00:00:00', '2020-09-29 15:20:00', '36', 'bc3421a02ec01187', 'done', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (325, 140, 186, 1, 15, '2020-10-02 00:00:00', '2020-10-02 13:45:00', '140', 'b1aef469408b5b2e', NULL, 15);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (326, 140, 176, 3, 9, '2020-10-02 00:00:00', '2020-10-02 13:45:00', '140', 'b1aef469408b5b2e', NULL, 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (327, 140, 176, 3, 9, '2020-10-02 00:00:00', '2020-10-02 13:45:00', '140', 'b1aef469408b5b2e', 'del', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (329, 140, 186, 1, NULL, '2020-10-05 00:00:00', '2020-10-02 13:46:02.968747', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (330, 140, 176, 3, NULL, '2020-10-05 00:00:00', '2020-10-02 13:46:02.968747', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (331, 140, 189, 1, 20, '2020-10-06 00:00:00', '2020-10-02 13:46:10.358087', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (332, 140, 186, 1, NULL, '2020-10-06 00:00:00', '2020-10-02 13:46:10.358087', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (333, 140, 176, 3, NULL, '2020-10-06 00:00:00', '2020-10-02 13:46:10.358087', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (334, 140, 189, 1, 20, '2020-10-07 00:00:00', '2020-10-02 13:46:10.595048', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (335, 140, 186, 1, NULL, '2020-10-07 00:00:00', '2020-10-02 13:46:10.595048', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (336, 140, 176, 3, NULL, '2020-10-07 00:00:00', '2020-10-02 13:46:10.595048', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (337, 140, 189, 1, 20, '2020-10-08 00:00:00', '2020-10-02 13:46:10.831651', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (338, 140, 186, 1, NULL, '2020-10-08 00:00:00', '2020-10-02 13:46:10.831651', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (339, 140, 176, 3, NULL, '2020-10-08 00:00:00', '2020-10-02 13:46:10.831651', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (340, 140, 189, 1, 20, '2020-10-09 00:00:00', '2020-10-02 13:46:11.070714', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (341, 140, 186, 1, NULL, '2020-10-09 00:00:00', '2020-10-02 13:46:11.070714', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (343, 140, 189, 1, 20, '2020-10-10 00:00:00', '2020-10-02 13:46:11.306261', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (344, 140, 186, 1, NULL, '2020-10-10 00:00:00', '2020-10-02 13:46:11.306261', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (345, 140, 176, 3, NULL, '2020-10-10 00:00:00', '2020-10-02 13:46:11.306261', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (346, 4, 3, 1, 21, '2020-11-30 00:00:00', '2020-11-28 10:25:38.396471', '4', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (347, 4, 3, 1, 21, '2020-12-01 00:00:00', '2020-11-28 10:25:38.679516', '4', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (348, 4, 3, 1, 21, '2020-12-02 00:00:00', '2020-11-28 10:25:38.887146', '4', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (349, 4, 3, 1, 21, '2020-12-03 00:00:00', '2020-11-28 10:25:39.094559', '4', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (350, 4, 3, 1, 21, '2020-12-04 00:00:00', '2020-11-28 10:25:39.30427', '4', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (351, 4, 3, 1, 21, '2020-12-05 00:00:00', '2020-11-28 10:25:39.511777', '4', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (352, 4, 3, 1, 21, '2020-11-30 00:00:00', '2020-11-28 11:47:44.755062', '4', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (353, 4, 3, 1, 21, '2020-12-01 00:00:00', '2020-11-28 12:50:11.811354', '4', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (354, 4, 3, 1, 21, '2020-12-02 00:00:00', '2020-11-28 12:50:12.070079', '4', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (355, 4, 3, 1, 21, '2020-12-03 00:00:00', '2020-11-28 12:50:12.316107', '4', 'b1aef469408b5b2e', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (357, 4, 3, 1, 21, '2020-12-05 00:00:00', '2020-11-28 12:50:12.811909', '4', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (356, 4, 189, 1, 21, '2020-12-04 00:00:00', '2020-11-28 13:27:00', '4', '46860b782c3139e3', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (359, 35, 189, 1, 21, '2020-11-28 00:00:00', '2020-11-28 18:26:00', '35', '10505312be2c4abb', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (360, 35, 189, 1, 20, '2020-11-30 00:00:00', '2020-11-28 18:27:37.652693', '35', '3a303e4a11fc4ba3', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (361, 35, 189, 1, 20, '2020-12-01 00:00:00', '2020-11-28 18:27:37.942187', '35', '3a303e4a11fc4ba3', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (362, 35, 189, 1, 20, '2020-12-02 00:00:00', '2020-11-28 18:27:38.189669', '35', '3a303e4a11fc4ba3', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (363, 35, 189, 1, 20, '2020-12-03 00:00:00', '2020-11-28 18:27:38.435543', '35', '3a303e4a11fc4ba3', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (364, 35, 189, 1, 20, '2020-12-04 00:00:00', '2020-11-28 18:27:38.679099', '35', '3a303e4a11fc4ba3', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (365, 35, 189, 1, 20, '2020-12-05 00:00:00', '2020-11-28 18:27:38.925352', '35', '3a303e4a11fc4ba3', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (342, 140, 176, 3, 9, '2020-12-07 00:00:00', '2020-11-29 10:58:00', '140', '10505312be2c4abb', NULL, 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (328, 140, 189, 1, 21, '2020-12-07 00:00:00', '2020-11-29 03:07:00', '140', '89c63153da33eee5', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (324, 140, 189, 10, 210, '2020-12-07 00:00:00', '2020-11-29 11:53:00', '140', '10505312be2c4abb', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (366, 35, 189, 1, 20, '2020-12-07 00:00:00', '2020-11-29 05:39:21.447292', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (367, 140, 189, 10, 200, '2020-12-08 00:00:00', '2020-11-29 05:55:06.222799', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (368, 140, 189, 1, 20, '2020-12-08 00:00:00', '2020-11-29 05:55:06.222799', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (369, 140, 176, 3, NULL, '2020-12-08 00:00:00', '2020-11-29 05:55:06.222799', '140', '7964256e0a63db1f', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (370, 140, 189, 102, 2142, '2020-12-08 00:00:00', '2020-11-29 14:08:00', '140', '10505312be2c4abb', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (371, 36, 189, 1, 20, '2020-12-07 00:00:00', '2020-11-29 06:17:04.721788', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (372, 36, 189, 1, 20, '2020-12-08 00:00:00', '2020-11-29 06:17:04.947145', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (373, 36, 189, 1, 20, '2020-12-09 00:00:00', '2020-11-29 06:17:05.117758', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (374, 36, 189, 1, 20, '2020-12-10 00:00:00', '2020-11-29 06:17:05.288707', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (375, 36, 189, 1, 20, '2020-12-11 00:00:00', '2020-11-29 06:17:05.480938', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (376, 36, 189, 1, 20, '2020-12-12 00:00:00', '2020-11-29 06:17:05.651513', '140', '7964256e0a63db1f', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (315, 17, 3, 1, 21, '2020-09-04 00:00:00', '2020-08-27 17:47:31.766736', '17', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (316, 17, 3, 1, 21, '2020-09-05 00:00:00', '2020-08-27 17:47:31.950717', '17', 'b1aef469408b5b2e', 'del', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (377, 18, 181, 10, NULL, '2020-12-21 00:00:00', '2020-12-13 20:15:09.942933', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (378, 18, 180, 10, NULL, '2020-12-21 00:00:00', '2020-12-13 20:15:09.942933', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (379, 18, 181, 10, NULL, '2020-12-22 00:00:00', '2020-12-13 20:15:10.197458', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (380, 18, 180, 10, NULL, '2020-12-22 00:00:00', '2020-12-13 20:15:10.197458', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (381, 18, 181, 10, NULL, '2020-12-23 00:00:00', '2020-12-13 20:15:10.434093', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (382, 18, 180, 10, NULL, '2020-12-23 00:00:00', '2020-12-13 20:15:10.434093', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (383, 18, 181, 10, NULL, '2020-12-24 00:00:00', '2020-12-13 20:15:10.665836', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (384, 18, 180, 10, NULL, '2020-12-24 00:00:00', '2020-12-13 20:15:10.665836', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (385, 18, 181, 10, NULL, '2020-12-25 00:00:00', '2020-12-13 20:15:10.897194', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (386, 18, 180, 10, NULL, '2020-12-25 00:00:00', '2020-12-13 20:15:10.897194', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (387, 18, 181, 10, NULL, '2020-12-26 00:00:00', '2020-12-13 20:15:11.127087', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (202, 464, 132, 34, 9, '2020-06-27 00:00:00', '2020-06-20 07:39:22.487554', '464', '', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (388, 18, 180, 10, 20, '2020-12-26 00:00:00', '2020-12-13 20:15:11.127087', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (389, 689, 185, 5, 15, '2019-03-20 00:00:00', '2019-03-20 19:08:00', '689', 'a696945e7053af62', 'done', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (390, 464, 3, 5, 23, '2019-03-25 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (391, 464, 132, 1, 9, '2019-03-25 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (392, 464, 132, 1, 9, '2019-03-26 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (393, 464, 132, 1, 9, '2019-03-27 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (394, 464, 132, 1, 9, '2019-03-28 00:00:00', '2019-03-28 20:57:00', '464', 'a696945e7053af62', 'done', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (395, 464, 132, 1, 9, '2019-03-29 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (396, 53, 181, 5, 20, '2019-03-27 00:00:00', '2019-03-17 11:07:00', '53', 'a696945e7053af62', '', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (397, 53, 181, 5, 20, '2019-03-28 00:00:00', '2019-03-28 20:56:00', '53', 'a696945e7053af62', 'done', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (398, 53, 181, 5, 20, '2019-03-26 00:00:00', '2019-03-17 11:07:00', '53', 'a696945e7053af62', '', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (399, 689, 8, 5, 40, '2019-08-20 00:00:00', '2019-08-12 16:27:00', '689', '3924fd504ff1ea2d', '', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (400, 689, 8, 5, 40, '2019-08-21 00:00:00', '2019-08-12 16:27:00', '689', '3924fd504ff1ea2d', '', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (401, 61, 182, 2, 8, '2019-04-02 00:00:00', '2019-08-13 18:05:00', '140', '3924fd504ff1ea2d', '', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (402, 61, 176, 1, 3, '2019-08-20 00:00:00', '2019-08-13 18:06:00', '140', '3924fd504ff1ea2d', '', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (403, 528, 97, 10, 150, '2020-04-07 00:00:00', '2020-03-30 06:20:00', '528', '70566f4ac30bd154', '', 15);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (404, 528, 97, 10, 150, '2020-04-06 00:00:00', '2020-03-30 06:20:00', '528', '70566f4ac30bd154', '', 15);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (405, 4, 3, 1, 20, '2020-04-06 00:00:00', '2020-04-03 05:43:00', '4', '70566f4ac30bd154', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (406, 17, 3, 1, 20, '2020-05-04 00:00:00', '2020-04-27 09:43:00', '17', 'b1aef469408b5b2e', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (407, 18, 181, 10, 40, '2020-05-04 00:00:00', '2020-04-27 06:47:00', '18', '6b7784294592c43c', '', 4);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (408, 18, 180, 10, 50, '2020-05-04 00:00:00', '2020-04-27 06:48:00', '18', '6b7784294592c43c', '', 5);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (409, 18, 180, 10, 50, '2020-05-06 00:00:00', '2020-04-27 06:48:00', '18', '6b7784294592c43c', '', 5);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (410, 16, 3, 1, 20, '2020-05-29 00:00:00', '2020-05-29 15:05:00', '16', '70566f4ac30bd154', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (411, 16, 133, 1, 16, '2020-05-29 00:00:00', '2020-05-29 15:05:00', '16', '70566f4ac30bd154', 'done', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (412, 16, 176, 1, 3, '2020-05-29 00:00:00', '2020-05-29 15:05:00', '16', '70566f4ac30bd154', 'done', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (413, 16, 3, 1, 20, '2020-06-01 00:00:00', '2020-06-01 10:40:00', '16', 'b1aef469408b5b2e', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (414, 16, 133, 1, 16, '2020-06-01 00:00:00', '2020-06-01 10:40:00', '16', 'b1aef469408b5b2e', 'done', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (415, 16, 176, 1, 3, '2020-05-31 00:00:00', '2020-05-31 08:12:00', '16', '70566f4ac30bd154', 'done', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (416, 16, 133, 1, 16, '2020-06-03 00:00:00', '2020-05-29 15:04:49.362734', '16', '70566f4ac30bd154', '', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (417, 16, 176, 1, 3, '2020-06-03 00:00:00', '2020-05-29 15:04:49.362734', '16', '70566f4ac30bd154', '', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (418, 16, 3, 1, 20, '2020-06-04 00:00:00', '2020-05-29 15:04:49.747148', '16', '70566f4ac30bd154', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (419, 16, 133, 1, 16, '2020-06-04 00:00:00', '2020-05-29 15:04:49.747148', '16', '70566f4ac30bd154', '', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (420, 16, 176, 1, 3, '2020-06-04 00:00:00', '2020-05-29 15:04:49.747148', '16', '70566f4ac30bd154', '', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (421, 16, 3, 1, 20, '2020-06-05 00:00:00', '2020-05-29 15:04:50.133063', '16', '70566f4ac30bd154', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (422, 16, 133, 1, 16, '2020-06-05 00:00:00', '2020-05-29 15:04:50.133063', '16', '70566f4ac30bd154', '', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (423, 16, 176, 1, 3, '2020-06-05 00:00:00', '2020-05-29 15:04:50.133063', '16', '70566f4ac30bd154', '', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (424, 53, 100, 2, 20, '2020-06-17 00:00:00', '2020-06-17 14:00:00', '53', 'cb99776f4779ac6d', 'done', 10);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (425, 17, 3, 1, 20, '2020-06-19 00:00:00', '2020-06-19 14:42:00', '17', 'b1aef469408b5b2e', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (426, 17, 3, 1, 20, '2020-06-23 00:00:00', '2020-06-23 19:29:00', '17', 'b1aef469408b5b2e', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (427, 17, 3, 1, 20, '2020-06-24 00:00:00', '2020-06-17 21:21:53.357479', '17', 'b1aef469408b5b2e', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (428, 17, 3, 1, 20, '2020-06-25 00:00:00', '2020-06-17 21:21:53.842356', '17', 'b1aef469408b5b2e', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (429, 17, 3, 1, 20, '2020-06-26 00:00:00', '2020-06-26 20:33:00', '17', 'b1aef469408b5b2e', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (430, 17, 3, 1, 20, '2020-06-27 00:00:00', '2020-06-17 21:21:54.573275', '17', 'b1aef469408b5b2e', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (431, 16, 3, 1, 20, '2020-06-22 00:00:00', '2020-06-19 09:54:24.004018', '16', '70566f4ac30bd154', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (432, 16, 133, 1, 16, '2020-06-22 00:00:00', '2020-06-19 09:54:24.004018', '16', '70566f4ac30bd154', '', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (433, 16, 176, 1, 3, '2020-06-22 00:00:00', '2020-06-19 09:54:24.004018', '16', '70566f4ac30bd154', '', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (434, 16, 3, 1, 20, '2020-06-23 00:00:00', '2020-06-19 09:54:24.344966', '16', '70566f4ac30bd154', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (435, 16, 133, 1, 16, '2020-06-23 00:00:00', '2020-06-19 09:54:24.344966', '16', '70566f4ac30bd154', '', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (436, 16, 176, 1, 3, '2020-06-23 00:00:00', '2020-06-19 09:54:24.344966', '16', '70566f4ac30bd154', '', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (437, 16, 3, 1, 20, '2020-06-24 00:00:00', '2020-06-19 09:54:24.635355', '16', '70566f4ac30bd154', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (438, 16, 133, 1, 16, '2020-06-24 00:00:00', '2020-06-19 09:54:24.635355', '16', '70566f4ac30bd154', '', 16);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (439, 16, 176, 1, 3, '2020-06-24 00:00:00', '2020-06-19 09:54:24.635355', '16', '70566f4ac30bd154', '', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (440, 17, 3, 1, 20, '2020-06-22 00:00:00', '2020-06-19 17:05:06.663687', '17', 'b1aef469408b5b2e', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (442, 20, 3, 1, 20, '2020-06-21 00:00:00', '2020-06-21 18:03:00', '20', 'cb99776f4779ac6d', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (443, 464, 3, 1, 23, '2020-06-22 00:00:00', '2020-06-20 07:39:20.81742', '464', '', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (444, 464, 132, 1, 9, '2020-06-22 00:00:00', '2020-06-20 07:39:20.81742', '464', '', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (445, 464, 3, 1, 23, '2020-06-23 00:00:00', '2020-06-20 07:39:21.161808', '464', '', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (446, 464, 132, 1, 9, '2020-06-23 00:00:00', '2020-06-20 07:39:21.161808', '464', '', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (447, 464, 3, 1, 23, '2020-06-24 00:00:00', '2020-06-20 07:39:21.491456', '464', '', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (448, 464, 132, 1, 9, '2020-06-24 00:00:00', '2020-06-20 07:39:21.491456', '464', '', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (449, 464, 3, 1, 23, '2020-06-25 00:00:00', '2020-06-20 07:39:21.82148', '464', '', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (450, 464, 132, 1, 9, '2020-06-25 00:00:00', '2020-06-20 07:39:21.82148', '464', '', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (451, 464, 3, 1, 23, '2020-06-26 00:00:00', '2020-06-20 07:39:22.154637', '464', '', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (452, 464, 132, 1, 9, '2020-06-26 00:00:00', '2020-06-20 07:39:22.154637', '464', '', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (453, 464, 3, 1, 23, '2020-06-27 00:00:00', '2020-06-20 07:39:22.487554', '464', '', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (454, 464, 132, 34, 9, '2020-06-27 00:00:00', '2020-06-20 07:39:22.487554', '464', '', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (456, 689, 8, 5, 40, '2020-06-29 00:00:00', '2020-06-26 07:44:39.39769', '689', '70566f4ac30bd154', '', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (457, 689, 8, 5, 40, '2020-06-30 00:00:00', '2020-06-26 07:44:39.748583', '689', '70566f4ac30bd154', '', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (458, 689, 8, 5, 40, '2020-07-01 00:00:00', '2020-06-26 07:44:40.070926', '689', '70566f4ac30bd154', '', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (459, 689, 8, 5, 40, '2020-07-02 00:00:00', '2020-06-26 07:44:40.393942', '689', '70566f4ac30bd154', '', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (460, 689, 8, 5, 40, '2020-07-03 00:00:00', '2020-06-26 07:44:40.719413', '689', '70566f4ac30bd154', '', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (461, 689, 8, 5, 40, '2020-07-04 00:00:00', '2020-06-26 07:44:41.042324', '689', '70566f4ac30bd154', '', 8);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (462, 500, 189, 1, 20, '2020-06-29 00:00:00', '2020-06-29 08:13:00', '500', 'cb99776f4779ac6d', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (463, 500, 190, 1, 29, '2020-06-26 00:00:00', '2020-06-26 09:59:00', '500', 'cb99776f4779ac6d', 'done', 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (464, 500, 188, 1, 21, '2020-06-26 00:00:00', '2020-06-26 09:59:00', '500', 'cb99776f4779ac6d', 'done', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (465, 500, 189, 1, 20, '2020-06-30 00:00:00', '2020-06-26 09:57:42.499406', '500', 'b1aef469408b5b2e', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (466, 500, 190, 1, 29, '2020-06-30 00:00:00', '2020-06-26 09:57:42.499406', '500', 'b1aef469408b5b2e', '', 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (467, 500, 188, 1, 21, '2020-06-30 00:00:00', '2020-06-26 09:57:42.499406', '500', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (468, 500, 189, 1, 20, '2020-07-01 00:00:00', '2020-06-26 09:57:42.799142', '500', 'b1aef469408b5b2e', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (469, 500, 190, 1, 29, '2020-07-01 00:00:00', '2020-06-26 09:57:42.799142', '500', 'b1aef469408b5b2e', '', 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (470, 500, 188, 1, 21, '2020-07-01 00:00:00', '2020-06-26 09:57:42.799142', '500', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (471, 500, 190, 1, 29, '2020-07-02 00:00:00', '2020-06-26 09:57:43.106674', '500', 'b1aef469408b5b2e', '', 29);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (472, 500, 188, 1, 21, '2020-07-02 00:00:00', '2020-06-26 09:57:43.106674', '500', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (473, 500, 188, 2, 46, '2020-07-03 00:00:00', '2020-06-27 09:32:00', '140', 'cb99776f4779ac6d', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (474, 500, 3, 1, 20, '2020-06-26 00:00:00', '2020-06-26 09:59:00', '500', 'cb99776f4779ac6d', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (475, 528, 83, 10, 350, '2020-06-29 00:00:00', '2020-06-29 08:15:00', '528', 'cb99776f4779ac6d', 'done', 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (476, 528, 82, 1, 30, '2020-06-29 00:00:00', '2020-06-29 08:15:00', '528', 'cb99776f4779ac6d', 'done', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (477, 528, 9, 5, 125, '2020-06-29 00:00:00', '2020-06-29 08:15:00', '528', 'cb99776f4779ac6d', 'done', 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (478, 528, 83, 10, 350, '2020-06-30 00:00:00', '2020-06-27 08:24:04.633714', '528', '3924fd504ff1ea2d', '', 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (479, 528, 82, 1, 30, '2020-06-30 00:00:00', '2020-06-27 08:24:04.633714', '528', '3924fd504ff1ea2d', '', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (480, 528, 9, 5, 125, '2020-06-30 00:00:00', '2020-06-27 08:24:04.633714', '528', '3924fd504ff1ea2d', '', 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (481, 528, 83, 10, 350, '2020-07-01 00:00:00', '2020-06-27 08:24:04.919569', '528', '3924fd504ff1ea2d', '', 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (482, 528, 82, 1, 30, '2020-07-01 00:00:00', '2020-06-27 08:24:04.919569', '528', '3924fd504ff1ea2d', '', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (483, 528, 9, 5, 125, '2020-07-01 00:00:00', '2020-06-27 08:24:04.919569', '528', '3924fd504ff1ea2d', '', 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (484, 528, 83, 10, 350, '2020-07-02 00:00:00', '2020-06-27 08:24:05.204944', '528', '3924fd504ff1ea2d', '', 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (485, 528, 82, 1, 30, '2020-07-02 00:00:00', '2020-06-27 08:24:05.204944', '528', '3924fd504ff1ea2d', '', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (486, 528, 9, 5, 125, '2020-07-02 00:00:00', '2020-06-27 08:24:05.204944', '528', '3924fd504ff1ea2d', '', 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (487, 528, 83, 10, 350, '2020-07-03 00:00:00', '2020-06-27 08:24:05.488735', '528', '3924fd504ff1ea2d', '', 35);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (488, 528, 82, 1, 30, '2020-07-03 00:00:00', '2020-06-27 08:24:05.488735', '528', '3924fd504ff1ea2d', '', 30);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (489, 528, 9, 5, 125, '2020-07-03 00:00:00', '2020-06-27 08:24:05.488735', '528', '3924fd504ff1ea2d', '', 25);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (490, 63, 3, 1, 20, '2020-06-27 00:00:00', '2020-06-27 08:36:00', '63', 'cb99776f4779ac6d', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (491, 500, 188, 2, 46, '2020-07-04 00:00:00', '2020-06-27 09:32:00', '140', 'cb99776f4779ac6d', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (492, 18, 181, 10, 0, '2020-07-06 00:00:00', '2020-06-29 08:16:11.380918', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (493, 18, 180, 10, 0, '2020-07-06 00:00:00', '2020-06-29 08:16:11.380918', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (494, 18, 181, 10, 0, '2020-07-07 00:00:00', '2020-06-29 08:16:11.711075', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (495, 18, 180, 10, 0, '2020-07-07 00:00:00', '2020-06-29 08:16:11.711075', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (496, 18, 181, 10, 0, '2020-07-08 00:00:00', '2020-06-29 08:16:12.006825', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (497, 18, 180, 10, 0, '2020-07-08 00:00:00', '2020-06-29 08:16:12.006825', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (498, 18, 181, 10, 0, '2020-07-09 00:00:00', '2020-06-29 08:16:12.301977', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (499, 18, 180, 10, 0, '2020-07-09 00:00:00', '2020-06-29 08:16:12.301977', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (500, 18, 181, 10, 0, '2020-07-10 00:00:00', '2020-06-29 08:16:12.596558', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (501, 18, 180, 10, 0, '2020-07-10 00:00:00', '2020-06-29 08:16:12.596558', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (502, 18, 181, 10, 0, '2020-07-11 00:00:00', '2020-06-29 08:16:12.891953', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (455, 20, 188, 1, 24, '2020-06-29 00:00:00', '2020-06-29 08:13:00', '20', 'cb99776f4779ac6d', 'done', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (503, 18, 180, 10, 0, '2020-07-11 00:00:00', '2020-06-29 08:16:12.891953', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (504, 17, 3, 1, 21, '2020-08-31 00:00:00', '2020-08-27 17:47:31.030448', '17', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (505, 17, 3, 1, 21, '2020-09-01 00:00:00', '2020-08-27 17:47:31.233595', '17', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (506, 17, 3, 1, 21, '2020-09-02 00:00:00', '2020-08-27 17:47:31.411219', '17', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (507, 17, 3, 1, 21, '2020-09-03 00:00:00', '2020-08-27 17:47:31.588829', '17', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (508, 36, 189, 1, 21, '2020-09-29 00:00:00', '2020-09-29 15:20:00', '36', 'bc3421a02ec01187', 'done', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (509, 36, 189, 1, 20, '2020-10-05 00:00:00', '2020-09-29 15:20:10.838945', '36', 'bc3421a02ec01187', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (510, 36, 189, 1, 20, '2020-10-06 00:00:00', '2020-09-29 15:20:11.070305', '36', 'bc3421a02ec01187', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (511, 36, 189, 1, 20, '2020-10-07 00:00:00', '2020-09-29 15:20:11.289277', '36', 'bc3421a02ec01187', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (512, 36, 189, 1, 20, '2020-10-08 00:00:00', '2020-09-29 15:20:11.508488', '36', 'bc3421a02ec01187', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (513, 36, 189, 1, 20, '2020-10-09 00:00:00', '2020-09-29 15:20:11.727127', '36', 'bc3421a02ec01187', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (514, 36, 189, 1, 20, '2020-10-10 00:00:00', '2020-09-29 15:20:11.945019', '36', 'bc3421a02ec01187', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (515, 140, 189, 10, 210, '2020-12-07 00:00:00', '2020-11-29 11:53:00', '140', '10505312be2c4abb', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (516, 140, 186, 1, 15, '2020-10-02 00:00:00', '2020-10-02 13:45:00', '140', 'b1aef469408b5b2e', '', 15);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (517, 140, 176, 3, 9, '2020-10-02 00:00:00', '2020-10-02 13:45:00', '140', 'b1aef469408b5b2e', '', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (518, 140, 189, 1, 21, '2020-12-07 00:00:00', '2020-11-29 03:07:00', '140', '89c63153da33eee5', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (519, 140, 186, 1, 0, '2020-10-05 00:00:00', '2020-10-02 13:46:02.968747', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (520, 140, 176, 3, 0, '2020-10-05 00:00:00', '2020-10-02 13:46:02.968747', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (521, 140, 189, 1, 20, '2020-10-06 00:00:00', '2020-10-02 13:46:10.358087', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (522, 140, 186, 1, 0, '2020-10-06 00:00:00', '2020-10-02 13:46:10.358087', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (523, 140, 176, 3, 0, '2020-10-06 00:00:00', '2020-10-02 13:46:10.358087', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (524, 140, 189, 1, 20, '2020-10-07 00:00:00', '2020-10-02 13:46:10.595048', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (525, 140, 186, 1, 0, '2020-10-07 00:00:00', '2020-10-02 13:46:10.595048', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (526, 140, 176, 3, 0, '2020-10-07 00:00:00', '2020-10-02 13:46:10.595048', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (527, 140, 189, 1, 20, '2020-10-08 00:00:00', '2020-10-02 13:46:10.831651', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (528, 140, 186, 1, 0, '2020-10-08 00:00:00', '2020-10-02 13:46:10.831651', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (529, 140, 176, 3, 0, '2020-10-08 00:00:00', '2020-10-02 13:46:10.831651', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (530, 140, 189, 1, 20, '2020-10-09 00:00:00', '2020-10-02 13:46:11.070714', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (531, 140, 186, 1, 0, '2020-10-09 00:00:00', '2020-10-02 13:46:11.070714', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (532, 140, 176, 3, 9, '2020-12-07 00:00:00', '2020-11-29 10:58:00', '140', '10505312be2c4abb', '', 3);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (533, 140, 189, 1, 20, '2020-10-10 00:00:00', '2020-10-02 13:46:11.306261', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (534, 140, 186, 1, 0, '2020-10-10 00:00:00', '2020-10-02 13:46:11.306261', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (535, 140, 176, 3, 0, '2020-10-10 00:00:00', '2020-10-02 13:46:11.306261', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (536, 4, 3, 1, 21, '2020-11-30 00:00:00', '2020-11-28 11:47:44.755062', '4', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (537, 4, 3, 1, 21, '2020-12-01 00:00:00', '2020-11-28 12:50:11.811354', '4', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (538, 4, 3, 1, 21, '2020-12-02 00:00:00', '2020-11-28 12:50:12.070079', '4', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (539, 4, 3, 1, 21, '2020-12-03 00:00:00', '2020-11-28 12:50:12.316107', '4', 'b1aef469408b5b2e', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (540, 4, 189, 1, 21, '2020-12-04 00:00:00', '2020-11-28 13:27:00', '4', '46860b782c3139e3', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (541, 35, 189, 1, 21, '2020-11-28 00:00:00', '2020-11-28 18:26:00', '35', '10505312be2c4abb', '', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (542, 35, 189, 1, 20, '2020-11-30 00:00:00', '2020-11-28 18:27:37.652693', '35', '3a303e4a11fc4ba3', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (543, 35, 189, 1, 20, '2020-12-01 00:00:00', '2020-11-28 18:27:37.942187', '35', '3a303e4a11fc4ba3', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (544, 35, 189, 1, 20, '2020-12-02 00:00:00', '2020-11-28 18:27:38.189669', '35', '3a303e4a11fc4ba3', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (545, 35, 189, 1, 20, '2020-12-03 00:00:00', '2020-11-28 18:27:38.435543', '35', '3a303e4a11fc4ba3', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (546, 35, 189, 1, 20, '2020-12-04 00:00:00', '2020-11-28 18:27:38.679099', '35', '3a303e4a11fc4ba3', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (547, 35, 189, 1, 20, '2020-12-05 00:00:00', '2020-11-28 18:27:38.925352', '35', '3a303e4a11fc4ba3', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (548, 35, 189, 1, 20, '2020-12-07 00:00:00', '2020-11-29 05:39:21.447292', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (549, 140, 189, 10, 200, '2020-12-08 00:00:00', '2020-11-29 05:55:06.222799', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (550, 140, 189, 1, 20, '2020-12-08 00:00:00', '2020-11-29 05:55:06.222799', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (551, 140, 176, 3, 0, '2020-12-08 00:00:00', '2020-11-29 05:55:06.222799', '140', '7964256e0a63db1f', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (552, 36, 189, 1, 20, '2020-12-07 00:00:00', '2020-11-29 06:17:04.721788', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (553, 36, 189, 1, 20, '2020-12-08 00:00:00', '2020-11-29 06:17:04.947145', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (554, 36, 189, 1, 20, '2020-12-09 00:00:00', '2020-11-29 06:17:05.117758', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (555, 36, 189, 1, 20, '2020-12-10 00:00:00', '2020-11-29 06:17:05.288707', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (556, 36, 189, 1, 20, '2020-12-11 00:00:00', '2020-11-29 06:17:05.480938', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (557, 36, 189, 1, 20, '2020-12-12 00:00:00', '2020-11-29 06:17:05.651513', '140', '7964256e0a63db1f', '', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (558, 18, 181, 10, 0, '2020-12-21 00:00:00', '2020-12-13 20:15:09.942933', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (559, 18, 180, 10, 0, '2020-12-21 00:00:00', '2020-12-13 20:15:09.942933', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (560, 18, 181, 10, 0, '2020-12-22 00:00:00', '2020-12-13 20:15:10.197458', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (561, 18, 180, 10, 0, '2020-12-22 00:00:00', '2020-12-13 20:15:10.197458', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (562, 18, 181, 10, 0, '2020-12-23 00:00:00', '2020-12-13 20:15:10.434093', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (563, 18, 180, 10, 0, '2020-12-23 00:00:00', '2020-12-13 20:15:10.434093', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (564, 18, 181, 10, 0, '2020-12-24 00:00:00', '2020-12-13 20:15:10.665836', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (565, 18, 180, 10, 0, '2020-12-24 00:00:00', '2020-12-13 20:15:10.665836', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (566, 18, 181, 10, 0, '2020-12-25 00:00:00', '2020-12-13 20:15:10.897194', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (567, 18, 180, 10, 0, '2020-12-25 00:00:00', '2020-12-13 20:15:10.897194', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (568, 18, 181, 10, 0, '2020-12-26 00:00:00', '2020-12-13 20:15:11.127087', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (569, 18, 180, 10, 20, '2020-12-26 00:00:00', '2020-12-13 20:15:11.127087', '18', '6b7784294592c43c', '', 0);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (570, 500, 188, 2, 46, '2020-07-05 00:00:00', '2020-06-27 09:32:00', '140', 'cb99776f4779ac6d', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (571, 500, 188, 2, 46, '2020-07-04 00:00:00', '2020-06-27 09:32:00', '140', 'cb99776f4779ac6d', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (572, 63, 3, 1, 21, '2021-05-31 00:00:00', '2021-05-31 19:19:51.771213', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (573, 63, 3, 1, 21, '2021-05-31 00:00:00', '2021-05-31 19:19:51.771213', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (574, 63, 3, 1, 21, '2021-06-01 00:00:00', '2021-05-31 19:19:51.982673', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (575, 63, 3, 1, 21, '2021-06-01 00:00:00', '2021-05-31 19:19:51.982673', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (576, 63, 3, 1, 21, '2021-06-02 00:00:00', '2021-05-31 19:19:52.162282', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (577, 63, 3, 1, 21, '2021-06-02 00:00:00', '2021-05-31 19:19:52.162282', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (578, 63, 3, 1, 21, '2021-06-03 00:00:00', '2021-05-31 19:19:52.340506', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (579, 63, 3, 1, 21, '2021-06-03 00:00:00', '2021-05-31 19:19:52.340506', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (580, 63, 3, 1, 21, '2021-06-04 00:00:00', '2021-05-31 19:19:52.516846', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (581, 63, 3, 1, 21, '2021-06-04 00:00:00', '2021-05-31 19:19:52.516846', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (582, 63, 3, 1, 21, '2021-06-05 00:00:00', '2021-05-31 19:19:52.694204', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (583, 63, 3, 1, 21, '2021-06-05 00:00:00', '2021-05-31 19:19:52.694204', '63', '2020-06-25 18:30:00', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (584, 65, 3, 1, 20, '2021-05-31 00:00:00', '2021-05-31 22:31:00', '65', 'c01c4fa0b7e408d1', NULL, 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (586, 65, 16, 1, 23, '2021-05-31 00:00:00', '2021-05-31 22:32:00', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (585, 65, 16, 1, 23, '2021-05-31 00:00:00', '2021-05-31 22:32:00', '65', 'c01c4fa0b7e408d1', 'del', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (589, 65, 3, 1, 21, '2021-06-08 00:00:00', '2021-05-31 22:33:25.975055', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (590, 65, 16, 1, 23, '2021-06-08 00:00:00', '2021-05-31 22:33:25.975055', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (591, 65, 3, 1, 21, '2021-06-09 00:00:00', '2021-05-31 22:33:26.695744', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (592, 65, 16, 1, 23, '2021-06-09 00:00:00', '2021-05-31 22:33:26.695744', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (593, 65, 3, 1, 21, '2021-06-10 00:00:00', '2021-05-31 22:33:27.302463', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (594, 65, 16, 1, 23, '2021-06-10 00:00:00', '2021-05-31 22:33:27.302463', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (595, 65, 3, 1, 21, '2021-06-11 00:00:00', '2021-05-31 22:33:28.025791', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (596, 65, 16, 1, 23, '2021-06-11 00:00:00', '2021-05-31 22:33:28.025791', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (597, 65, 3, 1, 21, '2021-06-12 00:00:00', '2021-05-31 22:33:28.741769', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (598, 65, 16, 1, 23, '2021-06-12 00:00:00', '2021-05-31 22:33:28.741769', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (587, 65, 3, 1, 21, '2021-06-07 00:00:00', '2021-06-07 19:18:00', '65', 'c01c4fa0b7e408d1', 'done', 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (588, 65, 16, 1, 23, '2021-06-07 00:00:00', '2021-06-07 19:18:00', '65', 'c01c4fa0b7e408d1', 'done', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (599, 65, 3, 1, 21, '2021-07-19 00:00:00', '2021-07-12 11:45:46.822026', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (600, 65, 16, 1, 23, '2021-07-19 00:00:00', '2021-07-12 11:45:46.822026', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (601, 65, 3, 1, 21, '2021-07-20 00:00:00', '2021-07-12 11:45:47.150252', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (602, 65, 16, 1, 23, '2021-07-20 00:00:00', '2021-07-12 11:45:47.150252', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (603, 65, 3, 1, 21, '2021-07-21 00:00:00', '2021-07-12 11:45:47.347038', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (604, 65, 16, 1, 23, '2021-07-21 00:00:00', '2021-07-12 11:45:47.347038', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (605, 65, 3, 1, 21, '2021-07-22 00:00:00', '2021-07-12 11:45:47.564499', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (606, 65, 16, 1, 23, '2021-07-22 00:00:00', '2021-07-12 11:45:47.564499', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (607, 65, 3, 1, 21, '2021-07-23 00:00:00', '2021-07-12 11:45:48.042765', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (608, 65, 16, 1, 23, '2021-07-23 00:00:00', '2021-07-12 11:45:48.042765', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (609, 65, 3, 1, 21, '2021-07-24 00:00:00', '2021-07-12 11:45:48.485092', '65', 'c01c4fa0b7e408d1', NULL, 21);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (610, 65, 16, 1, 23, '2021-07-24 00:00:00', '2021-07-12 11:45:48.485092', '65', 'c01c4fa0b7e408d1', NULL, 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (192, 464, 132, 1, 9, '2020-06-22 00:00:00', '2020-06-20 07:39:20.81742', '464', '70566f4ac30bd154', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (193, 464, 3, 1, 23, '2020-06-23 00:00:00', '2020-06-20 07:39:21.161808', '464', '70566f4ac30bd154', '', 23);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (194, 464, 132, 1, 9, '2020-06-23 00:00:00', '2020-06-20 07:39:21.161808', '464', '70566f4ac30bd154', '', 9);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (299, 18, 181, 10, 5, '2020-07-06 00:00:00', '2020-06-29 08:16:11.380918', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (300, 18, 180, 10, 4, '2020-07-06 00:00:00', '2020-06-29 08:16:11.380918', '18', '6b7784294592c43c', NULL, NULL);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (441, 20, 3, 1, 21, '2020-06-21 00:00:00', '2020-06-21 18:03:00', '20', 'cb99776f4779ac6d', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (184, 20, 3, 1, 23, '2020-06-21 00:00:00', '2020-06-21 18:03:00', '20', 'cb99776f4779ac6d', 'done', 20);
INSERT INTO public.fd_foods (food_id, person_id, feed_id, food_qty, food_amount, food_date, write_date, write_user, android_id, state, food_price) VALUES (65, 464, 3, 5, 21, '2019-03-25 00:00:00', '2019-03-17 08:54:00', '464', 'ab0c6b16e41f44b0', '', 23);


--
-- TOC entry 5567 (class 0 OID 5621856)
-- Dependencies: 243
-- Data for Name: fd_persons; Type: TABLE DATA; Schema: public; Owner: joqivmzw
--

INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (572, NULL, NULL, NULL, NULL, 'DSV', NULL, NULL, NULL, NULL, NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (5, 'feedmaker', NULL, NULL, NULL, 'FeedMaker2', NULL, NULL, 'aa3130d9ed20b81a--', 'valery@gmail.ua.com', NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (3, 'client', NULL, NULL, NULL, 'valera  732663', NULL, NULL, 'boris@gra.ua', NULL, NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (52, '', NULL, NULL, NULL, 'Заливной Виталий', NULL, '2019-03-16 08:39:00', 'xxx-yyyzz', 'ab0c6b16e41f44b0', NULL, 'del', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (358, NULL, NULL, NULL, NULL, 'Серая Елена', NULL, NULL, NULL, NULL, NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (61, '', NULL, NULL, NULL, 'Сидоров Дмитрий33', NULL, '2019-09-30 08:33:00', '', '447f3df9c7240c3c', NULL, 'del', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (140, 'admin', NULL, NULL, NULL, 'Admin', NULL, '2019-10-01 06:40:00', '', '7964256e0a63db1f', NULL, NULL, '140', 'fa215029af67113b,447f3df9c7240c3c,ab0c6b16e41f44b0,874da9a893938146,a696945e7053af62,3924fd504ff1ea2d,7964256e0a63db1f', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (637, NULL, NULL, NULL, NULL, 'Семенченко Евгений', NULL, NULL, NULL, NULL, NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (427, NULL, NULL, NULL, NULL, 'Пирог Валерий', NULL, NULL, NULL, NULL, NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (10, NULL, NULL, NULL, NULL, 'Tester1', NULL, '2020-04-25 09:58:00', 'tester1@com', '70566f4ac30bd154', NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (11, NULL, NULL, NULL, NULL, 'Tester1', NULL, '2020-04-25 10:14:00', 'tester1@com', '70566f4ac30bd154', NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (13, NULL, NULL, NULL, NULL, 'Tester1', NULL, '2020-04-25 17:11:00', 'tester1@com', '70566f4ac30bd154', NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (12, NULL, NULL, NULL, NULL, 'Tester1', NULL, '2020-04-25 10:17:00', 'tester1@com', '70566f4ac30bd154', NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (14, NULL, NULL, NULL, NULL, 'Tester1', NULL, '2020-04-25 17:22:00', 'tester1@com', '70566f4ac30bd154', NULL, 'del', NULL, NULL, true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (15, 'foodmaker', NULL, NULL, NULL, 'Tester1', NULL, '2020-04-26 08:51:00', 'tester1@com', '70566f4ac30bd154', NULL, 'del', '15', '70566f4ac30bd154', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (19, '', NULL, NULL, NULL, 'Буд.', NULL, '2020-06-19 17:12:00', '', 'b1aef469408b5b2e', NULL, 'del', NULL, 'b1aef469408b5b2e', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (21, '', NULL, NULL, NULL, 'text', NULL, '2020-06-26 00:39:00', '', '41b2ab47f20c0028', NULL, 'del', NULL, '41b2ab47f20c0028', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (23, '', NULL, NULL, NULL, 'avd10', NULL, '2020-07-24 09:20:00', 'avd10@ua', '7964256e0a63db1f', NULL, 'del', NULL, '7964256e0a63db1f', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (24, '', NULL, NULL, NULL, 'test1', NULL, '2020-07-24 10:39:00', 'test1@ua', '3a303e4a11fc4ba3', NULL, 'del', NULL, '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (25, '', NULL, NULL, NULL, 'test2', NULL, '2020-07-24 10:48:00', 'tes2@ua', '3a303e4a11fc4ba3', NULL, 'del', NULL, '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (33, '', NULL, NULL, NULL, 'test10', NULL, '2020-07-24 14:21:00', '10', '3a303e4a11fc4ba3', NULL, 'del', NULL, '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (26, '', NULL, NULL, NULL, 'test3', NULL, '2020-07-24 10:55:00', 'test2@ua', '528962d856c2dbcd', NULL, 'del', NULL, '528962d856c2dbcd', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (27, '', NULL, NULL, NULL, 'test4', NULL, '2020-07-24 11:00:00', 'ss', '3a303e4a11fc4ba3', NULL, 'del', NULL, '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (29, '', NULL, NULL, NULL, 'test6', NULL, '2020-07-24 11:13:00', '666', '3a303e4a11fc4ba3', NULL, 'del', NULL, '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (30, '', NULL, NULL, NULL, 'test7', NULL, '2020-07-24 11:25:00', '7777777', '3a303e4a11fc4ba3', NULL, 'del', NULL, '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (31, '', NULL, NULL, NULL, 'test8', NULL, '2020-07-24 14:15:00', '88888', '3a303e4a11fc4ba3', NULL, 'del', NULL, '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (32, '', NULL, NULL, NULL, 'test9', NULL, '2020-07-24 14:18:00', '999999999999', '3a303e4a11fc4ba3', NULL, 'del', NULL, '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (34, '', NULL, NULL, NULL, 'test11', NULL, '2020-07-24 14:35:00', '111', '3a303e4a11fc4ba3', NULL, 'del', NULL, '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (37, '', NULL, NULL, NULL, 'Boris Mezu3s', NULL, '2020-11-29 11:51:00', 'Boris.mezu@com', '10505312be2c4abb', NULL, 'del', '140', 'b1aef469408b5b2e', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (38, '', NULL, NULL, NULL, 'Борис2', NULL, '2020-11-29 13:27:00', 'qw@sdsss+++', '10505312be2c4abb', NULL, 'del', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (4, '', NULL, NULL, NULL, 'Борис44', NULL, '2020-11-29 13:47:00', 'qw@sdsss444++++', '10505312be2c4abb', NULL, 'del', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (40, '', NULL, NULL, NULL, 'Борис442', NULL, '2020-11-29 14:02:00', 'qw@sdsss4442', '10505312be2c4abb', NULL, 'del', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (42, '', NULL, NULL, NULL, 'ff', NULL, '2021-01-02 12:57:00', 'gh', 'b1aef469408b5b2e', NULL, 'del', NULL, 'b1aef469408b5b2e', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (43, '', NULL, NULL, NULL, 'ff', NULL, '2021-01-02 13:02:00', 'gh', 'b1aef469408b5b2e', NULL, 'del', NULL, 'b1aef469408b5b2e', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (20, 'feedmaker', '', '', '', 'Будмен', '', '2020-06-25 18:30:00', 'budmen@ua', 'cb99776f4779ac6d', '', '', '140', 'cb99776f4779ac6d', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (36, 'feedmaker', 'newCompany', '`Kharkov`', '', 'Киров Андрей', '', '2020-09-29 15:19:00', 'avd26@ua', 'bc3421a02ec01187', '', '', '140', 'bc3421a02ec01187', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (528, 'client', 'Новая компания', 'Харьков', '', 'Бондаренко', '', '2019-08-13 15:18:00', 'ss', '3924fd504ff1ea2d', '', '', '140', '333333', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (464, 'client', '', '', '', 'Мечта Татьяна', '', '2020-11-28 10:58:00', 'tat@gra.2', '46860b782c3139e3', '', '', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (35, 'client', '', '', '', 'test12', '', '2020-11-29 11:50:00', '1212wer33', '10505312be2c4abb', '', '', '140', '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (16, 'foodmaker', '', '', '', 'Tester1', '', '2020-07-20 09:59:00', 'tester1@com', '70566f4ac30bd154', '', '', '140', '70566f4ac30bd154', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (41, 'admin', '', '', '', 'Boris avd 11-64-45', '', '2020-12-02 09:45:00', 'boris@avd11-64', '08f2db2b8972767d', '', '', '340', '08f2db2b8972767d', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (53, 'client', '', '', '', 'Киров Андрей Федоров', '', '2020-06-25 18:30:00', 'kirov.ivan@ua.com', 'cb99776f4779ac6d', '', '', '140', 'cb99776f4779ac6d', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (689, 'client', '', '', '', 'Боровченко  Виталий', '', '2020-03-05 12:50:00', 'ss', '70566f4ac30bd154', '', '', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (17, 'admin', '', '', '', 'Boris Mezu3s', '', '2020-04-27 09:43:00', 'Boris.mezu@com', 'b1aef469408b5b2e', '', '', '140', 'b1aef469408b5b2e', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (47, 'foodmaker', 'Моя компания', 'Киев~', '', 'Петров Боткин', '', '2020-04-26 18:58:00', 'tester1@com', 'b1aef469408b5b2e', '', '', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (60, 'feedmaker', '', '', '', 'Boris avd26', '', '2020-06-25 18:30:00', 'avd26@ua', '2020-06-25 18:30:00', '', '', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (63, 'feedmaker', '', '', '', 'Boris', '', '2020-06-25 18:30:00', 'import kotlin.math.*;" sin=${sin(0.0)} ${sin(1.0)} ${sin(2.0)}"', '2020-06-25 18:30:00', '', '', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (7, '', NULL, NULL, NULL, 'Заливной Виталий 333', NULL, '2019-03-16 10:12:00', 'xxx-yyyzz', 'ab0c6b16e41f44b0', NULL, 'del', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (6, '', NULL, NULL, NULL, 'Заливной Виталий 777', NULL, '2019-03-16 08:44:00', 'xxx@ua', 'ab0c6b16e41f44b0', NULL, 'del', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (65, 'client', NULL, NULL, NULL, 'Борис Б', NULL, '2021-05-31 22:31:00', 'my.mail@com', 'c01c4fa0b7e408d1', NULL, NULL, '140', 'c01c4fa0b7e408d1', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (44, 'client', '', '', '', 'Будмен 44', '', '2020-07-24 11:59:00', 'br44567@ua', 'b1aef469408b5b2e', '', '', '999', 'b1aef469408b5b2e', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (45, 'feedmaker', '', '', '', 'FeedMaker', '', '2020-06-25 18:30:00', 'val@gmail.com', 'aa3130d9ed20b81a', '', '', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (64, 'client', NULL, NULL, NULL, 'Boris B', NULL, '2021-05-31 21:56:00', 'boris.gra.fo@gmail.com', '0c29168bdf285273', NULL, NULL, '140', '0c29168bdf285273', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (18, 'feedmaker', '', '', '', 'Boris AVD30', '', '2020-04-27 06:47:00', 'boris.avd30@com', '6b7784294592c43c', '', '', '555', '6b7784294592c43c', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (22, 'client', '', '', '', 'Будмен Б', '', '2020-07-24 11:59:00', 'br@ua33888', 'b1aef469408b5b2e', '', '', '240', 'b1aef469408b5b2e', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (48, 'foodmaker', '', '', '', 'Tester1 48', '', '2020-07-20 09:59:00', 'tester1@com', '70566f4ac30bd154', '', '', '140', '70566f4ac30bd154', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (49, 'foodmaker', '', '', '', 'Будмен 49', '', '2020-06-25 18:30:00', 'budmen@ua', 'cb99776f4779ac6d', '', '', '140', 'cb99776f4779ac6d', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (55, 'feedmaker', 'newCompany', '`Kharkov`', '', 'Киров Андрей 55', '', '2020-09-29 15:19:00', 'avd26@ua', 'bc3421a02ec01187', '', '', '140', 'bc3421a02ec01187', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (58, 'feedmaker', 'newCompany', '`Kharkov`', '', 'Киров Андрей 58', '', '2020-09-29 15:19:00', 'avd26@ua', 'bc3421a02ec01187', '', '', '140', 'bc3421a02ec01187', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (59, 'feedmaker', '', '', '', 'FeedMaker 59', '', '2020-06-25 18:30:00', 'val@gmail.com', 'aa3130d9ed20b81a', '', '', '125', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (500, 'foodmaker', 'Моя компания', 'Киев~', '', 'Петров Боткин 500', '', '2020-04-26 18:59:00', 'tester1@com', 'b1aef469408b5b2e', '', '', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (56, 'feedmaker', '', '', '', 'FeedMaker 56', '', '2020-06-25 18:30:00', 'val@gmail.com', 'aa3130d9ed20b81a', '', '', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (46, NULL, '', '', '', 'test12 46', '', '2020-11-29 11:50:00', '1212wer33', '10505312be2c4abb', '', '', '140', '3a303e4a11fc4ba3', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (801, 'client', '', '', '', 'Boris qw', '', '2020-11-29 14:03:00', 'qw@sdsss', '10505312be2c4abb', '', 'кпкпкп', '140', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (716, 'feedmaker', '', '', '', 'FeedMaker 716', '', '2020-06-25 18:30:00', 'val@gmail.com', 'aa3130d9ed20b81a', '', '', '777', '', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (57, 'feedmaker', '', '', '', 'Boris AVD30 57', '', '2020-04-27 06:46:00', 'boris.avd30@com', '6b7784294592c43c', '', '', '140', '6b7784294592c43c', true);
INSERT INTO public.fd_persons (id, status, company, address, country, person_name, phone, write_date, user_mail, android_id, town, state, write_user, android_ids, see_param) VALUES (54, 'feedmaker', '', '', '', 'Boris AVD30 54', '', '2020-04-27 06:45:00', 'boris.avd30@com', '6b7784294592c43c', '', '', '140', '6b7784294592c43c', true);


--
-- TOC entry 5565 (class 0 OID 5621573)
-- Dependencies: 239
-- Data for Name: querys; Type: TABLE DATA; Schema: public; Owner: joqivmzw
--

INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (129, 'Demo1', 'bd/animal/jsonPG/demo1', '', 'Demo 1', 'Big Animal (PGSQL)', 'SELECT firstname, lastname, (
	SELECT LISTAGG(lastname, '', '')
	FROM employee rt
	START WITH rt.employeeid=e.reportsto
	CONNECT BY employeeid = PRIOR reportsto
	) AS "chain of command"
FROM employee e;');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (16, 'foodorders_ro', 'bd/QUERY_BD/jsonPG/v_foodorders', '', 'Order''s feeds', 'Feed (querym)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (53, 'client_status_ro', 'bd/QUERY_BD/jsonPG/v_status', '', 'Client status', 'LookUp lists', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (54, 'feed_type_ro', 'bd/QUERY_BD/jsonPG/v_feed_type', '', 'List of dishes', 'LookUp lists', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (116, 'animal_invoice', 'bd/animal/jsonPG/invoice', '', 'Invoice', 'Big Animal (PGSQL)', '');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (113, 'animal_ArtistsAlbum_ro', 'bd/animal/jsonPG/artistsAlbum', '', 'Artist''s album', 'Big Animal (PGSQL)', 'select (select name from artist ar where ar.artistid = al.artistid ) as artistName,
title
from album al
order by artistname');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (117, 'animal_ArtistsAlbumCount_ro', 'bd/animal/jsonPG/artistsAlbumCount', '', 'Artist''s album count', 'Big Animal (PGSQL)', 'select (select name from artist ar where ar.artistid = al.artistid ) as artistName,
count(*) TileCount
from album al
group by artistName
order by artistname');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (2, 'feeds', 'bd/QUERY_BD/jsonPG/v_feeds', 'field:feed_id,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_type,cellEditor : agSelectCellEditor, 
cellEditorParams:v_feed_type;
field:feed_name;
field:feed_price,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_date,filter: agDateColumnFilter ;
field:write_date,filter: agDateColumnFilter ;
field:write_user;
field:android_id;
field:state,type: numericColumn,filter: agNumberColumnFilter ;
', 'Foods for Order', 'Feed (querym)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (77, 'v_persons_order', 'bd/QUERY_BD/jsonPG/v_persons', 'headerName: id pers, field: id,rowDrag: true,filter: agNumberColumnFilter,editable: false, pinned: left,
    type: numericColumn, width: 120,checkboxSelection: true;
headerName: status 123, field: status,type: rightAligned, editable: true , headerTooltip:Статус клиента (admin главный), cellEditor : agSelectCellEditor, 
cellEditorParams:one.two.three ;
headerName: person_name, field: person_name,wrapText: false,autoHeight: false ;
headerName: user_mail, field: user_mail, editable: true ;
headerName: write_date, field: write_date, filter: agDateColumnFilter ;
headerName: android_id, field: android_id,editable: true ,cellEditor: agLargeTextCellEditor;
headerName: Write User, field: write_user, width: 80,filter: ''agNumberColumnFilter'' ;', 'without Clients', 'All Query', 'select * from v_persons
where status in (''admin'',''feedmaker'',''foodmaker'')');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (48, '', '', 'import javax.script.ScriptEngineManager
import javax.script.Invocable
val engine = ScriptEngineManager().getEngineByExtension("kts")
println(engine .eval("1+2+102"))



/*  println(engine .eval("${this::class.java.name}.shouldBeVisibleFromRepl")) */', 'SOUNDPROOFING,Feed (querym),External', 'All Query', '');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (15, 'olympic-winners_ro', 'https://www.ag-grid.com/example-assets/olympic-winners.json', '', 'Olympic winners (from lihk)', 'External', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (122, 'anymal_list_table', 'bd/animal/jsonPG/list_table', '', ' Tables ALL list', 'Big Animal (PGSQL)', 'SELECT table_name as table_name_   --,table_type
FROM information_schema.tables
where table_schema = ''public''
and table_type = ''BASE TABLE''
order by 1');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (121, '', '', 'import kotlin.math.*


" sin=${sin(0.0)} ${sin(1.0)} ${sin(2.0)}"', '', 'Big Animal (PGSQL)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (115, 'submenu', '', 'name + "---" + name', 'LookUp lists', 'Development', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (120, 'info_link', 'https://www.enterprisedb.com/docs/biganimal/latest/using_cluster/06_demonstration_oracle_compatibility', '', '  INFO *', 'Big Animal (PGSQL)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (41, 'v_users_ro', 'bd/daas_nma/jsonPG/v_users/ order by id desc limit 50', 'field:id,type: numericColumn,filter: agNumberColumnFilter ;
field:status;
field:company;
field:address;
field:country;
field:person_name;
field:phone;
field:account_google;
field:write_date,filter: agDateColumnFilter ;
field:user_mail;
field:android_id;
field:town;
field:brand_material;
field:region;
', 'User Rednois(last 50) *', 'SOUNDPROOFING', '');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (128, 'Demo2', 'bd/animal/jsonPG/demo2', '', 'Demo 2', 'Big Animal (PGSQL)', 'SELECT UNIQUE title,
       ROUND(AVG(bytes) OVER (PARTITION BY mediatypeid)/1048576 ) media_avg_mb,
       LISTAGG(t.name || '' ('' || ROUND(bytes/1048576) || '' mb)'', chr(10))
         WITHIN GROUP (ORDER BY trackid)
         OVER (PARTITION BY title)  track_list
FROM track t
JOIN album USING (albumid)
JOIN mediatype USING (mediatypeid)
WHERE lower(title) LIKE ''%baby%''
ORDER BY title');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (47, '', '', 'import kotlin.math.*
import javax.script.ScriptEngineManager
import javax.script.Invocable
val engine = ScriptEngineManager().getEngineByExtension("kts")

val boundValue = 10100
val x = 1001
val z = 103
println(13.0 + boundValue + x + z)
//println(12 + boundValue*100)
/* put("boundValue", 101)*/
       val res1 = engine.eval("""
            fun fn(x: Int) = x + 2
            val myobj = object {
                fun fn1(x: Int) = x + 3
            }
            myobj""".trimIndent())
val invocator = engine as? Invocable
println(invocator!!.invokeFunction("fn", 300))
println(invocator!!.invokeMethod(res1, "fn1", 30000))

"ALL OK !  sin=" +sin(1.0)
', 'Development,Errors', 'Construction', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (111, 'anymal_employee', 'bd/animal/jsonPG/employee', 'field:employeeid,type: numericColumn,filter: agNumberColumnFilter ;
field:lastname;
field:firstname;
field:title;
field:reportsto,type: numericColumn,filter: agNumberColumnFilter ;
field:birthdate,filter: agDateColumnFilter ;
field:hiredate,filter: agDateColumnFilter ;
field:address;
field:city;
field:state;
field:country;
field:postalcode;
field:phone;
field:fax;
field:email;
', 'Employee', 'Big Animal (PGSQL)', '');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (112, 'animal_customer', 'bd/animal/jsonPG/customer', 'field:customerid,type: numericColumn,filter: agNumberColumnFilter ;
field:firstname;
field:lastname;
field:company;
field:address;
field:city;
field:state;
field:country;
field:postalcode;
field:phone;
field:fax;
field:email;
field:supportrepid,type: numericColumn,filter: agNumberColumnFilter ;
', 'Customer', 'Big Animal (PGSQL)', '');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (125, 'foods>464', 'bd/QUERY_BD/jsonPG/v_foods/and person_id >=464', 'field:food_id,type: numericColumn,filter: agNumberColumnFilter ;
field:person_id,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_id,type: numericColumn,filter: agNumberColumnFilter ;
field:food_qty,type: numericColumn,filter: agNumberColumnFilter ;
field:food_amount,type: numericColumn,filter: agNumberColumnFilter ;
field:food_date,filter: agDateColumnFilter ;
field:write_date,filter: agDateColumnFilter ;
field:write_user;
field:android_id;
field:state;
field:food_price,type: numericColumn,filter: agNumberColumnFilter ;', 'foods >= 464', 'Feed (querym)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (17, 'v_history_today_ro', 'bd/daas_nma/jsonPG/v_history/ and  date(write_date)=current_date  order by id desc', 'field:id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:noiseparty_tag;
field:description;
field:write_date,filter: agDateColumnFilter ;
field:info,width:360;
field:record_id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:user_mail,width:80;
field:android_id,width:80;
field:car_plate;
field:user_country,width:60;
field:address,width:80;
field:person_name;
field:phone;
field:town;
field:car_brand;
field:car_model;
field:car_country;
field:car_type;
field:car_manuf_year,type: numericColumn,filter: agNumberColumnFilter ;
field:record_utc,type: numericColumn,filter: agNumberColumnFilter ;
field:tags;
field:company;
', 'History Rednois TODAY', 'SOUNDPROOFING', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (114, 'v_querys', 'bd/QUERY_BD/jsonPG/v_querys', 'field:id,editable: false,width:60; 
field:query, wrapText: true,autoHeight:true,width:260 ;
field:name; 
field:columns,cellEditor: agLargeTextCellEditor; field:heading; 
field:submenu; field:_sql,editable:false,headerName:SQL,width:100;', 'Queries', 'Development', '');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (14, 'v_history_interval_ro', 'bd/daas_nma/jsonPG/v_history/ and  date(write_date)>=''{@dateFrom}'' and  date(write_date)<=''{@dateTo}'' order by id desc', 'field:id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:noiseparty_tag;
field:description;
field:write_date,filter: agDateColumnFilter ;
field:info,width:360;
field:record_id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:user_mail,width:80;
field:android_id,width:80;
field:car_plate;
field:user_country,width:60;
field:address,width:80;
field:person_name;
field:phone;
field:town;
field:car_brand;
field:car_model;
field:car_country;
field:car_type;
field:car_manuf_year,type: numericColumn,filter: agNumberColumnFilter ;
field:record_utc,type: numericColumn,filter: agNumberColumnFilter ;
field:tags;
field:company;
', 'History Rednois {@dateFrom}-{@dateTo}', 'SOUNDPROOFING', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (99, 'foods_all', 'bd/QUERY_BD/jsonPG/v_foods', 'field:food_id,type: numericColumn,filter: agNumberColumnFilter ;
field:person_id,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_id,type: numericColumn,filter: agNumberColumnFilter ;
field:food_qty,type: numericColumn,filter: agNumberColumnFilter ;
field:food_amount,type: numericColumn,filter: agNumberColumnFilter ;
field:food_date,filter: agDateColumnFilter ;
field:write_date,filter: agDateColumnFilter ;
field:write_user;
field:android_id;
field:state;
field:food_price,type: numericColumn,filter: agNumberColumnFilter ;', 'foods All', 'Feed (querym)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (126, 'feeds_n_noBase', 'bd/myBase/jsonPG/v_feeds/ order by name', 'field:feed_id,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_type,cellEditor : agSelectCellEditor, 
cellEditorParams:v_feed_type;
field:feed_name;
field:feed_price,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_date,filter: agDateColumnFilter ;
field:write_date,filter: agDateColumnFilter ;
field:write_user;
field:android_id;
field:state,type: numericColumn,filter: agNumberColumnFilter ;
', 'feeds_n order (Error no ENV)', 'Errors', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (127, 'foods>2464', 'bd/QUERY_BD/jsonPG/v_foods/and person_id >=1464', 'field:food_id,type: numericColumn,filter: agNumberColumnFilter ;
field:person_id,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_id,type: numericColumn,filter: agNumberColumnFilter ;
field:food_qty,type: numericColumn,filter: agNumberColumnFilter ;
field:food_amount,type: numericColumn,filter: agNumberColumnFilter ;
field:food_date,filter: agDateColumnFilter ;
field:write_date,filter: agDateColumnFilter ;
field:write_user;
field:android_id;
field:state;
field:food_price,type: numericColumn,filter: agNumberColumnFilter ;', 'foods >= 1464(Empty result)', 'Errors', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (3, 'persons', 'bd/QUERY_BD/jsonPG/v_persons', 'headerName: id pers, field: id,rowDrag: true,filter: agNumberColumnFilter,editable: false, pinned: left,
    type: numericColumn, width: 120,checkboxSelection: true;
headerName: status 123, field: status,type: rightAligned, editable: true , headerTooltip:Статус клиента (admin главный), cellEditor : agSelectCellEditor, 
cellEditorParams:v_status ;
headerName: person_name, field: person_name,wrapText: true,autoHeight:false ;
headerName: user_mail, field: user_mail, editable: true ;
headerName: write_date, field: write_date, filter: agDateColumnFilter,cellEditor: DatePicker;
headerName: android_id, field: android_id,editable: false,cellEditor: agLargeTextCellEditor;
headerName: Write User, field: write_user, width: 80,filter: ''agNumberColumnFilter'' ;', 'Clients  - fullWeb', 'Feed (querym)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (5, 'foodorders_person_ro', 'bd/QUERY_BD/jsonPG/v_foodorders/ and person_id = {id}', '', 'Order''s feeds by person {person_name}', 'Feed (querym)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (55, 'feeds_n', 'bd/QUERY_BD/jsonPG/v_feeds_err', 'field:feed_id,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_type,cellEditor : agSelectCellEditor, 
cellEditorParams:v_feed_type;
field:feed_name;
field:feed_price,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_date,filter: agDateColumnFilter ;
field:write_date,filter: agDateColumnFilter ;
field:write_user;
field:android_id;
field:state,type: numericColumn,filter: agNumberColumnFilter ;
', 'feeds_n (Error in SQL)', 'Errors', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (6, 'foods_interval', 'bd/QUERY_BD/jsonPG/v_foods/and  food_date >= ''{@dateFrom}'' and date(food_date) <= ''{@dateTo}''', 'field:food_id,type: numericColumn,filter: agNumberColumnFilter ;
field:person_id,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_id,type: numericColumn,filter: agNumberColumnFilter ;
field:food_qty,type: numericColumn,filter: agNumberColumnFilter ;
field:food_amount,type: numericColumn,filter: agNumberColumnFilter ;
field:food_date,filter: agDateColumnFilter ;
field:write_date,filter: agDateColumnFilter ;
field:write_user;
field:android_id;
field:state;
field:food_price,type: numericColumn,filter: agNumberColumnFilter ;', 'foods  {@dateFrom} - {@dateTo}', 'Feed (querym)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (98, 'Olympic winners (Error)', 'https://www.ag-grid.com/example-assets/olympic-winners_err.json', 'field:athlete;
field:age,type: numericColumn,filter: agNumberColumnFilter ;
field:country;
field:year,type: numericColumn,filter: agNumberColumnFilter ;
field:date,filter: agDateColumnFilter ;
field:sport;
field:gold,type: numericColumn,filter: agNumberColumnFilter ;
field:silver,type: numericColumn,filter: agNumberColumnFilter ;
field:bronze,type: numericColumn,filter: agNumberColumnFilter ;
field:total,type: numericColumn,filter: agNumberColumnFilter ;
', 'Olympic winners (Error in QUERY)', 'Errors', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (18, 'v_history_lastMonth_ro', 'bd/daas_nma/jsonPG/v_history/ and  date(write_date)>=cast(TO_CHAR(NOW(), ''yyyy-mm-01'')as date) order by id desc', 'field:id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:noiseparty_tag;
field:description;
field:write_date,filter: agDateColumnFilter ;
field:info,width:360;
field:record_id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:user_mail,width:80;
field:android_id,width:80;
field:car_plate;
field:user_country,width:60;
field:address,width:80;
field:person_name;
field:phone;
field:town;
field:car_brand;
field:car_model;
field:car_country;
field:car_type;
field:car_manuf_year,type: numericColumn,filter: agNumberColumnFilter ;
field:record_utc,type: numericColumn,filter: agNumberColumnFilter ;
field:tags;
field:company;
', 'History Rednois Current month', 'SOUNDPROOFING', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (76, 'v_history_last50_ro', 'bd/daas_nma/jsonPG/v_history/ order by id desc limit 50', 'field:id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:noiseparty_tag;
field:description;
field:write_date,filter: agDateColumnFilter ;
field:info,width:360;
field:record_id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:user_mail,width:80;
field:android_id,width:80;
field:car_plate;
field:user_country,width:60;
field:address,width:80;
field:person_name;
field:phone;
field:town;
field:car_brand;
field:car_model;
field:car_country;
field:car_type;
field:car_manuf_year,type: numericColumn,filter: agNumberColumnFilter ;
field:record_utc,type: numericColumn,filter: agNumberColumnFilter ;
field:tags;
field:company;
', 'History Rednois(last 50)', 'SOUNDPROOFING', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (20, '--v_history_lastMonth2_ro', 'bd/daas_nma/jsonPG/v_history/ and  date(write_date)>=cast(extract(year from NOW())||''-''||extract(month from NOW())||''-01'' as date) order by id desc', 'field:id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:noiseparty_tag;
field:description;
field:write_date,filter: agDateColumnFilter ;
field:info;
field:record_id,type: numericColumn,filter: agNumberColumnFilter,width:80 ;
field:user_mail;
field:android_id;
field:car_plate;
field:user_country;
field:address;
field:person_name;
field:phone;
field:town;
field:car_brand;
field:car_model;
field:car_country;
field:car_type;
field:car_manuf_year,type: numericColumn,filter: agNumberColumnFilter ;
field:record_utc,type: numericColumn,filter: agNumberColumnFilter ;
field:tags;
field:company;
', 'History Rednois Current month2', 'SOUNDPROOFING', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (8, '--feed_list_table', 'bd/QUERY_BD/jsonPG/list_table', '', ' Tables ALL list', 'Feed (querym)', 'SELECT table_name--,table_type
FROM information_schema.tables
where table_schema = ''public''
and table_type = ''BASE TABLE''
order by 1');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (4, '---feedsByPerson', 'bd/QUERY_BD/jsonPG/v_feeds/ and person_id = {id}', 'field:feed_id,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_type,cellEditor : agSelectCellEditor, 
cellEditorParams:v_feed_type;
field:feed_name;
field:feed_price,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_date,filter: agDateColumnFilter ;
field:write_date,filter: agDateColumnFilter ;
field:write_user;
field:android_id;
field:state,type: numericColumn,filter: agNumberColumnFilter ;
', 'Foods by person {person_name} not work', 'Feed (querym)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (13, 'foods_by_person', 'bd/QUERY_BD/jsonPG/v_foods/and  person_id = {id}', 'field:food_id,type: numericColumn,filter: agNumberColumnFilter ;
field:person_id,type: numericColumn,filter: agNumberColumnFilter ;
field:feed_id,type: numericColumn,filter: agNumberColumnFilter ;
field:food_qty,type: numericColumn,filter: agNumberColumnFilter ;
field:food_amount,type: numericColumn,filter: agNumberColumnFilter ;
field:food_date,filter: agDateColumnFilter ;
field:write_date,filter: agDateColumnFilter ;
field:write_user;
field:android_id;
field:state;
field:food_price,type: numericColumn,filter: agNumberColumnFilter ;', 'foods by  {person_name}  *', 'Feed (querym)', NULL);
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (1, 'anymal_table_name', 'bd/animal/jsonPG/{table_name_}', '', ' Table  {table_name_}', 'Big Animal (PGSQL)', 'select * from {table_name_}  -- limit 1 OFFSET 2987');
INSERT INTO public.querys (id, name, query, columns, heading, submenu, sql) VALUES (7, '--feed_table_name', 'bd/QUERY_BD/jsonPG/{table_name_}', '', ' Table  {table_name_}', 'Feed (querym)', 'select * from {table_name_}  -- limit 1 OFFSET 2987');


--
-- TOC entry 5403 (class 0 OID 18627)
-- Dependencies: 224
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5602 (class 0 OID 0)
-- Dependencies: 257
-- Name: etsy_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joqivmzw
--

SELECT pg_catalog.setval('public.etsy_info_id_seq', 1, false);


--
-- TOC entry 5603 (class 0 OID 0)
-- Dependencies: 245
-- Name: fd_feeds_feed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joqivmzw
--

SELECT pg_catalog.setval('public.fd_feeds_feed_id_seq', 503, true);


--
-- TOC entry 5604 (class 0 OID 0)
-- Dependencies: 248
-- Name: fd_foods_food_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joqivmzw
--

SELECT pg_catalog.setval('public.fd_foods_food_id_seq', 700, true);


--
-- TOC entry 5605 (class 0 OID 0)
-- Dependencies: 242
-- Name: fd_persons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joqivmzw
--

SELECT pg_catalog.setval('public.fd_persons_id_seq', 803, true);


--
-- TOC entry 5606 (class 0 OID 0)
-- Dependencies: 238
-- Name: querys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joqivmzw
--

SELECT pg_catalog.setval('public.querys_id_seq', 22, true);


--
-- TOC entry 5413 (class 2606 OID 5621581)
-- Name: querys books_pkey; Type: CONSTRAINT; Schema: public; Owner: joqivmzw
--

ALTER TABLE ONLY public.querys
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- TOC entry 5421 (class 2606 OID 5631970)
-- Name: etsy_info etsy_info_pkey; Type: CONSTRAINT; Schema: public; Owner: joqivmzw
--

ALTER TABLE ONLY public.etsy_info
    ADD CONSTRAINT etsy_info_pkey PRIMARY KEY (id);


--
-- TOC entry 5417 (class 2606 OID 5621902)
-- Name: fd_feeds fd_feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: joqivmzw
--

ALTER TABLE ONLY public.fd_feeds
    ADD CONSTRAINT fd_feeds_pkey PRIMARY KEY (feed_id);


--
-- TOC entry 5419 (class 2606 OID 5621917)
-- Name: fd_foods fd_foods_pkey; Type: CONSTRAINT; Schema: public; Owner: joqivmzw
--

ALTER TABLE ONLY public.fd_foods
    ADD CONSTRAINT fd_foods_pkey PRIMARY KEY (food_id);


--
-- TOC entry 5415 (class 2606 OID 5621865)
-- Name: fd_persons fd_persons_pkey; Type: CONSTRAINT; Schema: public; Owner: joqivmzw
--

ALTER TABLE ONLY public.fd_persons
    ADD CONSTRAINT fd_persons_pkey PRIMARY KEY (id);


--
-- TOC entry 5422 (class 2606 OID 5621918)
-- Name: fd_foods foods_feed_id; Type: FK CONSTRAINT; Schema: public; Owner: joqivmzw
--

ALTER TABLE ONLY public.fd_foods
    ADD CONSTRAINT foods_feed_id FOREIGN KEY (feed_id) REFERENCES public.fd_feeds(feed_id);


--
-- TOC entry 5423 (class 2606 OID 5621923)
-- Name: fd_foods foods_person_id; Type: FK CONSTRAINT; Schema: public; Owner: joqivmzw
--

ALTER TABLE ONLY public.fd_foods
    ADD CONSTRAINT foods_person_id FOREIGN KEY (person_id) REFERENCES public.fd_persons(id);


-- Completed on 2023-02-08 14:03:46

--
-- PostgreSQL database dump complete
--

