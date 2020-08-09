package com.company;

import java.util.Random;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        GirisRepostorySQL girisRepostorySQL = new GirisRepostorySQL();
        SoruRepostorySQL soruRepostorySQL = new SoruRepostorySQL();
        CevapRepostorySQL cevapRepostorySQL = new CevapRepostorySQL();

        Scanner scannner = new Scanner(System.in);
        Giris kullanici = null;
        Cevap cevap = null;
        Soru soru = null;

        Random random = new Random();
        System.out.println("Özmen Foruma Hoşgeldiniz. Giriş Yapmak İçin Kullanıcı Numaranızı ve Şifrenizi Girinizi");
        System.out.println("Misafir Kullanıcı iseniz 0 olarak tuşlayınız.");
        System.out.println("Moderatör İseniz 1 ya da 2 olarak tuşlayınız");
        int gorulme = 0;
        int ID;
        String kac;
        System.out.print("ID:");
        ID = scannner.nextInt();
        girisRepostorySQL.search(ID);
        while(true){

            if(ID >=0 && ID<=6){

                System.out.println("Hoşgeldiniz.");
                System.out.println("1- Soruları Listele");
                System.out.println("2- Cevapları Listele");
                System.out.println("3- Soru Sor");
                System.out.println("4- Cevap Ver");
                System.out.println("5- Soru Düzenle");
                System.out.println("6- Cevap Düzenle");
                System.out.println("7- Soru Sil");
                System.out.println("8- Cevap Sil");
                System.out.println("9- Çıkış Yap");

                kac = scannner.next();
                if(kac.equals("1"))
                    soruRepostorySQL.tumSorular();
                else if(kac.equals("2"))
                    cevapRepostorySQL.tumCevaplar();
                else if(kac.equals("3")){
                    System.out.println("Sorunuzu Yazınız:");
                    Scanner sca = new Scanner(System.in);
                    String icerik = sca.nextLine();
                    gorulme = random.nextInt(100);
                    soru = new Soru(ID,gorulme,icerik);
                    soruRepostorySQL.SoruSor(soru);
                    System.out.println("Sorunuz Sorulmuştur.");
                }
                else if(kac.equals("4")){
                    soruRepostorySQL.tumSorular();
                    System.out.print("Cevap Vermek İstediğiniz Sorunun ID'sini Giriniz:");

                    kac = scannner.next();

                    System.out.println("Cevabınız:");
                    Scanner  sca = new Scanner(System.in);
                    String Cevap = sca.nextLine();
                    cevap = new Cevap(Integer.parseInt(kac),ID,Cevap);
                    cevapRepostorySQL.CevapVer(cevap);
                    System.out.println("Cevabınız Verilmiştir.");
                }
                else if (kac.equals("5")){
                    if(ID == 1 || ID == 2){
                        Scanner sca = new Scanner(System.in);
                        soruRepostorySQL.tumSorular();
                        System.out.println("Güncellemek İstediğiniz Sorunun ID'sini Yazınız.");
                        int soruID = scannner.nextInt();
                        System.out.print("Yeni Sorunuzu Yazınız:");
                        String soru2 = sca.nextLine();

                        soru = new Soru(ID,gorulme,soru2);
                        soruRepostorySQL.degistir(soru,soruID);
                        System.out.println("Cevabınız Güncellenmiştir.");
                    }
                    else if(ID >2 && ID<=6){
                        Scanner sca = new Scanner(System.in);
                        System.out.print("Yeni Sorunuzu Yazınız:");
                        String Soru = sca.nextLine();

                        soru = new Soru(ID,gorulme,Soru);
                        soruRepostorySQL.degistir(soru,ID);
                        System.out.println("Cevabınız Güncellenmiştir.");
                    }
                    else{
                        System.out.println("Yetkiniz olmadığı için bu seçeneği kullanamazsınız.");
                    }
                }
                else if (kac.equals("6")){
                    if(ID == 1 || ID == 2){
                        Scanner sca = new Scanner(System.in);
                        cevapRepostorySQL.tumCevaplar();
                        System.out.println("Güncellemek İstediğiniz Cevabın ID'sini Yazınız.");
                        int cevapID = scannner.nextInt();
                        System.out.print("Yeni Cevabınızı Yazınız:");
                        String Cevap = sca.nextLine();

                        cevap = new Cevap(ID,Cevap);
                        cevapRepostorySQL.degistir(cevap,cevapID);
                        System.out.println("Cevabınız Güncellenmiştir.");
                    }
                    else if(ID >2 && ID<=6){
                        System.out.print("Yeni Cevabınızı Yazınız:");
                        String Cevap = scannner.nextLine();
                        cevap = new Cevap(ID,Cevap);
                        cevapRepostorySQL.degistir(cevap,ID);
                        System.out.println("Cevabınız Güncellenmiştir.");
                    }
                    else{
                        System.out.println("Yetkiniz olmadığı için bu seçeneği kullanamazsınız.");
                    }
                }
                else if (kac.equals("7")){
                    if(ID==1||ID==2){
                        soruRepostorySQL.tumSorular();
                        System.out.print("\nSilmek İstediğiniz Soru Numarasını Giriniz:");
                        int SoruID = scannner.nextInt();
                        soruRepostorySQL.sil(SoruID);
                        System.out.println("Cevabınız Silinmiştir.");
                    }
                    else
                        System.out.println("Bu alan için yetkiniz yok.");
                }
                else if(kac.equals("8")){
                    if(ID==1||ID==2){
                        cevapRepostorySQL.tumCevaplar();
                        System.out.print("\nSilmek İstediğiniz Soru Numarasını Giriniz");
                        int CevapID = scannner.nextInt();
                        cevapRepostorySQL.sil(CevapID);
                        System.out.println("Cevabınız Silinmiştir.");
                    }
                    else
                        System.out.println("Bu alan için yetkiniz yok.");
                }
                else if(kac.equals("9"))
                    break;
                else
                    System.out.println("Hatalı Tuşlama Yaptınız.");
            }
            else
            {
                System.out.println("Hatalı ID, Tekrar giriş Yapınız.");
                break;
            }
        }

    }
}
