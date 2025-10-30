using Baitaplonltw;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using static Baitaplonltw.QuanLySanPham;

namespace Baitaplonltw
{
    public partial class Thanhtoan : System.Web.UI.Page
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
                
                var danhSachSP = Session["XacNhanThanhToan"] as List<SanPhamGioHang>;
                if (danhSachSP != null)
                {
                    rptSanPham.DataSource = danhSachSP;
                    rptSanPham.DataBind();
                }
                else
                {
                    lblThongBao.Text = "Không có sản phẩm nào để thanh toán!";
                    btnDatHang.Enabled = false;
                }
            }
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string sdt = txtSDT.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();

            if (string.IsNullOrEmpty(hoTen) || string.IsNullOrEmpty(sdt) || string.IsNullOrEmpty(diaChi))
            {
                lblThongBao.ForeColor = System.Drawing.Color.Red;
                lblThongBao.Text = "Vui lòng điền đầy đủ thông tin.";
                return;
            }

            var danhSachSP = Session["XacNhanThanhToan"] as List<SanPhamGioHang>;

            DonHang donHang = new DonHang
            {
                HoTen = hoTen,
                SoDienThoai = sdt,
                DiaChi = diaChi,
                SanPham = danhSachSP,
                NgayDat = DateTime.Now,
            };

            // Lưu vào danh sách đơn hàng trong session
            List<DonHang> dsDonHang = Session["DonHang"] as List<DonHang>;
            if (dsDonHang == null)
                dsDonHang = new List<DonHang>();

            dsDonHang.Add(donHang);
            Session["DonHang"] = dsDonHang;

            // Xóa giỏ hàng sau khi đặt
            Session["GioHang"] = null;
            Session["XacNhanThanhToan"] = null;

            lblThongBao.ForeColor = System.Drawing.Color.Green;
            lblThongBao.Text = "Đặt hàng thành công! Cảm ơn bạn.";
            btnDatHang.Enabled = false;
        }
    }
}
