--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12rc1

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
-- Name: arsiv_tarih(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.arsiv_tarih() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE

BEGIN

    UPDATE "ArsivSoru" SET arsivTarih = CURRENT_DATE WHERE "SoruNo" = NEW."SoruNo";

    RETURN NEW;
END;

$$;


ALTER FUNCTION public.arsiv_tarih() OWNER TO postgres;

--
-- Name: etiket_temizle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.etiket_temizle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."etiketAd" = LTRIM(NEW."etiketAd");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.etiket_temizle() OWNER TO postgres;

--
-- Name: ililce_lis(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ililce_lis() RETURNS void
    LANGUAGE sql
    AS $$
	 SELECT "icerik","soruİcerik"  FROM "Soru" INNER JOIN "Cevap" ON "Soru"."soruNo" =  "Cevap"."SoruNo"
	$$;


ALTER FUNCTION public.ililce_lis() OWNER TO postgres;

--
-- Name: rozet_adi_buyult(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rozet_adi_buyult() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."rozetAd" = UPPER(NEW."rozetAd");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.rozet_adi_buyult() OWNER TO postgres;

--
-- Name: soru_listele(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.soru_listele()
    LANGUAGE plpgsql
    AS $$
	 DECLARE BEGIN
	 SELECT * FROM Soru;
	END; 
	$$;


ALTER PROCEDURE public.soru_listele() OWNER TO postgres;

--
-- Name: toplam_cevap_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplam_cevap_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	a integer;
BEGIN
   SELECT count(*) into a FROM "Cevap";
   RETURN a;
END;
$$;


ALTER FUNCTION public.toplam_cevap_sayisi() OWNER TO postgres;

--
-- Name: toplam_soru_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplam_soru_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	a integer;
BEGIN
   SELECT count(*) into a FROM "Soru";
   RETURN a;
END;
$$;


ALTER FUNCTION public.toplam_soru_sayisi() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AktifSoru; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AktifSoru" (
    "soruNo" integer NOT NULL,
    "odulDurum" character varying(2044) NOT NULL
);


ALTER TABLE public."AktifSoru" OWNER TO postgres;

--
-- Name: AktifSoru_soruNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AktifSoru_soruNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AktifSoru_soruNo_seq" OWNER TO postgres;

--
-- Name: AktifSoru_soruNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AktifSoru_soruNo_seq" OWNED BY public."AktifSoru"."soruNo";


--
-- Name: ArsivSoru; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ArsivSoru" (
    "SoruNo" integer NOT NULL,
    "arsivTarih" date NOT NULL
);


ALTER TABLE public."ArsivSoru" OWNER TO postgres;

--
-- Name: ArsivSoru_SoruNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ArsivSoru_SoruNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ArsivSoru_SoruNo_seq" OWNER TO postgres;

--
-- Name: ArsivSoru_SoruNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ArsivSoru_SoruNo_seq" OWNED BY public."ArsivSoru"."SoruNo";


--
-- Name: Basarim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Basarim" (
    "BasarimNo" integer NOT NULL,
    "BasarimAd" character varying(2044) NOT NULL
);


ALTER TABLE public."Basarim" OWNER TO postgres;

--
-- Name: BasarimKazanim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BasarimKazanim" (
    no integer NOT NULL,
    "kullanicNO" integer NOT NULL,
    "basarimNo" integer NOT NULL,
    "KazanimTarihi" date NOT NULL
);


ALTER TABLE public."BasarimKazanim" OWNER TO postgres;

--
-- Name: BasarimKazanim_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."BasarimKazanim_no_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."BasarimKazanim_no_seq" OWNER TO postgres;

--
-- Name: BasarimKazanim_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."BasarimKazanim_no_seq" OWNED BY public."BasarimKazanim".no;


--
-- Name: Basarim_BasarimNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Basarim_BasarimNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Basarim_BasarimNo_seq" OWNER TO postgres;

--
-- Name: Basarim_BasarimNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Basarim_BasarimNo_seq" OWNED BY public."Basarim"."BasarimNo";


