package com.company;

public class Cevap {
    private int soru_id;
    private int kullanici_id;
    private String icerik;
    private String tarih;
    private int puan;

    public Cevap(int Soru_ID, int Kullanici_ID, String txt) {
        this.soru_id = Soru_ID;
        this.kullanici_id = Kullanici_ID;
        this.icerik = txt;
    }
    public Cevap(int Kullanici_id,String txt){
        this.kullanici_id = Kullanici_id;
        this.icerik = txt;
    }

    public int getSoru_id() {
        return soru_id;
    }

    public int getKullanici_id() {
        return kullanici_id;
    }

    public String getIcerik() {
        return icerik;
    }

    public String getTarih(){return tarih;}

    public int getPuan(){return puan;}

}