package entity;

public class DangNhapModel {
    private int sellerID;
    private String hoVaTen;
    private String tenDangNhap;
    private String email;
    private String phone;

    public DangNhapModel() {
    }

    public DangNhapModel(int sellerID, String hoVaTen, String tenDangNhap, String email, String phone) {
        this.sellerID = sellerID;
        this.hoVaTen = hoVaTen;
        this.tenDangNhap = tenDangNhap;
        this.email = email;
        this.phone = phone;
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
}