--
-- Name: Cevap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cevap" (
    "cevapNo" integer NOT NULL,
    "SoruNo" integer NOT NULL,
    "KullaniciNo" integer NOT NULL,
    icerik text NOT NULL,
    "verilmeTarihi" date,
    "oyPuani" integer
);


ALTER TABLE public."Cevap" OWNER TO postgres;

--
-- Name: CevapEditOneri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CevapEditOneri" (
    no integer NOT NULL,
    "SoruNo" integer NOT NULL,
    "CevapNo" integer NOT NULL,
    "KullaniciNo" integer NOT NULL,
    icerik text NOT NULL
);


ALTER TABLE public."CevapEditOneri" OWNER TO postgres;

--
-- Name: CevapEditOneri_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CevapEditOneri_no_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."CevapEditOneri_no_seq" OWNER TO postgres;

--
-- Name: CevapEditOneri_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CevapEditOneri_no_seq" OWNED BY public."CevapEditOneri".no;


--
-- Name: Cevap_cevapNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Cevap_cevapNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Cevap_cevapNo_seq" OWNER TO postgres;

--
-- Name: Cevap_cevapNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Cevap_cevapNo_seq" OWNED BY public."Cevap"."cevapNo";


--
-- Name: Etiket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Etiket" (
    "etiketNo" integer NOT NULL,
    "etiketAd" character varying(2044) NOT NULL,
    "SoruSayisi" integer NOT NULL
);


ALTER TABLE public."Etiket" OWNER TO postgres;

--
-- Name: EtiketGozlem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."EtiketGozlem" (
    no integer NOT NULL,
    "KullanicNo" integer NOT NULL,
    "EtiketNo" integer NOT NULL,
    "gozlemTuru" integer NOT NULL
);


ALTER TABLE public."EtiketGozlem" OWNER TO postgres;

--
-- Name: EtiketGozlem_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."EtiketGozlem_no_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."EtiketGozlem_no_seq" OWNER TO postgres;

--
-- Name: EtiketGozlem_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."EtiketGozlem_no_seq" OWNED BY public."EtiketGozlem".no;


--
-- Name: Etiket_SoruSayisi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Etiket_SoruSayisi_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Etiket_SoruSayisi_seq" OWNER TO postgres;

--
-- Name: Etiket_SoruSayisi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Etiket_SoruSayisi_seq" OWNED BY public."Etiket"."SoruSayisi";


--
-- Name: Etiket_etiketNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Etiket_etiketNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Etiket_etiketNo_seq" OWNER TO postgres;

--
-- Name: Etiket_etiketNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Etiket_etiketNo_seq" OWNED BY public."Etiket"."etiketNo";


--
-- Name: KullaniciHesabı; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KullaniciHesabı" (
    "kullaniciNo" integer NOT NULL,
    email character varying(2044) NOT NULL,
    sifre character varying(2044) NOT NULL,
    "kayıtTarihi" date NOT NULL
);


ALTER TABLE public."KullaniciHesabı" OWNER TO postgres;

--
-- Name: KullaniciHesabı_kullaniciNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."KullaniciHesabı_kullaniciNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."KullaniciHesabı_kullaniciNo_seq" OWNER TO postgres;

--
-- Name: KullaniciHesabı_kullaniciNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."KullaniciHesabı_kullaniciNo_seq" OWNED BY public."KullaniciHesabı"."kullaniciNo";


--
-- Name: Moderator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Moderator" (
    "KullaniciNo" integer NOT NULL,
    "moderatorNo" integer NOT NULL
);


ALTER TABLE public."Moderator" OWNER TO postgres;

--
-- Name: Rozet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rozet" (
    "rozetNo" integer NOT NULL,
    "rozetAd" character varying(2044) NOT NULL,
    "Rozetturu" character varying(2044) NOT NULL
);


ALTER TABLE public."Rozet" OWNER TO postgres;

--
-- Name: RozetKazanim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RozetKazanim" (
    no integer NOT NULL,
    "Kullanicino" integer NOT NULL,
    "RozetNo" integer NOT NULL,
    "KazanimTarihi" date NOT NULL
);


