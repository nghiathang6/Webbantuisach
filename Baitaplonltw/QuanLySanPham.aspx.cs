using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Baitaplonltw
{
    public partial class QuanLySanPham : System.Web.UI.Page
    {
        public class SanPham
        {
            public string ID { get; set; }     
            public string Ten { get; set; }
            public decimal Gia { get; set; }
            public string MoTa { get; set; }
            public string Anh { get; set; }
            public string Loai { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HienThiDanhSach();
            }
        }

        private void HienThiDanhSach()
        {
            var ds = Session["DanhSachSanPham"] as List<SanPham>;
            if (ds == null) return;
            gvSanPham.DataSource = ds;
            gvSanPham.DataBind();
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            var ds = Session["DanhSachSanPham"] as List<SanPham>;
            if (ds == null) return;
            string idMoi = "SP" + (ds.Count + 1).ToString("D3");

            SanPham sp = new SanPham
            {
                ID = idMoi,
                Ten = txtTenBanh.Text.Trim(),
                Gia = decimal.TryParse(txtGia.Text.Trim(), out decimal gia) ? gia : 0,
                MoTa = txtMoTa.Text.Trim(),
                Anh = txtAnh.Text.Trim(),
                Loai = ddlLoai.SelectedValue
            };

            ds.Add(sp);
            Session["DanhSachSanPham"] = ds;
            HienThiDanhSach();
            XoaForm();
        }

        protected void gvSanPham_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvSanPham.SelectedIndex;
            var ds = Session["DanhSachSanPham"] as List<SanPham>;
            if (ds == null) return;
            SanPham sp = ds[index];

            txtTenBanh.Text = sp.Ten;
            txtGia.Text = sp.Gia.ToString();
            txtMoTa.Text = sp.MoTa;
            txtAnh.Text = sp.Anh;
            ddlLoai.SelectedValue = sp.Loai;

            ViewState["Index"] = index;
        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            if (ViewState["Index"] != null)
            {
                int index = (int)ViewState["Index"];
                var ds = Session["DanhSachSanPham"] as List<SanPham>;
                if (ds == null) return;

                ds[index].Ten = txtTenBanh.Text.Trim();
                ds[index].Gia = decimal.TryParse(txtGia.Text.Trim(), out decimal gia) ? gia : ds[index].Gia;
                ds[index].MoTa = txtMoTa.Text.Trim();
                ds[index].Anh = txtAnh.Text.Trim();
                ds[index].Loai = ddlLoai.SelectedValue;

                Session["DanhSachSanPham"] = ds;
                HienThiDanhSach();
                XoaForm();
            }
        }

        protected void btnXoa_Click(object sender, EventArgs e)
        {
            if (ViewState["Index"] != null)
            {
                int index = (int)ViewState["Index"];
                var ds = Session["DanhSachSanPham"] as List<SanPham>;
                if (ds == null) return;

                if (index >= 0 && index < ds.Count)
                {
                    ds.RemoveAt(index);
                }

                Session["DanhSachSanPham"] = ds;
                HienThiDanhSach();
                XoaForm();
            }
        }

        private void XoaForm()
        {
            txtTenBanh.Text = "";
            txtGia.Text = "";
            txtMoTa.Text = "";
            txtAnh.Text = "";
            ddlLoai.SelectedIndex = 0;
            ViewState["Index"] = null;
        }
    }
}