# HƯỚNG DẪN TRIỂN KHAI TRÊN MÁY CHỦ (WINDOWS SERVER PC)

Tài liệu này dành cho bạn (người triển khai) khi mang toàn bộ thư mục code này về máy tính Windows nhàn rỗi của khách hàng để cài đặt và biến nó thành **Server Kho Video 24/7**.

---

## 1. Yêu cầu Hệ thống & Chuẩn bị ban đầu
* **Hệ điều hành**: Windows 10 hoặc Windows 11 (64-bit).
* **Kết nối mạng**: Cắm dây mạng LAN trực tiếp vào modem (hạn chế dùng Wi-Fi để tránh chập chờn).
* **Vị trí chứa Video**: Thư mục chứa video (ví dụ: `D:\Videos` hoặc `E:\KhoVideo`).
* **Quyền hạn**: Tài khoản Windows có quyền **Administrator**.

---

## 2. Các bước triển khai chi tiết (Mất khoảng 10 - 15 phút)

### Bước 1: Sao chép thư mục dự án vào Máy Chủ
1. Tải toàn bộ thư mục `Download-Video-Team` về máy chủ Windows (ví dụ lưu tại `C:\Download-Video-Team` hoặc `D:\Download-Video-Team`).
2. Giải nén (nếu là file ZIP).

---

### Bước 2: Cấu hình thư mục Video và Mật khẩu
1. Mở file [server/config/copyparty.conf](file:///Users/phamvanhuy/Downloads/Download-Video-Team/Download-Video-Team/server/config/copyparty.conf) bằng Notepad.
2. Kiểm tra và chỉnh sửa:
   - **Đường dẫn thư mục video**: Tìm dòng `D:\Videos` và đổi thành đường dẫn thực tế trên máy khách nếu khác (ví dụ `E:\Videos`).
   - **Tài khoản & Mật khẩu**:
     - `admin: Admin@VideoTeam2026` (Đổi mật khẩu admin theo ý bạn).
     - `member: TeamVideoPass@123` (Mật khẩu gửi cho 20 người dùng).
3. Lưu file lại.

---

### Bước 3: Chạy Tinh chỉnh Windows 24/7 & Mở Firewall
1. Vào thư mục `server/scripts/`.
2. Click chuột phải vào file **`win_power_keepalive.ps1`** chọn **Run with PowerShell** (hoặc chạy file `setup_server.bat` với quyền Run as Administrator).
3. Script sẽ tự động:
   - Bật chế độ nguồn điện **High Performance**.
   - Tắt chế độ **Sleep / Hibernate** khi cắm điện.
   - Tắt tính năng ngắt điện trên **Card mạng** (tránh mất mạng ngầm).
   - Tắt chế độ ngủ ổ đĩa (Disk Timeout = 0).
   - Mở cổng tường lửa **Port 3923** và **8080** trên Windows Defender Firewall.
   - Ngăn Windows tự động khởi động lại khi có bản cập nhật Windows Update.

---

### Bước 4: Cài đặt & Đăng nhập Tailscale trên Máy Chủ
1. Truy cập [https://tailscale.com/download/windows](https://tailscale.com/download/windows) để tải và cài đặt Tailscale.
2. Sau khi cài xong, mở Tailscale dưới khay hệ thống (System Tray) và **Đăng nhập** vào tài khoản Tailscale của bạn.
3. Nhấp chuột phải vào biểu tượng Tailscale, chọn copy **Địa chỉ IP Tailscale** của máy chủ (dạng `100.x.y.z`, ví dụ `100.85.12.34`).
4. Ghi nhớ địa chỉ IP này để cấu hình cho máy con.

---

### Bước 5: Khởi động Server & Đặt tự chạy cùng Windows
1. Trong thư mục `server/scripts/`, bấm đúp vào **`setup_server.bat`**:
   - File này sẽ kiểm tra Python (nếu chưa có sẽ nhắc bạn tải).
   - Tự động chạy `pip install --upgrade copyparty`.
   - Tự động tạo một Shortcut trong thư mục `Startup` của Windows để mỗi khi bật máy hoặc cúp điện có điện lại, server sẽ **tự động chạy ngầm**.
2. Để chạy thử nghiệm ngay lập tức, bấm đúp vào file **`start_server_manual.bat`**.
   - Màn hình console màu đen sẽ hiện lên thông báo server đang lắng nghe tại port 3923 và 8080.

---

### Bước 6: Kiểm tra Nghiệm thu trên Máy Chủ
1. Mở trình duyệt Chrome/Edge trên máy chủ, truy cập:
   `http://localhost:3923` hoặc `http://127.0.0.1:3923`
2. Bạn sẽ thấy giao diện **Kho Video Team**.
3. Bấm vào nút đăng nhập ở góc trên, nhập tài khoản:
   - User: `member`
   - Pass: `TeamVideoPass@123`
4. Kiểm tra danh sách video: Thử bấm xem trực tiếp 1 video, tua thanh thời gian xem có mượt không. Nếu tua mượt là tính năng **HTTP Range 206** đã hoạt động hoàn hảo.

---

## 3. Checklist Bàn giao Máy Chủ
- [ ] Máy tính đã tắt hoàn toàn chế độ Sleep / Hibernate.
- [ ] Đã cắm nguồn sạc trực tiếp (khuyên khách trang bị thêm 1 cục lưu điện UPS 1-2 triệu nếu khu vực hay sập nguồn).
- [ ] Mạng LAN ổn định, Speedtest Upload đạt tối thiểu 40 - 100 Mbps.
- [ ] Server tự chạy lại khi khởi động lại máy tính.
- [ ] Đã lưu lại địa chỉ IP Tailscale của máy chủ.
