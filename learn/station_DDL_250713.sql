DROP TABLE IF EXISTS station_info, station_number CASCADE;
-- public.台鐵車站資訊 definition

-- Drop table

-- DROP TABLE public.台鐵車站資訊;

CREATE TABLE public.station_info (
	"stationCode" int4 NOT NULL,
	"stationName" varchar(50) NULL,
	"name" varchar(50) NULL,
	"stationAddrTw" varchar(50) NULL,
	"stationTel" varchar(50) NULL,
	gps varchar(50) NULL,
	"haveBike" varchar(50) NULL,
	CONSTRAINT station_info_pkey PRIMARY KEY ("stationCode")
);


-- public.station_number definition

-- Drop table

-- DROP TABLE public.station_number;

CREATE TABLE public.station_number (
	"Date" date NULL,
	"staCode" int4 NULL,
	"gateInComingCnt" int4 NULL,
	"gateOutGoingCnt" int4 NULL,
	CONSTRAINT "station_number_staCode_fkey" FOREIGN KEY ("staCode") REFERENCES public.station_info("stationCode")
);

