package com.company;

public class Soru {
    int kullanici_id;
    int gorulmeSayisi;
    String Soru;

    public Soru(int id,int gorulme,String txt){
        this.kullanici_id = id;
        this.gorulmeSayisi = gorulme;
        this.Soru = txt;
    }

    public int getKullanici_id() {
        return kullanici_id;
    }
    public int getGorulmeSayisi(){return gorulmeSayisi;}
    public String getSoru(){return Soru;}
}
