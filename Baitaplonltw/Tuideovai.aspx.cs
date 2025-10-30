using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Baitaplonltw.QuanLySanPham;

namespace Baitaplonltw
{
    public partial class Tuideovai : System.Web.UI.Page
    {
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<SanPhamDTO> FilterProductsByPrice(string priceRange)
        {
            var ds = HttpContext.Current.Session["DanhSachSanPham"] as List<SanPham>;
            if (ds == null) return new List<SanPhamDTO>();

            var prices = priceRange.Split('-');
            int min = int.Parse(prices[0]);
            int max = int.Parse(prices[1]);

            var result = ds
                .Where(sp => sp.Loai == "TuiDeoVai" && sp.Gia >= min && sp.Gia <= max)
                .Select(sp => new SanPhamDTO
                {
                    ID = sp.ID,
                    Ten = sp.Ten,
                    Anh = sp.Anh,
                    Gia = sp.Gia,
                })
                .ToList();

            return result;
        }

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
            public decimal Gia { get; set; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                if (Session["HoTen"] != null)
                    lblChao.Text = "Xin chào " + Session["HoTen"].ToString();
                else
                    lblChao.Text = "Xin chào khách!";

                if (Session["DanhSachSanPham"] == null)
                    KhoiTaoDanhSach();

                var ds = Session["DanhSachSanPham"] as List<SanPham>;
                var id2 = new List<string> { "TDV01", "TDV02", "TDV03", "TDV04" };
                var ds2 = ds.Where(sp => id2.Contains(sp.ID)).ToList();
                rptbontdv.DataSource = ds2;
                rptbontdv.DataBind();
                var id3 = new List<string> { "TDV05", "TDV06", "TDV07", "TDV08" };
                var ds3 = ds.Where(sp => id3.Contains(sp.ID)).ToList();
                rptbontdv2.DataSource = ds3;
                rptbontdv2.DataBind();

            }
        }
        private void KhoiTaoDanhSach()
        {
            List<SanPham> ds = new List<SanPham>
            {
                new SanPham { ID = "TDC01", Ten = "TDC Nắp Gập Khóa H - Lock Sz 19 - Kem", Gia = 883000M, MoTa = "...", Anh = ResolveUrl("~/tuideocheo/tdc1.jpeg"), Loai = "TuiDeoCheo" },
                new SanPham { ID = "TDC02", Ten = "TDC Nắp Gập Khóa H - Lock Sz 19 - Vàng", Gia = 883000M, MoTa = "...", Anh = ResolveUrl("~/tuideocheo/tdc2.jpeg"), Loai = "TuiDeoCheo" },
                new SanPham { ID = "TDC03", Ten = "TDC Nắp Gập Khóa H - Lock Sz 19 - Đen", Gia = 883000M, MoTa = "...", Anh = ResolveUrl("~/tuideocheo/tdc3.jpeg"), Loai = "TuiDeoCheo" },
                new SanPham { ID = "TDC04", Ten = "TDC Đáy Cong Khóa Gài Sz 23 - Xanh", Gia = 883000M, MoTa = "...", Anh = ResolveUrl("~/tuideocheo/tdc4.jpeg"), Loai = "TuiDeoCheo" },
                new SanPham { ID = "TDC05", Ten = "TDC Đáy Cong Khóa Gài Sz 23 - Đen", Gia = 883000M, MoTa = "...", Anh = ResolveUrl("~/tuideocheo/tdc5.jpeg"), Loai = "TuiDeoCheo" },
                new SanPham { ID = "TDC06", Ten = "TDC Đáy Cong Khóa Gài Sz 23 - Trắng", Gia = 883000M, MoTa = "...", Anh = ResolveUrl("~/tuideocheo/tdc6.jpeg"), Loai = "TuiDeoCheo" },
                new SanPham { ID = "TDC07", Ten = "TDC Ô Trám Nắp Gập Sz 20 - Đen", Gia = 883000M, MoTa = "...", Anh = ResolveUrl("~/tuideocheo/tdc7.jpeg"), Loai = "TuiDeoCheo" },
                new SanPham { ID = "TDC08", Ten = "TDC Khóa Gài Vân Rắn Mới Sz 18 - Đen", Gia = 883000M, MoTa = "...", Anh = ResolveUrl("~/tuideocheo/tdc8.jpeg"), Loai = "TuiDeoCheo" },

                new SanPham { ID = "TDV01", Ten = "TDV Đeo Vai Đai Dài Bubbly Mơ Sz 26 - Kem", Gia = 1033000M, MoTa = "...", Anh = ResolveUrl("~/tuideovai/tdv1.jpeg"), Loai = "TuiDeoVai" },
                new SanPham { ID = "TDV02", Ten = "TDV Đai Ngang Neutral Mơ Sz 27 - Kem", Gia = 1183000M, MoTa = "...", Anh = ResolveUrl("~/tuideovai/tdv2.jpeg"), Loai = "TuiDeoVai" },
                new SanPham { ID = "TDV03", Ten = "TDV Đeo Vai Đai Dài Bubbly Mơ Sz 26 - Jean", Gia = 833000M, MoTa = "...", Anh = ResolveUrl("~/tuideovai/tdv3.jpeg"), Loai = "TuiDeoVai" },
                new SanPham { ID = "TDV04", Ten = "TDV Đai Ngang Dreamy Sz 25 - Jean", Gia = 983000M, MoTa = "...", Anh = ResolveUrl("~/tuideovai/tdv4.jpeg"), Loai = "TuiDeoVai" },
                new SanPham { ID = "TDV05", Ten = "TDV Hobo Đai Chéo Cozy Sz 24 - Jean", Gia = 983000M, MoTa = "...", Anh = ResolveUrl("~/tuideovai/tdv5.jpeg"), Loai = "TuiDeoVai" },
                new SanPham { ID = "TDV06", Ten = "TDV Hobo Dáng Vuông Easy Sz 23 - Jean", Gia = 983000M, MoTa = "...", Anh = ResolveUrl("~/tuideovai/tdv6.jpeg"), Loai = "TuiDeoVai" },
                new SanPham { ID = "TDV07", Ten = "TDV Hobo Nắp Gập Chain Handle Sz 23 - Trắng", Gia = 983000M, MoTa = "...", Anh = ResolveUrl("~/tuideovai/tdv7.jpeg"), Loai = "TuiDeoVai" },
                new SanPham { ID = "TDV08", Ten = "TDV Hobo Nắp Gập Chain Handle Sz 23 - Đen", Gia = 983000M, MoTa = "...", Anh = ResolveUrl("~/tuideovai/tdv8.jpeg"), Loai = "TuiDeoVai" },

                new SanPham { ID = "TXT01", Ten = "TXT Phủ Màu Tag Vuông Sz 21 - Hồng", Gia = 933000M, MoTa = "...", Anh = ResolveUrl("~/tuixachtay/txt1.jpeg"), Loai = "TuiXachTay" },
                new SanPham { ID = "TXT02", Ten = "TXT Nắp Gập Khóa Xoay Sz 23 - Kem", Gia = 983000M, MoTa = "...", Anh = ResolveUrl("~/tuixachtay/txt2.jpeg"), Loai = "TuiXachTay" },
                new SanPham { ID = "TXT03", Ten = "TXT Nắp Gập Khóa Xoay Sz 23 - Trắng", Gia = 983000M, MoTa = "...", Anh = ResolveUrl("~/tuixachtay/txt3.jpeg"), Loai = "TuiXachTay" },
                new SanPham { ID = "TXT04", Ten = "TXT Nắp Gập Khóa Xoay Sz 23 - Đen", Gia = 983000M, MoTa = "...", Anh = ResolveUrl("~/tuixachtay/txt4.jpeg"), Loai = "TuiXachTay" },
                new SanPham { ID = "TXT05", Ten = "TXT Da bóng Curved Line Sz 23 - Trắng", Gia = 833000M, MoTa = "...", Anh = ResolveUrl("~/tuixachtay/txt5.jpeg"), Loai = "TuiXachTay" },
                new SanPham { ID = "TXT06", Ten = "TXT Da Bóng Curved Line Sz 23 - Đen", Gia = 833000M, MoTa = "...", Anh = ResolveUrl("~/tuixachtay/txt6.jpeg"), Loai = "TuiXachTay" },
                new SanPham { ID = "TXT07", Ten = "TXT Canvas Phối Viền Sz 20 - Nâu", Gia = 833000M, MoTa = "...", Anh = ResolveUrl("~/tuixachtay/txt7.jpeg"), Loai = "TuiXachTay" },
                new SanPham { ID = "TXT08", Ten = "TXT Canvas Phối Viền Sz 20 - Xanh Lá Cây", Gia = 833000M, MoTa = "...", Anh = ResolveUrl("~/tuixachtay/txt8.jpeg"), Loai = "TuiXachTay" },
            };
            Session["DanhSachSanPham"] = ds;
        }
    }
}