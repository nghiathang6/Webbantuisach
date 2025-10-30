using Baitaplonltw;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI.WebControls;
using static Baitaplonltw.QuanLySanPham;

namespace Baitaplonltw
{
    public partial class Giohang : System.Web.UI.Page
    {
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<SanPhamDTO> SearchProducts(string keyword)
        {
            var ds = HttpContext.Current.Session["DanhSachSanPham"] as List<SanPham>;
            if (ds == null) return new List<SanPhamDTO>();

            var result = ds
                .Where(sp => sp.Ten.IndexOf(keyword, StringComparison.OrdinalIgnoreCase) >= 0)
                .Select(sp => new SanPhamDTO
                {
                    ID = sp.ID,
                    Ten = sp.Ten,
                    Anh = sp.Anh
                })
                .ToList();

            return result;
        }

        public class SanPhamDTO
        {
            public string ID { get; set; }
            public string Ten { get; set; }
            public string Anh { get; set; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["HoTen"] != null)
                    lblChao.Text = "Xin chào " + Session["HoTen"].ToString();
                else
                    lblChao.Text = "Xin chào khách!";
                HienThiGioHang();
            }
        }


        protected void rptGioHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Xoa")
            {
                string idCanXoa = e.CommandArgument.ToString();

                var gioHang = Session["GioHang"] as List<SanPhamGioHang>;
                if (gioHang != null)
                {
                    // Xóa sản phẩm có ID trùng
                    var spCanXoa = gioHang.FirstOrDefault(sp => sp.ID == idCanXoa);
                    if (spCanXoa != null)
                    {
                        gioHang.Remove(spCanXoa);
                        Session["GioHang"] = gioHang;
                    }
                }

                // Cập nhật lại hiển thị giỏ hàng
                HienThiGioHang();
            }
        }

        private void HienThiGioHang()
        {
            var gioHang = Session["GioHang"] as List<SanPhamGioHang>;

            if (gioHang != null && gioHang.Count > 0)
            {
                rptGioHang.DataSource = gioHang;
                rptGioHang.DataBind();

                decimal tongTien = (decimal)gioHang.Sum(sp => sp.ThanhTien);
                lblTongTien.Text = "Tổng cộng: " + tongTien.ToString("N0") + " đ";
            }
            else
            {
                rptGioHang.DataSource = null;
                rptGioHang.DataBind();
                lblTongTien.Text = "Giỏ hàng của bạn đang trống.";
                btnThanhToan.Visible = false;
            }
        }

        protected void btnThanhToan_Click(object sender, EventArgs e)
        {
            // Lưu giỏ hàng sang Session["XacNhanThanhToan"] để truyền sang trang Thanhtoan.aspx
            var gioHang = Session["GioHang"] as List<SanPhamGioHang>;
            if (gioHang != null && gioHang.Count > 0)
            {
                Session["XacNhanThanhToan"] = gioHang;

                // Chuyển đến trang thanh toán
                Response.Redirect("Thanhtoan.aspx");
            }
            else
            {
                lblTongTien.Text = "Không thể thanh toán vì giỏ hàng trống.";
            }
        }
    }
}
