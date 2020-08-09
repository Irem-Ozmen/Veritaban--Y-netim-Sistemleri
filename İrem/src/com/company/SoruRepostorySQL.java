package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class SoruRepostorySQL {
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

    public void tumSorular() {

        System.out.println("Sorular Listeleniyor =>");

        Connection conn = this.connection();

        try {
            String sql = "SELECT \"soruNo\",\"soruİcerik\"  FROM \"Soru\"";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            //***** Bağlantı sonlandırma *****
            conn.close();

            while (rs.next()) {
                int soruNo = rs.getInt("soruNo");
                String soruİcerik = rs.getString("soruİcerik");

                System.out.print(soruNo + "-)");
                System.out.print("---Soru: " + soruİcerik + "\n");

            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void SoruSor(Soru soru) {
        String sql = "INSERT INTO  \"Soru\" (\"kullaniciNo\",\"gorulmeSayisi\",\"soruİcerik\") VALUES(\'" + soru.getKullanici_id() + "\',\'" + soru.getGorulmeSayisi() + "\',\'" + soru.getSoru() + "\')";
        Connection conn = this.connection();
        try {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            //***** Bağlantı sonlandırma *****
            conn.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void degistir(Soru soru, int no) {

        String sql = "UPDATE \"Soru\" SET \"soruİcerik\"=\'" + soru.getSoru() + "\' WHERE \"soruNo\"=\'" + no + "\'";

        Connection conn = this.connection();

        try {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            //***** Bağlantı sonlandırma *****
            conn.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sil(int no){
        System.out.println("Soru siliniyor...");

        String sql= "DELETE FROM \"Soru\" WHERE \"soruNo\"="+no;

        Connection conn=this.connection();
        try{
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            //***** Bağlantı sonlandırma *****
            conn.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