ALTER TABLE public."RozetKazanim" OWNER TO postgres;

--
-- Name: RozetKazanim_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."RozetKazanim_no_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."RozetKazanim_no_seq" OWNER TO postgres;

--
-- Name: RozetKazanim_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."RozetKazanim_no_seq" OWNED BY public."RozetKazanim".no;


--
-- Name: Rozet_rozetNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rozet_rozetNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Rozet_rozetNo_seq" OWNER TO postgres;

--
-- Name: Rozet_rozetNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rozet_rozetNo_seq" OWNED BY public."Rozet"."rozetNo";


--
-- Name: Soru; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Soru" (
    "soruNo" integer NOT NULL,
    "kullaniciNo" integer NOT NULL,
    "acilmaTarih" date,
    "etiketNo" integer,
    "gorulmeSayisi" integer NOT NULL,
    "oyPuani" integer,
    "soruİcerik" text NOT NULL
);


ALTER TABLE public."Soru" OWNER TO postgres;

--
-- Name: SoruEditOneri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SoruEditOneri" (
    no integer NOT NULL,
    "SoruNo" integer NOT NULL,
    "KullaniciNo" integer NOT NULL,
    icerik text NOT NULL
);


ALTER TABLE public."SoruEditOneri" OWNER TO postgres;

--
-- Name: SoruEditOneri_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."SoruEditOneri_no_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SoruEditOneri_no_seq" OWNER TO postgres;

--
-- Name: SoruEditOneri_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."SoruEditOneri_no_seq" OWNED BY public."SoruEditOneri".no;


--
-- Name: SoruEtiketi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SoruEtiketi" (
    "SoruNo" integer NOT NULL,
    "EtiketNo" integer NOT NULL
);


ALTER TABLE public."SoruEtiketi" OWNER TO postgres;

--
-- Name: Soru_soruNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Soru_soruNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Soru_soruNo_seq" OWNER TO postgres;

--
-- Name: Soru_soruNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Soru_soruNo_seq" OWNED BY public."Soru"."soruNo";


--
-- Name: Topluluk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Topluluk" (
    "toplulukNo" integer NOT NULL,
    "toplulukAd" character varying(2044) NOT NULL,
    "toplulukUyeSayisi" integer NOT NULL
);


ALTER TABLE public."Topluluk" OWNER TO postgres;

--
-- Name: ToplulukUye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ToplulukUye" (
    no integer NOT NULL,
    "kullaniciNo" integer NOT NULL,
    "toplulukNo" integer NOT NULL,
    "katilimTarihi" date NOT NULL
);


ALTER TABLE public."ToplulukUye" OWNER TO postgres;

--
-- Name: ToplulukUye_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ToplulukUye_no_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ToplulukUye_no_seq" OWNER TO postgres;

--
-- Name: ToplulukUye_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ToplulukUye_no_seq" OWNED BY public."ToplulukUye".no;


--
-- Name: Topluluk_toplulukNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Topluluk_toplulukNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Topluluk_toplulukNo_seq" OWNER TO postgres;

--
-- Name: Topluluk_toplulukNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Topluluk_toplulukNo_seq" OWNED BY public."Topluluk"."toplulukNo";


--
-- Name: YasaklıKullanıcı; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."YasaklıKullanıcı" (
    "kullaniciNo" integer NOT NULL,
    "yasaklanmaTarih" date NOT NULL,
    sure character varying(2044) NOT NULL,
    gerekce character varying(2044) NOT NULL,
    "modNo" integer NOT NULL
);


ALTER TABLE public."YasaklıKullanıcı" OWNER TO postgres;

--
-- Name: aktifKullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."aktifKullanici" (
    "KullaniciNo" integer NOT NULL,
    "aktifEditOneri" character varying(2044) NOT NULL
);


ALTER TABLE public."aktifKullanici" OWNER TO postgres;

--
-- Name: aktifKullanici_KullaniciNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."aktifKullanici_KullaniciNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."aktifKullanici_KullaniciNo_seq" OWNER TO postgres;

