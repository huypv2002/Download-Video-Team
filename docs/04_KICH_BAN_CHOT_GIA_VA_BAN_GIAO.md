# KỊCH BẢN TƯ VẤN, BÁO GIÁ & BIÊN BẢN BÀN GIAO CHO KHÁCH HÀNG

Tài liệu này cung cấp sẵn **tin nhắn mẫu gửi khách**, **bảng giá các gói dịch vụ**, và **biên bản nghiệm thu** giúp bạn chốt hợp đồng nhanh gọn, chuyên nghiệp và bảo vệ quyền lợi của bạn.

---

## 1. Mẫu Tin nhắn Gửi Khách Hàng (Copy & Paste)

> *"Dạ chào anh/chị, sau khi nghiên cứu kỹ nhu cầu lưu trữ và chia sẻ video nội bộ cho team ~20 người, em gửi anh/chị phương án tối ưu nhất để anh/chị họp team chốt nhé:*
>
> ### 🎯 Phương án triển khai:
> 1. **Tận dụng 100% PC Windows sẵn có**: Không phát sinh chi phí thuê máy chủ Cloud hay mua thêm ổ cứng hàng tháng.
> 2. **Giao diện Web mượt mà**: Thành viên chỉ cần mở trình duyệt xem thử (preview) video, tua nhanh không giật lag và bấm tải về tức thì.
> 3. **Bảo mật & Tốc độ cao**: Sử dụng hạ tầng mạng riêng ảo mã hóa đầu cuối (Tailscale). Phân quyền tài khoản chỉ được đọc/tải, không sợ bị xóa nhầm dữ liệu. Các máy thành viên được cô lập hoàn toàn, không thể soi mạng của nhau.
> 4. **Tối ưu máy chủ 24/7**: Tinh chỉnh Windows chống ngủ (Sleep/Hibernate), chống ngắt card mạng ngầm, tự động bật lại hệ thống khi có điện trở lại.
>
> ### 📦 Các gói triển khai đề xuất:
> * **Gói 1: Triển khai Cơ bản (5.000.000 VNĐ)**:
>   - Cài đặt & cấu hình toàn bộ máy chủ Windows 24/7.
>   - Bàn giao bộ tài liệu và script tự động 1-click cho máy con.
>   - Hướng dẫn đại diện 1 người trong team tự onboard cho các máy còn lại.
>   - Hỗ trợ kỹ thuật 7 ngày đầu.
>
> * **Gói 2: Trọn gói Tiêu chuẩn - Khuyên dùng (8.000.000 VNĐ)**:
>   - Bao gồm toàn bộ Gói 1.
>   - Trực tiếp hỗ trợ kết nối, cấu hình và nghiệm thu cho toàn bộ ~20 máy thành viên.
>   - Cấu hình tường lửa chống nghẽn đĩa và phân bổ băng thông đều cho các máy.
>   - Cung cấp công cụ hỗ trợ tải đa luồng (chuyên trị file siêu nặng 10GB - 50GB không sợ đứt mạng).
>   - **Cam kết hỗ trợ kỹ thuật & xử lý sự cố trong vòng 30 ngày**.
>
> ### ⏱️ Thời gian thực hiện:
> - Setup máy chủ & kiểm thử nội bộ: 1 ngày.
> - Hỗ trợ kết nối máy con & nghiệm thu bàn giao: 1 - 2 ngày.
>
> *Anh/chị xem qua có điểm nào cần điều chỉnh không, nếu team đồng thuận gói nào thì báo em để em sắp xếp lịch triển khai sớm cho team mình nhé!"*

---

## 2. Ranh giới Trách nhiệm & Phạm vi Công việc (Scope of Work)

Để tránh trường hợp sau này khách thắc mắc những vấn đề ngoài tầm kiểm soát, cần làm rõ các điểm sau trong biên bản thỏa thuận:

### ✅ Việc bạn chịu trách nhiệm:
1. Cấu hình phần mềm web server chạy ổn định, đúng phân quyền (Read-only cho thành viên).
2. Thiết lập kết nối từ xa bảo mật qua mạng Tailscale.
3. Tinh chỉnh Windows máy chủ không tự ý sleep hoặc tắt card mạng.
4. Hướng dẫn và đảm bảo các máy con truy cập được vào kho và tải được file.
5. Hỗ trợ khắc phục lỗi phần mềm cấu hình trong thời gian bảo hành (30 ngày).

### ❌ Việc khách hàng tự chịu trách nhiệm:
1. **Nguồn điện & Thiết bị vật lý**: Máy tính máy chủ phải cắm nguồn ổn định (khuyến nghị có UPS chống cúp điện). Khách tự chịu trách nhiệm nếu hỏng ổ cứng do tuổi thọ phần cứng.
2. **Đường truyền mạng Internet**: Tốc độ tải file tối đa phụ thuộc vào gói cước Upload của nhà mạng khách hàng đăng ký (ví dụ gói cước 100 Mbps thì tốc độ chia sẻ tối đa là ~12 MB/s).
3. **Quản lý file**: Việc thêm, bớt, dọn dẹp các file video trong thư mục do khách hàng chủ động quản lý.

---

## 3. Biên bản Nghiệm thu & Bàn giao (Checklist)

Khi hoàn tất cài đặt, cùng đại diện khách hàng kiểm tra lần lượt các tiêu chí sau trước khi nhận thanh toán:

- [ ] **Tiêu chí 1**: Máy chủ Windows khởi động lại thì server tự động chạy ngầm, không cần thao tác tay.
- [ ] **Tiêu chí 2**: Đăng nhập tài khoản `member` chỉ xem và tải được file, không thể bấm xóa file trên máy chủ.
- [ ] **Tiêu chí 3**: Trên 2-3 máy con khác mạng (dùng 4G hoặc mạng nhà riêng) truy cập vào địa chỉ web tải thử 1 file video dung lượng lớn thành công.
- [ ] **Tiêu chí 4**: Thử nghiệm tính năng xem trước (preview) và tua video mượt mà trên trình duyệt.
- [ ] **Tiêu chí 5**: Các máy con không thể truy cập trái phép vào dữ liệu cá nhân của nhau.
- [ ] **Tiêu chí 6**: Đã bàn giao đầy đủ tài khoản quản trị (Admin), tài khoản thành viên (Member) và file tài liệu hướng dẫn sử dụng.
