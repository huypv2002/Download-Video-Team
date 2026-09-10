# HƯỚNG DẪN DÀNH CHO THÀNH VIÊN (MÁY CON)

> **Mục đích**: Hướng dẫn thành viên trong team kết nối vào Kho Video nội bộ từ xa chỉ với **3 bước đơn giản (mất chưa đầy 2 phút)**.

---

## BƯỚC 1: Cài đặt mạng an toàn Tailscale (Chỉ làm 1 lần duy nhất)
1. Tải ứng dụng Tailscale chính thức:
   - **Dành cho Windows**: [Bấm vào đây để tải](https://tailscale.com/download/windows)
   - **Dành cho macOS**: [Bấm vào đây để tải](https://tailscale.com/download/mac)
   - **Dành cho iOS/Android**: Tìm "Tailscale" trên App Store / Google Play.
2. Cài đặt file vừa tải về và mở ứng dụng lên.
3. Bấm **Log in** (Đăng nhập bằng tài khoản Google/Microsoft mà quản lý đã cấp hoặc dùng mã Auth Key do quản lý gửi).

---

## BƯỚC 2: Mở Kho Video
Có 2 cách siêu nhanh để vào kho:

### Cách A: Dùng file tự động (Dành cho máy tính Windows)
1. Tải thư mục `client/` được gửi từ quản lý.
2. Bấm đúp chuột vào file **`1_click_join.bat`**.
3. Ngay lập tức, trên màn hình Desktop của bạn sẽ xuất hiện biểu tượng:
   📁 **Kho Video Team**
4. Từ nay về sau, mỗi lần cần xem/tải video, bạn chỉ cần bấm đúp vào biểu tượng này!

### Cách B: Mở trực tiếp bằng trình duyệt Web (Chrome / Edge / Safari)
1. Mở trình duyệt Web lên.
2. Gõ địa chỉ Tên Miền HTTPS do Quản lý cung cấp (Có biểu tượng 🔒 Ổ khóa bảo mật):
   👉 **`https://kho-video.tailxxxx.ts.net`** *(hoặc địa chỉ IP: http://100.x.y.z:3923/)*
3. Bạn nên bấm nút hình ngôi sao trên thanh địa chỉ để **Bookmark (Lưu trang)** lại.

---

## BƯỚC 3: Đăng nhập & Tải Video

1. Tại góc trên giao diện, bấm vào nút **Login**.
2. Nhập thông tin tài khoản được cấp:
   - **Tên đăng nhập**: `member`
   - **Mật khẩu**: `TeamVideoPass@123` *(hoặc mật khẩu do trưởng nhóm cập nhật)*
3. **Cách sử dụng:**
   - **Xem trước video**: Bấm chuột vào video để xem trực tiếp trên trình duyệt (có thể tua nhanh, chỉnh âm lượng như xem YouTube).
   - **Tải file về máy**: Bấm vào nút tải xuống (mũi tên tải) hoặc chuột phải chọn **Save link as...**.
   - **Tải file dung lượng siêu lớn (10GB - 50GB)**: Nếu đường truyền mạng nhà bạn chập chờn hay bị đứt, hãy chạy file `fast_download.bat` trong thư mục `client/` và dán link video vào để tải tiếp mà không lo phải tải lại từ đầu!
