CREATE TABLE public.news_headlines
(
    entry_id bigint NOT NULL DEFAULT nextval('news_headlines_entry_id_seq'::regclass),
    entry_date date,
    distributor_code character varying(10) COLLATE pg_catalog."default",
    story_id numeric(30,0),
    "timestamp" timestamp(4) without time zone,
    headline character varying(250) COLLATE pg_catalog."default",
    symbol_1 character varying(20) COLLATE pg_catalog."default",
    symbol_2 character varying(20) COLLATE pg_catalog."default",
    symbol_3 character varying(20) COLLATE pg_catalog."default",
    symbol_4 character varying(20) COLLATE pg_catalog."default",
    symbol_5 character varying(20) COLLATE pg_catalog."default",
    symbol_6 character varying(20) COLLATE pg_catalog."default",
    symbol_7 character varying(20) COLLATE pg_catalog."default",
    symbol_8 character varying(20) COLLATE pg_catalog."default",
    symbol_9 character varying(20) COLLATE pg_catalog."default",
    symbol_10 character varying(20) COLLATE pg_catalog."default",
    url character varying(500) COLLATE pg_catalog."default",
    symbol_11 character varying(20) COLLATE pg_catalog."default",
    symbol_12 character varying(20) COLLATE pg_catalog."default",
    symbol_13 character varying(20) COLLATE pg_catalog."default",
    symbol_14 character varying(20) COLLATE pg_catalog."default",
    symbol_15 character varying(20) COLLATE pg_catalog."default",
    entry_time time without time zone,
    CONSTRAINT news_headlines_pkey PRIMARY KEY (entry_id)
)

TABLESPACE pg_default;

ALTER TABLE public.news_headlines
    OWNER to postgres;

CREATE INDEX idx_news_headlines_entrydate
    ON public.news_headlines USING btree
    (entry_date DESC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_news_headlines_story_id
    ON public.news_headlines USING btree
    (story_id DESC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_1
    ON public.news_headlines USING btree
    (symbol_1 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_10
    ON public.news_headlines USING btree
    (symbol_10 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_11
    ON public.news_headlines USING btree
    (symbol_11 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_12
    ON public.news_headlines USING btree
    (symbol_12 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_13
    ON public.news_headlines USING btree
    (symbol_13 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_14
    ON public.news_headlines USING btree
    (symbol_14 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_15
    ON public.news_headlines USING btree
    (symbol_15 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_2
    ON public.news_headlines USING btree
    (symbol_2 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_3
    ON public.news_headlines USING btree
    (symbol_3 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_4
    ON public.news_headlines USING btree
    (symbol_4 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_5
    ON public.news_headlines USING btree
    (symbol_5 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_6
    ON public.news_headlines USING btree
    (symbol_6 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_7
    ON public.news_headlines USING btree
    (symbol_7 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_8
    ON public.news_headlines USING btree
    (symbol_8 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX idx_symbol_9
    ON public.news_headlines USING btree
    (symbol_9 COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;