--
-- Name: aktifKullanici_KullaniciNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."aktifKullanici_KullaniciNo_seq" OWNED BY public."aktifKullanici"."KullaniciNo";


--
-- Name: AktifSoru soruNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AktifSoru" ALTER COLUMN "soruNo" SET DEFAULT nextval('public."AktifSoru_soruNo_seq"'::regclass);


--
-- Name: ArsivSoru SoruNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ArsivSoru" ALTER COLUMN "SoruNo" SET DEFAULT nextval('public."ArsivSoru_SoruNo_seq"'::regclass);


--
-- Name: Basarim BasarimNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Basarim" ALTER COLUMN "BasarimNo" SET DEFAULT nextval('public."Basarim_BasarimNo_seq"'::regclass);


--
-- Name: BasarimKazanim no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BasarimKazanim" ALTER COLUMN no SET DEFAULT nextval('public."BasarimKazanim_no_seq"'::regclass);


--
-- Name: Cevap cevapNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cevap" ALTER COLUMN "cevapNo" SET DEFAULT nextval('public."Cevap_cevapNo_seq"'::regclass);


--
-- Name: CevapEditOneri no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CevapEditOneri" ALTER COLUMN no SET DEFAULT nextval('public."CevapEditOneri_no_seq"'::regclass);


--
-- Name: Etiket etiketNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Etiket" ALTER COLUMN "etiketNo" SET DEFAULT nextval('public."Etiket_etiketNo_seq"'::regclass);


--
-- Name: EtiketGozlem no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EtiketGozlem" ALTER COLUMN no SET DEFAULT nextval('public."EtiketGozlem_no_seq"'::regclass);


--
-- Name: KullaniciHesabı kullaniciNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KullaniciHesabı" ALTER COLUMN "kullaniciNo" SET DEFAULT nextval('public."KullaniciHesabı_kullaniciNo_seq"'::regclass);


--
-- Name: Rozet rozetNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rozet" ALTER COLUMN "rozetNo" SET DEFAULT nextval('public."Rozet_rozetNo_seq"'::regclass);


--
-- Name: RozetKazanim no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RozetKazanim" ALTER COLUMN no SET DEFAULT nextval('public."RozetKazanim_no_seq"'::regclass);


--
-- Name: Soru soruNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Soru" ALTER COLUMN "soruNo" SET DEFAULT nextval('public."Soru_soruNo_seq"'::regclass);


--
-- Name: SoruEditOneri no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SoruEditOneri" ALTER COLUMN no SET DEFAULT nextval('public."SoruEditOneri_no_seq"'::regclass);


--
-- Name: Topluluk toplulukNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Topluluk" ALTER COLUMN "toplulukNo" SET DEFAULT nextval('public."Topluluk_toplulukNo_seq"'::regclass);


--
-- Name: ToplulukUye no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ToplulukUye" ALTER COLUMN no SET DEFAULT nextval('public."ToplulukUye_no_seq"'::regclass);


--
-- Name: aktifKullanici KullaniciNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."aktifKullanici" ALTER COLUMN "KullaniciNo" SET DEFAULT nextval('public."aktifKullanici_KullaniciNo_seq"'::regclass);


--
-- Data for Name: AktifSoru; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."AktifSoru" VALUES
	(1, 'Yok'),
	(2, 'Az kaldı');


--
-- Data for Name: ArsivSoru; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ArsivSoru" VALUES
	(3, '2020-08-06');


--
-- Data for Name: Basarim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Basarim" VALUES
	(1, 'Yeni Üye'),
	(2, 'Başarılı Üye'),
	(3, 'Yardımsever Üye');


--
-- Data for Name: BasarimKazanim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."BasarimKazanim" VALUES
	(1, 1, 1, '2011-05-05');


--
-- Data for Name: Cevap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Cevap" VALUES
	(2, 2, 2, 'keltr21.dll yi yükle', '2018-08-08', 8),
	(3, 3, 1, 'Bilmiyorum', '2019-09-09', 0),
	(1, 1, 4, 'banane', '2017-07-07', 0),
	(5, 4, 3, 'Yeniden Başlatı', '2020-10-10', 2),
	(7, 15, 1, '', NULL, NULL),
	(8, 15, 1, '', NULL, NULL),
	(9, 15, 1, 'güncel 9 no', NULL, NULL);


