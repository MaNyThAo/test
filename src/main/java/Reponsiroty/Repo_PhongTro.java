package Reponsiroty;

import Ulti.DBConnect;
import entity.PhongTro;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Repo_PhongTro {

    public List<PhongTro> getAll(){
        List<PhongTro> danhSach = new ArrayList<>();
        try {
            Connection connection = DBConnect.getConnection();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("Select * From Thong_Tin_Phong_Tro");
            while (resultSet.next()){
                Integer id = resultSet.getInt("ID");
                String title = resultSet.getString("Title");
                Boolean trang_Thai = resultSet.getBoolean("Trang_Thai");
                String khu_Vuc = resultSet.getString("Khu_Vuc");
                Double gia_Thue  = resultSet.getDouble("Gia_Thue");
                Timestamp ngay_Cap_Nhap = resultSet.getTimestamp("Ngay_Cap_Nhap");

                PhongTro pt = new PhongTro();
                pt.setId(id);
                pt.setTitle(title);
                pt.setTrang_Thai(trang_Thai);
                pt.setKhu_Vuc(khu_Vuc);
                pt.setGia_Thue(gia_Thue);
                pt.setNgay_Cap_Nhap(ngay_Cap_Nhap);
                danhSach.add(pt);
            }
        }catch (Exception e ){
            e.printStackTrace();
        }
        return danhSach;
    }

    public int Delete(int id){
        try {
            Connection connection = DBConnect.getConnection();
            Statement statement = connection.createStatement();
            return statement.executeUpdate("Delete From Thong_Tin_Phong_Tro where id =" + id);

        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }

    public int add(PhongTro pt){
        String sql = "Insert Into Thong_Tin_Phong_Tro(Title,Trang_Thai,Khu_Vuc,Gia_Thue,Ngay_Cap_Nhap) Values (?,?,?,?,?)";
        try {
            Connection connection = DBConnect.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,pt.getTitle());
            ps.setBoolean(2,pt.getTrang_Thai());
            ps.setString(3,pt.getKhu_Vuc());
            ps.setDouble(4,pt.getGia_Thue());
            ps.setTimestamp(5,pt.getNgay_Cap_Nhap());
            return ps.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }
    public PhongTro detail(int id){
        String sql = "Select * From Thong_Tin_Phong_Tro where id = ?";
        try {
            Connection connection = DBConnect.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                PhongTro phongTro = new PhongTro();
                phongTro.setId(rs.getInt("ID"));
                phongTro.setTitle(rs.getString("Title"));
                phongTro.setTrang_Thai(rs.getBoolean("Trang_Thai"));
                phongTro.setKhu_Vuc(rs.getString("Khu_Vuc"));
                phongTro.setGia_Thue(rs.getDouble("Gia_Thue"));
                phongTro.setNgay_Cap_Nhap(rs.getTimestamp("Ngay_Cap_Nhap"));
                return phongTro;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }


    // Sửa game theo ID
    public int update(PhongTro phongTro) {
        try {
            Connection connection = DBConnect.getConnection();
            PreparedStatement ps = connection.prepareStatement(
                    "UPDATE Thong_Tin_Phong_Tro SET Title = ?, Trang_Thai = ?, Khu_Vuc = ?, Gia_Thue = ?, Ngay_Cap_Nhap = ? WHERE ID = ?"
            );
            ps.setString(1, phongTro.getTitle());
            ps.setBoolean(2, phongTro.getTrang_Thai());
            ps.setString(3, phongTro.getKhu_Vuc());
            ps.setDouble(4, phongTro.getGia_Thue());
            ps.setTimestamp(5, phongTro.getNgay_Cap_Nhap());
            ps.setInt(6, phongTro.getId());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public static void main(String[] args) throws Exception {
        Connection connection = DBConnect.getConnection();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("Select * From Thong_Tin_Phong_Tro");
        while (resultSet.next()){
            System.out.println(resultSet.getString("Title"));
        }
    }
}
