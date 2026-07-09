# Project Rules - VN Trekking

## Quy tắc bắt buộc
1. **Kiểm tra chất lượng (Quality Assurance):** Sau khi hoàn thành bất kỳ tác vụ hoặc thay đổi code nào, bắt buộc phải chạy lệnh `flutter analyze` để kiểm tra và đảm bảo dự án không có lỗi phát sinh hoặc cảnh báo (warnings).
2. **Kiến trúc ứng dụng (Architecture):** Ứng dụng luôn phải đảm bảo tuân thủ cấu trúc **Domain-Driven Design (DDD)**.
3. **Thay đổi Backend (Backend Changes):** Trong trường hợp cần Backend thay đổi, hãy thêm một tài liệu mô tả các thay đổi vào thư mục `backend_planning`.
4. **Nền tảng mục tiêu (Target Platform):** Dự án này là một ứng dụng Web. Hãy đảm bảo tối ưu hóa các trải nghiệm trên Web như Router (điều hướng), hành vi touchbar/scrollbar và các tương tác đặc thù trên trình duyệt.

## Hướng dẫn cấu trúc DDD (Domain-Driven Design)
Để đảm bảo tính nhất quán, cấu trúc trong thư mục `lib/` nên được phân chia như sau:
- **domain/**: Chứa các Entities, Value Objects, Repository Interfaces, và Domain Services. Lớp này là trung tâm của logic nghiệp vụ và không phụ thuộc vào các lớp khác.
- **infrastructure/**: Chứa các Data Sources, Repository Implementations (thực thi interface từ domain), DTOs (Data Transfer Objects), và các dịch vụ tích hợp bên ngoài (Firebase, API...).
- **application/**: Chứa các Application Services, State Management (BLoC, Riverpod, hoặc Provider) để điều phối logic giữa domain và presentation.
- **presentation/**: Chứa giao diện người dùng (UI), Widgets, Screens và Pages.

## Tiêu chuẩn Coding
- Tuân thủ nguyên tắc Clean Code.
- Đảm bảo Null-safety tuyệt đối.
- Đặt tên biến, hàm và class rõ ràng, có ý nghĩa bằng tiếng Anh (hoặc theo quy định cụ thể).