--
-- Data for Name: CevapEditOneri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."CevapEditOneri" VALUES
	(2, 1, 1, 4, 'Deneme');


--
-- Data for Name: Etiket; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Etiket" VALUES
	(1, '#yeni', 20),
	(2, '#Sakarya', 50);


--
-- Data for Name: EtiketGozlem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."EtiketGozlem" VALUES
	(1, 5, 1, 3),
	(2, 6, 2, 6);


--
-- Data for Name: KullaniciHesabı; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KullaniciHesabı" VALUES
	(1, 'i.yildirim@gmail.com', '123', '2010-05-05'),
	(2, 'e.emlek@gmail.com', '321', '2010-06-06'),
	(3, 'e.calis@@Gmail.com', '213', '2010-07-07'),
	(4, 'e.yazicioglu@gmail.com', '231', '2010-08-08'),
	(5, 'g.dincel@gmail.com', '123', '2010-09-09'),
	(6, 'o.zubaroglu@gmail.com', '321', '2010-10-10'),
	(0, '0', '0', '1900-01-01');


--
-- Data for Name: Moderator; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Moderator" VALUES
	(1, 1),
	(2, 2);


--
-- Data for Name: Rozet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Rozet" VALUES
	(1, 'Çılgın', 'İyi'),
	(2, 'Askeri', 'iyi');


--
-- Data for Name: RozetKazanim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."RozetKazanim" VALUES
	(1, 3, 1, '2013-05-05'),
	(3, 4, 2, '2014-05-05');


--
-- Data for Name: Soru; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Soru" VALUES
	(1, 2, '2015-05-05', 2, 150, 4, 'Bilgisayarım Kasıyor'),
	(3, 6, '2015-07-07', 1, 125, 8, 'Mavi Ekran Yedim'),
	(4, 3, '2013-04-04', 1, 100, 5, 'Bağlantı Hatası'),
	(2, 4, '2015-06-06', 1, 100, 3, 'çalışıyor'),
	(5, 4, '2020-08-07', 1, 82, 10, 'bilmem çalıştı mı'),
	(15, 1, NULL, NULL, 85, NULL, '2 kelime');


--
-- Data for Name: SoruEditOneri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."SoruEditOneri" VALUES
	(1, 1, 5, 'Sevilmeyen içerik'),
	(6, 2, 6, 'Az Sevilen İçerik');


--
-- Data for Name: SoruEtiketi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."SoruEtiketi" VALUES
	(1, 1),
	(2, 2);


--
-- Data for Name: Topluluk; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Topluluk" VALUES
	(1, 'Öğrenciler', 6);


--
-- Data for Name: ToplulukUye; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ToplulukUye" VALUES
	(1, 1, 1, '2010-10-10'),
	(2, 2, 1, '2010-10-10'),
	(3, 3, 1, '2010-10-10'),
	(1, 4, 1, '2010-10-10'),
	(2, 5, 1, '2010-10-10'),
	(3, 6, 1, '2010-10-10');


--
-- Data for Name: YasaklıKullanıcı; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."YasaklıKullanıcı" VALUES
	(3, '2015-05-05', '999999999999 gün', 'Admine Hakaret', 1);


--
-- Data for Name: aktifKullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."aktifKullanici" VALUES
	(4, 'Düzenleme1'),
	(5, 'Düzenleme2'),
	(6, 'Düzenleme3');


--
-- Name: AktifSoru_soruNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AktifSoru_soruNo_seq"', 1, false);


--
-- Name: ArsivSoru_SoruNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ArsivSoru_SoruNo_seq"', 1, false);


--
-- Name: BasarimKazanim_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."BasarimKazanim_no_seq"', 1, true);


--
-- Name: Basarim_BasarimNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Basarim_BasarimNo_seq"', 3, true);


