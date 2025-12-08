package controller.mail;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailService {
    private static final String USERNAME = "minhtien20070@gmail.com";
    private static final String APP_PASSWORD = "tfij dwid tvzd tpks";

    public static void sendWarningEmail(String to, String studentName, String deadLine) {
        try {
            // Cấu hình SMTP
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            // (Tuỳ chọn) ép MIME dùng UTF-8
            props.put("mail.mime.charset", "UTF-8");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USERNAME, APP_PASSWORD);
                }
            });

            MimeMessage message = new MimeMessage(session);

            // Tên người gửi có dấu: truyền charset vào InternetAddress
            message.setFrom(new InternetAddress(USERNAME, "Chuyên gia lừa đảo xuyên quốc gia", "UTF-8"));

            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

            // Subject có dấu: set kèm charset
            message.setSubject("Thông báo đăng nhập thành công", "UTF-8");

            // Nội dung HTML có dấu: charset UTF-8
            String html = "<h3>Xin chào " + escapeHtml(studentName) + ",</h3>"
                    + "<p>Bạn đã đăng nhập vào hệ thống lúc: <b>" + escapeHtml(deadLine) + "</b>.</p>"
                    + "<p>Chúc bạn một ngày làm việc hiệu quả!</p>";

            message.setContent(html, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("Email sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // (Tuỳ chọn) Escape cơ bản để tránh ký tự đặc biệt phá HTML
    private static String escapeHtml(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;");
    }
}