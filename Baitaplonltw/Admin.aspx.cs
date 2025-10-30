using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Baitaplonltw
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Dangnhap.aspx");
            }
        }
        protected void btnQuanLySanPham_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLySanPham.aspx");
        }

        protected void btnQuanLyDonHang_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLyDonHang.aspx");
        }
    }
}