--
-- Name: CevapEditOneri_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CevapEditOneri_no_seq"', 2, true);


--
-- Name: Cevap_cevapNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cevap_cevapNo_seq"', 9, true);


--
-- Name: EtiketGozlem_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."EtiketGozlem_no_seq"', 2, true);


--
-- Name: Etiket_SoruSayisi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Etiket_SoruSayisi_seq"', 1, false);


--
-- Name: Etiket_etiketNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Etiket_etiketNo_seq"', 2, true);


--
-- Name: KullaniciHesabı_kullaniciNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."KullaniciHesabı_kullaniciNo_seq"', 5, true);


--
-- Name: RozetKazanim_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."RozetKazanim_no_seq"', 3, true);


--
-- Name: Rozet_rozetNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rozet_rozetNo_seq"', 2, true);


--
-- Name: SoruEditOneri_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."SoruEditOneri_no_seq"', 6, true);


--
-- Name: Soru_soruNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Soru_soruNo_seq"', 15, true);


--
-- Name: ToplulukUye_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ToplulukUye_no_seq"', 3, true);


--
-- Name: Topluluk_toplulukNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Topluluk_toplulukNo_seq"', 1, true);


--
-- Name: aktifKullanici_KullaniciNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."aktifKullanici_KullaniciNo_seq"', 1, false);


--
-- Name: AktifSoru AktifSoru_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AktifSoru"
    ADD CONSTRAINT "AktifSoru_pkey" PRIMARY KEY ("soruNo");


--
-- Name: ArsivSoru ArsivSoru_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ArsivSoru"
    ADD CONSTRAINT "ArsivSoru_pkey" PRIMARY KEY ("SoruNo");


--
-- Name: BasarimKazanim BasarimKazanim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BasarimKazanim"
    ADD CONSTRAINT "BasarimKazanim_pkey" PRIMARY KEY (no, "kullanicNO");


--
-- Name: Basarim Basarim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Basarim"
    ADD CONSTRAINT "Basarim_pkey" PRIMARY KEY ("BasarimNo");


--
-- Name: CevapEditOneri CevapEditOneri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CevapEditOneri"
    ADD CONSTRAINT "CevapEditOneri_pkey" PRIMARY KEY (no, "SoruNo", "CevapNo", "KullaniciNo");


--
-- Name: Cevap Cevap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cevap"
    ADD CONSTRAINT "Cevap_pkey" PRIMARY KEY ("cevapNo", "SoruNo");


--
-- Name: EtiketGozlem EtiketGozlem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EtiketGozlem"
    ADD CONSTRAINT "EtiketGozlem_pkey" PRIMARY KEY (no, "KullanicNo");


--
-- Name: Etiket Etiket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Etiket"
    ADD CONSTRAINT "Etiket_pkey" PRIMARY KEY ("etiketNo");


--
-- Name: KullaniciHesabı KullaniciHesabı_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KullaniciHesabı"
    ADD CONSTRAINT "KullaniciHesabı_pkey" PRIMARY KEY ("kullaniciNo");


--
-- Name: Moderator Moderator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Moderator"
    ADD CONSTRAINT "Moderator_pkey" PRIMARY KEY ("KullaniciNo");


--
-- Name: RozetKazanim RozetKazanim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RozetKazanim"
    ADD CONSTRAINT "RozetKazanim_pkey" PRIMARY KEY (no, "Kullanicino");


--
-- Name: Rozet Rozet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rozet"
    ADD CONSTRAINT "Rozet_pkey" PRIMARY KEY ("rozetNo");


--
-- Name: SoruEditOneri SoruEditOneri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SoruEditOneri"
    ADD CONSTRAINT "SoruEditOneri_pkey" PRIMARY KEY (no, "SoruNo", "KullaniciNo");


--
-- Name: SoruEtiketi SoruEtiketi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SoruEtiketi"
    ADD CONSTRAINT "SoruEtiketi_pkey" PRIMARY KEY ("SoruNo", "EtiketNo");


--
-- Name: Soru Soru_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Soru"
    ADD CONSTRAINT "Soru_pkey" PRIMARY KEY ("soruNo");


