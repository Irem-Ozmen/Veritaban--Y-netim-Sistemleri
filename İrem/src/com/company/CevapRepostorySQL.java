package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class CevapRepostorySQL {

    private Connection connection(){
        Connection conn = null;
        try{
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/irem",
                    "postgres", "123321");
            if(conn != null){
            }
            else
                System.out.println("Bağlantı Grişimi başarısız.");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return conn;
    }

    public void tumCevaplar() {
        System.out.println("Cevaplar Listeleniyor =>");

        Connection conn = this.connection();

        try {
            String sql = "SELECT \"cevapNo\",\"SoruNo\",\"icerik\"  FROM \"Cevap\"";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            //***** Bağlantı sonlandırma *****
            conn.close();

            while (rs.next()) {
                int cevapNo = rs.getInt("cevapNo");
                int SoruNo = rs.getInt("SoruNo");
                String icerik = rs.getString("icerik");

                System.out.print(cevapNo+"-)");
                System.out.print("---Cevap: " + SoruNo);
                System.out.print("---SoruNo: " + icerik+"\n");

            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void CevapVer(Cevap cevap){
        String sql= "INSERT INTO  \"Cevap\" (\"SoruNo\",\"KullaniciNo\",\"icerik\") VALUES(\'"+cevap.getSoru_id()+"\',\'"+cevap.getKullanici_id()+"\',\'"+cevap.getIcerik()+"\')";
        Connection conn=this.connection();
        try
        {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            //***** Bağlantı sonlandırma *****
            conn.close();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void degistir(Cevap cevap, int no) {

        String sql = "UPDATE \"Cevap\" SET \"icerik\"=\'" + cevap.getIcerik() + "\' WHERE \"cevapNo\"=\'" + no + "\'";

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
        System.out.println("Cevap siliniyor...");

        String sql= "DELETE FROM \"Cevap\" WHERE \"cevapNo\"="+no;

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
