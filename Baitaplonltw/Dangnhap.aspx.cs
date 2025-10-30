using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Baitaplonltw.Dangky;

namespace Baitaplonltw
{
    public partial class Dangnhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string email = txtEmailDangNhap.Text.Trim();
            string password = txtMatKhauDangNhap.Text.Trim();

            // Xử lý phân quyền
            if (email == "admin@gmail.com" && password == "admin123")
            {
                // Người dùng là admin
                Session["Role"] = "Admin";
                Response.Redirect("Admin.aspx");
            }
            else
            {
                List<UserAccount> users = Session["Users"] as List<UserAccount>;

                if (users != null)
                {
                    var user = users.FirstOrDefault(u => u.Email == email && u.MatKhau == password);
                    if (user != null)
                    {
                        Session["Role"] = "User";
                        Session["HoTen"] = user.HoTen;
                        Response.Redirect("TrangChu.aspx");
                        return;
                    }
                }

                litDangNhapError.Text = "Thông tin đăng nhập không hợp lệ.";
            }
        }

    }
}