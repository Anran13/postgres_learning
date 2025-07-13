-- public.station_number definition

-- Drop table

-- DROP TABLE public.station_number;

CREATE TABLE public.station_number (
	"Date" date NULL,
	"staCode" int4 NULL,
	"gateInComingCnt" int4 NULL,
	"gateOutGoingCnt" int4 NULL
);


-- public.station_number foreign keys

ALTER TABLE public.station_number ADD CONSTRAINT "station_number_staCode_fkey" FOREIGN KEY ("staCode") REFERENCES public.台鐵車站資訊("stationCode");