--
-- Name: ToplulukUye ToplulukUye_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ToplulukUye"
    ADD CONSTRAINT "ToplulukUye_pkey" PRIMARY KEY (no, "kullaniciNo");


--
-- Name: Topluluk Topluluk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Topluluk"
    ADD CONSTRAINT "Topluluk_pkey" PRIMARY KEY ("toplulukNo");


--
-- Name: YasaklıKullanıcı YasaklıKullanıcı_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YasaklıKullanıcı"
    ADD CONSTRAINT "YasaklıKullanıcı_pkey" PRIMARY KEY ("kullaniciNo");


--
-- Name: aktifKullanici aktifKullanici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."aktifKullanici"
    ADD CONSTRAINT "aktifKullanici_pkey" PRIMARY KEY ("KullaniciNo");


--
-- Name: ArsivSoru arsiv_tarih; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER arsiv_tarih BEFORE INSERT ON public."ArsivSoru" FOR EACH ROW EXECUTE FUNCTION public.arsiv_tarih();


--
-- Name: Etiket etiket_temizle; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER etiket_temizle BEFORE INSERT ON public."Etiket" FOR EACH ROW EXECUTE FUNCTION public.etiket_temizle();


--
-- Name: Rozet rozet_adi_buyult; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER rozet_adi_buyult BEFORE INSERT ON public."Rozet" FOR EACH ROW EXECUTE FUNCTION public.rozet_adi_buyult();


--
-- Name: BasarimKazanim lnk_Basarim_BasarimKazanim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BasarimKazanim"
    ADD CONSTRAINT "lnk_Basarim_BasarimKazanim" FOREIGN KEY ("basarimNo") REFERENCES public."Basarim"("BasarimNo") MATCH FULL;


--
-- Name: EtiketGozlem lnk_Etiket_EtiketGozlem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EtiketGozlem"
    ADD CONSTRAINT "lnk_Etiket_EtiketGozlem" FOREIGN KEY ("EtiketNo") REFERENCES public."Etiket"("etiketNo") MATCH FULL;


--
-- Name: SoruEtiketi lnk_Etiket_SoruEtiketi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SoruEtiketi"
    ADD CONSTRAINT "lnk_Etiket_SoruEtiketi" FOREIGN KEY ("EtiketNo") REFERENCES public."Etiket"("etiketNo") MATCH FULL;


--
-- Name: BasarimKazanim lnk_KullaniciHesabı_BasarimKazanim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BasarimKazanim"
    ADD CONSTRAINT "lnk_KullaniciHesabı_BasarimKazanim" FOREIGN KEY ("kullanicNO") REFERENCES public."KullaniciHesabı"("kullaniciNo") MATCH FULL;


--
-- Name: Cevap lnk_KullaniciHesabı_Cevap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cevap"
    ADD CONSTRAINT "lnk_KullaniciHesabı_Cevap" FOREIGN KEY ("KullaniciNo") REFERENCES public."KullaniciHesabı"("kullaniciNo") MATCH FULL;


--
-- Name: EtiketGozlem lnk_KullaniciHesabı_EtiketGozlem; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."EtiketGozlem"
    ADD CONSTRAINT "lnk_KullaniciHesabı_EtiketGozlem" FOREIGN KEY ("KullanicNo") REFERENCES public."KullaniciHesabı"("kullaniciNo") MATCH FULL;


