using Baitaplonltw; // Để dùng class SanPhamGioHang đã tách riêng
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
    public partial class Donhang : System.Web.UI.Page
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
                List<DonHang> dsDonHang = Session["DonHang"] as List<DonHang>;

                if (dsDonHang != null && dsDonHang.Count > 0)
                {
                    rptDonHang.DataSource = dsDonHang;
                    rptDonHang.DataBind();
                }
                else
                {
                    lblThongBao.Text = "Chưa có đơn hàng nào.";
                }
            }
        }

        protected void rptDonHang_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Lấy đối tượng đơn hàng hiện tại
                DonHang donHang = (DonHang)e.Item.DataItem;

                // Tìm Repeater con hiển thị sản phẩm
                Repeater rptSP = (Repeater)e.Item.FindControl("rptSP");

                if (rptSP != null && donHang.SanPham != null)
                {
                    rptSP.DataSource = donHang.SanPham;
                    rptSP.DataBind();
                }
            }
        }
    }

    // ✅ Chỉ giữ lại class DonHang, vì SanPhamGioHang đã nằm trong file riêng
    [Serializable]
    public class DonHang
    {
        public string HoTen { get; set; }
        public string SoDienThoai { get; set; }
        public string DiaChi { get; set; }
        public DateTime NgayDat { get; set; }
        public List<SanPhamGioHang> SanPham { get; set; }
        public string TrangThai { get; set; } = "Chờ xử lý";
    }
}
