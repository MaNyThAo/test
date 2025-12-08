package entity;

public class DangNhap {
    private int sellerID;
    private String hoVaTen;
    private String tenDangNhap;
    private String email;
    private String phone;
    private String gioiTinh;
    private String ngaySinh;
    private String cccd;
    private String diaChi;
    private String matKhau;
    private String avatarPath;

    public DangNhap() {
    }

    public DangNhap(int sellerID, String hoVaTen, String tenDangNhap, String email, String phone, String gioiTinh, String ngaySinh, String cccd, String diaChi, String matKhau, String avatarPath) {
        this.sellerID = sellerID;
        this.hoVaTen = hoVaTen;
        this.tenDangNhap = tenDangNhap;
        this.email = email;
        this.phone = phone;
        this.gioiTinh = gioiTinh;
        this.ngaySinh = ngaySinh;
        this.cccd = cccd;
        this.diaChi = diaChi;
        this.matKhau = matKhau;
        this.avatarPath = avatarPath;
    }

    public int getSellerID() {
        return sellerID;
    }

    public void setSellerID(int sellerID) {
        this.sellerID = sellerID;
    }

    public String getHoVaTen() {
        return hoVaTen;
    }

    public void setHoVaTen(String hoVaTen) {
        this.hoVaTen = hoVaTen;
    }

    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(String ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public String getAvatarPath() {
        return avatarPath;
    }

    public void setAvatarPath(String avatarPath) {
        this.avatarPath = avatarPath;
    }
}
