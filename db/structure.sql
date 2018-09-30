--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.9
-- Dumped by pg_dump version 9.6.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: haves_set_created_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.haves_set_created_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$        BEGIN
          IF (TG_OP = 'UPDATE') THEN
            NEW."created_at" := OLD."created_at";
          ELSIF (TG_OP = 'INSERT') THEN
            NEW."created_at" := CURRENT_TIMESTAMP;
          END IF;
          RETURN NEW;
        END;
$$;


--
-- Name: haves_set_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.haves_set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$        BEGIN
          NEW."updated_at" := CURRENT_TIMESTAMP;
          RETURN NEW;
        END;
$$;


--
-- Name: o_auth_authentications_set_created_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.o_auth_authentications_set_created_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$        BEGIN
          IF (TG_OP = 'UPDATE') THEN
            NEW."created_at" := OLD."created_at";
          ELSIF (TG_OP = 'INSERT') THEN
            NEW."created_at" := CURRENT_TIMESTAMP;
          END IF;
          RETURN NEW;
        END;
$$;


--
-- Name: o_auth_authentications_set_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.o_auth_authentications_set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$        BEGIN
          NEW."updated_at" := CURRENT_TIMESTAMP;
          RETURN NEW;
        END;
$$;


--
-- Name: users_set_created_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.users_set_created_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$        BEGIN
          IF (TG_OP = 'UPDATE') THEN
            NEW."created_at" := OLD."created_at";
          ELSIF (TG_OP = 'INSERT') THEN
            NEW."created_at" := CURRENT_TIMESTAMP;
          END IF;
          RETURN NEW;
        END;
$$;


--
-- Name: users_set_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.users_set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$        BEGIN
          NEW."updated_at" := CURRENT_TIMESTAMP;
          RETURN NEW;
        END;
$$;


--
-- Name: wants_set_created_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.wants_set_created_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$        BEGIN
          IF (TG_OP = 'UPDATE') THEN
            NEW."created_at" := OLD."created_at";
          ELSIF (TG_OP = 'INSERT') THEN
            NEW."created_at" := CURRENT_TIMESTAMP;
          END IF;
          RETURN NEW;
        END;
$$;


--
-- Name: wants_set_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.wants_set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$        BEGIN
          NEW."updated_at" := CURRENT_TIMESTAMP;
          RETURN NEW;
        END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: haves; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.haves (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    amount integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id uuid
);


--
-- Name: o_auth_authentications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.o_auth_authentications (
    id integer NOT NULL,
    provider_uid text NOT NULL,
    provider_name text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    user_id uuid
);


--
-- Name: o_auth_authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.o_auth_authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: o_auth_authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.o_auth_authentications_id_seq OWNED BY public.o_auth_authentications.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    filename text NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wants (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    amount integer DEFAULT 1 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id uuid
);


--
-- Name: o_auth_authentications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.o_auth_authentications ALTER COLUMN id SET DEFAULT nextval('public.o_auth_authentications_id_seq'::regclass);


--
-- Name: haves haves_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.haves
    ADD CONSTRAINT haves_pkey PRIMARY KEY (id);


--
-- Name: o_auth_authentications o_auth_authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.o_auth_authentications
    ADD CONSTRAINT o_auth_authentications_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wants wants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wants
    ADD CONSTRAINT wants_pkey PRIMARY KEY (id);


--
-- Name: o_auth_authentications_provider_uid_provider_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX o_auth_authentications_provider_uid_provider_name_index ON public.o_auth_authentications USING btree (provider_uid, provider_name);


--
-- Name: users set_created_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_created_at BEFORE INSERT OR UPDATE ON public.users FOR EACH ROW EXECUTE PROCEDURE public.users_set_created_at();


--
-- Name: o_auth_authentications set_created_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_created_at BEFORE INSERT OR UPDATE ON public.o_auth_authentications FOR EACH ROW EXECUTE PROCEDURE public.o_auth_authentications_set_created_at();


--
-- Name: wants set_created_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_created_at BEFORE INSERT OR UPDATE ON public.wants FOR EACH ROW EXECUTE PROCEDURE public.wants_set_created_at();


--
-- Name: haves set_created_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_created_at BEFORE INSERT OR UPDATE ON public.haves FOR EACH ROW EXECUTE PROCEDURE public.haves_set_created_at();


--
-- Name: users set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_updated_at BEFORE INSERT OR UPDATE ON public.users FOR EACH ROW EXECUTE PROCEDURE public.users_set_updated_at();


--
-- Name: o_auth_authentications set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_updated_at BEFORE INSERT OR UPDATE ON public.o_auth_authentications FOR EACH ROW EXECUTE PROCEDURE public.o_auth_authentications_set_updated_at();


--
-- Name: wants set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_updated_at BEFORE INSERT OR UPDATE ON public.wants FOR EACH ROW EXECUTE PROCEDURE public.wants_set_updated_at();


--
-- Name: haves set_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER set_updated_at BEFORE INSERT OR UPDATE ON public.haves FOR EACH ROW EXECUTE PROCEDURE public.haves_set_updated_at();


--
-- Name: haves haves_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.haves
    ADD CONSTRAINT haves_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: o_auth_authentications o_auth_authentications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.o_auth_authentications
    ADD CONSTRAINT o_auth_authentications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: wants wants_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wants
    ADD CONSTRAINT wants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;
INSERT INTO "schema_migrations" ("filename") VALUES ('20180803000000_enable_uuid_ossp.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180803002754_create_users.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180803002754_users_auto_timestamps.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180803011611_create_o_auth_authentications.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180803011612_authentications_auto_timestamps.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180809131546_create_wants.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180809131546_wants_auto_timestamps.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180818040413_create_haves.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20180818040415_haves_auto_timestamps.rb');