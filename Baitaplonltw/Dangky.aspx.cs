using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Baitaplonltw
{
    public partial class Dangky : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public class UserAccount
        {
            public string HoTen { get; set; }
            public string Email { get; set; }
            public string MatKhau { get; set; } // Có thể thêm Role nếu cần
        }
        protected void btnNhapLai_Click(object sender, EventArgs e)
        {
            // Reset dữ liệu
            txtHoTen.Text = "";
            txtEmailDangKy.Text = "";
            txtMatKhauDangKy.Text = "";
            txtNhapLaiMatKhau.Text = "";

            // Reset lỗi
            litNameError.Text = "";
            litEmailError.Text = "";
            litMatKhauError.Text = "";
            litNhapLaiMatKhauError.Text = "";
            
        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string email = txtEmailDangKy.Text.Trim();
            string matKhau = txtMatKhauDangKy.Text.Trim();
            string nhapLai = txtNhapLaiMatKhau.Text.Trim();

            litNameError.Text = "";
            litEmailError.Text = "";
            litMatKhauError.Text = "";
            litNhapLaiMatKhauError.Text = "";

            bool isValid = true;

            // Kiểm tra rỗng
            if (string.IsNullOrEmpty(hoTen))
            {
                litNameError.Text = "Vui lòng nhập họ tên.";
                isValid = false;
            }

            if (string.IsNullOrEmpty(email))
            {
                litEmailError.Text = "Vui lòng nhập email.";
                isValid = false;
            }

            if (string.IsNullOrEmpty(matKhau))
            {
                litMatKhauError.Text = "Vui lòng nhập mật khẩu.";
                isValid = false;
            }

            if (string.IsNullOrEmpty(nhapLai))
            {
                litNhapLaiMatKhauError.Text = "Vui lòng nhập lại mật khẩu.";
                isValid = false;
            }

            // Kiểm tra định dạng họ tên
            string hoTenPattern = @"^[A-Za-zÀ-ỹ\s]{5,50}$";
            if (!string.IsNullOrEmpty(hoTen) && !Regex.IsMatch(hoTen, hoTenPattern))
            {
                litNameError.Text = "Họ tên phải từ 5-50 ký tự chữ cái và khoảng trắng.";
                isValid = false;
            }

            // Kiểm tra định dạng email
            string emailPattern = @"^[a-zA-Z0-9.+]{3,32}@[a-zA-Z0-9.-]{2,20}\.[a-zA-Z]{2,10}$";
            if (!string.IsNullOrEmpty(email) && !Regex.IsMatch(email, emailPattern))
            {
                litEmailError.Text = "Email không đúng định dạng.";
                isValid = false;
            }

            // Kiểm tra khớp mật khẩu
            if (!string.IsNullOrEmpty(matKhau) && !string.IsNullOrEmpty(nhapLai) && matKhau != nhapLai)
            {
                litNhapLaiMatKhauError.Text = "Mật khẩu nhập lại không khớp.";
                isValid = false;
            }

            // Nếu hợp lệ
            List<UserAccount> users = Session["Users"] as List<UserAccount>;
            if (users == null)
            {
                users = new List<UserAccount>();
            }

            // Kiểm tra email đã tồn tại chưa
            if (users.Any(u => u.Email == email))
            {
                litEmailError.Text = "Email đã tồn tại.";
                return;
            }

            users.Add(new UserAccount
            {
                HoTen = hoTen,
                Email = email,
                MatKhau = matKhau // Có thể mã hóa ở đây
            });

            Session["Users"] = users;

            Session["ThongBao"] = "Đăng ký thành công!";
            Response.Redirect("Dangnhap.aspx");
        }
    }
}
