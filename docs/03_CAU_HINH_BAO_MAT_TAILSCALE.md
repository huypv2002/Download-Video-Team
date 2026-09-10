# HƯỚNG DẪN CẤU HÌNH BẢO MẬT & TẠO AUTH KEY TRÊN TAILSCALE

Tài liệu này hướng dẫn quản trị viên cách cấu hình Tailscale một cách **an toàn tuyệt đối**, đảm bảo:
1. **Không phải chia sẻ mật khẩu tài khoản Admin** cho 20 người trong team (Dùng Reusable Auth Key).
2. **Cô lập 20 máy con**: Máy con không thể soi, quét cổng hoặc xâm nhập lẫn nhau (Bảo vệ tính riêng tư và chống lây lan virus trong team).
3. **Giữ trọn vẹn gói Free**: Tối đa 100 thiết bị, không tốn thêm chi phí hàng tháng.

---

## 1. Cách tạo Reusable Auth Key (Khóa kết nối dùng chung cho 20 máy)

Thay vì bắt từng người phải đăng nhập bằng email của bạn:
1. Đăng nhập vào trang quản trị Tailscale: [https://login.tailscale.com/admin/settings/keys](https://login.tailscale.com/admin/settings/keys)
2. Bấm vào nút **Generate auth key...**
3. Cấu hình các mục như sau:
   - **Description**: `Team Video Client Key`
   - **Reusable**: Tích chọn `[x] Reusable` *(Quan trọng: Để cả 20 máy con có thể dùng chung 1 key này)*
   - **Expiration**: Chọn thời hạn (ví dụ 90 ngày hoặc tuỳ ý).
   - **Ephemeral**: Để tắt (Unchecked).
   - **Tags**: Thêm tag `tag:client` (nếu có).
4. Bấm **Generate key**.
5. Copy chuỗi key vừa tạo (có dạng `tskey-auth-kXXXXX...`).
6. Dán key này vào file `client/1_click_join.bat` tại dòng `set "TAILSCALE_AUTH_KEY=..."` trước khi gửi cho team.

---

## 2. Cách dán cấu hình ACL để cô lập mạng (Access Control List)

Theo mặc định của Tailscale, tất cả máy khi tham gia sẽ nhìn thấy nhau (như chung 1 mạng LAN). Để **chặn hoàn toàn việc máy con soi máy con khác**, bạn làm như sau:

1. Truy cập vào mục ACL trên trang quản trị: [https://login.tailscale.com/admin/acls](https://login.tailscale.com/admin/acls)
2. Mở file [server/config/tailscale_acl.json](file:///Users/phamvanhuy/Downloads/Download-Video-Team/Download-Video-Team/server/config/tailscale_acl.json) trong dự án.
3. Copy toàn bộ nội dung trong file đó và dán đè vào khung cấu hình ACL trên Tailscale.
4. Bấm **Save**.

### Cơ chế hoạt động của bộ quy tắc này:
* **Máy con (`tag:client`) ➔ Máy chủ (`tag:server`)**: CHỈ được phép truy cập vào đúng **Port 3923** và **8080** (Giao diện web xem/tải video).
* **Máy con ➔ Máy con khác**: **BỊ CHẶN HOÀN TOÀN** (Không thể ping, không thể hack, không thể truy cập file chia sẻ riêng tư của nhau).
* **Admin ➔ Máy chủ**: Toàn quyền quản trị (Web, Remote Desktop, SSH).

---

## 3. Cách kiểm tra tốc độ kết nối P2P (Tránh bị bóp băng thông)

Để kiểm tra xem máy con kết nối thẳng tới máy chủ (Direct P2P - Tốc độ tối đa) hay đang phải đi vòng qua trạm relay (DERP Relay):

1. Trên máy con hoặc máy chủ, mở Terminal/Command Prompt.
2. Gõ lệnh:
   ```bash
   tailscale status
   ```
3. Sau đó gõ lệnh ping kiểm tra:
   ```bash
   tailscale ping <IP-Tailscale-Máy-Chủ>
   ```
4. **Kết quả:**
   - Nếu hiển thị: `pong from ... via [IP:Port] in 15ms (direct)` ➔ **Rất tốt**, kết nối thẳng máy - máy, tận dụng 100% tốc độ mạng nhà.
   - Nếu hiển thị: `pong from ... via DERP(sin) in 95ms (relay)` ➔ Đang bị đi vòng qua máy chủ Singapore. Lúc này hãy kiểm tra modem mạng nhà máy chủ: Bật tính năng **UPnP** trên modem hoặc mở cổng UDP ngẫu nhiên của Tailscale để chuyển sang chế độ `direct`.
