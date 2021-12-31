CREATE TABLE public.eco_events
(
    event_date date NOT NULL,
    event_time time without time zone NOT NULL,
    event_name character varying(125) COLLATE pg_catalog."default" NOT NULL,
    importance smallint,
    actual numeric(20,4),
    forecast numeric(20,4),
    previuos numeric(20,4),
    actual_forecast numeric(10,4),
    actual_previous numeric(10,4),
    update_date date,
    update_time time without time zone,
    CONSTRAINT eco_events_pkey PRIMARY KEY (event_date, event_time, event_name)
)

TABLESPACE pg_default;

ALTER TABLE public.eco_events
    OWNER to postgres;