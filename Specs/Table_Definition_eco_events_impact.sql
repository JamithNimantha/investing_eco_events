CREATE TABLE public.eco_events_impact
(
    event_name character varying(125) COLLATE pg_catalog."default" NOT NULL,
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
    symbol_11 character varying(20) COLLATE pg_catalog."default",
    symbol_12 character varying(20) COLLATE pg_catalog."default",
    symbol_13 character varying(20) COLLATE pg_catalog."default",
    symbol_14 character varying(20) COLLATE pg_catalog."default",
    symbol_15 character varying(20) COLLATE pg_catalog."default",
    url character varying(100) COLLATE pg_catalog."default",
    no_actual boolean,
    CONSTRAINT eco_events_impact_pkey PRIMARY KEY (event_name)
)

TABLESPACE pg_default;

ALTER TABLE public.eco_events_impact
    OWNER to postgres;