--
-- Name: Moderator lnk_KullaniciHesabı_Moderator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Moderator"
    ADD CONSTRAINT "lnk_KullaniciHesabı_Moderator" FOREIGN KEY ("KullaniciNo") REFERENCES public."KullaniciHesabı"("kullaniciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RozetKazanim lnk_KullaniciHesabı_RozetKazanim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RozetKazanim"
    ADD CONSTRAINT "lnk_KullaniciHesabı_RozetKazanim" FOREIGN KEY ("Kullanicino") REFERENCES public."KullaniciHesabı"("kullaniciNo") MATCH FULL;


--
-- Name: Soru lnk_KullaniciHesabı_Soru; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Soru"
    ADD CONSTRAINT "lnk_KullaniciHesabı_Soru" FOREIGN KEY ("kullaniciNo") REFERENCES public."KullaniciHesabı"("kullaniciNo") MATCH FULL;


--
-- Name: ToplulukUye lnk_KullaniciHesabı_ToplulukUye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ToplulukUye"
    ADD CONSTRAINT "lnk_KullaniciHesabı_ToplulukUye" FOREIGN KEY ("kullaniciNo") REFERENCES public."KullaniciHesabı"("kullaniciNo") MATCH FULL;


--
-- Name: YasaklıKullanıcı lnk_KullaniciHesabı_YasaklıKullanıcı; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YasaklıKullanıcı"
    ADD CONSTRAINT "lnk_KullaniciHesabı_YasaklıKullanıcı" FOREIGN KEY ("kullaniciNo") REFERENCES public."KullaniciHesabı"("kullaniciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: aktifKullanici lnk_KullaniciHesabı_aktifKullanici; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."aktifKullanici"
    ADD CONSTRAINT "lnk_KullaniciHesabı_aktifKullanici" FOREIGN KEY ("KullaniciNo") REFERENCES public."KullaniciHesabı"("kullaniciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: YasaklıKullanıcı lnk_Moderator_YasaklıKullanıcı; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YasaklıKullanıcı"
    ADD CONSTRAINT "lnk_Moderator_YasaklıKullanıcı" FOREIGN KEY ("modNo") REFERENCES public."Moderator"("KullaniciNo") MATCH FULL;


--
-- Name: RozetKazanim lnk_Rozet_RozetKazanim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RozetKazanim"
    ADD CONSTRAINT "lnk_Rozet_RozetKazanim" FOREIGN KEY ("RozetNo") REFERENCES public."Rozet"("rozetNo") MATCH FULL;


--
-- Name: AktifSoru lnk_Soru_AktifSoru; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AktifSoru"
    ADD CONSTRAINT "lnk_Soru_AktifSoru" FOREIGN KEY ("soruNo") REFERENCES public."Soru"("soruNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ArsivSoru lnk_Soru_ArsivSoru; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ArsivSoru"
    ADD CONSTRAINT "lnk_Soru_ArsivSoru" FOREIGN KEY ("SoruNo") REFERENCES public."Soru"("soruNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Cevap lnk_Soru_Cevap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cevap"
    ADD CONSTRAINT "lnk_Soru_Cevap" FOREIGN KEY ("SoruNo") REFERENCES public."Soru"("soruNo") MATCH FULL;


--
-- Name: SoruEditOneri lnk_Soru_SoruEditOneri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SoruEditOneri"
    ADD CONSTRAINT "lnk_Soru_SoruEditOneri" FOREIGN KEY ("SoruNo") REFERENCES public."Soru"("soruNo") MATCH FULL;


--
-- Name: SoruEtiketi lnk_Soru_SoruEtiketi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SoruEtiketi"
    ADD CONSTRAINT "lnk_Soru_SoruEtiketi" FOREIGN KEY ("SoruNo") REFERENCES public."Soru"("soruNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ToplulukUye lnk_Topluluk_ToplulukUye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ToplulukUye"
    ADD CONSTRAINT "lnk_Topluluk_ToplulukUye" FOREIGN KEY ("toplulukNo") REFERENCES public."Topluluk"("toplulukNo") MATCH FULL;


--
-- Name: CevapEditOneri lnk_aktifKullanici_CevapEditOneri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CevapEditOneri"
    ADD CONSTRAINT "lnk_aktifKullanici_CevapEditOneri" FOREIGN KEY ("KullaniciNo") REFERENCES public."aktifKullanici"("KullaniciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SoruEditOneri lnk_aktifKullanici_SoruEditOneri; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SoruEditOneri"
    ADD CONSTRAINT "lnk_aktifKullanici_SoruEditOneri" FOREIGN KEY ("KullaniciNo") REFERENCES public."aktifKullanici"("KullaniciNo") MATCH FULL;


--
-- PostgreSQL database dump complete
--

