# HƯỚNG DẪN QUẢN LÝ TÀI KHOẢN, PHÂN QUYỀN VAI TRÒ & TÙY BIẾN GIAO DIỆN WEB

Tài liệu này hướng dẫn chi tiết:
1. **Nơi cấu hình tài khoản, mật khẩu (TK/MK)**.
2. **Cách phân quyền vai trò (Role): Ai được tải video về máy, ai chỉ được xem trực tiếp trên Web (cấm tải)**.
3. **Nơi chỉnh sửa giao diện web (Logo, tiêu đề, màu sắc, font chữ, banner thông báo)**.

---

## 1. Nơi Thiết Lập Tài Khoản & Mật Khẩu (Setup TK/MK)

Toàn bộ tài khoản và mật khẩu được lưu trữ tập trung tại file:
👉 **[server/config/copyparty.conf](file:///Users/phamvanhuy/Downloads/Download-Video-Team/Download-Video-Team/server/config/copyparty.conf)** (Mục `[accounts]`)

### Cách thêm hoặc đổi mật khẩu:
Mở file `server/config/copyparty.conf` bằng Notepad, tìm đến đoạn `[accounts]` và thêm theo cú pháp `tên_đăng_nhập: mật_khẩu`:

```yaml
[accounts]
  # 1. Tài khoản Quản trị viên (Admin)
  admin: Admin@VideoTeam2026
  quanly: QuanLyKho@2026

  # 2. Tài khoản Thành viên ĐƯỢC PHÉP TẢI FILE
  member: TeamVideoPass@123
  member1: MatKhauThanhVien1@2026
  member2: MatKhauThanhVien2@2026

  # 3. Tài khoản Thành viên CHỈ ĐƯỢC XEM TRÊN WEB (CẤM TẢI FILE VỀ)
  viewer: ViewerOnly@123
  viewer1: MatKhauChiXem1@2026
  khachhang: KhachXemThu@123
```

---

## 2. Quản Lý Vai Trò: Cho Phép Tải Hay Cấm Tải

Để phân loại người dùng nào được tải file, người dùng nào chỉ được xem, bạn khai báo tên tài khoản vào các nhóm tương ứng tại mục `[groups]` trong file `server/config/copyparty.conf`:

```yaml
[groups]
  # NHÓM 1: Quản trị viên (Toàn quyền upload, xóa file, tải mọi dữ liệu)
  admins: admin, quanly

  # NHÓM 2: Thành viên ĐƯỢC PHÉP TẢI (Xem video + Bấm nút tải file về máy)
  downloaders: member, member1, member2

  # NHÓM 3: Thành viên CHỈ ĐƯỢC XEM (Chỉ phát video trên Web, KHÔNG CÓ NÚT TẢI)
  viewers: viewer, viewer1, khachhang
```

### 🛡️ Cơ chế bảo vệ 3 lớp chống tải trộm cho nhóm "Viewers":
1. **Khóa nút tải giao diện (Frontend)**: Khi tài khoản thuộc nhóm `viewers` đăng nhập, hệ thống sẽ tự động ẩn toàn bộ các nút Download, icon tải xuống và hiển thị huy hiệu màu vàng: `👁️ Tài khoản: Chỉ Xem (Chặn Tải)`.
2. **Chặn tính năng của trình duyệt**: Toàn bộ thẻ video được gán thuộc tính `controlsList="nodownload"` (xóa nút 3 chấm tải xuống của trình duyệt Chrome/Edge) và vô hiệu hóa chuột phải (cấm bấm chuột phải chọn *"Lưu video thành..."*).
3. **Khóa tải ZIP hàng loạt (Backend)**: Thiết lập `zip-who: 1` đảm bảo chỉ có Admin mới có quyền nén cả thư mục video thành file ZIP tải về. Nhóm thành viên và Viewer không thể kéo trộm dung lượng lớn.

---

## 3. Nơi Tùy Biến Giao Diện Web (Custom Theme, Logo & Banner)

File giao diện tùy biến được đặt tại:
👉 **[server/custom/custom_head.html](file:///Users/phamvanhuy/Downloads/Download-Video-Team/Download-Video-Team/server/custom/custom_head.html)**

File này tự động được nhúng vào phần đầu (`<head>`) của toàn bộ các trang Web xem video.

### Những phần bạn có thể tùy chỉnh dễ dàng:

### A. Đổi Tên Kho Video, Slogan & Biểu tượng Logo
Mở file `server/custom/custom_head.html`, tìm đoạn mã HTML khoảng dòng 120:
```html
<div class="brand-left">
  <div class="brand-icon">🎬</div> <!-- Đổi icon hoặc thay bằng thẻ <img> chứa logo -->
  <div>
    <h1 class="brand-title">KHO VIDEO TEAM NỘI BỘ</h1> <!-- Đổi tên thương hiệu -->
    <div class="brand-subtitle">Hệ thống truyền phát & lưu trữ video tốc độ cao</div>
  </div>
</div>
```

### B. Thay đổi Màu sắc chủ đạo (Theme Color)
Trong khối `<style>` ở đầu file `server/custom/custom_head.html`:
```css
:root {
  --primary: #3b82f6; /* Đổi màu xanh chủ đạo (Accent Color) */
  --bg-dark: #0f172a; /* Màu nền tối sang trọng */
  --surface: rgba(30, 41, 59, 0.85); /* Hiệu ứng kính mờ (Glassmorphism) */
}
```

### C. Đổi Font chữ hiển thị
Mặc định hệ thống đã nạp sẵn Font chữ **Plus Jakarta Sans** cực kỳ mịn màng và hiện đại từ Google Fonts. Bạn có thể đổi sang Font khác tùy ý bằng cách thay đổi link Google Font ở đầu file.

---

## 4. Quản Lý Trực Quan Trên Trình Duyệt Web (Không Cần Sửa File)

Nếu bạn không muốn mở file cấu hình bằng Notepad mỗi khi cần kiểm tra:
1. Mở trình duyệt truy cập: `http://localhost:3923/` (hoặc IP Tailscale của máy chủ).
2. Đăng nhập bằng tài khoản:
   - User: `admin`
   - Pass: `Admin@VideoTeam2026`
3. Tại góc trên màn hình, bấm vào menu điều khiển hoặc truy cập `http://localhost:3923/?cpanel`:
   - Bạn sẽ thấy bảng điều khiển **Control Panel** hiển thị danh sách các phiên kết nối, ai đang xem video, địa chỉ IP của máy con, và dung lượng ổ cứng còn trống.
