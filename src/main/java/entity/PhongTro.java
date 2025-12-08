package entity;

import java.sql.Timestamp;

public class PhongTro {
    private Integer Id;
    private String Title;
    private Boolean Trang_Thai;
    private String Khu_Vuc;
    private Double Gia_Thue;
    private Timestamp Ngay_Cap_Nhap;

    public PhongTro() {
    }

    public PhongTro(String title, Boolean trang_Thai, String khu_Vuc, Double gia_Thue, Timestamp ngay_Cap_Nhap) {
        Title = title;
        Trang_Thai = trang_Thai;
        Khu_Vuc = khu_Vuc;
        this.Gia_Thue = gia_Thue;
        Ngay_Cap_Nhap = ngay_Cap_Nhap;
    }

    public PhongTro(Integer id, String title, Boolean trang_Thai, String khu_Vuc, Double gia_Thue, Timestamp ngay_Cap_Nhap) {
        Id = id;
        Title = title;
        Trang_Thai = trang_Thai;
        Khu_Vuc = khu_Vuc;
        this.Gia_Thue = gia_Thue;
        Ngay_Cap_Nhap = ngay_Cap_Nhap;
    }

    public Integer getId() {
        return Id;
    }

    public void setId(Integer id) {
        Id = id;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }

    public Boolean getTrang_Thai() {
        return Trang_Thai;
    }

    public void setTrang_Thai(Boolean trang_Thai) {
        Trang_Thai = trang_Thai;
    }

    public String getKhu_Vuc() {
        return Khu_Vuc;
    }

    public void setKhu_Vuc(String khu_Vuc) {
        Khu_Vuc = khu_Vuc;
    }

    public Double getGia_Thue() {
        return Gia_Thue;
    }

    public void setGia_Thue(Double gia_Thue) {
        this.Gia_Thue = gia_Thue;
    }

    public Timestamp getNgay_Cap_Nhap() {
        return Ngay_Cap_Nhap;
    }

    public void setNgay_Cap_Nhap(Timestamp ngay_Cap_Nhap) {
        Ngay_Cap_Nhap = ngay_Cap_Nhap;
    }
}
