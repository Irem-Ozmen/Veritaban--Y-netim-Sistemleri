package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class GirisRepostorySQL {
    private Connection connection() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/irem",
                    "postgres", "123321");
            if (conn != null) {
            } else
                System.out.println("Bağlantı Grişimi başarısız.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public Giris search(int id){
        System.out.println("Ogrenci Numarası Kontrol Ediliyor...");
        Giris uye= null;

        String sql= "SELECT * FROM \"KullaniciHesabı\" WHERE \"kullaniciNo\"="+id;
        Connection conn = this.connection();
        try{
            Statement stmt  = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            conn.close();
            int no;
            while(rs.next())
            {
                int ID = rs.getInt("kullaniciNo");
                String pass = rs.getString("sifre");
                uye  = new Giris(ID,pass);
            }
            rs.close();
            stmt.close();
        }
        catch (Exception e ){
            e.printStackTrace();
        }
        return uye;
    }
}
